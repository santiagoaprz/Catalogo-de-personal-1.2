<?php
function generarNumeroAutomatico($conn) {
    // Obtener el último número de empleado automático
    $query = "SELECT MAX(CAST(SUBSTRING(numero_empleado, 5) AS UNSIGNED)) as max_num 
              FROM catalogo_personal 
              WHERE numero_empleado LIKE 'EMP-%'";
    $result = mysqli_query($conn, $query);
    
    if (!$result) {
        throw new Exception("Error al generar número automático: " . mysqli_error($conn));
    }
    
    $row = mysqli_fetch_assoc($result);
    $next_num = ($row['max_num'] ?? 0) + 1;
    return 'EMP-' . str_pad($next_num, 5, '0', STR_PAD_LEFT);
}

function validarCorreoInstitucional($email) {
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        return false;
    }
    return preg_match('/@tlalpan\.cdmx\.gob\.mx$/i', $email);
}

function actualizarCatalogoPersonal($conn, $datos) {
    $email = strtolower(trim($datos['email_institucional']));
    
    $check = $conn->prepare("SELECT id, numero_empleado FROM catalogo_personal WHERE email_institucional = ?");
    if (!$check) {
        throw new Exception("Error al preparar consulta: " . $conn->error);
    }
    
    $check->bind_param('s', $email);
    $check->execute();
    $result = $check->get_result();
    
    if ($result->num_rows > 0) {
        // Actualizar registro existente
        $row = $result->fetch_assoc();
        $personal_id = $row['id'];
        
        if (!preg_match('/^EMP-\d{5}$/', $row['numero_empleado'])) {
            $numero_empleado = generarNumeroAutomatico($conn);
            $update_num = $conn->prepare("UPDATE catalogo_personal SET numero_empleado = ? WHERE id = ?");
            $update_num->bind_param('si', $numero_empleado, $personal_id);
            $update_num->execute();
        }
        
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
            $datos['remitente'],
            $datos['cargo_remitente'],
            $datos['depto_remitente'],
            $datos['telefono'],
            $datos['extension'],
            $personal_id
        );
        
        if (!$update->execute()) {
            throw new Exception("Error al actualizar personal: " . $update->error);
        }
        
        return $personal_id; // Siempre retorna solo el ID
    } else {
        $numero_empleado = generarNumeroAutomatico($conn);
        
        $insert = $conn->prepare("
            INSERT INTO catalogo_personal (
                numero_empleado, nombre, puesto, departamento_jud,
                telefono, extension, email_institucional, fecha_registro
            ) VALUES (?, ?, ?, ?, ?, ?, ?, NOW())
        ");
        
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
        
        if (!$insert->execute()) {
            throw new Exception("Error al insertar personal: " . $insert->error);
        }
        
        return $conn->insert_id; // Siempre retorna solo el ID
    }
}

function generarNumeroEmpleado($conn) {
    // Alias para compatibilidad con código existente
    return generarNumeroAutomatico($conn);
}


function registrarHistorial($conn, $documento_id, $accion, $descripcion, $usuario_id) {
    $insert = $conn->prepare("
        INSERT INTO historial_departamentos (
            documento_id, accion, descripcion, usuario_registra, fecha_cambio
        ) VALUES (?, ?, ?, ?, NOW())
    ");
    $insert->bind_param('issi', $documento_id, $accion, $descripcion, $usuario_id);
    
    if (!$insert->execute()) {
        throw new Exception("Error al registrar en historial: " . $insert->error);
    }
}