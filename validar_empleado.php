<?php
require 'database.php';

header('Content-Type: application/json');

$numero = $_GET['numero'] ?? '';
if (empty($numero)) {
    echo json_encode(['error' => 'Número requerido']);
    exit;
}

$query = "SELECT nombre FROM catalogo_personal WHERE numero_empleado = ?";
$stmt = mysqli_prepare($conn, $query);
mysqli_stmt_bind_param($stmt, 's', $numero);
mysqli_stmt_execute($stmt);
$result = mysqli_stmt_get_result($stmt);

if ($empleado = mysqli_fetch_assoc($result)) {
    echo json_encode(['existe' => true, 'nombre' => $empleado['nombre']]);
} else {
    echo json_encode(['existe' => false]);
}