-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-06-2025 a las 21:11:32
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `alcaldia_control`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `catalogo_personal`
--

CREATE TABLE `catalogo_personal` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `puesto` varchar(100) NOT NULL,
  `dire_admon` varchar(100) DEFAULT NULL,
  `dire_fisica` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `ultima_actualizacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `catalogo_personal`
--

INSERT INTO `catalogo_personal` (`id`, `nombre`, `puesto`, `dire_admon`, `dire_fisica`, `telefono`, `fecha_registro`, `ultima_actualizacion`) VALUES
(1, 'LORENA', 'SECRETARIA', 'DESARROLLO DE SISTEMAS', NULL, NULL, '2025-05-21 17:43:29', '2025-05-22 16:06:05'),
(2, 'a santiago', 'AUX SISTEMAS', 'DESARROLLO DE SISTEMAS', 'CALLE MONEDA SIN NUMERO', '5548857963', '2025-05-21 17:51:50', '2025-05-27 16:32:06'),
(5, 'A SANTIAGO', 'AUX', 'DESARROLLO DE SISTEMAS', 'MONEDA SIN NUMERO', '556699887766', '2025-05-21 18:01:16', '2025-05-22 16:06:05'),
(7, 'EMI', 'AUX', 'DESARROLLO DE SISTEMAS', 'MONEDA SIN NUMERO', '5566778899', '2025-05-21 18:05:22', '2025-05-22 16:06:05'),
(9, 'RICARDO', 'AUX SISTEMAS', 'SOPORTE TECNICO', '', '', '2025-05-21 18:13:45', '2025-05-22 18:04:22'),
(24, 'A SANTIAGO', 'PROGRAMACION', 'ALCALDIA TLALPAN', 'VIVANCO SIN NUMERO', '5548899665', '2025-05-27 19:54:26', '2025-05-27 19:54:26'),
(25, 'A SANTIAGO', 'AUX DE SERVICIOS', 'DESARROLLO DE SISTEMAS', 'MONEDA S/NUMERO', '55112233665544', '2025-05-28 18:37:17', '2025-06-09 20:44:09'),
(26, 'a santiago', 'aux de sistemas', 'Desarrollo', 'av moneda s/numero', '548648653', '2025-06-03 20:27:05', '2025-06-03 20:29:07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion`
--

CREATE TABLE `configuracion` (
  `id` int(11) NOT NULL,
  `clave` varchar(50) NOT NULL,
  `valor` text NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `editable` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documentos`
--

CREATE TABLE `documentos` (
  `id` int(11) NOT NULL,
  `fecha_entrega` date NOT NULL,
  `fecha_recepcion` date DEFAULT NULL,
  `numero_oficio` varchar(50) NOT NULL,
  `remitente` varchar(100) NOT NULL,
  `cargo_remitente` varchar(100) NOT NULL,
  `depto_remitente` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `asunto` text NOT NULL,
  `tipo` enum('OFICIO','TURNO','CIRCULAR','NOTA_INFORMATIVA','CONOCIMIENTO') NOT NULL,
  `estatus` enum('SEGUIMIENTO','ATENDIDO','TURNADO') NOT NULL,
  `pdf_url` varchar(255) NOT NULL,
  `etapa` enum('RECIBIDO','RESPUESTA','ACUSE') DEFAULT 'RECIBIDO',
  `fecha_respuesta` date DEFAULT NULL,
  `destinatario` varchar(255) DEFAULT NULL,
  `usuario_responde` int(11) DEFAULT NULL,
  `usuario_acusa` int(11) DEFAULT NULL,
  `fecha_acuse` date DEFAULT NULL,
  `dire_fisica` varchar(255) DEFAULT NULL,
  `usuario_registra` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `documentos`
--

INSERT INTO `documentos` (`id`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`) VALUES
(1, '2025-05-19', NULL, 'OFICINA1', 'A SANTIAGO', 'AUX SISTEMAS', 'DESARROLLO DE SISTEMAS', NULL, 'PRUEBA EN OFICINA 1', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/REVISION_DE_SERVIDOR_PARA_SIPS_2025_ALEXIS_SANTIAGO.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, '2025-05-19', NULL, 'PRUEBA2', 'SSANTIAGO', 'AUX SISTEMAS', 'DESARROLLO DE SISTEMAS', NULL, 'PRUEBA2 PARA VER CARGA CORRECTA PDF', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/REVISION_DE_SERVIDOR_PARA_SIPS_2025_ALEXIS_SANTIAGO.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, '2025-05-21', NULL, 'PRUBEA3', 'A SANTIAGO', 'AUX SISTEMAS', 'DESARROLLO DE SISTEMAS', NULL, 'PRUEBA 3 EN OTRO DIA PARA INICIAR NUEVAS PRUEBAS EL DIA DE HOY', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/Programacion-con-PHP.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, '2025-05-21', NULL, 'PRUEBA4', 'A SANTIAGO', 'AUX SISTEMAS', 'DESARROLLO DE SISTEMAS', NULL, 'SEGUNDA PRUEBA DEL DIA DE HOY PARA VER SU COMPORTAMIENTO', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/ServidorWebCentosNgix_v2.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, '2025-05-21', NULL, 'prueba 5', 'LORENA', 'SECRETARIA', 'DESARROLLO DE SISTEMAS', NULL, 'VERIFICACION PERSONAL JUDDS', 'NOTA_INFORMATIVA', 'TURNADO', 'pdfs/Algoritmo_SIPS_MAYO_2025.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, '2025-05-21', NULL, 'prueba 6', 'a santiago', 'AUX SISTEMAS', 'DESARROLLO DE SISTEMAS', NULL, 'VERIFICACION DE AUTOCPLETADO CATALOGO PERSONAL', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/CASO_DE_USO.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, '2025-05-21', NULL, 'PRUEBA 6', 'A SANTIAGO', 'AUX SISTEMAS', 'DESARROLLO DE SISTEMAS', NULL, 'VERIFICACION DE AUTOCPLETADO PERSONA NO GUARDA ALGUNOS', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/NOTA_INFORMATIVA_ALEXIS_SANTIAGO_NIVEL_5_RH_.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, '2025-05-21', NULL, 'PRUEBA 7', 'A SANTIAGO', 'AUX SISTEMAS', 'DE', NULL, 'NO SE GUARDAN INFO EN AUTOCOMPLEETADO', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/Algoritmo_SIPS_MAYO_2025.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(9, '2025-05-22', NULL, '8', 'A SANTIAGO', 'AUX', 'DESARROLLO DE SISTEMAS', NULL, 'VERIFICACION DE AUTOCOMPLETADO', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/sabadoSIPS_POR_JESUS.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10, '2025-05-21', NULL, 'PRUEBA 9', 'A SANTIAGO', 'AUX SISTEMAS', 'DESARROLLO DE SISTEMAS', NULL, 'NO SE GUARDAN O SE RESCRIBEN', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/sabadoSIPS_POR_JESUS.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11, '2025-05-21', NULL, 'PRUEBA 10', 'EMI', 'AUX', 'DESARROLLO DE SISTEMAS', NULL, 'SE SOOBREESCRIBEN DATOS AL PARECER', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/NOTA_INFORMATIVA_ALEXIS_SANTIAGO_NIVEL_5_RH_.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(12, '2025-05-21', NULL, 'PRUEBA 11', 'EMI', 'AUX', 'DESARROLLO DE SISTEMAS', NULL, 'SE SIGUE VERIFICANDO USO', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/NOTA_INFORMATIVA_ALEXIS_SANTIAGO_NIVEL_5_RH_.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(13, '2025-05-21', NULL, 'PRUEBA 12', 'RICARDO', 'AUX SISTEMAS', 'DESARROLLO DE SISTEMAS', NULL, 'SE SIGUEN LAS PRUEBAS DE SOBREESCRITURA', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/sabadoSIPS_POR_JESUS.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(14, '2024-05-22', NULL, 'prueba 13', 'A SANTIAGO', 'AUX SISTEMAS', 'Soporte tecnivo', NULL, 'PRUEBA DE ACTUALIZACION E HISTORIAL DE USUARIO', 'NOTA_INFORMATIVA', 'TURNADO', '', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(15, '2025-05-22', NULL, 'PRUEBA 14', 'A SANTIAGO', 'AUX SISTEMAS', 'Soporte tecnivo', NULL, 'PRUEBA DE ACTUALIZACION E HISTORIAL DE USUARIO en el 13 no se reflejaba el pdf subido ni se actualiza la base de datos catalogo', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', '', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(16, '2025-05-22', NULL, 'prueba 15', 'A SANTIAGO', 'AUX SISTEMAS', 'MODERNIZACION', NULL, 'PRUEBA DE ACTUALIZACION E HISTORIAL DE USUARIO en el 13 no se reflejaba el pdf subido ni se actualiza la base de datos DOCUMENTOS NO APARECE EL PDF_URL', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/doc_20250522_195703_682f656f3d988.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(17, '2025-05-22', NULL, 'prueba 16', 'RICARDO', 'AUX SISTEMAS', 'SOPORTE TECNICO', NULL, 'PRUEBA DE ACTUALIZACION E HISTORIAL DE USUARIO en el 14 no se reflejaba el pdf subiDO', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250522_200421_682f6725eabe8.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(18, '2025-05-27', NULL, 'PRUEBA 17', 'A SANTIAGO', 'AUX SISTEMAS', 'DESARROLLO DE SISTEMAS', '5548857963', 'SE AGREGAN USUARIOS, SE CORRIE SUBIDA PDF ADEMAS DE AGREGAR CARACTERISITICAS ADICIONALES', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250527_215058_683617a23ff9e.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, 'CALLE MONEDA SIN NUMERO', 1),
(19, '2025-05-27', NULL, 'prueba 18', 'A SANTIAGO', 'PROGRAMACION', 'ALCALDIA TLALPAN', '5548899665', 'SE CREA USUARIO ADMIN, PDF CORRECTO, HISTORIAL DE USUARIO,SE AGREGA TELEFONO Y SE REALIZAN PRUEBAS', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/doc_20250527_215426_683618725d2a2.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, 'VIVANCO SIN NUMERO', 1),
(20, '2025-05-28', NULL, 'PRUEBA 19', 'A SANTIAGO', 'AUX DE SERVICIOS', 'DESARROLLO DE SISTEMAS', '5513697876', 'SE AGREGAN MODULOS, SESIONES Y PRUEBAS DE SUBIDA PDF', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/doc_20250528_203717_683757dd0112a.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, 'CALLE MONEDA SIN NUMERO', 1),
(21, '2025-06-03', NULL, '20', 'a santiago', 'aux de sistemas', 'Desarrollo', '5565655625', 'prueba no me deja subir desde admin por falta de permisos', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/doc_20250603_222705_683f5a9932bd2.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, 'vivanco s/numero', 2),
(22, '2025-06-03', NULL, '21', 'a santiago', 'aux de sistemas', 'Desarrollo', '548648653', 'SI ME DEJA SUBIRLO DESDE JUDDS\r\nSISTEMAS NO\r\nSE REALIZA DESDE CAPTURISTA1', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250603_222907_683f5b1379e3d.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, 'av moneda s/numero', 3),
(23, '2025-06-06', NULL, '22', 'A SANTIAGO', 'AUX DE SERVICIOS', 'DESARROLLO DE SISTEMAS', '5548857606', 'Prueba de captura de datos, carga pdf y complementos de usuario desde judds\r\nADMIN MARCA PERMISOS DENEGADOS', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/doc_20250606_182852_684317442dcf3.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, 'MONEDA S/NUMERO', 2),
(24, '2025-06-06', NULL, '23', 'A SANTIAGO', 'AUX DE SERVICIOS', 'DESARROLLO DE SISTEMAS', '5548857606', 'Se debe ingresar con capturista1\r\nPrueba de carga de pdf', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/doc_20250606_184006_684319e66739c.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, 'MONEDA S/NUMERO', 3),
(25, '2025-06-09', NULL, '24', 'A SANTIAGO', 'AUX DE SERVICIOS', 'DESARROLLO DE SISTEMAS', '5548857606', 'captura de datos y carga de pdf\r\nDESDE ADMIN SIGUE DENEGANDO PERMISOS', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250609_220056_68473d7883290.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, 'MONEDA S/NUMERO', 2),
(26, '2025-06-09', NULL, '25', 'A SANTIAGO', 'AUX DE SERVICIOS', 'DESARROLLO DE SISTEMAS', '5548857606', 'captura de datos y carga de pdf \r\nADMIN NO SE PUEDE\r\nJUDDS SI SE PUEDE\r\nAHORA SE INTENTA POR CAPTURISTA1', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250609_220226_68473dd25356a.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, 'MONEDA S/NUMERO', 3),
(27, '2025-06-09', NULL, '25', 'A SANTIAGO', 'AUX DE SERVICIOS', 'DESARROLLO DE SISTEMAS', '55112233665544', 'Se realizan cambios y verificaciones para poder capturar y subir pdf desde usuario ADMIN/SISTEMAS', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/doc_20250609_224409_68474799dec7c.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, 'MONEDA S/NUMERO', 1),
(28, '2025-06-09', NULL, '26', 'A SANTIAGO', 'AUX DE SERVICIOS', 'DESARROLLO DE SISTEMAS', '55112233665544', 'Ya se puede capturar y subir desde usuario Admin/Sistemas, pero al momento de ir al historial no aparece en el, pero si en oficios registrados\r\nESTA PRUEBA ES DESDE JUDDS', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250609_224752_68474878bc18d.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, 'MONEDA S/NUMERO', 2),
(29, '2025-06-09', NULL, '27', 'A SANTIAGO', 'AUX DE SERVICIOS', 'DESARROLLO DE SISTEMAS', '55112233665544', 'Se logra capturar, guardar pdf e ingresar al historial desde cualquier usuario', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250609_225629_68474a7d2d64c.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, 'MONEDA S/NUMERO', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_departamentos`
--

CREATE TABLE `historial_departamentos` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `departamento_anterior` varchar(100) DEFAULT NULL,
  `departamento_nuevo` varchar(100) DEFAULT NULL,
  `fecha_cambio` timestamp NOT NULL DEFAULT current_timestamp(),
  `usuario_registra` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `historial_departamentos`
--

INSERT INTO `historial_departamentos` (`id`, `usuario_id`, `departamento_anterior`, `departamento_nuevo`, `fecha_cambio`, `usuario_registra`) VALUES
(1, 2, 'DESARROLLO DE SISTEMAS', 'Soporte tecnivo', '2025-05-22 17:06:52', 0),
(2, 2, 'Soporte tecnivo', 'MODERNIZACION', '2025-05-22 17:47:04', 0),
(3, 9, 'DESARROLLO DE SISTEMAS', 'SOPORTE TECNICO', '2025-05-22 18:04:21', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logs_sistema`
--

CREATE TABLE `logs_sistema` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `accion` varchar(100) NOT NULL,
  `detalles` text DEFAULT NULL,
  `ip` varchar(45) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modulos`
--

CREATE TABLE `modulos` (
  `id` int(11) NOT NULL,
  `codigo` varchar(10) DEFAULT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

CREATE TABLE `permisos` (
  `usuario_id` int(11) NOT NULL,
  `modulo_id` int(11) NOT NULL,
  `nivel_acceso` enum('LECTURA','ESCRITURA','TOTAL') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `nombre_completo` varchar(100) DEFAULT NULL,
  `rol` enum('SISTEMAS','ADMIN','CAPTURISTA') DEFAULT NULL,
  `departamento` varchar(50) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `ultimo_acceso` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `username`, `password`, `nombre_completo`, `rol`, `departamento`, `activo`, `fecha_creacion`, `ultimo_acceso`) VALUES
(1, 'admin', '$2y$10$WBCaSgMZraXILd65Bnym..2P3S2QZTWmXApQjkSGYhG4ks6Ya90Oi', 'Administrador Principal', 'SISTEMAS', NULL, 1, '2025-05-29 17:15:33', NULL),
(2, 'judds', '$2y$10$2W7JFfRstQhcswqYgJHXyuZchIELRpGoTBETXzbg1lG2hL5/yV8UO', 'Administrador JUDDS', 'ADMIN', NULL, 1, '2025-05-29 17:15:33', NULL),
(3, 'capturista1', '$2y$10$OrPW2kExuEpctZUKO74X9eW3w/VfVuKxJZ7yLmsvqXLueZ93ubwBK', 'Capturista Principal', 'CAPTURISTA', NULL, 1, '2025-05-29 17:15:33', NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `catalogo_personal`
--
ALTER TABLE `catalogo_personal`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`,`puesto`),
  ADD UNIQUE KEY `unique_nombre_puesto` (`nombre`,`puesto`);

--
-- Indices de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `clave` (`clave`);

--
-- Indices de la tabla `documentos`
--
ALTER TABLE `documentos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `historial_departamentos`
--
ALTER TABLE `historial_departamentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `logs_sistema`
--
ALTER TABLE `logs_sistema`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `modulos`
--
ALTER TABLE `modulos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `codigo` (`codigo`);

--
-- Indices de la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD PRIMARY KEY (`usuario_id`,`modulo_id`),
  ADD KEY `modulo_id` (`modulo_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `catalogo_personal`
--
ALTER TABLE `catalogo_personal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `documentos`
--
ALTER TABLE `documentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de la tabla `historial_departamentos`
--
ALTER TABLE `historial_departamentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `logs_sistema`
--
ALTER TABLE `logs_sistema`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `modulos`
--
ALTER TABLE `modulos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `historial_departamentos`
--
ALTER TABLE `historial_departamentos`
  ADD CONSTRAINT `historial_departamentos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `catalogo_personal` (`id`);

--
-- Filtros para la tabla `logs_sistema`
--
ALTER TABLE `logs_sistema`
  ADD CONSTRAINT `logs_sistema_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD CONSTRAINT `permisos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `permisos_ibfk_2` FOREIGN KEY (`modulo_id`) REFERENCES `modulos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
