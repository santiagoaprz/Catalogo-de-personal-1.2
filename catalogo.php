<?php
require 'session_config.php';
require 'auth_middleware.php';
requireAuth();
require 'database.php';

// Aumentamos el límite de GROUP_CONCAT
mysqli_query($conn, "SET SESSION group_concat_max_len = 1000000;");

// Consulta optimizada para el catálogo de personal
$query = "SELECT 
    cp.numero_empleado,
    cp.nombre,
    cp.puesto,
    cp.departamento_jud AS departamento_actual,
    COUNT(d.id) AS total_documentos
FROM catalogo_personal cp
LEFT JOIN documentos d ON cp.numero_empleado = d.numero_empleado
GROUP BY cp.numero_empleado
ORDER BY cp.nombre";

$result = mysqli_query($conn, $query);

if (!$result) {
    die("Error en la consulta: " . mysqli_error($conn));
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catálogo de Personal</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
            line-height: 1.6;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1, h2 {
            color: #5D2E36;
            margin-bottom: 10px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            font-size: 0.9em;
        }
        th, td {
            padding: 12px 15px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #5D2E36;
            color: white;
            position: sticky;
            top: 0;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .historial {
            max-width: 300px;
            white-space: normal;
            font-size: 0.9em;
        }
        .depto-actual {
            font-weight: bold;
            color: #5D2E36;
        }
        .btn {
            display: inline-block;
            background-color: #5D2E36;
            color: white;
            padding: 10px 15px;
            text-decoration: none;
            border-radius: 4px;
            margin: 10px 0;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #722F37;
        }
        .action-link {
            color: #5D2E36;
            text-decoration: none;
            margin-right: 10px;
        }
        .action-link:hover {
            text-decoration: underline;
        }
        .document-count {
            background-color: #5D2E36;
            color: white;
            padding: 2px 6px;
            border-radius: 10px;
            font-size: 0.8em;
        }
        @media (max-width: 768px) {
            table {
                display: block;
                overflow-x: auto;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Catálogo de Personal</h1>
        <h2>Relación de Personal con Historial de Departamentos JUD</h2>
        
        <a href="nuevo_personal.php" class="btn">➕ Agregar Nuevo Personal</a>
        
        <table>
            <thead>
                <tr>
                    <th>N° Empleado</th>
                    <th>Nombre</th>
                    <th>Puesto</th>
                    <th>Departamento Actual</th>
                    <th>Historial de Departamentos</th>
                    <th>Documentos</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <?php while ($row = mysqli_fetch_assoc($result)): ?>
                <tr>
                    <td><?= htmlspecialchars($row['numero_empleado']) ?></td>
                    <td><?= htmlspecialchars($row['nombre']) ?></td>
                    <td><?= htmlspecialchars($row['puesto']) ?></td>
                    <td><?= htmlspecialchars($row['departamento_actual']) ?></td>
                    <td class="historial">
                        <?php 
                        if (!empty($row['historial_deptos']) && $row['historial_deptos'] != 'Sin historial') {
                            echo str_replace('→', '<br>→', htmlspecialchars($row['historial_deptos']));
                        } else {
                            echo 'Sin historial registrado';
                        }
                        ?>
                    </td>
                    <td><?= $row['total_documentos'] ?></td>
                    <td>
                        <!-- Botones de acciones -->
                    </td>
                </tr>
                <?php endwhile; ?>
            </tbody>
        </table>
    </div>

    <script>
    // Función para actualizar departamento via AJAX
    function actualizarDepartamento(idPersonal, nuevoDepto) {
        if (confirm(`¿Cambiar departamento a ${nuevoDepto}?`)) {
            fetch('actualizar_departamento.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    id: idPersonal,
                    departamento: nuevoDepto
                })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Departamento actualizado correctamente');
                    location.reload();
                } else {
                    alert('Error: ' + data.message);
                }
            })
            .catch(error => {
                alert('Error en la conexión: ' + error);
            });
        }
    }
    </script>
</body>
</html>
