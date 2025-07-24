<?php
require 'session_config.php';
require 'auth_middleware.php';
requireAuth();
require 'database.php';

header("Cache-Control: no-cache, no-store, must-revalidate");
header("Pragma: no-cache");
header("Expires: 0");

// Consulta mejorada con más información
$query = "SELECT 
    d.id, 
    d.numero_oficio,
    d.numero_oficio_usuario,
    d.remitente,
    d.numero_empleado,
    IFNULL(cp.nombre, d.remitente) AS nombre_empleado, 
    d.asunto, 
    d.tipo,
    d.jud_destino,
    d.estatus,
    DATE_FORMAT(d.fecha_entrega, '%d/%m/%Y') AS fecha_entrega,
    d.pdf_url,
    u.username AS usuario_registro,
    (SELECT COUNT(*) FROM documentos WHERE numero_empleado = d.numero_empleado) AS total_documentos
FROM documentos d
LEFT JOIN catalogo_personal cp ON TRIM(d.numero_empleado) = TRIM(cp.numero_empleado)
LEFT JOIN usuarios u ON d.usuario_registra = u.id
ORDER BY d.fecha_entrega DESC, d.id DESC";

$result = mysqli_query($conn, $query);

if (!$result) {
    die("Error en la consulta: " . mysqli_error($conn));
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Historial de Documentos</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            line-height: 1.6;
        }
        .container {
            width: 90%;
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #3498db;
            color: white;
            font-weight: 600;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .pdf-link {
            color: #e74c3c;
            text-decoration: none;
            font-weight: bold;
        }
        .pdf-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Historial Completo de Documentos</h2>
        
        <table>
            <thead>
                <tr>
                    <th>Oficio</th>
                    <th>Remitente</th>
                    <th>N° Empleado</th>
                  
                    <th>Jud Destino</th>
                    <th>Asunto</th>
                    <th>Tipo</th>
                    <th>Estatus</th>
                    <th>Fecha Entrega</th>
                    <th>Usuario</th>
                    <th>PDF</th>
                </tr>
            </thead>
            <tbody>
                <?php while ($row = mysqli_fetch_assoc($result)): ?>
                <tr>
                    <td><?= htmlspecialchars($row['numero_oficio_usuario'] ?? 'N/A') ?></td>
                    <td><?= htmlspecialchars($row['remitente']) ?></td>
                    <td><?= htmlspecialchars($row['numero_empleado']) ?></td>
                    <td><?= htmlspecialchars($row['jud_destino']) ?></td>
                    <td><?= htmlspecialchars(substr($row['asunto'], 0, 50)) ?>...</td>
                    <td><?= htmlspecialchars($row['tipo']) ?></td>
                    <td><?= htmlspecialchars($row['estatus']) ?></td>
                    <td><?= htmlspecialchars($row['fecha_entrega']) ?></td>
                    <td><?= htmlspecialchars($row['usuario_registro']) ?></td>
                    <td>
                        <?php if (!empty($row['pdf_url'])): ?>
                            <a href="<?= htmlspecialchars($row['pdf_url']) ?>" target="_blank" class="pdf-link">📄</a>
                        <?php else: ?>
                            <span>No disponible</span>
                        <?php endif; ?>
                    </td>
                </tr>
                <?php endwhile; ?>
            </tbody>
        </table>
    </div>
</body>
</html>