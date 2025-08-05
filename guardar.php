<?php

// Activar reporte de errores completo
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Registrar todos los errores en un archivo
ini_set('log_errors', 1);
ini_set('error_log', __DIR__ . '/php_errors.log');

if (session_status() === PHP_SESSION_NONE) session_start();

require 'session_config.php';
require 'funciones.php';
require 'database.php';
if (!$conn) {
    die(json_encode(['error' => "Error de conexión: " . mysqli_connect_error()]));
}

// Debug: Verificar datos recibidos
error_log("Datos recibidos: " . print_r($_POST, true));
error_log("Archivos recibidos: " . print_r($_FILES, true));

// Validaciones básicas
if (empty($_POST['email_institucional'])) {
    die(json_encode(['error' => "El correo institucional es obligatorio"]));
}

// Procesar PDF
$upload_dir = $_SERVER['DOCUMENT_ROOT'] . '/SISTEMA_OFICIOS/pdfs/';
if (!file_exists($upload_dir)) {
    mkdir($upload_dir, 0755, true);
}

$pdf_nombre = 'doc_' . time() . '_' . bin2hex(random_bytes(4)) . '.pdf';
$pdf_destino = $upload_dir . $pdf_nombre;

if (!move_uploaded_file($_FILES['pdf_file']['tmp_name'], $pdf_destino)) {
    die(json_encode(['error' => "Error al subir el PDF"]));
}

// Obtener próximo número de oficio
$secuencia = mysqli_query($conn, "SELECT ultimo_numero FROM secuencia_oficios LIMIT 1");
$row = mysqli_fetch_assoc($secuencia);
$proximo_numero = $row['ultimo_numero'] + 1;
$numero_oficio = "OF-" . str_pad($proximo_numero, 5, '0', STR_PAD_LEFT);

// Insertar en catálogo de personal (versión simplificada)
$email = mysqli_real_escape_string($conn, $_POST['email_institucional']);
$nombre = mysqli_real_escape_string($conn, $_POST['remitente']);
$query_personal = "INSERT INTO catalogo_personal (
    email_institucional, nombre, puesto, departamento_jud, telefono, extension
) VALUES (
    '$email', '$nombre', 
    '" . mysqli_real_escape_string($conn, $_POST['cargo_remitente']) . "',
    '" . mysqli_real_escape_string($conn, $_POST['depto_remitente']) . "',
    '" . mysqli_real_escape_string($conn, $_POST['telefono']) . "',
    '" . mysqli_real_escape_string($conn, $_POST['extension'] ?? '') . "'
) ON DUPLICATE KEY UPDATE 
    puesto = VALUES(puesto),
    departamento_jud = VALUES(departamento_jud),
    telefono = VALUES(telefono),
    extension = VALUES(extension)";

if (!mysqli_query($conn, $query_personal)) {
    unlink($pdf_destino);
    die(json_encode(['error' => "Error al actualizar catálogo: " . mysqli_error($conn)]));
}

// Insertar documento
$query_documento = "INSERT INTO documentos (
    fecha_creacion, fecha_entrega, numero_oficio, numero_oficio_usuario,
    remitente, cargo_remitente, depto_remitente, telefono, extension,
    asunto, tipo, estatus, pdf_url, jud_destino,
    email_institucional, dire_fisica, usuario_registra
) VALUES (
    NOW(), '" . mysqli_real_escape_string($conn, $_POST['fecha_entrega']) . "',
    '$numero_oficio', '" . mysqli_real_escape_string($conn, $_POST['numero_oficio_usuario']) . "',
    '$nombre', 
    '" . mysqli_real_escape_string($conn, $_POST['cargo_remitente']) . "',
    '" . mysqli_real_escape_string($conn, $_POST['depto_remitente']) . "',
    '" . mysqli_real_escape_string($conn, $_POST['telefono']) . "',
    '" . mysqli_real_escape_string($conn, $_POST['extension'] ?? '') . "',
    '" . mysqli_real_escape_string($conn, $_POST['asunto']) . "',
    '" . mysqli_real_escape_string($conn, $_POST['tipo']) . "',
    '" . mysqli_real_escape_string($conn, $_POST['estatus']) . "',
    '" . mysqli_real_escape_string($conn, $pdf_destino) . "',
    '" . mysqli_real_escape_string($conn, $_POST['jud_destino']) . "',
    '$email',
    '" . mysqli_real_escape_string($conn, $_POST['dire_fisica'] ?? '') . "',
    " . (int)$_SESSION['user']['id'] . "
)";

if (mysqli_query($conn, $query_documento)) {
    // Actualizar secuencia
    mysqli_query($conn, "UPDATE secuencia_oficios SET ultimo_numero = $proximo_numero");
    
    $_SESSION['success'] = "Documento guardado correctamente!";
    header("Location: index.php");
    exit;
} else {
    unlink($pdf_destino);
    die(json_encode(['error' => "Error al guardar documento: " . mysqli_error($conn)]));
}

