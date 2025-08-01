-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-08-2025 a las 18:58:45
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET FOREIGN_KEY_CHECKS=0;
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
CREATE DATABASE IF NOT EXISTS `alcaldia_control` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `alcaldia_control`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `reset_auto_increment`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `reset_auto_increment` ()   BEGIN
    DECLARE next_id INT;
    SELECT MAX(id) + 1 INTO next_id FROM documentos;
    SET @sql = CONCAT('ALTER TABLE documentos AUTO_INCREMENT = ', next_id);
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditoria_oficios`
--

DROP TABLE IF EXISTS `auditoria_oficios`;
CREATE TABLE `auditoria_oficios` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `accion` varchar(50) NOT NULL,
  `numero_oficio` varchar(20) DEFAULT NULL,
  `numero_oficio_usuario` varchar(50) DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `auditoria_oficios`:
--   `usuario_id`
--       `usuarios` -> `id`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `catalogo_personal`
--

DROP TABLE IF EXISTS `catalogo_personal`;
CREATE TABLE `catalogo_personal` (
  `id` int(11) NOT NULL,
  `numero_empleado` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `puesto` varchar(100) NOT NULL,
  `departamento_jud` varchar(100) NOT NULL DEFAULT 'SIN DEPARTAMENTO',
  `dire_fisica` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `extension` varchar(10) DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `ultima_actualizacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `email_institucional` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `catalogo_personal`:
--

--
-- Volcado de datos para la tabla `catalogo_personal`
--

INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(1, 'TEMP-1', 'LORENA', 'SECRETARIA', 'DESARROLLO DE SISTEMAS', NULL, NULL, NULL, '2025-05-21 17:43:29', '2025-07-31 19:17:10', 'temp_temp-1@institucion.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(2, 'TEMP-2', 'a santiago', 'AUX SISTEMAS', 'DESARROLLO DE SISTEMAS', 'CALLE MONEDA SIN NUMERO', '5548857963', NULL, '2025-05-21 17:51:50', '2025-07-31 19:17:10', 'temp_temp-2@institucion.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(5, 'TEMP-5', 'A SANTIAGO', 'AUX', 'DESARROLLO DE SISTEMAS', 'MONEDA SIN NUMERO', '556699887766', NULL, '2025-05-21 18:01:16', '2025-07-31 19:17:10', 'temp_temp-5@institucion.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(7, 'TEMP-7', 'EMI', 'AUX', 'DESARROLLO DE SISTEMAS', 'MONEDA SIN NUMERO', '5566778899', NULL, '2025-05-21 18:05:22', '2025-07-31 19:17:10', 'temp_temp-7@institucion.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(9, 'TEMP-9', 'RICARDO', 'AUX SISTEMAS', 'SOPORTE TECNICO', '', '', NULL, '2025-05-21 18:13:45', '2025-07-31 19:17:10', 'temp_temp-9@institucion.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(24, 'TEMP-24', 'A SANTIAGO', 'PROGRAMACION', 'J.U.D. de Desarrollo de Sistemas', 'MONEDA S/NUMERO', '55112233665544', NULL, '2025-05-27 19:54:26', '2025-07-31 19:17:10', 'temp_temp-24@institucion.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(25, 'TEMP-25', 'A SANTIAGO', 'AUX DE SERVICIOS', 'JUD de Desarrollo de Sistemas', 'MONEDA S/NUMERO', '55112233665544', NULL, '2025-05-28 18:37:17', '2025-07-31 19:17:10', 'temp_temp-25@institucion.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(26, 'TEMP-26', 'a santiago', 'aux de sistemas', 'Desarrollo', 'av moneda s/numero', '548648653', NULL, '2025-06-03 20:27:05', '2025-07-31 19:17:10', 'temp_temp-26@institucion.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(36, 'TEMP-36', 'BERNAL', 'AUX DE SERVICIOS', 'JUD de Desarrollo de Sistemas', 'CALLE MONEDA S/NUMERO', '454545466', NULL, '2025-06-12 20:35:34', '2025-07-31 19:17:10', 'temp_temp-36@institucion.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(37, 'TEMP-37', 'luis', 'captura', 'Subdirección de Servicios Generales', 'MONEDA S/NUMERO', '787897845585', NULL, '2025-06-13 18:19:02', '2025-07-31 19:17:10', 'temp_temp-37@institucion.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(38, 'TEMP-38', 'SERV', 'PROGRAMACION', 'J.U.D. de Desarrollo de Sistemas', 'MONEDA S/NUMERO', '528532554752575', NULL, '2025-06-13 19:53:13', '2025-07-31 19:17:10', 'temp_temp-38@institucion.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(41, 'TEMP-41', 'DIRECTOR', 'DIRECTOR', 'DIRECCIÓN GENERAL DE ADMINISTRACIÓN Y FINANZAS', 'MONEDA S/NUMERO', '554565454642414', NULL, '2025-06-13 20:40:01', '2025-07-31 19:17:10', 'temp_temp-41@institucion.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(42, 'TEMP-42', 'DIRECTOR', 'SUBDIRECTOR', 'Subdirección de Tecnologías de la Información y Comunicaciones', 'MONEDA S/NUMERO', '55112233665544', NULL, '2025-06-13 20:42:25', '2025-07-31 19:17:10', 'temp_temp-42@institucion.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(43, 'TEMP-43', 'Jesus Melgoza', 'JUD DESARROLLO DE SISTEMAS', 'Subdirección de Tecnologías de la Información y Comunicaciones', 'MONEDA S/NUMERO', '4563214', NULL, '2025-06-25 18:06:50', '2025-07-31 19:17:10', 'temp_temp-43@institucion.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(50, 'TEMP-50', 'Jesus Melgoza', 'JUD DESARROLLO DE SISTEMAS', 'Subdirección de Tecnologías de la Información y Comunicaciones', 'MONEDA S/NUMERO', '5521741979', NULL, '2025-06-26 18:28:41', '2025-07-31 19:17:10', 'temp_temp-50@institucion.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(51, 'TEMP-51', 'Jesus Melgoza', 'JUD SOPORTE TECNICO', 'Subdirección de Tecnologías de la Información y Comunicaciones', 'MONEDA S/NUMERO', '4563214', NULL, '2025-06-26 18:31:52', '2025-07-31 19:17:10', 'temp_temp-51@institucion.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(52, 'TEMP-52', 'A SANTIAGO', 'JUD SOPORTE TECNICO', 'Subdirección de Tecnologías de la Información y Comunicaciones', 'MONEDA S/NUMERO', '4563214', NULL, '2025-06-26 18:34:00', '2025-07-31 19:17:10', 'temp_temp-52@institucion.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(53, 'TEMP-53', 'Jesus Melgoza', 'JUD SOPORTE TECNICO', 'Subdirección de Tecnologías de la Información y Comunicaciones', 'MONEDA S/NUMERO', '528532554752575', NULL, '2025-06-26 18:35:53', '2025-07-31 19:17:10', 'temp_temp-53@institucion.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(55, 'TEMP-55', 'A SANTIAGO', 'AUX DE SERVICIOS', 'J.U.D. de Modernización Administrativa', 'MONEDA S/NUMERO', '4563214', NULL, '2025-06-26 18:37:38', '2025-07-31 19:17:10', 'temp_temp-55@institucion.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(56, 'TEMP-56', 'A SANTIAGO', 'AUX DE SERVICIOS', 'Dirección de Administración de Capital Humano', 'MONEDA S/NUMERO', '4563214', NULL, '2025-06-26 18:38:46', '2025-07-31 19:17:10', 'temp_temp-56@institucion.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(57, '1996', 'A SANTIAGO', 'AUX DE SERVICIOS', 'J.U.D. de Desarrollo de Sistemas', 'MONEDA S/NUMERO', '5510060676', NULL, '2025-06-26 19:42:48', '2025-07-25 16:50:26', 'temp_1996@institucion.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(58, '1197767', 'Alexis Santiago Pérez', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', 'av moneda s/numero', '5548857306', NULL, '2025-07-08 16:49:14', '2025-07-31 19:17:10', 'temp_1197767@institucion.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(59, '1234567', 'jesus melgoza', 'JUD Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', 'av moneda s/numero', '5548857355', NULL, '2025-07-08 21:01:09', '2025-07-25 16:50:26', 'temp_1234567@institucion.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(60, '199680', 'Ricardo Santiago Bernal', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', 'av moneda s/numero', '5548857306', NULL, '2025-07-10 18:53:55', '2025-07-31 19:17:10', 'temp_199680@institucion.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(61, '1197768', 'DANIEL SANCHEZ', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', 'av moneda s/numero', '5548857368', NULL, '2025-07-10 21:25:05', '2025-07-31 19:17:10', 'temp_1197768@institucion.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(62, '17041824', 'Emilio Tagle Machorro', 'Aux. Tecnico T.I', 'J.U.D. de Soporte Técnico', 'av moneda s/numero', '1234567', NULL, '2025-07-11 16:11:40', '2025-07-31 19:17:10', 'temp_17041824@institucion.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(63, '854069', 'Maria Guadalupe Zenteno Garcia', 'Aux Operativa Administrativa', 'J.U.D. de Modernización Administrativa', 'av moneda s/numero', '54831500 ext 5110', NULL, '2025-07-11 16:32:25', '2025-07-31 19:17:10', 'temp_854069@institucion.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(64, '123', 'hola', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', 'av moneda s/numero', '12345678', '236', '2025-07-23 19:53:20', '2025-07-31 19:17:10', 'temp_123@institucion.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(65, '', 'Alexis Santiago Pérez', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', 'av moneda s/numero', '582028755', '254', '2025-07-25 17:27:12', '2025-07-25 17:27:12', NULL);
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(70, 'EMP-90895', 'Alexis Santiago Pérez', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', 'av moneda s/numero', '5548857306', '213', '2025-07-25 19:53:04', '2025-07-28 20:42:08', 'prueba@tlalpan.cdmx.gob.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(71, 'EMP-00896', 'ASP', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', 'av moneda s/numero', '12345678', '123', '2025-07-28 20:38:36', '2025-07-28 21:09:08', 'prueba1@tlalpan.cdmx.gob.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(72, 'EMP-90896', 'jesus melgoza', 'Desarrollo de sistemas', 'J.U.D. de Soporte Técnico', 'av moneda s/numero', '1234567', '123', '2025-07-28 21:10:36', '2025-07-28 21:10:36', 'prueba2@tlalpan.cdmx.gob.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(73, 'EMP-90897', 'Alexis Santiago Pérez', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', 'av moneda s/numero', '5548857306', '963', '2025-07-29 17:00:35', '2025-07-29 17:00:35', 'prueba3@tlalpan.cdmx.gob.mx');
INSERT INTO `catalogo_personal` (`id`, `numero_empleado`, `nombre`, `puesto`, `departamento_jud`, `dire_fisica`, `telefono`, `extension`, `fecha_registro`, `ultima_actualizacion`, `email_institucional`) VALUES(78, 'EMP-00000', 'Test Manual', '', '', NULL, NULL, NULL, '2025-07-31 19:17:10', '2025-07-31 19:17:10', 'test@institucion.gob.mx');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion`
--

DROP TABLE IF EXISTS `configuracion`;
CREATE TABLE `configuracion` (
  `id` int(11) NOT NULL,
  `clave` varchar(50) NOT NULL,
  `valor` text NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `editable` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `configuracion`:
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documentos`
--

DROP TABLE IF EXISTS `documentos`;
CREATE TABLE `documentos` (
  `id` int(11) NOT NULL,
  `fecha_creacion` datetime NOT NULL,
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
  `usuario_registra` int(11) DEFAULT NULL,
  `jud_destino` varchar(100) DEFAULT NULL,
  `numero_empleado` varchar(20) NOT NULL,
  `numero_oficio_usuario` varchar(50) DEFAULT NULL,
  `email_institucional` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `documentos`:
--

--
-- Volcado de datos para la tabla `documentos`
--

INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(1, '2025-07-18 13:43:18', '2025-05-19', NULL, 'OFICINA1', 'A SANTIAGO', 'AUX SISTEMAS', 'DESARROLLO DE SISTEMAS', NULL, 'PRUEBA EN OFICINA 1', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/REVISION_DE_SERVIDOR_PARA_SIPS_2025_ALEXIS_SANTIAGO.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(2, '2025-07-18 13:43:18', '2025-05-19', NULL, 'PRUEBA2', 'SSANTIAGO', 'AUX SISTEMAS', 'DESARROLLO DE SISTEMAS', NULL, 'PRUEBA2 PARA VER CARGA CORRECTA PDF', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/REVISION_DE_SERVIDOR_PARA_SIPS_2025_ALEXIS_SANTIAGO.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(3, '2025-07-18 13:43:18', '2025-05-21', NULL, 'PRUBEA3', 'A SANTIAGO', 'AUX SISTEMAS', 'DESARROLLO DE SISTEMAS', NULL, 'PRUEBA 3 EN OTRO DIA PARA INICIAR NUEVAS PRUEBAS EL DIA DE HOY', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/Programacion-con-PHP.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(4, '2025-07-18 13:43:18', '2025-05-21', NULL, 'PRUEBA4', 'A SANTIAGO', 'AUX SISTEMAS', 'DESARROLLO DE SISTEMAS', NULL, 'SEGUNDA PRUEBA DEL DIA DE HOY PARA VER SU COMPORTAMIENTO', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/ServidorWebCentosNgix_v2.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(5, '2025-07-18 13:43:18', '2025-05-21', NULL, 'prueba 5', 'LORENA', 'SECRETARIA', 'DESARROLLO DE SISTEMAS', NULL, 'VERIFICACION PERSONAL JUDDS', 'NOTA_INFORMATIVA', 'TURNADO', 'pdfs/Algoritmo_SIPS_MAYO_2025.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(6, '2025-07-18 13:43:18', '2025-05-21', NULL, 'prueba 6', 'a santiago', 'AUX SISTEMAS', 'DESARROLLO DE SISTEMAS', NULL, 'VERIFICACION DE AUTOCPLETADO CATALOGO PERSONAL', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/CASO_DE_USO.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(7, '2025-07-18 13:43:18', '2025-05-21', NULL, 'PRUEBA 6', 'A SANTIAGO', 'AUX SISTEMAS', 'DESARROLLO DE SISTEMAS', NULL, 'VERIFICACION DE AUTOCPLETADO PERSONA NO GUARDA ALGUNOS', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/NOTA_INFORMATIVA_ALEXIS_SANTIAGO_NIVEL_5_RH_.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(8, '2025-07-18 13:43:18', '2025-05-21', NULL, 'PRUEBA 7', 'A SANTIAGO', 'AUX SISTEMAS', 'DE', NULL, 'NO SE GUARDAN INFO EN AUTOCOMPLEETADO', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/Algoritmo_SIPS_MAYO_2025.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(9, '2025-07-18 13:43:18', '2025-05-22', NULL, '8', 'A SANTIAGO', 'AUX', 'DESARROLLO DE SISTEMAS', NULL, 'VERIFICACION DE AUTOCOMPLETADO', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/sabadoSIPS_POR_JESUS.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(10, '2025-07-18 13:43:18', '2025-05-21', NULL, 'PRUEBA 9', 'A SANTIAGO', 'AUX SISTEMAS', 'DESARROLLO DE SISTEMAS', NULL, 'NO SE GUARDAN O SE RESCRIBEN', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/sabadoSIPS_POR_JESUS.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(11, '2025-07-18 13:43:18', '2025-05-21', NULL, 'PRUEBA 10', 'EMI', 'AUX', 'DESARROLLO DE SISTEMAS', NULL, 'SE SOOBREESCRIBEN DATOS AL PARECER', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/NOTA_INFORMATIVA_ALEXIS_SANTIAGO_NIVEL_5_RH_.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(12, '2025-07-18 13:43:18', '2025-05-21', NULL, 'PRUEBA 11', 'EMI', 'AUX', 'DESARROLLO DE SISTEMAS', NULL, 'SE SIGUE VERIFICANDO USO', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/NOTA_INFORMATIVA_ALEXIS_SANTIAGO_NIVEL_5_RH_.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(13, '2025-07-18 13:43:18', '2025-05-21', NULL, 'PRUEBA 12', 'RICARDO', 'AUX SISTEMAS', 'DESARROLLO DE SISTEMAS', NULL, 'SE SIGUEN LAS PRUEBAS DE SOBREESCRITURA', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/sabadoSIPS_POR_JESUS.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(14, '2025-07-18 13:43:18', '2024-05-22', NULL, 'prueba 13', 'A SANTIAGO', 'AUX SISTEMAS', 'Soporte tecnivo', NULL, 'PRUEBA DE ACTUALIZACION E HISTORIAL DE USUARIO', 'NOTA_INFORMATIVA', 'TURNADO', '', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(15, '2025-07-18 13:43:18', '2025-05-22', NULL, 'PRUEBA 14', 'A SANTIAGO', 'AUX SISTEMAS', 'Soporte tecnivo', NULL, 'PRUEBA DE ACTUALIZACION E HISTORIAL DE USUARIO en el 13 no se reflejaba el pdf subido ni se actualiza la base de datos catalogo', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', '', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(16, '2025-07-18 13:43:18', '2025-05-22', NULL, 'prueba 15', 'A SANTIAGO', 'AUX SISTEMAS', 'MODERNIZACION', NULL, 'PRUEBA DE ACTUALIZACION E HISTORIAL DE USUARIO en el 13 no se reflejaba el pdf subido ni se actualiza la base de datos DOCUMENTOS NO APARECE EL PDF_URL', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/doc_20250522_195703_682f656f3d988.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(17, '2025-07-18 13:43:18', '2025-05-22', NULL, 'prueba 16', 'RICARDO', 'AUX SISTEMAS', 'SOPORTE TECNICO', NULL, 'PRUEBA DE ACTUALIZACION E HISTORIAL DE USUARIO en el 14 no se reflejaba el pdf subiDO', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250522_200421_682f6725eabe8.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(18, '2025-07-18 13:43:18', '2025-05-27', NULL, 'PRUEBA 17', 'A SANTIAGO', 'AUX SISTEMAS', 'DESARROLLO DE SISTEMAS', '5548857963', 'SE AGREGAN USUARIOS, SE CORRIE SUBIDA PDF ADEMAS DE AGREGAR CARACTERISITICAS ADICIONALES', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250527_215058_683617a23ff9e.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, 'CALLE MONEDA SIN NUMERO', 1, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(19, '2025-07-18 13:43:18', '2025-05-27', NULL, 'prueba 18', 'A SANTIAGO', 'PROGRAMACION', 'ALCALDIA TLALPAN', '5548899665', 'SE CREA USUARIO ADMIN, PDF CORRECTO, HISTORIAL DE USUARIO,SE AGREGA TELEFONO Y SE REALIZAN PRUEBAS', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/doc_20250527_215426_683618725d2a2.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, 'VIVANCO SIN NUMERO', 1, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(20, '2025-07-18 13:43:18', '2025-05-28', NULL, 'PRUEBA 19', 'A SANTIAGO', 'AUX DE SERVICIOS', 'DESARROLLO DE SISTEMAS', '5513697876', 'SE AGREGAN MODULOS, SESIONES Y PRUEBAS DE SUBIDA PDF', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/doc_20250528_203717_683757dd0112a.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, 'CALLE MONEDA SIN NUMERO', 1, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(21, '2025-07-18 13:43:18', '2025-06-03', NULL, '20', 'a santiago', 'aux de sistemas', 'Desarrollo', '5565655625', 'prueba no me deja subir desde admin por falta de permisos', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/doc_20250603_222705_683f5a9932bd2.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, 'vivanco s/numero', 2, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(22, '2025-07-18 13:43:18', '2025-06-03', NULL, '21', 'a santiago', 'aux de sistemas', 'Desarrollo', '548648653', 'SI ME DEJA SUBIRLO DESDE JUDDS\r\nSISTEMAS NO\r\nSE REALIZA DESDE CAPTURISTA1', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250603_222907_683f5b1379e3d.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, 'av moneda s/numero', 3, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(23, '2025-07-18 13:43:18', '2025-06-06', NULL, '22', 'A SANTIAGO', 'AUX DE SERVICIOS', 'DESARROLLO DE SISTEMAS', '5548857606', 'Prueba de captura de datos, carga pdf y complementos de usuario desde judds\r\nADMIN MARCA PERMISOS DENEGADOS', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/doc_20250606_182852_684317442dcf3.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, 'MONEDA S/NUMERO', 2, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(24, '2025-07-18 13:43:18', '2025-06-06', NULL, '23', 'A SANTIAGO', 'AUX DE SERVICIOS', 'DESARROLLO DE SISTEMAS', '5548857606', 'Se debe ingresar con capturista1\r\nPrueba de carga de pdf', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/doc_20250606_184006_684319e66739c.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, 'MONEDA S/NUMERO', 3, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(25, '2025-07-18 13:43:18', '2025-06-09', NULL, '24', 'A SANTIAGO', 'AUX DE SERVICIOS', 'DESARROLLO DE SISTEMAS', '5548857606', 'captura de datos y carga de pdf\r\nDESDE ADMIN SIGUE DENEGANDO PERMISOS', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250609_220056_68473d7883290.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, 'MONEDA S/NUMERO', 2, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(26, '2025-07-18 13:43:18', '2025-06-09', NULL, '25', 'A SANTIAGO', 'AUX DE SERVICIOS', 'DESARROLLO DE SISTEMAS', '5548857606', 'captura de datos y carga de pdf \r\nADMIN NO SE PUEDE\r\nJUDDS SI SE PUEDE\r\nAHORA SE INTENTA POR CAPTURISTA1', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250609_220226_68473dd25356a.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, 'MONEDA S/NUMERO', 3, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(27, '2025-07-18 13:43:18', '2025-06-09', NULL, '25', 'A SANTIAGO', 'AUX DE SERVICIOS', 'DESARROLLO DE SISTEMAS', '55112233665544', 'Se realizan cambios y verificaciones para poder capturar y subir pdf desde usuario ADMIN/SISTEMAS', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/doc_20250609_224409_68474799dec7c.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, 'MONEDA S/NUMERO', 1, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(28, '2025-07-18 13:43:18', '2025-06-09', NULL, '26', 'A SANTIAGO', 'AUX DE SERVICIOS', 'DESARROLLO DE SISTEMAS', '55112233665544', 'Ya se puede capturar y subir desde usuario Admin/Sistemas, pero al momento de ir al historial no aparece en el, pero si en oficios registrados\r\nESTA PRUEBA ES DESDE JUDDS', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250609_224752_68474878bc18d.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, 'MONEDA S/NUMERO', 2, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(29, '2025-07-18 13:43:18', '2025-06-09', NULL, '27', 'A SANTIAGO', 'AUX DE SERVICIOS', 'DESARROLLO DE SISTEMAS', '55112233665544', 'Se logra capturar, guardar pdf e ingresar al historial desde cualquier usuario', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250609_225629_68474a7d2d64c.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, 'MONEDA S/NUMERO', 2, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(30, '2025-07-18 13:43:18', '2025-06-12', NULL, '28', 'A SANTIAGO', 'AUX DE SERVICIOS', 'JUD de Desarrollo de Sistemas', '55112233665544', 'SE AGREGAN CAMPOS \"JUD REMITENTE\" \"JUD DESTINO\"\r\nSE AGREGAN TAMBIEN EN LOS APARTADOS DE CATALOGO E HISTORIAL\r\nSE AGREGAN NOMBRES ACTUALES DE ORGANIGRAMA ALCALDIA PARA TENER LOS NOMBRES DE JUD\r\nSE REALIZAN PRUEBAS', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250612_223415_684b39c72affe.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, 'MONEDA S/NUMERO', 1, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(31, '2025-07-18 13:43:18', '2025-06-12', NULL, '29', 'BERNAL', 'AUX DE SERVICIOS', 'JUD de Desarrollo de Sistemas', '454545466', 'SE HACEN SEGUNDA PRUEBA PARA VER SU CARGA EN CATALOGO', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250612_223534_684b3a1680d81.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, 'CALLE MONEDA S/NUMERO', 1, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(32, '2025-07-18 13:43:18', '2025-06-13', NULL, '29', 'luis', 'captura', 'Subdirección de Servicios Generales', '787897845585', 'SE AGREGA ESTRUCUTRA DE 8. DIRECCIÓN GENERAL DE ADMINISTRACIÓN Y FINANZAS\r\n- NO SE REFLEJAN CAPTURAS EN APARTADO DE HISTORIAL Y CATALOGO\r\n', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250613_201902_684c6b9699d73.pdf', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, 'MONEDA S/NUMERO', 1, NULL, 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(33, '2025-07-18 13:43:18', '2025-06-13', NULL, '30', 'SERV', 'PROGRAMACION', 'J.U.D. de Desarrollo de Sistemas', '528532554752575', 'ESTE ES UNA PRUEBA PARA SABER SI SE GUARDA EN EL CATALOGO CORRECTAMENTE, ADEMAS DE\\r\\nQUITAR LA OPCION DE CAMBIAR EL DEPTO JUD EN EL MISMO CATALOGO, YA QUE ES \\r\\nEXCLUSIVAMENTE PARA VER EL HISTORIAL Y CAMBIO DE DEPTO DE LOS EMPLEADOS', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250613_215628_684c826c85910.pdf', 'RECIBIDO', NULL, 'PRUEBA', NULL, NULL, NULL, 'MONEDA S/NUMERO', 1, 'J.U.D. de Soporte Técnico', 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(34, '2025-07-18 13:43:18', '2025-06-13', NULL, '31', 'A SANTIAGO', 'PROGRAMACION', 'J.U.D. de Desarrollo de Sistemas', '55112233665544', 'SE AGREGA NUMERO DE EMPLEADO Y SE HACE EL IDENTIFICADOR\\r\\nSE COMPLEMENTA EL CATALOGO\\r\\nSE AGREGAN NOMBRES DE JUDS\\r\\n', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250613_223610_684c8bbac8863.pdf', 'RECIBIDO', NULL, 'PRUEBA', NULL, NULL, NULL, 'MONEDA S/NUMERO', 1, 'Subdirección de Tecnologías de la Información y Comunicaciones', 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(35, '2025-07-18 13:43:18', '2025-06-13', NULL, '32', 'DIRECTOR', 'DIRECTOR', 'DIRECCIÓN GENERAL DE ADMINISTRACIÓN Y FINANZAS', '554565454642414', 'ESTO ES UNA PRUEBA PARA VER SI SE GUARDAN DE MANERA INCREMENTAL LOS NUMEROS DE EMPLEADO\\r\\nYA QUE EN LA PRUEBA31 CON N° DE EMPLEADO 20 NO SE VE REFLEJADO EN EL CATALOGO DE PERSONAL\\r\\nEN EL HISTORIAL SI SE VE REFLEJADO PERO SIN EL NUMERO DE EMPLEADO', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250613_224001_684c8ca1c1da0.pdf', 'RECIBIDO', NULL, 'JESUS', NULL, NULL, NULL, 'MONEDA S/NUMERO', 1, 'J.U.D. de Desarrollo de Sistemas', 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(36, '2025-07-18 13:43:18', '2025-06-13', NULL, '32', 'DIRECTOR', 'SUBDIRECTOR', 'Subdirección de Tecnologías de la Información y Comunicaciones', '55112233665544', 'LA PRUEBA 31 NO SE VE REFLEJADO EL NUMERO (PORQUE SI SE VE EN DICHO CATALOGO)\\r\\nAHORA SE UTILIZA EL MISMO NUMEOR DE EMPLEADO 1 PARA VER SI ACTUALIZA SU DEPARTAMENTO AL QUE PERTENECE', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250613_224225_684c8d3120292.pdf', 'RECIBIDO', NULL, 'PRUEBA', NULL, NULL, NULL, 'MONEDA S/NUMERO', 1, 'J.U.D. de Desarrollo de Sistemas', 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(37, '2025-07-18 13:43:18', '2025-06-25', NULL, '33', 'Jesus Melgoza', 'JUD DESARROLLO DE SISTEMAS', 'J.U.D. de Desarrollo de Sistemas', '4563214', 'SE REALIZAN PRUEBAS DE CAPTURA DE DATOS PARA VERIFICAR FUNCIONAMIENTO;\\r\\nSe debe agregar el NUMERO DE EMPLEADO, esto para que se actualice su historial\\r\\nEsto se debe ver reflejado tanto en el historial como en el catalogo.\\r\\n', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250625_200650_685c3abac3182.pdf', 'RECIBIDO', NULL, 'A PRUEBA DE CATALOGO', NULL, NULL, NULL, 'MONEDA S/NUMERO', 1, 'J.U.D. de Desarrollo de Sistemas', 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(38, '2025-07-18 13:43:18', '2025-06-25', NULL, '34', 'Jesus Melgoza', 'JUD DESARROLLO DE SISTEMAS', 'J.U.D. de Desarrollo de Sistemas', '4563214', 'no se ve reflado el numero de empleado en catalogo esto para llevar su correcto historial de usuario.\\r\\n', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250625_205944_685c4720719de.pdf', 'RECIBIDO', NULL, 'A PRUEBA DE CATALOGO', NULL, NULL, NULL, 'MONEDA S/NUMERO', 1, 'J.U.D. de Desarrollo de Sistemas', 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(39, '2025-07-18 13:43:18', '2025-06-25', NULL, '35', 'Jesus Melgoza', 'JUD DESARROLLO DE SISTEMAS', 'J.U.D. de Desarrollo de Sistemas', '787897845585', 'Se hacen pruebas para ver si en jud destinatario aparece el destino correctamente.\\r\\n', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250625_221028_685c57b418372.pdf', 'RECIBIDO', NULL, 'A PRUEBA DE CATALOGO', NULL, NULL, NULL, 'MONEDA S/NUMERO', 1, 'Subdirección de Tecnologías de la Información y Comunicaciones', 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(40, '2025-07-18 13:43:18', '2025-06-25', NULL, '36', 'Jesus Melgoza', 'JUD DESARROLLO DE SISTEMAS', 'J.U.D. de Desarrollo de Sistemas', '4563214', 'se realizan pruebas exitosas aparecen ya los  recuadros con informacion correcta\\r\\nFALTA AÑADIR EL NUMERO DE EMPLEADO QUE SIGUE SIN APARECER PARA PODER INICIAR EL STATUS.\\r\\nTANTO CATALOGO COMO HISTORIAL FUNCIONAN CORRECTAMENTE', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250625_222740_685c5bbc22671.pdf', 'RECIBIDO', NULL, 'A PRUEBA DE CATALOGO', NULL, NULL, NULL, 'MONEDA S/NUMERO', 1, 'Subdirección de Tecnologías de la Información y Comunicaciones', 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(41, '2025-07-18 13:43:18', '2025-06-26', NULL, '37', 'Jesus Melgoza', 'JUD DESARROLLO DE SISTEMAS', 'J.U.D. de Desarrollo de Sistemas', '5521741979', 'se realizan pruebas de implementacion de N° empleado\\r\\n-Debe reflejarse en catalogo de personal\\r\\n-Ademas con esta funcion se podra ubicar el oficio segun el numero de empleado', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250626_202841_685d9159c7fb6.pdf', 'RECIBIDO', NULL, 'A PRUEBA DE CATALOGO', NULL, NULL, NULL, 'MONEDA S/NUMERO', 1, 'Subdirección de Tecnologías de la Información y Comunicaciones', 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(42, '2025-07-18 13:43:18', '2025-06-26', NULL, '37', 'Jesus Melgoza', 'JUD SOPORTE TECNICO', 'J.U.D. de Soporte Técnico', '4563214', '-SE LOGRA REGISTRAR NUMERO DE EMPLEADO\\r\\n-SE REVISA SI SE LLEVA EL HISTORIAL DE EMPLEADO CORRECTAMENTE ', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250626_203152_685d921841291.pdf', 'RECIBIDO', NULL, 'A PRUEBA DE CATALOGO', NULL, NULL, NULL, 'MONEDA S/NUMERO', 1, 'Subdirección de Tecnologías de la Información y Comunicaciones', 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(43, '2025-07-18 13:43:18', '2025-06-26', NULL, '38', 'A SANTIAGO', 'JUD SOPORTE TECNICO', 'J.U.D. de Soporte Técnico', '4563214', '-NO SE REGISTRO EL N° DE EMPLEADO Y SEPARA EL HISTORIAL AL CAMBIAR DE JUD', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250626_203400_685d92984c163.pdf', 'RECIBIDO', NULL, 'A PRUEBA DE CATALOGO', NULL, NULL, NULL, 'MONEDA S/NUMERO', 1, 'Subdirección de Tecnologías de la Información y Comunicaciones', 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(44, '2025-07-18 13:43:18', '2025-06-26', NULL, '39', 'Jesus Melgoza', 'JUD SOPORTE TECNICO', 'J.U.D. de Soporte Técnico', '528532554752575', 'NO SE REGISTRO EL N° DE EMPLEADO Y SEPARA EL HISTORIAL AL CAMBIAR DE JUD', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250626_203553_685d9309cb025.pdf', 'RECIBIDO', NULL, 'A PRUEBA DE CATALOGO', NULL, NULL, NULL, 'MONEDA S/NUMERO', 1, 'Subdirección de Tecnologías de la Información y Comunicaciones', 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(45, '2025-07-18 13:43:18', '2025-06-26', NULL, '40', 'A SANTIAGO', 'AUX DE SERVICIOS', 'J.U.D. de Desarrollo de Sistemas', '4563214', 'NO SE REGISTRO EL N° DE EMPLEADO Y SEPARA EL HISTORIAL', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250626_203738_685d937284e14.pdf', 'RECIBIDO', NULL, 'A PRUEBA DE CATALOGO', NULL, NULL, NULL, 'MONEDA S/NUMERO', 1, 'J.U.D. de Modernización Administrativa', 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(46, '2025-07-18 13:43:18', '2025-06-26', NULL, '41', 'A SANTIAGO', 'AUX DE SERVICIOS', 'J.U.D. de Soporte Técnico', '4563214', 'NO SE REGISTRO EL N° DE EMPLEADO Y SEPARA EL HISTORIAL AL CAMBIAR DE JUD', 'TURNO', 'SEGUIMIENTO', 'pdfs/doc_20250626_203846_685d93b69bb0f.pdf', 'RECIBIDO', NULL, 'A PRUEBA DE CATALOGO', NULL, NULL, NULL, 'MONEDA S/NUMERO', 1, 'Dirección de Administración de Capital Humano', 'EMP-00000', NULL, 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(47, '2025-07-18 13:43:18', '2025-07-08', NULL, 'OF-00052', 'Alexis Santiago Pérez', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', '5548857306', 'SIGUEN SIN REFLEJARSE LAS CAPTURAS DE DATOS', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250708_220154_686d79320ad66.pdf', 'RECIBIDO', NULL, 'Jesus Melgoza', NULL, NULL, NULL, 'av moneda s/numero', 1, 'J.U.D. de Servicios Generales y Apoyo Logístico', '1197767', NULL, 'temp_1197767@institucion.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(48, '2025-07-18 13:43:18', '2025-07-08', NULL, 'OF-00062', 'Alexis Santiago Pérez', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', '5548857306', 'SIGUEN SIN REFLEJARSE CAMBIOS', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250708_231114_686d897254994.pdf', 'RECIBIDO', NULL, 'PRUEBA', NULL, NULL, NULL, 'av moneda s/numero', 1, 'J.U.D. de Registro y Movimientos de Personal', '1197767', NULL, 'temp_1197767@institucion.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(49, '2025-07-18 13:43:18', '2025-07-08', NULL, 'OF-00063', 'Alexis Santiago Pérez', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', '5548857306', 'se reflejan cptura de datos\r\nSe intenta agregar historial correctamente', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250708_232020_686d8b9431726.pdf', 'RECIBIDO', NULL, 'PRUEBA', NULL, NULL, NULL, 'av moneda s/numero', 1, 'J.U.D. de Registro y Movimientos de Personal', '1197767', NULL, 'temp_1197767@institucion.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(50, '2025-07-18 13:43:18', '2025-07-08', NULL, 'OF-00064', 'Alexis Santiago Pérez', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', '5548857306', 'se reflejan cptura de datos\r\nSe intenta agregar historial correctamente 2', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250708_232145_686d8be997b82.pdf', 'RECIBIDO', NULL, 'PRUEBA', NULL, NULL, NULL, 'av moneda s/numero', 1, 'J.U.D. de Registro y Movimientos de Personal', '1197767', NULL, 'temp_1197767@institucion.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(51, '2025-07-18 13:43:18', '2025-07-08', NULL, 'OF-00068', 'Alexis Santiago Pérez', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', '5548857306', 'se reflejan cptura de datos Se intenta agregar historial correctamente 2', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250708_234001_686d9031d7548.pdf', 'RECIBIDO', NULL, 'Jesus Melgoza', NULL, NULL, NULL, 'av moneda s/numero', 1, 'J.U.D. de Servicios Generales y Apoyo Logístico', '1197767', NULL, 'temp_1197767@institucion.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(52, '2025-07-18 13:43:18', '2025-07-10', NULL, 'OF-00071', 'Alexis Santiago Pérez', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', '5548857306', 'debe verse reflejado en el apartado de: a)Oficios regidstrados b)catalago de personal y registrar historial de depto c)historial de documentos completo', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250710_203735_05c70602.pdf', 'RECIBIDO', NULL, 'PRUEBA', NULL, NULL, NULL, 'av moneda s/numero', 1, 'J.U.D. de Soporte Técnico', '1197767', NULL, 'temp_1197767@institucion.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(53, '2025-07-18 13:43:18', '2025-07-10', NULL, 'OF-00074', 'Alexis Santiago Pérez', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', '5548857306', 'CON USUARIO REGISTRADO PREVIAMENTE SI SE REFLEJA EN TODO A EXCEPCION DE ACTUALIZAR EL HISTORIAL DE DEPARTAMENTOS. \r\n(EN EL ANTERIOR SE CAMBIO EL JUD PERTENECIENTE Y YA NO REFLEJO EN LOS DEMAS APARTADOS DE CAT, HISTORIAL DE DOCUMENTOS Y OFICIOS REGISTRADOS)\r\nY CON USUARIO NUEVO NO SE VE REFLEJADO EN HISTORIAL COMPLETO DE DOCUMENTOS http://localhost/SISTEMA_OFICIOS/historial.php , NI EN OFICIOS REGISTRADOS (INDEX.PHP)', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250710_210141_bda3ba45.pdf', 'RECIBIDO', NULL, 'PRUEBA', NULL, NULL, NULL, 'av moneda s/numero', 1, 'J.U.D. de Soporte Técnico', '1197767', NULL, 'temp_1197767@institucion.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(54, '2025-07-18 13:43:18', '2025-07-10', NULL, 'OF-00075', 'Ricardo Santiago Bernal', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', '5548857306', 'este es el segundo con el de 199680 para ver si se refleja en historial completo de documentos, y oficios registrados de index.php\r\nYa que el primero solamente se ve unicamente en el catalogo de personal', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250710_210735_aad025e5.pdf', 'RECIBIDO', NULL, 'PRUEBA', NULL, NULL, NULL, 'av moneda s/numero', 1, 'J.U.D. de Soporte Técnico', '199680', NULL, 'temp_199680@institucion.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(55, '2025-07-18 13:43:18', '2025-07-10', NULL, 'OF-00078', 'Alexis Santiago Pérez', 'Desarrollo de sistemas', 'Dirección de Modernización Administrativa y Tecnologías de la Información y Comunicaciones', '5548857356', 'siguen igual que CON USUARIO REGISTRADO PREVIAMENTE SI SE REFLEJA EN TODO A EXCEPCION DE ACTUALIZAR  EN EL APARTADO DE CATALOGO EL HISTORIAL DE DEPARTAMENTOS. http://localhost/SISTEMA_OFICIOS/catalogo.php  (PERO CUANDO CAMBIO EL Departamento del Remitente JUD) en la captura de datos y guardo nuevamente a) deja de reflejarse dicha captura y en caso de dejarlo con su \"Departamento del Remitente JUD\" de siempre SI se ve reflejado en todo )\r\n\r\nY CON USUARIO NUEVO NO SE VE REFLEJADO EN HISTORIAL COMPLETO DE DOCUMENTOS http://localhost/SISTEMA_OFICIOS/historial.php , NI EN OFICIOS REGISTRADOS (INDEX.PHP)\r\npero con la segunda prueba con el mismo usuario nuevo YA SE VE REFLEJADO', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250710_215456_495745c8.pdf', 'RECIBIDO', NULL, 'PRUEBA', NULL, NULL, NULL, 'av moneda s/numero', 1, 'Dirección de Finanzas', '1197767', NULL, 'temp_1197767@institucion.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(60, '2025-07-18 13:43:18', '2025-07-10', NULL, 'OF-00083', 'Alexis Santiago Pérez', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', '5548857306', 'CON USUARIO REGISTRADO Y DEJANDO SU JUD DEBE APARECER EN TODOS LADOS 00083 NUMERO DE PRUEBA', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250710_220952_ee594f08.pdf', 'RECIBIDO', NULL, 'PRUEBA', NULL, NULL, NULL, 'av moneda s/numero', 1, 'Dirección de Modernización Administrativa y Tecnologías de la Información y Comunicaciones', '1197767', NULL, 'temp_1197767@institucion.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(61, '2025-07-18 13:43:18', '2025-07-10', NULL, 'OF-00088', 'Alexis Santiago Pérez', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', '5548857306', 'SE HACEN PRUEBAS GENERALES PARA VER SU FUNCIONAMIENTO', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250710_231429_ed59e89a.pdf', 'RECIBIDO', NULL, 'PRUEBA', NULL, NULL, NULL, 'av moneda s/numero', 1, 'J.U.D. de Soporte Técnico', '1197767', NULL, 'temp_1197767@institucion.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(62, '2025-07-18 13:43:18', '2025-07-10', NULL, 'OF-00089', 'Alexis Santiago Pérez', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', '5548857355', 'se hace prueba para saber si se registra en el historial.php', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250710_231801_813f13c4.pdf', 'RECIBIDO', NULL, 'PRUEBA', NULL, NULL, NULL, 'av moneda s/numero', 1, 'L.C.P. de Gestión Documental', '1197767', NULL, 'temp_1197767@institucion.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(63, '2025-07-18 13:43:18', '2025-07-10', NULL, 'OF-00090', 'DANIEL SANCHEZ', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', '5548857368', 'SE TIENE QUE REGISTAR NUEVO EMPLEADO', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250710_232505_65d90ec8.pdf', 'RECIBIDO', NULL, 'PRUEBA', NULL, NULL, NULL, 'av moneda s/numero', 1, 'L.C.P. de Seguimiento e Informes', '1197768', NULL, 'temp_1197768@institucion.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(64, '2025-07-18 13:43:18', '2025-07-10', NULL, 'OF-00091', 'Alexis Santiago Pérez', 'Desarrollo de sistemas', 'L.C.P. de Seguimiento e Informes', '5548857355', 'se prueba si se sube pdf en historial documentois completo', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250710_235218_733711ae.pdf', 'RECIBIDO', NULL, 'PRUEBA', NULL, NULL, NULL, 'av moneda s/numero', 1, 'L.C.P. de Seguimiento e Informes', '1197767', NULL, 'temp_1197767@institucion.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(65, '2025-07-18 13:43:18', '2025-07-10', NULL, 'OF-00092', 'Alexis Santiago Pérez', 'Desarrollo de sistemas', 'J.U.D. de Soporte Técnico', '5548857368', 'PRUEBA CON CAMBIO DE JUD Y TIPO', 'CIRCULAR', 'TURNADO', 'pdfs/doc_20250711_001524_cedcf4b7.pdf', 'RECIBIDO', NULL, 'PRUEBA', NULL, NULL, NULL, 'av moneda s/numero', 1, 'L.C.P. de Seguimiento e Informes', '1197767', NULL, 'temp_1197767@institucion.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(66, '2025-07-18 13:43:18', '2025-07-11', NULL, 'OF-00093', 'Emilio Tagle Machorro', 'Aux. Tecnico T.I', 'J.U.D. de Soporte Técnico', '1234567', 'Esto es una prueba del funcionamiento del programa con nuevo usuarioi', 'CONOCIMIENTO', 'SEGUIMIENTO', 'pdfs/doc_20250711_181140_ed32c2c1.pdf', 'RECIBIDO', NULL, '', NULL, NULL, NULL, 'av moneda s/numero', 1, 'J.U.D. de Desarrollo de Sistemas', '17041824', NULL, 'temp_17041824@institucion.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(67, '2025-07-18 13:43:18', '2025-07-11', NULL, 'OF-00094', 'Maria Guadalupe Zenteno Garcia', 'Aux Operativa Administrativa', 'J.U.D. de Modernización Administrativa', '54831500 ext 5110', 'ESTO ES UNA PRUEBA DESDE EL USUARIO CAPTURISTA', 'NOTA_INFORMATIVA', 'SEGUIMIENTO', 'pdfs/doc_20250711_183225_d7ab59b2.pdf', 'RECIBIDO', NULL, 'Jesus Melgoza', NULL, NULL, NULL, 'av moneda s/numero', 3, 'J.U.D. de Desarrollo de Sistemas', '854069', NULL, 'temp_854069@institucion.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(68, '2025-07-18 13:43:18', '2025-07-15', NULL, 'OF-00098', 'Alexis Santiago Pérez', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', '5548857306', 'no se reflejan en historiales', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250715_192625_b4a2b0fc.pdf', 'RECIBIDO', NULL, 'PRUEBA', NULL, NULL, NULL, 'av moneda s/numero', 1, 'J.U.D. de Desarrollo de Sistemas', '1197767', NULL, 'temp_1197767@institucion.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(69, '2025-07-18 13:43:18', '2025-07-15', NULL, 'OF-00099', 'Alexis Santiago Pérez', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', '5548857306', 'se realiza prueba para captura de datos', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250715_192825_cafd92ab.pdf', 'RECIBIDO', NULL, 'PRUEBA', NULL, NULL, NULL, 'av moneda s/numero', 3, 'Subdirección de Tecnologías de la Información y Comunicaciones', '1197767', NULL, 'temp_1197767@institucion.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(70, '2025-07-18 13:43:18', '2025-07-15', NULL, 'OF-00100', 'Alexis Santiago Pérez', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', '5548857306', 'se realiza prueba', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250715_193559_906a4d57.pdf', 'RECIBIDO', NULL, 'PRUEBA', NULL, NULL, NULL, 'av moneda s/numero', 2, 'J.U.D. de Soporte Técnico', '1197767', NULL, 'temp_1197767@institucion.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(71, '2025-07-18 13:43:18', '2025-07-15', NULL, 'OF-00101', 'Alexis Santiago Pérez', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', '5548857306', 'se realiza captura y prueba de programa desde usuario jUDDS', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250715_193808_c801a529.pdf', 'RECIBIDO', NULL, 'PRUEBA', NULL, NULL, NULL, 'av moneda s/numero', 2, 'Subdirección de Tecnologías de la Información y Comunicaciones', '1197767', NULL, 'temp_1197767@institucion.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(72, '2025-07-18 13:43:18', '2025-07-15', NULL, 'OF-00102', 'Emilio Tagle Machorro', 'Desarrollo de sistemas', 'J.U.D. de Soporte Técnico', '5548857306', 'priueba desde usuario capturista para ver su funcionalidad', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250715_194052_cf038a81.pdf', 'RECIBIDO', NULL, 'PRUEBA', NULL, NULL, NULL, 'av moneda s/numero', 3, 'Subdirección de Tecnologías de la Información y Comunicaciones', '17041824', NULL, 'temp_17041824@institucion.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(73, '2025-07-18 13:43:18', '2025-07-15', NULL, 'OF-00103', 'Alexis Santiago Pérez', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', '5548857306', 'Esto es una prueba para mostrar al sevicio socila del funcionamiento\r\ny desarrollo dle codigo/programa.', 'OFICIO', 'ATENDIDO', 'pdfs/doc_20250715_205551_cc30ffb2.pdf', 'RECIBIDO', NULL, 'PRUEBA', NULL, NULL, NULL, 'av moneda s/numero', 1, 'Subdirección de Tecnologías de la Información y Comunicaciones', '1197767', NULL, 'temp_1197767@institucion.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(74, '2025-07-21 14:59:32', '2025-07-21', NULL, 'OF-00105', 'Alexis Santiago Pérez', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', '5548857306', 'prueba gral de programa', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250721_180521_156df2c9.pdf', 'RECIBIDO', NULL, 'PRUEBA', NULL, NULL, NULL, 'av moneda s/numero', 1, 'Subdirección de Tecnologías de la Información y Comunicaciones', '1197767', NULL, 'temp_1197767@institucion.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(75, '2025-07-21 14:59:32', '2025-07-21', NULL, 'OF-00106', 'Alexis Santiago Pérez', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', '5548857306', 'SE HACE PRUEBA AL OCULTAR NUMERO DE OFICIO\r\nDEBE SER EL 106 AUTOMATICAMENTE', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250721_200716_600d4f80.pdf', 'RECIBIDO', NULL, 'PRUEBA', NULL, NULL, NULL, 'av moneda s/numero', 1, 'Subdirección de Tecnologías de la Información y Comunicaciones', '1197767', NULL, 'temp_1197767@institucion.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(76, '0000-00-00 00:00:00', '0000-00-00', NULL, '', '', '', NULL, NULL, '', 'OFICIO', 'SEGUIMIENTO', '', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'EMP-00000', '$numero_oficio_usuario', 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(77, '2025-07-21 14:59:32', '2025-07-21', NULL, 'OF-00107', 'Alexis Santiago Pérez', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', '5548857306', 'prueba general despues de quitar el n oficio automatizado y crear otro manual', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250721_221409_feec9a69.pdf', 'RECIBIDO', NULL, 'PRUEBA', NULL, NULL, NULL, 'av moneda s/numero', 1, 'Subdirección de Tecnologías de la Información y Comunicaciones', '1197767', NULL, 'temp_1197767@institucion.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(78, '2025-07-23 14:59:32', '2025-07-23', NULL, 'OF-00109', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', 'asdfghjk', '5548857306', 'esto es una prueba para saber si registra el numero_oficio_usuarios correctamente en los \"oficios registrados\" y en historial sigue sin definisrse la variable', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250723_185702_7002d75f.pdf', 'RECIBIDO', NULL, 'PRUEBA', NULL, NULL, NULL, 'av moneda s/numero', 1, 'Subdirección de Tecnologías de la Información y Comunicaciones', '1197767', 'Alexis Santiago Pérez', 'temp_1197767@institucion.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(79, '2025-07-23 14:59:32', '2025-07-23', NULL, 'OF-00110', 'Alexis Santiago Pérez', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', '5548857306', 'ESTO ES UNA PRUEBA PARA VER COMO SE GUARDAN LOS DATOS CON EL NUMERO_OFICIO_USUARIO DE MANERA MANUAL', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250723_191130_eb235099.pdf', 'RECIBIDO', NULL, 'PRUEBA', NULL, NULL, NULL, 'av moneda s/numero', 1, 'Subdirección de Tecnologías de la Información y Comunicaciones', '1197767', 'DMGA/TA/123/456', 'temp_1197767@institucion.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(80, '2025-07-23 14:59:32', '2025-07-23', NULL, 'OF-00112', 'Alexis Santiago Pérez', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', '5548857306', 'para ver funcionamiento gral y si se guardan las capturas de datos correctamente', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250723_213930_6a82923c.pdf', 'RECIBIDO', NULL, 'PRUEBA', NULL, NULL, NULL, 'av moneda s/numero', 1, 'Subdirección de Tecnologías de la Información y Comunicaciones', '1197767', 'DMGA/TA/567/890', 'temp_1197767@institucion.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(81, '2025-07-23 14:59:32', '2025-07-23', NULL, 'OF-00113', 'hola', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', '12345678', 'esto es una prueba para auditoria_oficios', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250723_215320_825ef30f.pdf', 'RECIBIDO', NULL, 'PRUEBA', NULL, NULL, NULL, 'av moneda s/numero', 1, 'Subdirección de Tecnologías de la Información y Comunicaciones', '123', 'DMGA/TA/567/890', 'temp_123@institucion.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(82, '2025-05-27 14:59:32', '2025-05-27', NULL, 'OF-00114', 'Alexis Santiago Pérez', 'Desarrollo de sistemas', 'J.U.D. de Desarrollo de Sistemas', '582028755', 'se realizan pruebas despues de quitar n° empleado y poner correo institucional', 'OFICIO', 'SEGUIMIENTO', 'pdfs/doc_20250725_192712_5a241028.pdf', 'RECIBIDO', NULL, 'PRUEBA', NULL, NULL, NULL, 'av moneda s/numero', 1, 'Subdirección de Tecnologías de la Información y Comunicaciones', 'EMP-00000', 'asdfghjklñd', 'sin-correo@tlalpan.cdmx.gob.mx');
INSERT INTO `documentos` (`id`, `fecha_creacion`, `fecha_entrega`, `fecha_recepcion`, `numero_oficio`, `remitente`, `cargo_remitente`, `depto_remitente`, `telefono`, `asunto`, `tipo`, `estatus`, `pdf_url`, `etapa`, `fecha_respuesta`, `destinatario`, `usuario_responde`, `usuario_acusa`, `fecha_acuse`, `dire_fisica`, `usuario_registra`, `jud_destino`, `numero_empleado`, `numero_oficio_usuario`, `email_institucional`) VALUES(83, '0000-00-00 00:00:00', '0000-00-00', NULL, 'OF-TEST', 'Test Manual', '', NULL, NULL, '', 'OFICIO', 'SEGUIMIENTO', '', 'RECIBIDO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'EMP-00000', NULL, 'test@institucion.gob.mx');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial`
--

DROP TABLE IF EXISTS `historial`;
CREATE TABLE `historial` (
  `id` int(11) NOT NULL,
  `documento_id` int(11) NOT NULL,
  `accion` varchar(50) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `detalles` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `historial`:
--   `documento_id`
--       `documentos` -> `id`
--   `usuario_id`
--       `usuarios` -> `id`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_departamentos`
--

DROP TABLE IF EXISTS `historial_departamentos`;
CREATE TABLE `historial_departamentos` (
  `id` int(11) NOT NULL,
  `personal_id` int(11) NOT NULL,
  `numero_empleado` varchar(20) NOT NULL,
  `departamento_anterior` varchar(100) DEFAULT NULL,
  `departamento_nuevo` varchar(100) DEFAULT NULL,
  `fecha_cambio` timestamp NOT NULL DEFAULT current_timestamp(),
  `usuario_registra` int(11) NOT NULL,
  `documento_id` int(11) DEFAULT NULL,
  `numero_oficio_usuario` varchar(50) DEFAULT NULL,
  `email_institucional` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `historial_departamentos`:
--   `numero_empleado`
--       `catalogo_personal` -> `numero_empleado`
--   `personal_id`
--       `catalogo_personal` -> `id`
--   `personal_id`
--       `catalogo_personal` -> `id`
--   `documento_id`
--       `documentos` -> `id`
--

--
-- Volcado de datos para la tabla `historial_departamentos`
--

INSERT INTO `historial_departamentos` (`id`, `personal_id`, `numero_empleado`, `departamento_anterior`, `departamento_nuevo`, `fecha_cambio`, `usuario_registra`, `documento_id`, `numero_oficio_usuario`, `email_institucional`) VALUES(1, 2, 'TEMP-2', 'DESARROLLO DE SISTEMAS', 'Soporte tecnivo', '2025-05-22 17:06:52', 0, NULL, NULL, 'temp_temp-2@institucion.mx');
INSERT INTO `historial_departamentos` (`id`, `personal_id`, `numero_empleado`, `departamento_anterior`, `departamento_nuevo`, `fecha_cambio`, `usuario_registra`, `documento_id`, `numero_oficio_usuario`, `email_institucional`) VALUES(2, 2, 'TEMP-2', 'Soporte tecnivo', 'MODERNIZACION', '2025-05-22 17:47:04', 0, NULL, NULL, 'temp_temp-2@institucion.mx');
INSERT INTO `historial_departamentos` (`id`, `personal_id`, `numero_empleado`, `departamento_anterior`, `departamento_nuevo`, `fecha_cambio`, `usuario_registra`, `documento_id`, `numero_oficio_usuario`, `email_institucional`) VALUES(3, 9, 'TEMP-9', 'DESARROLLO DE SISTEMAS', 'SOPORTE TECNICO', '2025-05-22 18:04:21', 0, NULL, NULL, 'temp_temp-9@institucion.mx');
INSERT INTO `historial_departamentos` (`id`, `personal_id`, `numero_empleado`, `departamento_anterior`, `departamento_nuevo`, `fecha_cambio`, `usuario_registra`, `documento_id`, `numero_oficio_usuario`, `email_institucional`) VALUES(4, 25, 'TEMP-25', 'DESARROLLO DE SISTEMAS', 'JUD de Desarrollo de Sistemas', '2025-06-12 20:34:15', 1, NULL, NULL, 'temp_temp-25@institucion.mx');
INSERT INTO `historial_departamentos` (`id`, `personal_id`, `numero_empleado`, `departamento_anterior`, `departamento_nuevo`, `fecha_cambio`, `usuario_registra`, `documento_id`, `numero_oficio_usuario`, `email_institucional`) VALUES(5, 38, 'TEMP-38', 'J.U.D. de Desarrollo de Sistemas', 'J.U.D. de Desarrollo de Sistemas', '2025-06-13 19:56:28', 1, NULL, NULL, 'temp_temp-38@institucion.mx');
INSERT INTO `historial_departamentos` (`id`, `personal_id`, `numero_empleado`, `departamento_anterior`, `departamento_nuevo`, `fecha_cambio`, `usuario_registra`, `documento_id`, `numero_oficio_usuario`, `email_institucional`) VALUES(6, 24, 'TEMP-24', 'J.U.D. de Desarrollo de Sistemas', 'J.U.D. de Desarrollo de Sistemas', '2025-06-13 20:36:10', 1, NULL, NULL, 'temp_temp-24@institucion.mx');
INSERT INTO `historial_departamentos` (`id`, `personal_id`, `numero_empleado`, `departamento_anterior`, `departamento_nuevo`, `fecha_cambio`, `usuario_registra`, `documento_id`, `numero_oficio_usuario`, `email_institucional`) VALUES(7, 41, 'TEMP-41', 'DIRECCIÓN GENERAL DE ADMINISTRACIÓN Y FINANZAS', 'DIRECCIÓN GENERAL DE ADMINISTRACIÓN Y FINANZAS', '2025-06-13 20:40:01', 1, NULL, NULL, 'temp_temp-41@institucion.mx');
INSERT INTO `historial_departamentos` (`id`, `personal_id`, `numero_empleado`, `departamento_anterior`, `departamento_nuevo`, `fecha_cambio`, `usuario_registra`, `documento_id`, `numero_oficio_usuario`, `email_institucional`) VALUES(8, 42, 'TEMP-42', 'Subdirección de Tecnologías de la Información y Comunicaciones', 'Subdirección de Tecnologías de la Información y Comunicaciones', '2025-06-13 20:42:25', 1, NULL, NULL, 'temp_temp-42@institucion.mx');
INSERT INTO `historial_departamentos` (`id`, `personal_id`, `numero_empleado`, `departamento_anterior`, `departamento_nuevo`, `fecha_cambio`, `usuario_registra`, `documento_id`, `numero_oficio_usuario`, `email_institucional`) VALUES(9, 43, 'TEMP-43', 'J.U.D. de Desarrollo de Sistemas', 'J.U.D. de Desarrollo de Sistemas', '2025-06-25 18:06:50', 1, NULL, NULL, 'temp_temp-43@institucion.mx');
INSERT INTO `historial_departamentos` (`id`, `personal_id`, `numero_empleado`, `departamento_anterior`, `departamento_nuevo`, `fecha_cambio`, `usuario_registra`, `documento_id`, `numero_oficio_usuario`, `email_institucional`) VALUES(10, 43, 'TEMP-43', 'J.U.D. de Desarrollo de Sistemas', 'J.U.D. de Desarrollo de Sistemas', '2025-06-25 18:59:44', 1, NULL, NULL, 'temp_temp-43@institucion.mx');
INSERT INTO `historial_departamentos` (`id`, `personal_id`, `numero_empleado`, `departamento_anterior`, `departamento_nuevo`, `fecha_cambio`, `usuario_registra`, `documento_id`, `numero_oficio_usuario`, `email_institucional`) VALUES(11, 43, 'TEMP-43', 'Subdirección de Tecnologías de la Información y Comunicaciones', 'J.U.D. de Desarrollo de Sistemas', '2025-06-25 20:10:28', 1, NULL, NULL, 'temp_temp-43@institucion.mx');
INSERT INTO `historial_departamentos` (`id`, `personal_id`, `numero_empleado`, `departamento_anterior`, `departamento_nuevo`, `fecha_cambio`, `usuario_registra`, `documento_id`, `numero_oficio_usuario`, `email_institucional`) VALUES(12, 43, 'TEMP-43', 'Subdirección de Tecnologías de la Información y Comunicaciones', 'J.U.D. de Desarrollo de Sistemas', '2025-06-25 20:27:40', 1, NULL, NULL, 'temp_temp-43@institucion.mx');
INSERT INTO `historial_departamentos` (`id`, `personal_id`, `numero_empleado`, `departamento_anterior`, `departamento_nuevo`, `fecha_cambio`, `usuario_registra`, `documento_id`, `numero_oficio_usuario`, `email_institucional`) VALUES(13, 50, 'TEMP-50', 'Subdirección de Tecnologías de la Información y Comunicaciones', 'J.U.D. de Desarrollo de Sistemas', '2025-06-26 18:28:41', 1, NULL, NULL, 'temp_temp-50@institucion.mx');
INSERT INTO `historial_departamentos` (`id`, `personal_id`, `numero_empleado`, `departamento_anterior`, `departamento_nuevo`, `fecha_cambio`, `usuario_registra`, `documento_id`, `numero_oficio_usuario`, `email_institucional`) VALUES(14, 51, 'TEMP-51', 'Subdirección de Tecnologías de la Información y Comunicaciones', 'J.U.D. de Soporte Técnico', '2025-06-26 18:31:52', 1, NULL, NULL, 'temp_temp-51@institucion.mx');
INSERT INTO `historial_departamentos` (`id`, `personal_id`, `numero_empleado`, `departamento_anterior`, `departamento_nuevo`, `fecha_cambio`, `usuario_registra`, `documento_id`, `numero_oficio_usuario`, `email_institucional`) VALUES(15, 52, 'TEMP-52', 'Subdirección de Tecnologías de la Información y Comunicaciones', 'J.U.D. de Soporte Técnico', '2025-06-26 18:34:00', 1, NULL, NULL, 'temp_temp-52@institucion.mx');
INSERT INTO `historial_departamentos` (`id`, `personal_id`, `numero_empleado`, `departamento_anterior`, `departamento_nuevo`, `fecha_cambio`, `usuario_registra`, `documento_id`, `numero_oficio_usuario`, `email_institucional`) VALUES(16, 53, 'TEMP-53', 'Subdirección de Tecnologías de la Información y Comunicaciones', 'J.U.D. de Soporte Técnico', '2025-06-26 18:35:53', 1, NULL, NULL, 'temp_temp-53@institucion.mx');
INSERT INTO `historial_departamentos` (`id`, `personal_id`, `numero_empleado`, `departamento_anterior`, `departamento_nuevo`, `fecha_cambio`, `usuario_registra`, `documento_id`, `numero_oficio_usuario`, `email_institucional`) VALUES(17, 55, 'TEMP-55', 'J.U.D. de Modernización Administrativa', 'J.U.D. de Desarrollo de Sistemas', '2025-06-26 18:37:38', 1, NULL, NULL, 'temp_temp-55@institucion.mx');
INSERT INTO `historial_departamentos` (`id`, `personal_id`, `numero_empleado`, `departamento_anterior`, `departamento_nuevo`, `fecha_cambio`, `usuario_registra`, `documento_id`, `numero_oficio_usuario`, `email_institucional`) VALUES(18, 56, 'TEMP-56', 'Dirección de Administración de Capital Humano', 'J.U.D. de Soporte Técnico', '2025-06-26 18:38:46', 1, NULL, NULL, 'temp_temp-56@institucion.mx');
INSERT INTO `historial_departamentos` (`id`, `personal_id`, `numero_empleado`, `departamento_anterior`, `departamento_nuevo`, `fecha_cambio`, `usuario_registra`, `documento_id`, `numero_oficio_usuario`, `email_institucional`) VALUES(19, 58, '1197767', NULL, 'J.U.D. de Desarrollo de Sistemas', '2025-07-08 19:15:26', 1, NULL, NULL, 'temp_1197767@institucion.mx');
INSERT INTO `historial_departamentos` (`id`, `personal_id`, `numero_empleado`, `departamento_anterior`, `departamento_nuevo`, `fecha_cambio`, `usuario_registra`, `documento_id`, `numero_oficio_usuario`, `email_institucional`) VALUES(20, 58, '1197767', NULL, 'J.U.D. de Desarrollo de Sistemas', '2025-07-08 19:36:56', 1, NULL, NULL, 'temp_1197767@institucion.mx');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jud_departamentos`
--

DROP TABLE IF EXISTS `jud_departamentos`;
CREATE TABLE `jud_departamentos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `responsable` varchar(100) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `jud_departamentos`:
--

--
-- Volcado de datos para la tabla `jud_departamentos`
--

INSERT INTO `jud_departamentos` (`id`, `nombre`, `responsable`, `activo`) VALUES(1, 'DIRECCIÓN GENERAL DE ADMINISTRACIÓN Y FINANZAS', NULL, 1);
INSERT INTO `jud_departamentos` (`id`, `nombre`, `responsable`, `activo`) VALUES(2, 'Dirección de Administración de Capital Humano', NULL, 1);
INSERT INTO `jud_departamentos` (`id`, `nombre`, `responsable`, `activo`) VALUES(3, 'Subdirección de Nóminas y Registro de Personal', NULL, 1);
INSERT INTO `jud_departamentos` (`id`, `nombre`, `responsable`, `activo`) VALUES(4, 'J.U.D. de Registro y Movimientos de Personal', NULL, 1);
INSERT INTO `jud_departamentos` (`id`, `nombre`, `responsable`, `activo`) VALUES(5, 'Subdirección de Relaciones Laborales y Capacitación', NULL, 1);
INSERT INTO `jud_departamentos` (`id`, `nombre`, `responsable`, `activo`) VALUES(6, 'J.U.D. de Capacitación y Desarrollo de Personal', NULL, 1);
INSERT INTO `jud_departamentos` (`id`, `nombre`, `responsable`, `activo`) VALUES(7, 'J.U.D. de Relaciones Laborales y Prestaciones', NULL, 1);
INSERT INTO `jud_departamentos` (`id`, `nombre`, `responsable`, `activo`) VALUES(8, 'Dirección de Autogenerados', NULL, 1);
INSERT INTO `jud_departamentos` (`id`, `nombre`, `responsable`, `activo`) VALUES(9, 'L.C.P. de Seguimiento e Informes', NULL, 1);
INSERT INTO `jud_departamentos` (`id`, `nombre`, `responsable`, `activo`) VALUES(10, 'Dirección de Finanzas', NULL, 1);
INSERT INTO `jud_departamentos` (`id`, `nombre`, `responsable`, `activo`) VALUES(11, 'Subdirección de Contabilidad', NULL, 1);
INSERT INTO `jud_departamentos` (`id`, `nombre`, `responsable`, `activo`) VALUES(12, 'J.U.D. de Registro Contable', NULL, 1);
INSERT INTO `jud_departamentos` (`id`, `nombre`, `responsable`, `activo`) VALUES(13, 'Subdirección de Programación y Presupuesto', NULL, 1);
INSERT INTO `jud_departamentos` (`id`, `nombre`, `responsable`, `activo`) VALUES(14, 'J.U.D. de Control Presupuestal', NULL, 1);
INSERT INTO `jud_departamentos` (`id`, `nombre`, `responsable`, `activo`) VALUES(15, 'Subdirección de Tesorería', NULL, 1);
INSERT INTO `jud_departamentos` (`id`, `nombre`, `responsable`, `activo`) VALUES(16, 'Dirección de Modernización Administrativa y Tecnologías de la Información y Comunicaciones', NULL, 1);
INSERT INTO `jud_departamentos` (`id`, `nombre`, `responsable`, `activo`) VALUES(17, 'Subdirección de Tecnologías de la Información y Comunicaciones', NULL, 1);
INSERT INTO `jud_departamentos` (`id`, `nombre`, `responsable`, `activo`) VALUES(18, 'J.U.D. de Modernización Administrativa', NULL, 1);
INSERT INTO `jud_departamentos` (`id`, `nombre`, `responsable`, `activo`) VALUES(19, 'J.U.D. de Desarrollo de Sistemas', NULL, 1);
INSERT INTO `jud_departamentos` (`id`, `nombre`, `responsable`, `activo`) VALUES(20, 'J.U.D. de Soporte Técnico', NULL, 1);
INSERT INTO `jud_departamentos` (`id`, `nombre`, `responsable`, `activo`) VALUES(21, 'Subdirección de Cumplimiento de Auditorías y Rendición de Cuentas', NULL, 1);
INSERT INTO `jud_departamentos` (`id`, `nombre`, `responsable`, `activo`) VALUES(22, 'Subdirección de Seguimiento de Proyectos Administrativos y Control de Gestión', NULL, 1);
INSERT INTO `jud_departamentos` (`id`, `nombre`, `responsable`, `activo`) VALUES(23, 'L.C.P. de Gestión Documental', NULL, 1);
INSERT INTO `jud_departamentos` (`id`, `nombre`, `responsable`, `activo`) VALUES(24, 'Dirección de Recursos Materiales y Servicios Generales', NULL, 1);
INSERT INTO `jud_departamentos` (`id`, `nombre`, `responsable`, `activo`) VALUES(25, 'J.U.D. de Almacenes e Inventarios', NULL, 1);
INSERT INTO `jud_departamentos` (`id`, `nombre`, `responsable`, `activo`) VALUES(26, 'Subdirección de Adquisiciones', NULL, 1);
INSERT INTO `jud_departamentos` (`id`, `nombre`, `responsable`, `activo`) VALUES(27, 'Subdirección de Servicios Generales', NULL, 1);
INSERT INTO `jud_departamentos` (`id`, `nombre`, `responsable`, `activo`) VALUES(28, 'J.U.D. de Control Vehicular, Talleres y Combustible', NULL, 1);
INSERT INTO `jud_departamentos` (`id`, `nombre`, `responsable`, `activo`) VALUES(29, 'J.U.D. de Servicios Generales y Apoyo Logístico', NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logs_sistema`
--

DROP TABLE IF EXISTS `logs_sistema`;
CREATE TABLE `logs_sistema` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `accion` varchar(100) NOT NULL,
  `detalles` text DEFAULT NULL,
  `ip` varchar(45) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `logs_sistema`:
--   `usuario_id`
--       `usuarios` -> `id`
--

--
-- Volcado de datos para la tabla `logs_sistema`
--

INSERT INTO `logs_sistema` (`id`, `usuario_id`, `accion`, `detalles`, `ip`, `fecha`) VALUES(1, 1, 'DOCUMENTO_CREADO', 'Oficio 30', '::1', '2025-06-13 19:56:28');
INSERT INTO `logs_sistema` (`id`, `usuario_id`, `accion`, `detalles`, `ip`, `fecha`) VALUES(2, 1, 'DOCUMENTO_CREADO', 'Oficio 31', '::1', '2025-06-13 20:36:10');
INSERT INTO `logs_sistema` (`id`, `usuario_id`, `accion`, `detalles`, `ip`, `fecha`) VALUES(3, 1, 'DOCUMENTO_CREADO', 'Oficio 32', '::1', '2025-06-13 20:40:01');
INSERT INTO `logs_sistema` (`id`, `usuario_id`, `accion`, `detalles`, `ip`, `fecha`) VALUES(4, 1, 'DOCUMENTO_CREADO', 'Oficio 32', '::1', '2025-06-13 20:42:25');
INSERT INTO `logs_sistema` (`id`, `usuario_id`, `accion`, `detalles`, `ip`, `fecha`) VALUES(5, 1, 'DOCUMENTO_CREADO', 'Oficio 33', '::1', '2025-06-25 18:06:50');
INSERT INTO `logs_sistema` (`id`, `usuario_id`, `accion`, `detalles`, `ip`, `fecha`) VALUES(6, 1, 'DOCUMENTO_CREADO', 'Oficio 34', '::1', '2025-06-25 18:59:44');
INSERT INTO `logs_sistema` (`id`, `usuario_id`, `accion`, `detalles`, `ip`, `fecha`) VALUES(7, 1, 'DOCUMENTO_CREADO', 'Oficio 35', '::1', '2025-06-25 20:10:28');
INSERT INTO `logs_sistema` (`id`, `usuario_id`, `accion`, `detalles`, `ip`, `fecha`) VALUES(8, 1, 'DOCUMENTO_CREADO', 'Oficio 36', '::1', '2025-06-25 20:27:40');
INSERT INTO `logs_sistema` (`id`, `usuario_id`, `accion`, `detalles`, `ip`, `fecha`) VALUES(9, 1, 'DOCUMENTO_CREADO', 'Oficio 37', '::1', '2025-06-26 18:28:41');
INSERT INTO `logs_sistema` (`id`, `usuario_id`, `accion`, `detalles`, `ip`, `fecha`) VALUES(10, 1, 'DOCUMENTO_CREADO', 'Oficio 37', '::1', '2025-06-26 18:31:52');
INSERT INTO `logs_sistema` (`id`, `usuario_id`, `accion`, `detalles`, `ip`, `fecha`) VALUES(11, 1, 'DOCUMENTO_CREADO', 'Oficio 38', '::1', '2025-06-26 18:34:00');
INSERT INTO `logs_sistema` (`id`, `usuario_id`, `accion`, `detalles`, `ip`, `fecha`) VALUES(12, 1, 'DOCUMENTO_CREADO', 'Oficio 39', '::1', '2025-06-26 18:35:53');
INSERT INTO `logs_sistema` (`id`, `usuario_id`, `accion`, `detalles`, `ip`, `fecha`) VALUES(13, 1, 'DOCUMENTO_CREADO', 'Oficio 40', '::1', '2025-06-26 18:37:38');
INSERT INTO `logs_sistema` (`id`, `usuario_id`, `accion`, `detalles`, `ip`, `fecha`) VALUES(14, 1, 'DOCUMENTO_CREADO', 'Oficio 41', '::1', '2025-06-26 18:38:46');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modulos`
--

DROP TABLE IF EXISTS `modulos`;
CREATE TABLE `modulos` (
  `id` int(11) NOT NULL,
  `codigo` varchar(10) DEFAULT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `modulos`:
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

DROP TABLE IF EXISTS `permisos`;
CREATE TABLE `permisos` (
  `usuario_id` int(11) NOT NULL,
  `modulo_id` int(11) NOT NULL,
  `nivel_acceso` enum('LECTURA','ESCRITURA','TOTAL') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `permisos`:
--   `usuario_id`
--       `usuarios` -> `id`
--   `modulo_id`
--       `modulos` -> `id`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `secuencia_oficios`
--

DROP TABLE IF EXISTS `secuencia_oficios`;
CREATE TABLE `secuencia_oficios` (
  `id` int(11) NOT NULL,
  `ultimo_numero` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELACIONES PARA LA TABLA `secuencia_oficios`:
--

--
-- Volcado de datos para la tabla `secuencia_oficios`
--

INSERT INTO `secuencia_oficios` (`id`, `ultimo_numero`) VALUES(1, 130);
INSERT INTO `secuencia_oficios` (`id`, `ultimo_numero`) VALUES(2, 130);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
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
-- RELACIONES PARA LA TABLA `usuarios`:
--

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `username`, `password`, `nombre_completo`, `rol`, `departamento`, `activo`, `fecha_creacion`, `ultimo_acceso`) VALUES(1, 'admin', '$2y$10$WBCaSgMZraXILd65Bnym..2P3S2QZTWmXApQjkSGYhG4ks6Ya90Oi', 'Administrador Principal', 'SISTEMAS', NULL, 1, '2025-05-29 17:15:33', NULL);
INSERT INTO `usuarios` (`id`, `username`, `password`, `nombre_completo`, `rol`, `departamento`, `activo`, `fecha_creacion`, `ultimo_acceso`) VALUES(2, 'judds', '$2y$10$2W7JFfRstQhcswqYgJHXyuZchIELRpGoTBETXzbg1lG2hL5/yV8UO', 'Administrador JUDDS', 'ADMIN', NULL, 1, '2025-05-29 17:15:33', NULL);
INSERT INTO `usuarios` (`id`, `username`, `password`, `nombre_completo`, `rol`, `departamento`, `activo`, `fecha_creacion`, `ultimo_acceso`) VALUES(3, 'capturista1', '$2y$10$OrPW2kExuEpctZUKO74X9eW3w/VfVuKxJZ7yLmsvqXLueZ93ubwBK', 'Capturista Principal', 'CAPTURISTA', NULL, 1, '2025-05-29 17:15:33', NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `auditoria_oficios`
--
ALTER TABLE `auditoria_oficios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `catalogo_personal`
--
ALTER TABLE `catalogo_personal`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero_empleado` (`numero_empleado`),
  ADD UNIQUE KEY `uk_numero_empleado` (`numero_empleado`),
  ADD UNIQUE KEY `email_institucional` (`email_institucional`),
  ADD KEY `unique_nombre_puesto` (`nombre`,`puesto`) USING BTREE,
  ADD KEY `idx_cat_email` (`email_institucional`),
  ADD KEY `idx_cat_numemp` (`numero_empleado`),
  ADD KEY `idx_email` (`email_institucional`);

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
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_email_institucional` (`email_institucional`),
  ADD KEY `idx_doc_numemp` (`numero_empleado`),
  ADD KEY `idx_doc_email` (`email_institucional`);

--
-- Indices de la tabla `historial`
--
ALTER TABLE `historial`
  ADD PRIMARY KEY (`id`),
  ADD KEY `documento_id` (`documento_id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `historial_departamentos`
--
ALTER TABLE `historial_departamentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `documento_id` (`documento_id`),
  ADD KEY `fk_personal` (`personal_id`),
  ADD KEY `idx_numero_empleado` (`numero_empleado`),
  ADD KEY `idx_email_institucional` (`email_institucional`),
  ADD KEY `idx_hist_email` (`email_institucional`);

--
-- Indices de la tabla `jud_departamentos`
--
ALTER TABLE `jud_departamentos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

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
-- Indices de la tabla `secuencia_oficios`
--
ALTER TABLE `secuencia_oficios`
  ADD PRIMARY KEY (`id`);

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
-- AUTO_INCREMENT de la tabla `auditoria_oficios`
--
ALTER TABLE `auditoria_oficios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `catalogo_personal`
--
ALTER TABLE `catalogo_personal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `documentos`
--
ALTER TABLE `documentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=84;

--
-- AUTO_INCREMENT de la tabla `historial`
--
ALTER TABLE `historial`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `historial_departamentos`
--
ALTER TABLE `historial_departamentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `jud_departamentos`
--
ALTER TABLE `jud_departamentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de la tabla `logs_sistema`
--
ALTER TABLE `logs_sistema`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `modulos`
--
ALTER TABLE `modulos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `secuencia_oficios`
--
ALTER TABLE `secuencia_oficios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `auditoria_oficios`
--
ALTER TABLE `auditoria_oficios`
  ADD CONSTRAINT `auditoria_oficios_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `historial`
--
ALTER TABLE `historial`
  ADD CONSTRAINT `historial_ibfk_1` FOREIGN KEY (`documento_id`) REFERENCES `documentos` (`id`),
  ADD CONSTRAINT `historial_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `historial_departamentos`
--
ALTER TABLE `historial_departamentos`
  ADD CONSTRAINT `fk_empleado_historial` FOREIGN KEY (`numero_empleado`) REFERENCES `catalogo_personal` (`numero_empleado`),
  ADD CONSTRAINT `fk_personal` FOREIGN KEY (`personal_id`) REFERENCES `catalogo_personal` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `historial_departamentos_ibfk_1` FOREIGN KEY (`personal_id`) REFERENCES `catalogo_personal` (`id`),
  ADD CONSTRAINT `historial_departamentos_ibfk_2` FOREIGN KEY (`documento_id`) REFERENCES `documentos` (`id`);

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
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
