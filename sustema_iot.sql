-- MySQL dump 10.13  Distrib 8.0.41, for Linux (x86_64)
--
-- Host: localhost    Database: sistema_iot
-- ------------------------------------------------------
-- Server version	8.0.41-0ubuntu0.24.04.1

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(80) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sqlite_autoindex_auth_group_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_permission_id_84c5c92e` (`permission_id`),
  KEY `auth_group_permissions_group_id_b120cbf9` (`group_id`),
  CONSTRAINT `auth_group_permissions_FK_0_0` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_FK_1_0` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  KEY `auth_permission_content_type_id_2f476e4b` (`content_type_id`),
  CONSTRAINT `auth_permission_FK_0_0` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,1,'add_logentry','Can add log entry'),(2,1,'change_logentry','Can change log entry'),(3,1,'delete_logentry','Can delete log entry'),(4,2,'add_permission','Can add permission'),(5,2,'change_permission','Can change permission'),(6,2,'delete_permission','Can delete permission'),(7,3,'add_group','Can add group'),(8,3,'change_group','Can change group'),(9,3,'delete_group','Can delete group'),(10,4,'add_user','Can add user'),(11,4,'change_user','Can change user'),(12,4,'delete_user','Can delete user'),(13,5,'add_contenttype','Can add content type'),(14,5,'change_contenttype','Can change content type'),(15,5,'delete_contenttype','Can delete content type'),(16,6,'add_session','Can add session'),(17,6,'change_session','Can change session'),(18,6,'delete_session','Can delete session'),(19,7,'add_campo','Can add campo'),(20,7,'change_campo','Can change campo'),(21,7,'delete_campo','Can delete campo'),(22,8,'add_dispositivo','Can add dispositivo'),(23,8,'change_dispositivo','Can change dispositivo'),(24,8,'delete_dispositivo','Can delete dispositivo'),(25,9,'add_proyecto','Can add proyecto'),(26,9,'change_proyecto','Can change proyecto'),(27,9,'delete_proyecto','Can delete proyecto'),(28,10,'add_sensor','Can add sensor'),(29,10,'change_sensor','Can change sensor'),(30,10,'delete_sensor','Can delete sensor'),(31,11,'add_valor','Can add valor'),(32,11,'change_valor','Can change valor'),(33,11,'delete_valor','Can delete valor');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_general_ci NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `first_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sqlite_autoindex_auth_user_1` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$36000$CGwDSJHYzWGh$/JKUNWESZjk/xcMLOZ3PnBApToVJfrq0xvRVvbemXSY=','2018-02-09 19:26:08',1,'','','eyden_v96@hotmail.com',1,1,'2017-08-19 18:09:20','eyden');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544` (`group_id`),
  KEY `auth_user_groups_user_id_6a12ed8b` (`user_id`),
  CONSTRAINT `auth_user_groups_FK_0_0` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_FK_1_0` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_permission_id_1fbb5f2c` (`permission_id`),
  KEY `auth_user_user_permissions_user_id_a95ead1b` (`user_id`),
  CONSTRAINT `auth_user_user_permissions_FK_0_0` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_FK_1_0` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_campo`
--

DROP TABLE IF EXISTS `dashboard_campo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_campo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre_de_campo` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `tipo_de_valor` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `sensor_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dashboard_campo_sensor_id_be4d5343` (`sensor_id`),
  CONSTRAINT `dashboard_campo_FK_0_0` FOREIGN KEY (`sensor_id`) REFERENCES `dashboard_sensor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_campo`
--

LOCK TABLES `dashboard_campo` WRITE;
/*!40000 ALTER TABLE `dashboard_campo` DISABLE KEYS */;
INSERT INTO `dashboard_campo` VALUES (1,'Temperatura','flotante',1);
/*!40000 ALTER TABLE `dashboard_campo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_dispositivo`
--

DROP TABLE IF EXISTS `dashboard_dispositivo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_dispositivo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre_de_dispositivo` varchar(80) COLLATE utf8mb4_general_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_general_ci NOT NULL,
  `tipo` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `latitud` double DEFAULT NULL,
  `esta_habilitado` tinyint(1) NOT NULL,
  `fecha_creacion` datetime NOT NULL,
  `proyecto_id` int NOT NULL,
  `longitud` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dashboard_dispositivo_proyecto_id_b4c0acef` (`proyecto_id`),
  CONSTRAINT `dashboard_dispositivo_FK_0_0` FOREIGN KEY (`proyecto_id`) REFERENCES `dashboard_proyecto` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_dispositivo`
--

LOCK TABLES `dashboard_dispositivo` WRITE;
/*!40000 ALTER TABLE `dashboard_dispositivo` DISABLE KEYS */;
INSERT INTO `dashboard_dispositivo` VALUES (1,'Dispositivo Uno','Descripción del dispositivo Uno','Tipo',5,1,'2017-08-19 18:23:36',1,16),(2,'Nodo aula 1','Monitorea el índice del comfort del aula 1','Arduino',34234,1,'2017-09-05 17:36:51',3,325);
/*!40000 ALTER TABLE `dashboard_dispositivo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_proyecto`
--

DROP TABLE IF EXISTS `dashboard_proyecto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_proyecto` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre_de_proyecto` varchar(80) COLLATE utf8mb4_general_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_general_ci NOT NULL,
  `usuario_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dashboard_proyecto_usuario_id_217f737f` (`usuario_id`),
  CONSTRAINT `dashboard_proyecto_FK_0_0` FOREIGN KEY (`usuario_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_proyecto`
--

LOCK TABLES `dashboard_proyecto` WRITE;
/*!40000 ALTER TABLE `dashboard_proyecto` DISABLE KEYS */;
INSERT INTO `dashboard_proyecto` VALUES (1,'Bahía de chetumal.','Monitoreo de las variables del agua de la bahía de Chetumal, Quintana Roo.',1),(2,'Edificio N','Medición de parámetros para deterinación del índice del confort de las instalaciones de las salas del laboratorio de cómputo del ITCh.',1),(3,'Laboratorio de Arquitectura','Medición de parámetros para deterinación del índice del confort de las instalaciones del labooratorio de arquitectura del ITCh',1);
/*!40000 ALTER TABLE `dashboard_proyecto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_sensor`
--

DROP TABLE IF EXISTS `dashboard_sensor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_sensor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre_de_sensor` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `tipo` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `fecha_creacion` datetime NOT NULL,
  `esta_habilitado` tinyint(1) NOT NULL,
  `dispositivo_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dashboard_sensor_dispositivo_id_25d02eb9` (`dispositivo_id`),
  CONSTRAINT `dashboard_sensor_FK_0_0` FOREIGN KEY (`dispositivo_id`) REFERENCES `dashboard_dispositivo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_sensor`
--

LOCK TABLES `dashboard_sensor` WRITE;
/*!40000 ALTER TABLE `dashboard_sensor` DISABLE KEYS */;
INSERT INTO `dashboard_sensor` VALUES (1,'Dht22','terrestre','2018-02-06 16:17:56',1,1);
/*!40000 ALTER TABLE `dashboard_sensor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_valor`
--

DROP TABLE IF EXISTS `dashboard_valor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_valor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `valor` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `fecha_hora_lectura` datetime NOT NULL,
  `campo_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dashboard_valor_campo_id_2e24263d` (`campo_id`),
  CONSTRAINT `dashboard_valor_FK_0_0` FOREIGN KEY (`campo_id`) REFERENCES `dashboard_campo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_valor`
--

LOCK TABLES `dashboard_valor` WRITE;
/*!40000 ALTER TABLE `dashboard_valor` DISABLE KEYS */;
INSERT INTO `dashboard_valor` VALUES (1,'2.5','2018-02-07 15:30:41',1),(2,'5.5','2018-02-07 15:45:17',1),(3,'3.3','2018-02-08 14:37:59',1),(4,'3.4','2018-02-08 15:56:24',1),(5,'10.4','2018-02-08 15:58:09',1),(6,'911','2018-02-08 16:00:47',1),(7,'520','2018-02-08 16:30:27',1),(8,'27','2018-02-09 19:37:38',1),(9,'27','2018-02-09 19:39:16',1),(10,'23.351','2018-02-09 19:40:43',1),(11,'17.7','2018-02-09 17:06:27',1),(12,'17.8','2018-02-09 17:07:27',1);
/*!40000 ALTER TABLE `dashboard_valor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `object_id` text COLLATE utf8mb4_general_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` text COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  `action_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_user_id_c564eba6` (`user_id`),
  KEY `django_admin_log_content_type_id_c4bce8eb` (`content_type_id`),
  CONSTRAINT `django_admin_log_FK_0_0` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_FK_1_0` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'1','Dht22',1,'[{\"added\": {}}]',10,1,'2018-02-06 16:17:56'),(2,'1','Temperatura',1,'[{\"added\": {}}]',7,1,'2018-02-06 16:18:16');
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(7,'dashboard','campo'),(8,'dashboard','dispositivo'),(9,'dashboard','proyecto'),(10,'dashboard','sensor'),(11,'dashboard','valor'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2017-08-17 20:57:17'),(2,'auth','0001_initial','2017-08-17 20:57:18'),(3,'admin','0001_initial','2017-08-17 20:57:18'),(4,'admin','0002_logentry_remove_auto_add','2017-08-17 20:57:19'),(5,'contenttypes','0002_remove_content_type_name','2017-08-17 20:57:20'),(6,'auth','0002_alter_permission_name_max_length','2017-08-17 20:57:20'),(7,'auth','0003_alter_user_email_max_length','2017-08-17 20:57:20'),(8,'auth','0004_alter_user_username_opts','2017-08-17 20:57:21'),(9,'auth','0005_alter_user_last_login_null','2017-08-17 20:57:21'),(10,'auth','0006_require_contenttypes_0002','2017-08-17 20:57:21'),(11,'auth','0007_alter_validators_add_error_messages','2017-08-17 20:57:22'),(12,'auth','0008_alter_user_username_max_length','2017-08-17 20:57:22'),(13,'sessions','0001_initial','2017-08-17 20:57:23'),(14,'dashboard','0001_initial','2017-08-18 23:34:34'),(15,'dashboard','0002_auto_20170819_2249','2017-08-19 22:49:57'),(16,'dashboard','0003_auto_20170927_1653','2017-10-07 02:57:18'),(17,'dashboard','0004_auto_20171019_1852','2018-01-24 15:37:37');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `session_data` text COLLATE utf8mb4_general_ci NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('2ova62dad0xi75lml8u76kro81mlh4ea','ZmYwNjE1ZDI5Y2Y3ZTYyMzNkYmZiZDkzZDdiZDRjZTBiM2YwNDE1NDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkYjM4YzQ4M2ZhMDE5NGU1YWU2N2Q0YTIwYjhjMGQ1OTgyZWI2YjFjIn0=','2017-10-09 17:33:01'),('4bbp1mrqpntnaazdwedc0sp9057hxc8n','ZmYwNjE1ZDI5Y2Y3ZTYyMzNkYmZiZDkzZDdiZDRjZTBiM2YwNDE1NDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkYjM4YzQ4M2ZhMDE5NGU1YWU2N2Q0YTIwYjhjMGQ1OTgyZWI2YjFjIn0=','2017-09-27 18:05:36'),('j9ueo2q3xvzkeyly9t0gyjpj2obs69ok','ZmYwNjE1ZDI5Y2Y3ZTYyMzNkYmZiZDkzZDdiZDRjZTBiM2YwNDE1NDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkYjM4YzQ4M2ZhMDE5NGU1YWU2N2Q0YTIwYjhjMGQ1OTgyZWI2YjFjIn0=','2018-02-23 19:26:09'),('m6s8e5dnb7s5o2k3y88rmhosjdx3zkx0','ZmYwNjE1ZDI5Y2Y3ZTYyMzNkYmZiZDkzZDdiZDRjZTBiM2YwNDE1NDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkYjM4YzQ4M2ZhMDE5NGU1YWU2N2Q0YTIwYjhjMGQ1OTgyZWI2YjFjIn0=','2017-10-21 02:56:32'),('u6813aaqtdkqvyek8ap7a65q0c9mywcj','ZmYwNjE1ZDI5Y2Y3ZTYyMzNkYmZiZDkzZDdiZDRjZTBiM2YwNDE1NDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkYjM4YzQ4M2ZhMDE5NGU1YWU2N2Q0YTIwYjhjMGQ1OTgyZWI2YjFjIn0=','2017-09-02 18:09:51'),('xy2l6v6lklvrfjjurm7v3cbltsf91r6h','ZmYwNjE1ZDI5Y2Y3ZTYyMzNkYmZiZDkzZDdiZDRjZTBiM2YwNDE1NDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkYjM4YzQ4M2ZhMDE5NGU1YWU2N2Q0YTIwYjhjMGQ1OTgyZWI2YjFjIn0=','2018-02-07 15:29:47');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-12 12:57:14
