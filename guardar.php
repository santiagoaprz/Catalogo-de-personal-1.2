<?php

// Evitar que la conexión se cierre prematuramente
register_shutdown_function(function() {
    global $conn;
    if (isset($conn)) {
        $conn = null; // Limpiar sin cerrar explícitamente
    }
});
if (session_status() === PHP_SESSION_NONE) session_start();

require 'session_config.php';
require 'database.php';
require 'auth_middleware.php';
require 'funciones.php';
requireAuth();
requireRole(['SISTEMAS', 'ADMIN', 'CAPTURISTA']);

error_reporting(E_ALL);
ini_set('display_errors', 1);

// Validaciones iniciales
if (!isset($_SESSION['user']['id'])) {
    die(json_encode(['error' => 'Sesión no válida', 'details' => 'ID de usuario no encontrado']));
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    die(json_encode(['error' => 'Método no permitido']));
}

if (empty($_FILES['pdf_file']['tmp_name'])) {
    die(json_encode(['error' => 'Archivo PDF requerido']));
}

// Validar correo institucional
$email_institucional = trim($_POST['email_institucional']);
if (!filter_var($email_institucional, FILTER_VALIDATE_EMAIL) || !preg_match('/@tlalpan\.cdmx\.gob\.mx$/i', $email_institucional)) {
    die(json_encode(['error' => 'Correo institucional inválido', 'details' => 'Debe usar un correo @tlalpan.cdmx.gob.mx']));
}

$conn->begin_transaction();

try {
    // ===== 1. GENERACIÓN DE NÚMERO DE OFICIO =====
    mysqli_query($conn, "LOCK TABLES secuencia_oficios WRITE, catalogo_personal WRITE, documentos WRITE");
    $seq_result = mysqli_query($conn, "SELECT ultimo_numero FROM secuencia_oficios LIMIT 1");
    $seq_row = mysqli_fetch_assoc($seq_result);
    $nuevo_numero = (int)$seq_row['ultimo_numero'] + 1;
    mysqli_query($conn, "UPDATE secuencia_oficios SET ultimo_numero = $nuevo_numero");
    
    $numero_oficio = "OF-".str_pad($nuevo_numero, 5, '0', STR_PAD_LEFT);

    // ===== 2. PREPARAR VARIABLES PARA INSERCIÓN =====
    $etapa = 'RECIBIDO';
    $fecha_entrega = $_POST['fecha_entrega'];
    $remitente = $_POST['remitente'];
    $cargo_remitente = $_POST['cargo_remitente'];
    $depto_remitente = ($_POST['depto_remitente'] === 'OTRO') ? trim($_POST['depto_remitente_otro']) : trim($_POST['depto_remitente']);
    $telefono = $_POST['telefono'];
    $extension = $_POST['extension'] ?? '';
    $asunto = $_POST['asunto'];
    $tipo = $_POST['tipo'];
    $estatus = $_POST['estatus'];
    $jud_destino = ($_POST['jud_destino'] === 'OTRO') ? trim($_POST['jud_destino_otro']) : trim($_POST['jud_destino']);
    $destinatario = $_POST['trabajador_destino'] ?? '';
    $dire_fisica = $_POST['dire_fisica'];
    $usuario_id = $_SESSION['user']['id'];
    $numero_oficio_usuario = trim($_POST['numero_oficio_usuario']);

    // ===== 3. VALIDACIÓN DE CAMPOS REQUERIDOS =====
    $required = ['fecha_entrega', 'asunto', 'tipo', 'estatus', 'remitente', 'cargo_remitente'];
    foreach ($required as $field) {
        if (empty($_POST[$field])) {
            throw new Exception("Campo requerido faltante: $field");
        }
    }

    // ===== 4. PROCESAMIENTO DEL PDF =====
    if (!is_uploaded_file($_FILES['pdf_file']['tmp_name'])) {
        throw new Exception("Intento de subida no válido");
    }

    $finfo = finfo_open(FILEINFO_MIME_TYPE);
    $mime_type = finfo_file($finfo, $_FILES['pdf_file']['tmp_name']);
    finfo_close($finfo);

    if ($mime_type != 'application/pdf') {
        throw new Exception("Solo se permiten archivos PDF (tipo detectado: $mime_type)");
    }

    $upload_dir = 'pdfs/';
    if (!file_exists($upload_dir)) {
        if (!mkdir($upload_dir, 0755, true)) {
            throw new Exception("No se pudo crear el directorio PDF");
        }
    }

    $pdf_name = 'doc_'.date('Ymd_His').'_'.bin2hex(random_bytes(4)).'.pdf';
    $pdf_path = $upload_dir . $pdf_name;

    if (!move_uploaded_file($_FILES['pdf_file']['tmp_name'], $pdf_path)) {
        throw new Exception("Error al mover el PDF. Verifique permisos.");
    }

    // ===== 5. GESTIÓN DE EMPLEADOS EN CATÁLOGO (nuevo código) =====
    $check_query = "SELECT id FROM catalogo_personal WHERE email_institucional = ? LIMIT 1";
    $stmt_check = $conn->prepare($check_query);
    $stmt_check->bind_param('s', $email_institucional);
    $stmt_check->execute();

    if ($stmt_check->get_result()->num_rows > 0) {
        // Actualizar empleado existente
        $update_query = "UPDATE catalogo_personal SET 
            nombre = ?,
            puesto = ?,
            departamento_jud = ?,
            telefono = ?,
            extension = ?,
            dire_fisica = ?,
            ultima_actualizacion = NOW()
            WHERE email_institucional = ?";
        
        $stmt_update = $conn->prepare($update_query);
        $stmt_update->bind_param('sssssss', 
            $remitente,
            $cargo_remitente,
            $depto_remitente,
            $telefono,
            $extension,
            $dire_fisica,
            $email_institucional
        );
        $stmt_update->execute();
    } else {
        // Insertar nuevo empleado
        
        $insert_query = "INSERT INTO catalogo_personal (
            email_institucional, 
            numero_empleado, 
            nombre, 
            puesto, 
            departamento_jud, 
            dire_fisica, 
            telefono, 
            extension
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        $numero_empleado = generarNumeroEmpleado($conn);
        $stmt_insert = $conn->prepare($insert_query);
        $stmt_insert->bind_param('ssssssss', 
            $email_institucional,
            $numero_empleado,
            $remitente,
            $cargo_remitente,
            $depto_remitente,
            $dire_fisica,
            $telefono,
            $extension
        );
        $stmt_insert->execute();
    }
    if (empty($email_institucional)) {
        throw new Exception("Correo institucional es requerido");
    }
    if (empty($numero_empleado)) {
        $numero_empleado = generarNumeroEmpleado($conn);
    }

   // ===== 6. INSERCIÓN DEL DOCUMENTO =====
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

$stmt_doc = $conn->prepare($insert_doc_query);
$stmt_doc->bind_param('sssssssssssssssssis',
    $fecha_entrega,
    $numero_oficio,
    $numero_oficio_usuario,
    $remitente,
    $cargo_remitente,
    $depto_remitente,
    $telefono,
    $extension, // Asegúrate de incluir este campo
    $asunto,
    $tipo,
    $estatus,
    $pdf_path,
    $destinatario,
    $jud_destino,
    $email_institucional,
    $numero_empleado,
    $dire_fisica,
    $usuario_id,
    $etapa
);

if (!$stmt_doc->execute()) {
    throw new Exception("Error al guardar documento: " . $stmt_doc->error);
}

// ===== 6.1 INSERCIÓN EN HISTORIAL DEPARTAMENTOS =====
$historial_query = "INSERT INTO historial_departamentos (
    personal_id,
    numero_empleado,
    departamento_anterior,
    departamento_nuevo,
    usuario_registra,
    documento_id,
    numero_oficio_usuario,
    email_institucional
) SELECT 
    id,
    numero_empleado,
    departamento_jud,
    ?,
    ?,
    LAST_INSERT_ID(),
    ?,
    ?
FROM catalogo_personal 
WHERE email_institucional = ?";

$stmt_historial = $conn->prepare($historial_query);
$stmt_historial->bind_param('sisss', 
    $depto_remitente,      // departamento_nuevo
    $usuario_id,           // usuario_registra
    $numero_oficio_usuario,
    $email_institucional,
    $email_institucional   // WHERE email_institucional = ?
);

if (!$stmt_historial->execute()) {
    throw new Exception("Error al registrar historial de departamento: " . $stmt_historial->error);
}

    
    // ===== 7. REGISTRO EN AUDITORÍA =====
    $accion = 'CREACION_OFICIO';
    $ip_address = $_SERVER['REMOTE_ADDR'];
    $user_agent = $_SERVER['HTTP_USER_AGENT'] ?? 'Desconocido';

    $auditoria_query = "INSERT INTO auditoria_oficios (
        usuario_id,
        accion,
        numero_oficio,
        numero_oficio_usuario,
        ip_address,
        user_agent
    ) VALUES (?, ?, ?, ?, ?, ?)";

    $stmt_auditoria = $conn->prepare($auditoria_query);
    $stmt_auditoria->bind_param('isssss', 
        $usuario_id,
        $accion,
        $numero_oficio,
        $numero_oficio_usuario,
        $ip_address,
        $user_agent
    );
    $stmt_auditoria->execute();

    // ===== 8. FINALIZACIÓN =====
    mysqli_query($conn, "UNLOCK TABLES");
    $conn->commit();

    $_SESSION['success'] = "Documento $numero_oficio registrado correctamente";
    header("Location: index.php");
    exit;

} catch (Exception $e) {
    $conn->rollback();
    mysqli_query($conn, "UNLOCK TABLES");
    
    if (isset($pdf_path) && file_exists($pdf_path)) {
        @unlink($pdf_path);
    }

    error_log("Error en guardar.php: ".$e->getMessage());
    $_SESSION['error'] = "Error al procesar: ".$e->getMessage();
    header("Location: index.php");
    exit;
}
