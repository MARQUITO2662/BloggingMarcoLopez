-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-04-2024 a las 21:47:40
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
-- Base de datos: `facebook`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `autores_publicaciones`
--

CREATE TABLE `autores_publicaciones` (
  `autores_publicaciones_id` int(11) NOT NULL,
  `publicacion_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `autores_publicaciones`
--

INSERT INTO `autores_publicaciones` (`autores_publicaciones_id`, `publicacion_id`, `usuario_id`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 7),
(8, 8, 8),
(9, 9, 9),
(10, 10, 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `categoria_id` int(11) NOT NULL,
  `categoria_nombre` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`categoria_id`, `categoria_nombre`) VALUES
(1, 'Tecnología'),
(2, 'Deportes'),
(3, 'Cine'),
(4, 'Cocina'),
(5, 'Viajes'),
(6, 'Literatura'),
(7, 'Belleza'),
(8, 'Jardinería'),
(9, 'Noticias'),
(10, 'Salud y Bienestar');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias_publicaciones`
--

CREATE TABLE `categorias_publicaciones` (
  `cp_id` int(11) NOT NULL,
  `categoria_id` int(11) DEFAULT NULL,
  `publicaciones_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias_publicaciones`
--

INSERT INTO `categorias_publicaciones` (`cp_id`, `categoria_id`, `publicaciones_id`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 7),
(8, 8, 8),
(9, 9, 9),
(10, 10, 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentarios`
--

CREATE TABLE `comentarios` (
  `comentario_id` int(11) NOT NULL,
  `comentario` text DEFAULT NULL,
  `publicaciones_id` int(11) DEFAULT NULL,
  `usuarios_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `comentarios`
--

INSERT INTO `comentarios` (`comentario_id`, `comentario`, `publicaciones_id`, `usuarios_id`) VALUES
(1, 'Excelente artículo, muy informativo.', 1, 3),
(2, 'Me encantó este partido, ¡fue emocionante!', 2, 4),
(3, 'Buena crítica, me ayudó a decidir si ver la película o no.', 3, 2),
(4, '¿Tienes más recetas? Esta suena deliciosa.', 4, 6),
(5, 'Gracias por los consejos, me serán útiles en mi próximo viaje.', 5, 7),
(6, 'Estoy de acuerdo, este libro es una obra maestra.', 6, 5),
(7, '¡Los tutoriales son geniales! Me ayudaron a mejorar mis habilidades de maquillaje.', 7, 8),
(8, 'Necesitaba estos consejos, mi jardín necesita atención.', 8, 9),
(9, 'Interesantes noticias, estoy ansioso por ver lo que viene.', 9, 10),
(10, 'Estos consejos son justo lo que necesitaba para comenzar mi rutina de ejercicio.', 10, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `publicaciones`
--

CREATE TABLE `publicaciones` (
  `publicaciones_id` int(11) NOT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `contenido` text DEFAULT NULL,
  `usuarios_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `publicaciones`
--

INSERT INTO `publicaciones` (`publicaciones_id`, `titulo`, `contenido`, `usuarios_id`) VALUES
(1, 'Nuevo producto tecnológico', 'Descripción del nuevo producto tecnológico.', 1),
(2, 'Partido de fútbol', 'Resumen del partido de fútbol.', 2),
(3, 'Estreno de película', 'Opinión sobre la última película de cine.', 3),
(4, 'Recetas de cocina', 'Recetas deliciosas para preparar en casa.', 4),
(5, 'Consejos de viaje', 'Consejos útiles para viajar de manera segura y económica.', 5),
(6, 'Reseñas de libros', 'Opiniones sobre los últimos libros más vendidos.', 6),
(7, 'Tutoriales de maquillaje', 'Instrucciones paso a paso para maquillarse como un profesional.', 7),
(8, 'Consejos de jardinería', 'Cómo cuidar tus plantas y jardín durante todas las estaciones del año.', 8),
(9, 'Noticias de tecnología', 'Últimas noticias sobre avances tecnológicos y gadgets.', 9),
(10, 'Consejos de ejercicio', 'Formas efectivas de mantenerse en forma y saludable.', 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `rol_id` int(11) NOT NULL,
  `rol_nombre` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`rol_id`, `rol_nombre`) VALUES
(1, 'Administrador'),
(2, 'Moderador'),
(3, 'Usuario regular');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles_asignados`
--

CREATE TABLE `roles_asignados` (
  `roles_asignados_id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `rol_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles_asignados`
--

INSERT INTO `roles_asignados` (`roles_asignados_id`, `usuario_id`, `rol_id`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 1),
(4, 4, 2),
(5, 5, 1),
(6, 6, 2),
(7, 7, 1),
(8, 8, 2),
(9, 9, 1),
(10, 10, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `usuarios_id` int(11) NOT NULL,
  `usuarios_nombre` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `rol_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`usuarios_id`, `usuarios_nombre`, `email`, `password`, `rol_id`) VALUES
(1, 'Juan Pérez', 'juan@example.com', 'password123', 1),
(2, 'María López', 'maria@example.com', 'password456', 2),
(3, 'Pedro García', 'pedro@example.com', 'password789', 1),
(4, 'Laura Martínez', 'laura@example.com', 'password123', 2),
(5, 'Carlos Rodríguez', 'carlos@example.com', 'password456', 1),
(6, 'Ana Gómez', 'ana@example.com', 'password789', 2),
(7, 'David Fernández', 'david@example.com', 'password123', 1),
(8, 'Sofía Díaz', 'sofia@example.com', 'password456', 2),
(9, 'Elena Ruiz', 'elena@example.com', 'password789', 1),
(10, 'Javier Sánchez', 'javier@example.com', 'password123', 2);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `autores_publicaciones`
--
ALTER TABLE `autores_publicaciones`
  ADD PRIMARY KEY (`autores_publicaciones_id`),
  ADD KEY `publicacion_id` (`publicacion_id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`categoria_id`);

--
-- Indices de la tabla `categorias_publicaciones`
--
ALTER TABLE `categorias_publicaciones`
  ADD PRIMARY KEY (`cp_id`),
  ADD KEY `categoria_id` (`categoria_id`),
  ADD KEY `publicaciones_id` (`publicaciones_id`);

--
-- Indices de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD PRIMARY KEY (`comentario_id`),
  ADD KEY `publicaciones_id` (`publicaciones_id`),
  ADD KEY `usuarios_id` (`usuarios_id`);

--
-- Indices de la tabla `publicaciones`
--
ALTER TABLE `publicaciones`
  ADD PRIMARY KEY (`publicaciones_id`),
  ADD KEY `usuarios_id` (`usuarios_id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`rol_id`);

--
-- Indices de la tabla `roles_asignados`
--
ALTER TABLE `roles_asignados`
  ADD PRIMARY KEY (`roles_asignados_id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `rol_id` (`rol_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`usuarios_id`),
  ADD KEY `rol_id` (`rol_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `autores_publicaciones`
--
ALTER TABLE `autores_publicaciones`
  MODIFY `autores_publicaciones_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `categoria_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `categorias_publicaciones`
--
ALTER TABLE `categorias_publicaciones`
  MODIFY `cp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `comentario_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `publicaciones`
--
ALTER TABLE `publicaciones`
  MODIFY `publicaciones_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `rol_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `roles_asignados`
--
ALTER TABLE `roles_asignados`
  MODIFY `roles_asignados_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `usuarios_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `autores_publicaciones`
--
ALTER TABLE `autores_publicaciones`
  ADD CONSTRAINT `autores_publicaciones_ibfk_1` FOREIGN KEY (`publicacion_id`) REFERENCES `publicaciones` (`publicaciones_id`),
  ADD CONSTRAINT `autores_publicaciones_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`usuarios_id`);

--
-- Filtros para la tabla `categorias_publicaciones`
--
ALTER TABLE `categorias_publicaciones`
  ADD CONSTRAINT `categorias_publicaciones_ibfk_1` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`categoria_id`),
  ADD CONSTRAINT `categorias_publicaciones_ibfk_2` FOREIGN KEY (`publicaciones_id`) REFERENCES `publicaciones` (`publicaciones_id`);

--
-- Filtros para la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`publicaciones_id`) REFERENCES `publicaciones` (`publicaciones_id`),
  ADD CONSTRAINT `comentarios_ibfk_2` FOREIGN KEY (`usuarios_id`) REFERENCES `usuarios` (`usuarios_id`);

--
-- Filtros para la tabla `publicaciones`
--
ALTER TABLE `publicaciones`
  ADD CONSTRAINT `publicaciones_ibfk_1` FOREIGN KEY (`usuarios_id`) REFERENCES `usuarios` (`usuarios_id`);

--
-- Filtros para la tabla `roles_asignados`
--
ALTER TABLE `roles_asignados`
  ADD CONSTRAINT `roles_asignados_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`usuarios_id`),
  ADD CONSTRAINT `roles_asignados_ibfk_2` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`rol_id`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`rol_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
