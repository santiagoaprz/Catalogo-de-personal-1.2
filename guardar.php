<?php
if (session_status() === PHP_SESSION_NONE) session_start();

require 'session_config.php';
require 'database.php';
require 'auth_middleware.php';
requireAuth();
requireRole(['SISTEMAS', 'ADMIN', 'CAPTURISTA']);

error_reporting(E_ALL);
ini_set('display_errors', 1);

if (!isset($_SESSION['user']['id'])) {
    die(json_encode(['error' => 'Sesión no válida', 'details' => 'ID de usuario no encontrado']));
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    die(json_encode(['error' => 'Método no permitido']));
}

if (empty($_FILES['pdf_file']['tmp_name'])) {
    die(json_encode(['error' => 'Archivo PDF requerido']));
}

$numero_empleado = preg_replace('/[^A-Za-z0-9\-]/', '', trim($_POST['numero_empleado']));
if (empty($numero_empleado)) {
    die(json_encode(['error' => 'Número de empleado inválido']));
}

$conn->begin_transaction();

try {
    // ===== GENERACIÓN DE NÚMERO DE OFICIO =====
    mysqli_query($conn, "LOCK TABLES secuencia_oficios WRITE, catalogo_personal WRITE, documentos WRITE");
    $seq_result = mysqli_query($conn, "SELECT ultimo_numero FROM secuencia_oficios LIMIT 1");
    $seq_row = mysqli_fetch_assoc($seq_result);
    $nuevo_numero = (int)$seq_row['ultimo_numero'] + 1;
    mysqli_query($conn, "UPDATE secuencia_oficios SET ultimo_numero = $nuevo_numero");
    
    $numero_oficio = "OF-".str_pad($nuevo_numero, 5, '0', STR_PAD_LEFT);

    // ===== PREPARAR VARIABLES PARA INSERCIÓN =====
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

    // ===== PROCESAMIENTO DEL PDF =====
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
    $pdf_path = 'pdfs/' . $pdf_name;

    if (!move_uploaded_file($_FILES['pdf_file']['tmp_name'], $pdf_path)) {
        throw new Exception("Error al mover el PDF. Verifique permisos.");
    }
    error_log("PDF guardado en: " . realpath($pdf_path));
error_log("URL accesible: http://localhost/SISTEMA_OFICIOS/" . $pdf_path);

    // ===== VALIDACIÓN DE CAMPOS REQUERIDOS =====
    $required = ['fecha_entrega', 'asunto', 'tipo', 'estatus'];
    foreach ($required as $field) {
        if (empty($_POST[$field])) {
            throw new Exception("Campo requerido faltante: $field");
        }
    }

    // ===== GESTIÓN DE EMPLEADOS =====
    $check_query = "SELECT departamento_jud FROM catalogo_personal WHERE numero_empleado = ? LIMIT 1";
$stmt_check = $conn->prepare($check_query);
$stmt_check->bind_param('s', $numero_empleado);
$stmt_check->execute();
$empleado = $stmt_check->get_result()->fetch_assoc();

if ($empleado) {
    // Empleado existente - actualizar departamento si cambió
    $depto_actual = $empleado['departamento_jud'];
    if ($depto_actual !== $depto_remitente) {
        // Guardar historial antes de actualizar
        $historial_query = "INSERT INTO historial_departamentos 
            (numero_empleado, departamento_jud) 
            VALUES (?, ?)";
        $stmt_historial = $conn->prepare($historial_query);
        $stmt_historial->bind_param('ss', $numero_empleado, $depto_actual);
        $stmt_historial->execute();

        // Registrar el cambio en historial_departamentos
$historial_query = "INSERT INTO historial_departamentos (
    numero_empleado, 
    departamento_anterior, 
    departamento_nuevo, 
    usuario_registra,
    numero_oficio_usuario
) VALUES (?, ?, ?, ?, ?)";

$stmt_historial = $conn->prepare($historial_query);
$stmt_historial->bind_param('sssis', 
    $numero_empleado,
    $empleado ? $empleado['departamento_jud'] : 'Nuevo ingreso',
    $depto_remitente,
    $usuario_id,
    $numero_oficio_usuario
);
$stmt_historial->execute();

        // Actualizar departamento
        $update_query = "UPDATE catalogo_personal SET 
            departamento_jud = ?,
            telefono = ?,
            extension = ?,
            ultima_actualizacion = CURRENT_TIMESTAMP
            WHERE numero_empleado = ?";
        $stmt_update = $conn->prepare($update_query);
        $stmt_update->bind_param('ssss', $depto_remitente, $telefono, $extension, $numero_empleado);
        $stmt_update->execute();
    }
} else {
    // Nuevo empleado - insertar en catalogo_personal
    $insert_query = "INSERT INTO catalogo_personal 
        (numero_empleado, nombre, puesto, departamento_jud, dire_fisica, telefono, extension) 
        VALUES (?, ?, ?, ?, ?, ?, ?)";
    $stmt_insert = $conn->prepare($insert_query);
    $stmt_insert->bind_param('sssssss', 
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

    // ===== INSERCIÓN DEL DOCUMENTO =====
    $insert_doc_query = "INSERT INTO documentos (
        fecha_entrega, numero_oficio, numero_oficio_usuario, remitente, cargo_remitente, 
        depto_remitente, telefono, asunto, tipo, estatus, 
        pdf_url, destinatario, jud_destino, numero_empleado,
        dire_fisica, usuario_registra, etapa
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    
    $stmt_doc = $conn->prepare($insert_doc_query);
    $stmt_doc->bind_param('sssssssssssssssis',
        $fecha_entrega,
        $numero_oficio,
        $numero_oficio_usuario,  // Número capturado por el usuario
        $remitente,              // Nombre del remitente
        $cargo_remitente,
        $depto_remitente,
        $telefono,
        $asunto,
        $tipo,
        $estatus,
        $pdf_path,
        $destinatario,
        $jud_destino,
        $numero_empleado,
        $dire_fisica,
        $usuario_id,
        $etapa
    );
    
    if (!$stmt_doc->execute()) {
        throw new Exception("Error al guardar documento: ".$stmt_doc->error);
    }


// ===== REGISTRO EN AUDITORÍA =====
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



    mysqli_query($conn, "UNLOCK TABLES");
    $conn->commit();

    $_SESSION['success'] = "Documento $numero_oficio registrado correctamente";
    header("Location: index.php?rand=".rand());
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