<?php
function generarNumeroEmpleado($conn) {
    $prefix = 'EMP-';
    $query = "SELECT MAX(CAST(SUBSTRING(numero_empleado, 5) AS UNSIGNED)) as max_num 
              FROM catalogo_personal 
              WHERE numero_empleado LIKE 'EMP-%'";
    $result = mysqli_query($conn, $query);
    $row = mysqli_fetch_assoc($result);
    $next_num = ($row['max_num'] ?? 0) + 1;
    return $prefix . str_pad($next_num, 5, '0', STR_PAD_LEFT);
}

function validarCorreoInstitucional($email) {
    return filter_var($email, FILTER_VALIDATE_EMAIL) && 
           preg_match('/@tlalpan\.cdmx\.gob\.mx$/i', $email);
}

