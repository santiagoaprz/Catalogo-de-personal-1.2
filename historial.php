<?php
// Evitar que la conexión se cierre prematuramente
register_shutdown_function(function() {
    global $conn;
    if (isset($conn)) {
        $conn = null; // Limpiar sin cerrar explícitamente
    }
});

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
    COALESCE(d.numero_oficio_usuario, d.numero_oficio) AS numero_oficio_mostrar,
    d.remitente,
    COALESCE(d.email_institucional, 'No especificado') AS email_institucional,
    d.asunto, 
    d.tipo,
    d.jud_destino,
    d.estatus,
    DATE_FORMAT(d.fecha_entrega, '%d/%m/%Y') AS fecha_entrega_format,
    d.pdf_url,
    u.username AS usuario_registro
FROM documentos d
LEFT JOIN usuarios u ON d.usuario_registra = u.id
WHERE d.remitente IS NOT NULL
ORDER BY d.fecha_creacion DESC, d.id DESC";

$result = mysqli_query($conn, $query);

if (!$result) {
    die("Error en la consulta: " . mysqli_error($conn));
}
?>

<?php
require 'session_config.php';
require 'auth_middleware.php';
requireAuth();
require 'database.php';

header("Cache-Control: no-cache, no-store, must-revalidate");
header("Pragma: no-cache");
header("Expires: 0");

// Consulta segura y optimizada
$query = "SELECT 
    d.id, 
    d.numero_oficio,
    COALESCE(d.numero_oficio_usuario, d.numero_oficio) AS numero_oficio_mostrar,
    d.remitente,
    COALESCE(d.email_institucional, 'No especificado') AS email_institucional,
    d.asunto, 
    d.tipo,
    d.jud_destino,
    d.estatus,
    DATE_FORMAT(d.fecha_entrega, '%d/%m/%Y') AS fecha_entrega_format,
    d.pdf_url,
    u.username AS usuario_registro
FROM documentos d
LEFT JOIN usuarios u ON d.usuario_registra = u.id
WHERE d.remitente IS NOT NULL
ORDER BY d.fecha_creacion DESC, d.id DESC";

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
        /* [Mantén tus estilos actuales] */
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
                    <th>Email Institucional</th>
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
                    <td><?= htmlspecialchars($row['numero_oficio_mostrar'] ?? 'N/A') ?></td>
                    <td><?= htmlspecialchars($row['remitente'] ?? '') ?></td>
                    <td><?= htmlspecialchars($row['email_institucional'] ?? '') ?></td>
                    <td><?= htmlspecialchars($row['jud_destino'] ?? '') ?></td>
                    <td><?= htmlspecialchars(substr($row['asunto'] ?? '', 0, 50)) ?>...</td>
                    <td><?= htmlspecialchars($row['tipo'] ?? '') ?></td>
                    <td><?= htmlspecialchars($row['estatus'] ?? '') ?></td>
                    <td><?= htmlspecialchars($row['fecha_entrega_format'] ?? '') ?></td>
                    <td><?= htmlspecialchars($row['usuario_registro'] ?? '') ?></td>
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