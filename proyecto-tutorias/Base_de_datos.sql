-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: app_tutorias
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alerta`
--

DROP TABLE IF EXISTS `alerta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alerta` (
  `id_alerta` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_estudiante` int unsigned NOT NULL,
  `id_alerta_tipo` smallint unsigned NOT NULL,
  `detalle` varchar(255) DEFAULT NULL,
  `nivel` enum('Info','Atencion','Critica') NOT NULL DEFAULT 'Info',
  `generada_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `atendida` tinyint(1) NOT NULL DEFAULT '0',
  `atendida_por` int unsigned DEFAULT NULL,
  `atendida_en` datetime DEFAULT NULL,
  PRIMARY KEY (`id_alerta`),
  KEY `fk_al_tipo` (`id_alerta_tipo`),
  KEY `fk_al_usr` (`atendida_por`),
  KEY `idx_al_est_tipo` (`id_estudiante`,`id_alerta_tipo`,`atendida`),
  CONSTRAINT `fk_al_est` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiante` (`id_estudiante`),
  CONSTRAINT `fk_al_tipo` FOREIGN KEY (`id_alerta_tipo`) REFERENCES `alerta_tipo` (`id_alerta_tipo`),
  CONSTRAINT `fk_al_usr` FOREIGN KEY (`atendida_por`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerta`
--

LOCK TABLES `alerta` WRITE;
/*!40000 ALTER TABLE `alerta` DISABLE KEYS */;
/*!40000 ALTER TABLE `alerta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alerta_tipo`
--

DROP TABLE IF EXISTS `alerta_tipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alerta_tipo` (
  `id_alerta_tipo` smallint unsigned NOT NULL AUTO_INCREMENT,
  `codigo` varchar(50) NOT NULL,
  `descripcion` varchar(200) NOT NULL,
  `activa_por_defecto` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_alerta_tipo`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerta_tipo`
--

LOCK TABLES `alerta_tipo` WRITE;
/*!40000 ALTER TABLE `alerta_tipo` DISABLE KEYS */;
INSERT INTO `alerta_tipo` VALUES (1,'FALTAS_CONSEC','Alerta por faltas consecutivas de un estudiante',1),(2,'REPROBADAS_MULTI','Alerta por múltiples materias reprobadas',1),(3,'DOCENTE_MANUAL','Alerta manual generada por docente',1);
/*!40000 ALTER TABLE `alerta_tipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asignacion_tutor`
--

DROP TABLE IF EXISTS `asignacion_tutor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asignacion_tutor` (
  `id_asignacion` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_estudiante` int unsigned NOT NULL,
  `id_tutor` int unsigned NOT NULL,
  `periodo` varchar(20) NOT NULL,
  `vigente` tinyint(1) NOT NULL DEFAULT '1',
  `asignado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_asignacion`),
  UNIQUE KEY `uk_est_per` (`id_estudiante`,`periodo`),
  KEY `fk_ast_tut` (`id_tutor`),
  CONSTRAINT `fk_ast_est` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiante` (`id_estudiante`),
  CONSTRAINT `fk_ast_tut` FOREIGN KEY (`id_tutor`) REFERENCES `tutor` (`id_tutor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asignacion_tutor`
--

LOCK TABLES `asignacion_tutor` WRITE;
/*!40000 ALTER TABLE `asignacion_tutor` DISABLE KEYS */;
/*!40000 ALTER TABLE `asignacion_tutor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bitacora_accion`
--

DROP TABLE IF EXISTS `bitacora_accion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bitacora_accion` (
  `id_evento` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_usuario` int unsigned DEFAULT NULL,
  `modulo` varchar(60) NOT NULL,
  `accion` varchar(80) NOT NULL,
  `entidad_id` bigint unsigned DEFAULT NULL,
  `detalle` varchar(255) DEFAULT NULL,
  `ip_origen` varbinary(16) DEFAULT NULL,
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_evento`),
  KEY `idx_bit_mod_acc` (`modulo`,`accion`,`creado_en`),
  KEY `idx_bit_usr_fecha` (`id_usuario`,`creado_en`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bitacora_accion`
--

LOCK TABLES `bitacora_accion` WRITE;
/*!40000 ALTER TABLE `bitacora_accion` DISABLE KEYS */;
/*!40000 ALTER TABLE `bitacora_accion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `canalizacion`
--

DROP TABLE IF EXISTS `canalizacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `canalizacion` (
  `id_canalizacion` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_estudiante` int unsigned NOT NULL,
  `id_tutor_emisor` int unsigned NOT NULL,
  `tipo_atencion` enum('Academica','Psicologica','Social','Medica','Otra') NOT NULL,
  `fecha_canalizacion` date NOT NULL,
  `derivado_por` varchar(120) DEFAULT NULL,
  `observaciones` text,
  `estatus` enum('Abierta','EnProceso','Cerrada') NOT NULL DEFAULT 'Abierta',
  `creada_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_canalizacion`),
  KEY `fk_can_est` (`id_estudiante`),
  KEY `fk_can_tut` (`id_tutor_emisor`),
  CONSTRAINT `fk_can_est` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiante` (`id_estudiante`),
  CONSTRAINT `fk_can_tut` FOREIGN KEY (`id_tutor_emisor`) REFERENCES `tutor` (`id_tutor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `canalizacion`
--

LOCK TABLES `canalizacion` WRITE;
/*!40000 ALTER TABLE `canalizacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `canalizacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `canalizacion_seguimiento`
--

DROP TABLE IF EXISTS `canalizacion_seguimiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `canalizacion_seguimiento` (
  `id_seguimiento` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_canalizacion` bigint unsigned NOT NULL,
  `nota` text NOT NULL,
  `privado_coord` tinyint(1) NOT NULL DEFAULT '0',
  `creado_por` int unsigned NOT NULL,
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_seguimiento`),
  KEY `fk_cseg_can` (`id_canalizacion`),
  KEY `fk_cseg_usr` (`creado_por`),
  CONSTRAINT `fk_cseg_can` FOREIGN KEY (`id_canalizacion`) REFERENCES `canalizacion` (`id_canalizacion`) ON DELETE CASCADE,
  CONSTRAINT `fk_cseg_usr` FOREIGN KEY (`creado_por`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `canalizacion_seguimiento`
--

LOCK TABLES `canalizacion_seguimiento` WRITE;
/*!40000 ALTER TABLE `canalizacion_seguimiento` DISABLE KEYS */;
/*!40000 ALTER TABLE `canalizacion_seguimiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carrera`
--

DROP TABLE IF EXISTS `carrera`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carrera` (
  `id_carrera` smallint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(120) NOT NULL,
  `id_division` smallint unsigned NOT NULL,
  PRIMARY KEY (`id_carrera`),
  UNIQUE KEY `nombre` (`nombre`),
  KEY `fk_carrera_div` (`id_division`),
  CONSTRAINT `fk_carrera_div` FOREIGN KEY (`id_division`) REFERENCES `division` (`id_division`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carrera`
--

LOCK TABLES `carrera` WRITE;
/*!40000 ALTER TABLE `carrera` DISABLE KEYS */;
/*!40000 ALTER TABLE `carrera` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `division`
--

DROP TABLE IF EXISTS `division`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `division` (
  `id_division` smallint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(120) NOT NULL,
  PRIMARY KEY (`id_division`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `division`
--

LOCK TABLES `division` WRITE;
/*!40000 ALTER TABLE `division` DISABLE KEYS */;
/*!40000 ALTER TABLE `division` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documento`
--

DROP TABLE IF EXISTS `documento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documento` (
  `id_documento` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tipo` enum('Oficio','Reporte','Constancia','Otro') NOT NULL,
  `nombre_archivo` varchar(190) NOT NULL,
  `ruta_almacen` varchar(255) NOT NULL,
  `hash_contenido` char(64) NOT NULL,
  `subido_por` int unsigned NOT NULL,
  `visible_rol_min` tinyint unsigned NOT NULL,
  `validado_por` int unsigned DEFAULT NULL,
  `validado_en` datetime DEFAULT NULL,
  `subido_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_documento`),
  KEY `fk_doc_usr` (`subido_por`),
  KEY `fk_doc_val` (`validado_por`),
  KEY `idx_doc_tipo` (`tipo`,`subido_en`),
  CONSTRAINT `fk_doc_usr` FOREIGN KEY (`subido_por`) REFERENCES `usuario` (`id_usuario`),
  CONSTRAINT `fk_doc_val` FOREIGN KEY (`validado_por`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documento`
--

LOCK TABLES `documento` WRITE;
/*!40000 ALTER TABLE `documento` DISABLE KEYS */;
/*!40000 ALTER TABLE `documento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documento_lectura`
--

DROP TABLE IF EXISTS `documento_lectura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documento_lectura` (
  `id_documento` bigint unsigned NOT NULL,
  `id_usuario` int unsigned NOT NULL,
  `leido_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_documento`,`id_usuario`),
  KEY `fk_dl_usr` (`id_usuario`),
  CONSTRAINT `fk_dl_doc` FOREIGN KEY (`id_documento`) REFERENCES `documento` (`id_documento`) ON DELETE CASCADE,
  CONSTRAINT `fk_dl_usr` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documento_lectura`
--

LOCK TABLES `documento_lectura` WRITE;
/*!40000 ALTER TABLE `documento_lectura` DISABLE KEYS */;
/*!40000 ALTER TABLE `documento_lectura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estudiante`
--

DROP TABLE IF EXISTS `estudiante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estudiante` (
  `id_estudiante` int unsigned NOT NULL AUTO_INCREMENT,
  `id_usuario` int unsigned NOT NULL,
  `num_control` varchar(20) NOT NULL,
  `id_carrera` smallint unsigned NOT NULL,
  `semestre` tinyint unsigned NOT NULL,
  `fecha_ingreso` date DEFAULT NULL,
  PRIMARY KEY (`id_estudiante`),
  UNIQUE KEY `id_usuario` (`id_usuario`),
  UNIQUE KEY `num_control` (`num_control`),
  KEY `fk_est_carrera` (`id_carrera`),
  CONSTRAINT `fk_est_carrera` FOREIGN KEY (`id_carrera`) REFERENCES `carrera` (`id_carrera`),
  CONSTRAINT `fk_est_usr` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estudiante`
--

LOCK TABLES `estudiante` WRITE;
/*!40000 ALTER TABLE `estudiante` DISABLE KEYS */;
/*!40000 ALTER TABLE `estudiante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `falta_asistencia`
--

DROP TABLE IF EXISTS `falta_asistencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `falta_asistencia` (
  `id_falta` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_estudiante` int unsigned NOT NULL,
  `fecha` date NOT NULL,
  `motivo` varchar(200) DEFAULT NULL,
  `registrada_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_falta`),
  KEY `idx_falta_est_fecha` (`id_estudiante`,`fecha`),
  CONSTRAINT `fk_falta_est` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiante` (`id_estudiante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `falta_asistencia`
--

LOCK TABLES `falta_asistencia` WRITE;
/*!40000 ALTER TABLE `falta_asistencia` DISABLE KEYS */;
/*!40000 ALTER TABLE `falta_asistencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset`
--

DROP TABLE IF EXISTS `password_reset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset` (
  `id_usuario` int unsigned NOT NULL,
  `token_hash` char(64) NOT NULL,
  `expira_en` datetime NOT NULL,
  `usado` tinyint(1) NOT NULL DEFAULT '0',
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_usuario`,`token_hash`),
  CONSTRAINT `fk_pr_usr` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset`
--

LOCK TABLES `password_reset` WRITE;
/*!40000 ALTER TABLE `password_reset` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permiso`
--

DROP TABLE IF EXISTS `permiso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permiso` (
  `id_permiso` smallint unsigned NOT NULL AUTO_INCREMENT,
  `codigo` varchar(80) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_permiso`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permiso`
--

LOCK TABLES `permiso` WRITE;
/*!40000 ALTER TABLE `permiso` DISABLE KEYS */;
INSERT INTO `permiso` VALUES (1,'USUARIOS_GESTION','Alta, baja y edición de usuarios'),(2,'TUTORIAS_GESTION','Gestión de tutorías'),(3,'CANALIZACIONES_GESTION','Gestión de canalizaciones'),(4,'DOCUMENTOS_SUBIR','Subir documentos'),(5,'DOCUMENTOS_VALIDAR','Validar documentos'),(6,'REPORTES_GENERAR','Generación de reportes'),(7,'ALERTAS_CONFIG','Configurar alertas'),(8,'RIESGOS_REGISTRAR','Registrar factores de riesgo');
/*!40000 ALTER TABLE `permiso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `riesgo_estudiante`
--

DROP TABLE IF EXISTS `riesgo_estudiante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `riesgo_estudiante` (
  `id_riesgo` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_estudiante` int unsigned NOT NULL,
  `id_riesgo_tipo` smallint unsigned NOT NULL,
  `descripcion` varchar(250) DEFAULT NULL,
  `registrado_por` int unsigned NOT NULL,
  `registrado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_riesgo`),
  KEY `fk_rie_tipo` (`id_riesgo_tipo`),
  KEY `fk_rie_usr` (`registrado_por`),
  KEY `idx_riesgo_est` (`id_estudiante`,`id_riesgo_tipo`),
  CONSTRAINT `fk_rie_est` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiante` (`id_estudiante`),
  CONSTRAINT `fk_rie_tipo` FOREIGN KEY (`id_riesgo_tipo`) REFERENCES `riesgo_tipo` (`id_riesgo_tipo`),
  CONSTRAINT `fk_rie_usr` FOREIGN KEY (`registrado_por`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `riesgo_estudiante`
--

LOCK TABLES `riesgo_estudiante` WRITE;
/*!40000 ALTER TABLE `riesgo_estudiante` DISABLE KEYS */;
/*!40000 ALTER TABLE `riesgo_estudiante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `riesgo_tipo`
--

DROP TABLE IF EXISTS `riesgo_tipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `riesgo_tipo` (
  `id_riesgo_tipo` smallint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) NOT NULL,
  PRIMARY KEY (`id_riesgo_tipo`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `riesgo_tipo`
--

LOCK TABLES `riesgo_tipo` WRITE;
/*!40000 ALTER TABLE `riesgo_tipo` DISABLE KEYS */;
INSERT INTO `riesgo_tipo` VALUES (1,'Academico'),(2,'Emocional'),(3,'Personal');
/*!40000 ALTER TABLE `riesgo_tipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol` (
  `id_rol` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_rol`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol_permiso`
--

DROP TABLE IF EXISTS `rol_permiso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol_permiso` (
  `id_rol` tinyint unsigned NOT NULL,
  `id_permiso` smallint unsigned NOT NULL,
  PRIMARY KEY (`id_rol`,`id_permiso`),
  KEY `fk_rp_permiso` (`id_permiso`),
  CONSTRAINT `fk_rp_permiso` FOREIGN KEY (`id_permiso`) REFERENCES `permiso` (`id_permiso`) ON DELETE CASCADE,
  CONSTRAINT `fk_rp_rol` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id_rol`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol_permiso`
--

LOCK TABLES `rol_permiso` WRITE;
/*!40000 ALTER TABLE `rol_permiso` DISABLE KEYS */;
/*!40000 ALTER TABLE `rol_permiso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tutor`
--

DROP TABLE IF EXISTS `tutor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tutor` (
  `id_tutor` int unsigned NOT NULL AUTO_INCREMENT,
  `id_usuario` int unsigned NOT NULL,
  `id_division` smallint unsigned NOT NULL,
  `clave_empleado` varchar(20) NOT NULL,
  PRIMARY KEY (`id_tutor`),
  UNIQUE KEY `id_usuario` (`id_usuario`),
  UNIQUE KEY `clave_empleado` (`clave_empleado`),
  KEY `fk_tutor_div` (`id_division`),
  CONSTRAINT `fk_tutor_div` FOREIGN KEY (`id_division`) REFERENCES `division` (`id_division`),
  CONSTRAINT `fk_tutor_usr` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tutor`
--

LOCK TABLES `tutor` WRITE;
/*!40000 ALTER TABLE `tutor` DISABLE KEYS */;
/*!40000 ALTER TABLE `tutor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tutoria`
--

DROP TABLE IF EXISTS `tutoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tutoria` (
  `id_tutoria` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_estudiante` int unsigned NOT NULL,
  `id_tutor` int unsigned NOT NULL,
  `titulo` varchar(150) NOT NULL,
  `descripcion` text,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `duracion_min` smallint unsigned NOT NULL,
  `estado` enum('Pendiente','Completada','Cancelada') NOT NULL,
  `creada_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_tutoria`),
  KEY `idx_tut_est` (`id_estudiante`,`fecha`),
  KEY `idx_tut_tutor` (`id_tutor`,`fecha`),
  CONSTRAINT `fk_tut_est` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiante` (`id_estudiante`),
  CONSTRAINT `fk_tut_tut` FOREIGN KEY (`id_tutor`) REFERENCES `tutor` (`id_tutor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tutoria`
--

LOCK TABLES `tutoria` WRITE;
/*!40000 ALTER TABLE `tutoria` DISABLE KEYS */;
/*!40000 ALTER TABLE `tutoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(120) NOT NULL,
  `apellido_paterno` varchar(120) NOT NULL,
  `apellido_materno` varchar(120) DEFAULT NULL,
  `correo` varchar(190) NOT NULL,
  `password_hash` char(60) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `actualizado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `correo` (`correo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario_alerta_config`
--

DROP TABLE IF EXISTS `usuario_alerta_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario_alerta_config` (
  `id_usuario` int unsigned NOT NULL,
  `id_alerta_tipo` smallint unsigned NOT NULL,
  `habilitada` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_usuario`,`id_alerta_tipo`),
  KEY `fk_uac_tipo` (`id_alerta_tipo`),
  CONSTRAINT `fk_uac_tipo` FOREIGN KEY (`id_alerta_tipo`) REFERENCES `alerta_tipo` (`id_alerta_tipo`) ON DELETE CASCADE,
  CONSTRAINT `fk_uac_usr` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_alerta_config`
--

LOCK TABLES `usuario_alerta_config` WRITE;
/*!40000 ALTER TABLE `usuario_alerta_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario_alerta_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario_rol`
--

DROP TABLE IF EXISTS `usuario_rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario_rol` (
  `id_usuario` int unsigned NOT NULL,
  `id_rol` tinyint unsigned NOT NULL,
  PRIMARY KEY (`id_usuario`,`id_rol`),
  KEY `fk_ur_rol` (`id_rol`),
  CONSTRAINT `fk_ur_rol` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id_rol`) ON DELETE RESTRICT,
  CONSTRAINT `fk_ur_usr` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_rol`
--

LOCK TABLES `usuario_rol` WRITE;
/*!40000 ALTER TABLE `usuario_rol` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario_rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_estudiantes_por_division`
--

DROP TABLE IF EXISTS `vw_estudiantes_por_division`;
/*!50001 DROP VIEW IF EXISTS `vw_estudiantes_por_division`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_estudiantes_por_division` AS SELECT 
 1 AS `id_estudiante`,
 1 AS `num_control`,
 1 AS `nombre`,
 1 AS `apellido_paterno`,
 1 AS `apellido_materno`,
 1 AS `carrera`,
 1 AS `division`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_estudiantes_por_division`
--

/*!50001 DROP VIEW IF EXISTS `vw_estudiantes_por_division`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_estudiantes_por_division` AS select `e`.`id_estudiante` AS `id_estudiante`,`e`.`num_control` AS `num_control`,`u`.`nombre` AS `nombre`,`u`.`apellido_paterno` AS `apellido_paterno`,`u`.`apellido_materno` AS `apellido_materno`,`c`.`nombre` AS `carrera`,`d`.`nombre` AS `division` from (((`estudiante` `e` join `usuario` `u` on((`u`.`id_usuario` = `e`.`id_usuario`))) join `carrera` `c` on((`c`.`id_carrera` = `e`.`id_carrera`))) join `division` `d` on((`d`.`id_division` = `c`.`id_division`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-20 17:56:05
