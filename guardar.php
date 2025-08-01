<?php
if (session_status() === PHP_SESSION_NONE) session_start();

require 'session_config.php';
require 'database.php';
require 'auth_middleware.php';
require 'funciones.php';
requireAuth();
requireRole(['SISTEMAS', 'ADMIN', 'CAPTURISTA']);

error_reporting(E_ALL);
ini_set('display_errors', 1);

// Validar campos requeridos
$required_fields = [
    'fecha_entrega', 'numero_oficio_usuario', 'remitente', 
    'email_institucional', 'cargo_remitente', 'depto_remitente',
    'telefono', 'asunto', 'tipo', 'estatus', 'jud_destino'
];

foreach ($required_fields as $field) {
    if (empty($_POST[$field])) {
        die(json_encode(['error' => "Campo requerido faltante: $field"]));
    }
}

if (empty($_FILES['pdf_file']['tmp_name'])) {
    die("Archivo PDF requerido");
}

// Validar correo institucional
$email_institucional = strtolower(trim($_POST['email_institucional']));
if (!preg_match('/@tlalpan\.cdmx\.gob\.mx$/i', $email_institucional)) {
    die("Correo institucional inválido");
}

// Obtener el próximo número de oficio
$secuencia_query = "SELECT ultimo_numero FROM secuencia_oficios LIMIT 1 FOR UPDATE";
$secuencia_result = mysqli_query($conn, $secuencia_query);
$secuencia_row = mysqli_fetch_assoc($secuencia_result);
$proximo_numero = $secuencia_row['ultimo_numero'] + 1;
$numero_oficio = "OF-" . str_pad($proximo_numero, 5, '0', STR_PAD_LEFT);

// Procesar PDF
$upload_dir = 'pdfs/';
if (!file_exists($upload_dir)) {
    mkdir($upload_dir, 0755, true);
}
$pdf_nombre = 'doc_' . date('Ymd_His') . '_' . bin2hex(random_bytes(4)) . '.pdf';
$pdf_destino = $upload_dir . $pdf_nombre;

if (!move_uploaded_file($_FILES['pdf_file']['tmp_name'], $pdf_destino)) {
    die("No se pudo mover el archivo PDF");
}

$conn->begin_transaction();

try {

    $personal_id = actualizarCatalogoPersonal($conn, $datos);
    // 1. Actualizar o insertar en catálogo de personal
    $check_personal = $conn->prepare("SELECT id, departamento_jud FROM catalogo_personal WHERE email_institucional = ?");
    $check_personal->bind_param('s', $email_institucional);
    $check_personal->execute();
    $result = $check_personal->get_result();
    
    if ($result->num_rows > 0) {
        // Actualizar registro existente
        $row = $result->fetch_assoc();
        $personal_id = $row['id'];
        $departamento_anterior = $row['departamento_jud'];
        
        $update = $conn->prepare("
            UPDATE catalogo_personal SET 
                nombre = ?,
                puesto = ?,
                departamento_jud = ?,
                telefono = ?,
                extension = ?,
                ultima_actualizacion = NOW()
            WHERE id = ?
        ");
        $update->bind_param(
            'sssssi',
            $_POST['remitente'],
            $_POST['cargo_remitente'],
            $_POST['depto_remitente'] === 'OTRO' ? $_POST['depto_remitente_otro'] : $_POST['depto_remitente'],
            $_POST['telefono'],
            $_POST['extension'] ?? '',
            $personal_id
        );
        $update->execute();
    } else {
        // Insertar nuevo registro
        $departamento_anterior = 'SIN DEPARTAMENTO';
        $insert = $conn->prepare("
            INSERT INTO catalogo_personal (
                numero_empleado, nombre, puesto, departamento_jud,
                telefono, extension, email_institucional, fecha_registro, ultima_actualizacion
            ) VALUES (?, ?, ?, ?, ?, ?, ?, NOW(), NOW())
        ");
        $numero_empleado = generarNumeroAutomatico($conn);
        $insert->bind_param(
            'sssssss',
            $numero_empleado,
            $_POST['remitente'],
            $_POST['cargo_remitente'],
            $_POST['depto_remitente'] === 'OTRO' ? $_POST['depto_remitente_otro'] : $_POST['depto_remitente'],
            $_POST['telefono'],
            $_POST['extension'] ?? '',
            $email_institucional
        );
        $insert->execute();
        $personal_id = $conn->insert_id;
    }

    // 2. Insertar documento
    $insert_doc_query = "INSERT INTO documentos (
        fecha_creacion,
        fecha_entrega, 
        numero_oficio, 
        numero_oficio_usuario, 
        remitente, 
        cargo_remitente, 
        depto_remitente, 
        telefono, 
        extension,
        asunto, 
        tipo, 
        estatus, 
        pdf_url, 
        destinatario, 
        jud_destino, 
        email_institucional,
        numero_empleado,
        dire_fisica, 
        usuario_registra, 
        etapa
    ) VALUES (NOW(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    
    // Preparar variables para bind_param
    $fecha_entrega = $_POST['fecha_entrega'];
    $numero_oficio_usuario = $_POST['numero_oficio_usuario'] ?? '';
    $remitente = $_POST['remitente'];
    $cargo_remitente = $_POST['cargo_remitente'];
    $depto_remitente = $_POST['depto_remitente'] === 'OTRO' ? $_POST['depto_remitente_otro'] : $_POST['depto_remitente'];
    $telefono = $_POST['telefono'];
    $extension = $_POST['extension'] ?? '';
    $asunto = $_POST['asunto'];
    $tipo = $_POST['tipo'];
    $estatus = $_POST['estatus'];
    $destinatario = $_POST['trabajador_destino'] ?? '';
    $jud_destino = $_POST['jud_destino'] === 'OTRO' ? $_POST['jud_destino_otro'] : $_POST['jud_destino'];
    $dire_fisica = $_POST['dire_fisica'] ?? '';
    $usuario_registra = $_SESSION['user']['id'];
    
    $stmt->bind_param(
        'sssssssssssssssssii',  // Nota las dos 'i' finales (usuario_registra y personal_id)
        $fecha_entrega,
        $numero_oficio,
        $numero_oficio_usuario,
        $remitente,
        $cargo_remitente,
        $depto_remitente,
        $telefono,
        $extension,
        $asunto,
        $tipo,
        $estatus,
        $pdf_destino,
        $destinatario,
        $jud_destino,
        $email_institucional,
        $numero_empleado,
        $dire_fisica,
        $usuario_registra,
        $personal_id  // <- Añade esta variable
    );
    
    $stmt->execute();
    $documento_id = $conn->insert_id;

    // 3. Insertar historial de departamento
    $insert_historial = $conn->prepare("
    INSERT INTO historial_departamentos (
        personal_id, numero_empleado, departamento_anterior,
        departamento_nuevo, usuario_registra, documento_id,
        numero_oficio_usuario, email_institucional
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
");

$insert_historial->bind_param(
    'isssisss',
    $personal_id,
    $numero_empleado,
    $departamento_anterior,  // Obtenido al buscar en catalogo_personal
    $depto_remitente,        // Nuevo departamento
    $usuario_registra,
    $documento_id,
    $numero_oficio_usuario,
    $email_institucional
);
    $insert_historial->execute();

    // 4. Actualizar secuencia de oficios
    $conn->query("UPDATE secuencia_oficios SET ultimo_numero = $proximo_numero");

    // 5. Registrar auditoría
    $auditoria = $conn->prepare("
        INSERT INTO auditoria_oficios (
            usuario_id, accion, numero_oficio, numero_oficio_usuario,
            ip_address, user_agent
        ) VALUES (?, 'CREACION_OFICIO', ?, ?, ?, ?)
    ");
    
    $auditoria->bind_param(
        'issss',
        $usuario_registra,
        $numero_oficio,
        $numero_oficio_usuario,
        $_SERVER['REMOTE_ADDR'],
        $_SERVER['HTTP_USER_AGENT']
    );
    $auditoria->execute();

    $conn->commit();
    
    $_SESSION['success'] = "Documento registrado correctamente (ID: $documento_id)";
    header('Location: index.php');
    exit;

} catch (Exception $e) {
    $conn->rollback();
    
    // Eliminar archivo PDF si se subió pero falló la transacción
    if (isset($pdf_destino) && file_exists($pdf_destino)) {
        @unlink($pdf_destino);
    }
    
    error_log("[" . date('Y-m-d H:i:s') . "] Error en guardar.php: " . $e->getMessage() . "\nDatos: " . print_r($_POST, true));
    $_SESSION['error'] = "Ocurrió un error al procesar el documento. ID de error: " . uniqid();
    header('Location: index.php');
    exit;
}