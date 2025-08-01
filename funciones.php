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

function actualizarCatalogoPersonal($conn, $datos) {
    // Verificar si el correo ya existe en el catálogo
    $check = $conn->prepare("SELECT id FROM catalogo_personal WHERE email_institucional = ?");
    $check->bind_param('s', $datos['email_institucional']);
    $check->execute();
    $result = $check->get_result();
    
    if ($result->num_rows > 0) {
        // Obtener ID existente
        $row = $result->fetch_assoc();
        $personal_id = $row['id'];
        
        // Actualizar registro existente
        $update = $conn->prepare("
            UPDATE catalogo_personal SET 
                nombre = ?,
                puesto = ?,
                departamento_jud = ?,
                telefono = ?,
                extension = ?,
                ultima_actualizacion = NOW()
            WHERE id = ?  // Cambiamos a WHERE id = ? para mayor seguridad
        ");
        $update->bind_param(
            'sssssi',
            $datos['remitente'],
            $datos['cargo_remitente'],
            $datos['depto_remitente'],
            $datos['telefono'],
            $datos['extension'],
            $personal_id
        );
        $update->execute();
        return $personal_id;  // Devolvemos el ID existente
    } else {
        // Insertar nuevo registro
        $insert = $conn->prepare("
            INSERT INTO catalogo_personal (
                numero_empleado, nombre, puesto, departamento_jud,
                telefono, extension, email_institucional
            ) VALUES (?, ?, ?, ?, ?, ?, ?)
        ");
        $numero_empleado = $datos['numero_empleado'] ?? generarNumeroEmpleado($conn);
        $insert->bind_param(
            'sssssss',
            $numero_empleado,
            $datos['remitente'],
            $datos['cargo_remitente'],
            $datos['depto_remitente'],
            $datos['telefono'],
            $datos['extension'],
            $datos['email_institucional']
        );
        $insert->execute();
        return $conn->insert_id;
    }
}

function generarNumeroAutomatico($conn) {
    // Obtener el último número de empleado
    $query = "SELECT MAX(CAST(numero_empleado AS UNSIGNED)) as max_num FROM catalogo_personal";
    $result = mysqli_query($conn, $query);
    $row = mysqli_fetch_assoc($result);
    
    // Generar nuevo número (último + 1 o 1000 si no hay registros)
    $nuevo_numero = ($row['max_num'] ? $row['max_num'] + 1 : 1000);
    
    return str_pad($nuevo_numero, 4, '0', STR_PAD_LEFT);
}