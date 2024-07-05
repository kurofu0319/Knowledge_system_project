-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: ry-vue
-- ------------------------------------------------------
-- Server version	8.0.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `forum_content`
--

DROP TABLE IF EXISTS `forum_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forum_content` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `file_name` varchar(255) NOT NULL,
  `upload_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `file_url` varchar(255) NOT NULL,
  `has_upload` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_content`
--

LOCK TABLES `forum_content` WRITE;
/*!40000 ALTER TABLE `forum_content` DISABLE KEYS */;
INSERT INTO `forum_content` VALUES (43,'forum_20240629090423A004.txt','2024-06-29 01:04:23','http://172.20.10.2:8081/profile/upload/2024/06/29/forum_20240629090423A004.txt',1);
/*!40000 ALTER TABLE `forum_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_likes`
--

DROP TABLE IF EXISTS `forum_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forum_likes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) DEFAULT NULL,
  `post_id` bigint DEFAULT NULL,
  `reply_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_post_reply` (`user_name`,`post_id`,`reply_id`),
  KEY `fk_likes_post_id` (`post_id`),
  KEY `fk_likes_reply_id` (`reply_id`),
  CONSTRAINT `fk_likes_post_id` FOREIGN KEY (`post_id`) REFERENCES `forum_post` (`id`),
  CONSTRAINT `fk_likes_reply_id` FOREIGN KEY (`reply_id`) REFERENCES `forum_reply` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=262 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_likes`
--

LOCK TABLES `forum_likes` WRITE;
/*!40000 ALTER TABLE `forum_likes` DISABLE KEYS */;
INSERT INTO `forum_likes` VALUES (261,'admin',NULL,125,'2024-06-29 01:02:12');
/*!40000 ALTER TABLE `forum_likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_post`
--

DROP TABLE IF EXISTS `forum_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forum_post` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `post_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `likes` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_post`
--

LOCK TABLES `forum_post` WRITE;
/*!40000 ALTER TABLE `forum_post` DISABLE KEYS */;
INSERT INTO `forum_post` VALUES (24,'yzr123456','饺子园在哈工大哪一个食堂？','饺子园在哈工大哪一个食堂？','2022-07-29 11:21:55',1),(26,'fr123456','今年哪位领导人访问了哈工大','今年哪位领导人访问了哈工大','2024-05-20 12:27:17',99),(28,'wyd123456','501班软件工程实验课project验收的日期和时间是什么？','501班软件工程实验课project验收的日期和时间是什么？','2024-06-27 12:18:31',33),(29,'admin','哈工大今年成立什么新的学院？','哈工大今年成立什么新的学院？','2024-06-01 12:23:51',60),(30,'yzr123456','哈工大风雨操场在地面上有哪些球类运动场？','哈工大风雨操场在地面上有哪些球类运动场？','2023-12-24 12:27:29',50);
/*!40000 ALTER TABLE `forum_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_reply`
--

DROP TABLE IF EXISTS `forum_reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forum_reply` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `post_id` bigint DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `content` text,
  `reply_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `likes` int DEFAULT '0',
  `file_url` varchar(255) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_reply_post_id` (`post_id`),
  CONSTRAINT `fk_reply_post_id` FOREIGN KEY (`post_id`) REFERENCES `forum_post` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_reply`
--

LOCK TABLES `forum_reply` WRITE;
/*!40000 ALTER TABLE `forum_reply` DISABLE KEYS */;
INSERT INTO `forum_reply` VALUES (92,24,'wyd123456','学苑好像有卖的来着','2024-06-27 11:22:32',0,NULL,NULL),(94,26,'wyd123456','是习大大么','2024-06-27 11:28:59',0,NULL,NULL),(95,26,'yzr123456','是普京大帝[耶]','2024-06-27 12:15:10',0,NULL,NULL),(96,26,'admin','是俄罗斯总统普京','2024-06-27 12:15:32',0,NULL,NULL),(97,24,'fr123456','学苑卖的是包子吧，饺子园在学子','2024-06-27 12:16:19',0,NULL,NULL),(98,24,'admin','饺子园在哈工大学子食堂','2024-06-27 12:16:53',0,NULL,NULL),(99,28,'yzr123456','xd，你提醒我要验收实验了[cry]','2024-06-27 12:18:58',0,NULL,NULL),(100,28,'fr123456','是6月22号34节课吧','2024-06-27 12:19:57',0,NULL,NULL),(101,28,'wyd123456','刚刚看了一下老师发的通知，似乎改到下周六（6.29）了','2024-06-27 12:20:51',0,NULL,NULL),(102,28,'admin','501班软件工程实验课project验收的日期为6月29号，时间是8：00到9：00','2024-06-27 12:22:07',0,NULL,NULL),(103,29,'fr123456','人工智能学院','2024-06-27 12:24:21',0,NULL,NULL),(104,29,'wyd123456','院士班！学校变强带飞我~','2024-06-27 12:24:58',0,NULL,NULL),(105,29,'yzr123456','害，英才人上人','2024-06-27 12:25:13',0,NULL,NULL),(106,29,'admin','哈工大今年成立的新学院是人工智能学院','2024-06-27 12:25:59',0,NULL,NULL),(107,30,'fr123456','网球场，篮球场。','2024-06-27 12:27:51',0,NULL,NULL),(108,30,'wyd123456','好耶，可以运动了','2024-06-27 12:28:08',0,NULL,NULL),(109,30,'admin','哈工大风雨操场在地面上有网球场，篮球场两类球类运动场。\n','2024-06-27 12:28:42',0,NULL,NULL),(125,28,'admin','1','2024-06-29 01:01:46',1,'http://172.20.10.2:8081/profile/upload/2024/06/29/用例1(1)(1)(1)(1)_20240629090204A002.png','用例1(1)(1)(1)(1).png');
/*!40000 ALTER TABLE `forum_reply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_table`
--

DROP TABLE IF EXISTS `gen_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gen_table` (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='代码生成业务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table`
--

LOCK TABLES `gen_table` WRITE;
/*!40000 ALTER TABLE `gen_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `gen_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_table_column`
--

DROP TABLE IF EXISTS `gen_table_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gen_table_column` (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) DEFAULT '' COMMENT '字典类型',
  `sort` int DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='代码生成业务表字段';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table_column`
--

LOCK TABLES `gen_table_column` WRITE;
/*!40000 ALTER TABLE `gen_table_column` DISABLE KEYS */;
/*!40000 ALTER TABLE `gen_table_column` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) DEFAULT NULL,
  `message` text,
  `is_read` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=256 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,'admin','Your post has been liked by admin',0,NULL),(2,'admin','Your post has been liked by admin',0,NULL),(3,'admin','Your post has been liked by admin',0,NULL),(4,'admin','Your post has been liked by admin',0,NULL),(5,'admin','Your reply has been liked by admin',0,NULL),(6,'admin','Your reply has been liked by admin',0,NULL),(7,'admin','Your reply has been liked by admin',0,NULL),(8,'admin','Your reply has been liked by admin',0,NULL),(9,'admin','Your reply has been liked by admin',0,NULL),(10,'admin','Your reply has been liked by admin',0,NULL),(11,'admin','Your reply has been liked by admin',0,NULL),(12,'admin','Your reply has been liked by admin',0,NULL),(13,'admin','Your reply has been liked by admin',0,NULL),(14,'admin','Your reply has been liked by admin',0,NULL),(15,'admin','Your reply has been liked by admin',0,NULL),(16,'admin','Your reply has been liked by admin',0,NULL),(17,'admin','Your reply has been liked by admin',0,NULL),(18,'admin','Your post has been liked by admin',0,NULL),(19,'admin','Your reply has been liked by admin',0,NULL),(20,'admin','Your reply has been liked by admin',0,NULL),(21,'admin','Your reply has been liked by admin',0,NULL),(22,'admin','Your reply has been liked by admin',0,NULL),(23,'admin','Your post has been liked by admin',0,NULL),(24,'admin','Your post has been liked by admin',0,NULL),(25,'admin','Your post has been liked by admin',0,NULL),(26,'admin','Your post has been liked by admin',0,NULL),(27,'admin','Your post has been liked by admin',0,NULL),(28,'admin','Your post has been liked by admin',0,NULL),(29,'admin','Your post has been liked by admin',0,NULL),(30,'admin','Your post has been liked by admin',0,NULL),(31,'admin','Your post has been liked by admin',0,NULL),(32,'admin','Your post has been liked by admin',0,NULL),(33,'admin','Your post has been liked by admin',0,NULL),(34,'admin','Your post has been liked by admin',0,NULL),(35,'admin','Your post has been liked by admin',0,NULL),(36,'admin','Your post has been liked by admin',0,NULL),(37,'admin','Your post has been liked by admin',0,NULL),(38,'admin','Your post has been liked by admin',0,NULL),(39,'admin','Your post has been liked by admin',0,NULL),(40,'admin','Your post has been liked by admin',0,NULL),(41,'admin','Your post has been liked by admin',0,NULL),(42,'admin','Your post has been liked by admin',0,NULL),(43,'admin','Your post has been liked by admin',0,NULL),(44,'admin','Your post has been liked by admin',0,NULL),(45,'admin','Your post has been liked by admin',0,NULL),(46,'admin','Your post has been liked by admin',0,NULL),(47,'admin','Your post has been liked by admin',0,NULL),(48,'admin','Your post has been liked by admin',0,NULL),(49,'admin','Your post has been liked by admin',0,NULL),(50,'admin','Your post has been liked by admin',0,NULL),(51,'admin','Your post has been liked by admin',0,NULL),(52,'admin','Your post has been liked by admin',0,NULL),(53,'admin','Your post has been liked by admin',0,NULL),(54,'admin','Your post has been liked by admin',0,NULL),(55,'admin','Your post has been liked by admin',0,NULL),(56,'admin','Your post has been liked by admin',0,NULL),(57,'admin','Your post has been liked by admin',0,NULL),(58,'admin','Your post has been liked by admin',0,NULL),(59,'admin','Your post has been liked by admin',0,NULL),(60,'admin','Your post has been liked by admin',0,NULL),(61,'admin','Your post has been liked by admin',0,NULL),(62,'admin','Your post has been liked by admin',0,NULL),(63,'admin','Your post has been liked by admin',0,NULL),(64,'admin','Your post has been liked by admin',0,NULL),(65,'admin','Your post has been liked by admin',0,NULL),(66,'admin','Your post has been liked by admin',0,NULL),(67,'admin','Your post has been liked by admin',0,NULL),(68,'admin','Your post has been liked by admin',0,NULL),(69,'admin','Your post has been liked by admin',0,NULL),(70,'admin','Your post has been liked by admin',0,NULL),(71,'admin','Your post has been liked by admin',0,NULL),(72,'admin','Your post has been liked by admin',0,NULL),(73,'admin','Your post has been liked by admin',0,NULL),(74,'admin','Your post has been liked by admin',0,NULL),(75,'admin','Your post has been liked by admin',0,NULL),(76,'admin','Your post has been liked by admin',0,NULL),(77,'admin','Your post has been liked by admin',0,NULL),(78,'admin','Your post has been liked by admin',0,NULL),(79,'admin','Your post has been liked by admin',0,NULL),(80,'admin','Your post has been liked by admin',0,NULL),(81,'admin','Your post has been liked by admin',0,NULL),(82,'admin','Your post has been liked by admin',0,NULL),(83,'admin','Your post has been liked by admin',0,NULL),(84,'admin','Your post has been liked by admin',0,NULL),(85,'admin','Your reply has been liked by admin',0,NULL),(86,'admin','Your reply has been liked by admin',0,NULL),(87,'admin','Your post has been liked by admin',0,NULL),(88,'admin','Your post has been liked by admin',0,NULL),(89,'admin','Your post has been liked by admin',0,NULL),(90,'admin','Your post has been liked by admin',0,NULL),(91,'admin','Your reply has been liked by admin',0,NULL),(92,'admin','Your reply has been liked by admin',0,NULL),(93,'admin','Your post has been liked by admin',0,NULL),(94,'admin','Your reply has been liked by admin',0,NULL),(95,'admin','Your reply has been liked by admin',0,NULL),(96,'admin','Your post has been liked by admin',0,NULL),(97,'admin','Your post has been liked by admin',0,NULL),(98,'admin','Your post has been liked by admin',0,NULL),(99,'admin','Your post has been liked by admin',0,NULL),(100,'admin','Your post has been liked by admin',0,NULL),(101,'admin','Your post has been liked by admin',0,NULL),(102,'admin','Your post has been liked by admin',0,NULL),(103,'admin','Your post has been liked by admin',0,NULL),(104,'admin','Your post has been liked by admin',0,NULL),(105,'admin','Your post has been liked by admin',0,NULL),(106,'admin','Your post has been liked by admin',0,NULL),(107,'admin','Your reply has been liked by admin',0,NULL),(108,'admin','Your reply has been liked by admin',0,NULL),(109,'admin','Your reply has been liked by admin',0,NULL),(110,'admin','Your post has been liked by admin',0,NULL),(111,'admin','Your post has been liked by admin',0,NULL),(112,'admin','Your post has been liked by admin',0,NULL),(113,'admin','Your post has been liked by admin',0,NULL),(114,'admin','Your reply has been liked by admin',0,NULL),(115,'admin','Your reply has been liked by admin',0,NULL),(116,'admin','Your post has been liked by admin',0,NULL),(117,'admin','Your post has been liked by admin',0,NULL),(118,'admin','Your reply has been liked by admin',0,NULL),(119,'admin','Your post has been liked by admin',0,NULL),(120,'admin','Your reply has been liked by admin',0,NULL),(121,'admin','Your post has been liked by admin',0,NULL),(122,'123456','Your post has been liked by 123456',0,NULL),(123,'123456','Your reply has been liked by admin',0,NULL),(124,'123456','Your post has been liked by admin',0,NULL),(125,'123456','Your post has been liked by admin',0,NULL),(126,'123456','Your reply has been liked by admin',0,NULL),(127,'123456','Your post has been liked by 2021110667',0,NULL),(128,'123456','Your reply has been liked by 2021110667',0,NULL),(129,'123456','Your reply has been liked by 2021110667',0,NULL),(130,'123456','Your post has been liked by 2021110667',0,NULL),(131,'2021110667','Your reply has been liked by 2021110667',0,NULL),(132,'2021110667','Your reply has been liked by 2021110667',0,NULL),(133,'88888888','Your post has been liked by 88888888',0,NULL),(134,'88888888','Your reply has been liked by 88888888',0,NULL),(135,'123456','Your post has been liked by 88888888',0,NULL),(136,'123456','Your reply has been liked by 88888888',0,NULL),(137,'00000000','Your post has been liked by 00000000',0,NULL),(138,'00000000','Your post has been liked by 00000000',0,NULL),(139,'00000000','Your reply has been liked by 00000000',0,NULL),(140,'00000000','Your reply has been liked by 00000000',0,NULL),(141,'123456','Your post has been liked by 00000000',0,NULL),(142,'123456','Your post has been liked by 00000000',0,NULL),(143,'123456','Your reply has been liked by 00000000',0,NULL),(144,'123456','Your reply has been liked by 00000000',0,NULL),(145,'00000000','Your reply has been liked by 00000000',0,NULL),(146,'123456','Your post has been liked by admin',0,NULL),(147,'123456','Your reply has been liked by admin',0,NULL),(148,'admin','Your post has been liked by 00000000',0,NULL),(149,'admin','Your post has been liked by 00000000',0,NULL),(150,'00000000','Your reply has been liked by 00000000',0,NULL),(151,'kurofu0319','Your post has been liked by admin',0,NULL),(152,'00000000','Your post has been liked by admin',0,NULL),(153,'kurofu0319','Your reply has been liked by 00000000',0,NULL),(154,'admin','Your post has been liked by 00000000',0,NULL),(155,'admin','Your post has been liked by 00000000',0,NULL),(156,'admin','Your reply has been liked by admin',0,NULL),(157,'admin','Your reply has been liked by admin',0,NULL),(158,'admin','Your reply has been liked by admin',0,NULL),(159,'admin','Your reply has been liked by admin',0,NULL),(160,'admin','Your reply has been liked by admin',0,NULL),(161,'admin','Your reply has been liked by admin',0,NULL),(162,'admin','Your post has been liked by admin',0,NULL),(163,'admin','Your post has been liked by admin',0,NULL),(164,'admin','Your post has been liked by admin',0,NULL),(165,'admin','Your post has been liked by admin',0,NULL),(166,'admin','Your post has been liked by admin',0,NULL),(167,'admin','Your post has been liked by admin',0,NULL),(168,'00000000','Your reply has been liked by admin',0,NULL),(169,'admin','Your reply has been liked by admin',0,NULL),(170,'admin','Your post has been liked by admin',0,NULL),(171,'admin','Your post has been liked by admin',0,NULL),(172,'admin','Your post has been liked by admin',0,NULL),(173,'kurofu0319','Your reply has been liked by admin',0,NULL),(174,'kurofu0319','Your reply has been liked by admin',0,NULL),(175,'kurofu0319','Your reply has been liked by admin',0,NULL),(176,'00000000','Your reply has been liked by admin',0,NULL),(177,'admin','Your reply has been liked by admin',0,NULL),(178,'admin','Your reply has been liked by admin',0,NULL),(179,'admin','Your reply has been liked by admin',0,NULL),(180,'admin','Your reply has been liked by admin',0,NULL),(181,'admin','Your reply has been liked by admin',0,NULL),(182,'00000000','Your reply has been liked by admin',0,NULL),(183,'admin','Your reply has been liked by admin',0,NULL),(184,'00000000','Your reply has been liked by admin',0,NULL),(185,'admin','Your post has been liked by admin',0,NULL),(186,'admin','Your reply has been liked by admin',0,NULL),(187,'admin','Your reply has been liked by admin',0,NULL),(188,'admin','Your post has been liked by admin',0,NULL),(189,'kurofu0319','Your post has been liked by admin',0,NULL),(190,'kurofu0319','Your post has been liked by admin',0,NULL),(191,'kurofu0319','Your post has been liked by admin',0,NULL),(192,'kurofu0319','Your post has been liked by admin',0,NULL),(193,'admin','Your reply has been liked by admin',0,NULL),(194,'kurofu0319','Your reply has been liked by admin',0,NULL),(195,'admin','Your post has been liked by admin',0,NULL),(196,'admin','Your post has been liked by admin',0,NULL),(197,'admin','Your reply has been liked by admin',0,NULL),(198,'admin','Your reply has been liked by admin',0,NULL),(199,'00000000','Your reply has been liked by admin',0,NULL),(200,'admin','Your reply has been liked by admin',0,NULL),(201,'admin','Your reply has been liked by admin',0,NULL),(202,'admin','Your reply has been liked by admin',0,NULL),(203,'00000000','Your reply has been liked by admin',0,NULL),(204,'kurofu0319','Your post has been liked by admin',0,NULL),(205,'admin','Your post has been liked by admin',0,NULL),(206,'admin','Your post has been liked by admin',0,NULL),(207,'00000000','Your reply has been liked by admin',0,NULL),(208,'admin','Your reply has been liked by admin',0,NULL),(209,'admin','Your reply has been liked by admin',0,NULL),(210,'admin','Your reply has been liked by admin',0,NULL),(211,'admin','Your reply has been liked by admin',0,NULL),(212,'admin','Your reply has been liked by admin',0,NULL),(213,'admin','Your post has been liked by admin',0,NULL),(214,'kurofu0319','Your reply has been liked by admin',0,NULL),(215,'admin','Your reply has been liked by admin',0,NULL),(216,'kurofu0319','Your reply has been liked by admin',0,NULL),(217,'admin','Your reply has been liked by admin',0,NULL),(218,'admin','Your post has been liked by admin',0,NULL),(219,'admin','Your post has been liked by admin',0,NULL),(220,'admin','Your post has been liked by admin',0,NULL),(221,'admin','Your post has been liked by admin',0,NULL),(222,'admin','Your post has been liked by admin',0,NULL),(223,'admin','Your post has been liked by admin',0,NULL),(224,'admin','Your reply has been liked by admin',0,NULL),(225,'admin','Your reply has been liked by admin',0,NULL),(226,'admin','Your reply has been liked by admin',0,NULL),(227,'admin','Your reply has been liked by admin',0,NULL),(228,'admin','Your reply has been liked by admin',0,NULL),(229,'admin','Your reply has been liked by admin',0,NULL),(230,'admin','Your reply has been liked by admin',0,NULL),(231,'admin','Your reply has been liked by admin',0,NULL),(232,'admin','Your reply has been liked by admin',0,NULL),(233,'admin','Your reply has been liked by admin',0,NULL),(234,'admin','Your reply has been liked by admin',0,NULL),(235,'admin','Your reply has been liked by admin',0,NULL),(236,'admin','Your reply has been liked by admin',0,NULL),(237,'admin','Your post has been liked by admin',0,NULL),(238,'admin','Your reply has been liked by admin',0,NULL),(239,'admin','Your reply has been liked by admin',0,NULL),(240,'admin','Your reply has been liked by admin',0,NULL),(241,'admin','Your reply has been liked by admin',0,NULL),(242,'admin','Your reply has been liked by admin',0,NULL),(243,'admin','Your reply has been liked by admin',0,NULL),(244,'admin','Your reply has been liked by admin',0,NULL),(245,'wyd123456','Your reply has been liked by admin',0,NULL),(246,'admin','Your reply has been liked by admin',0,NULL),(247,'admin','Your reply has been liked by admin',0,NULL),(248,'admin','Your reply has been liked by admin',0,NULL),(249,'admin','Your reply has been liked by admin',0,NULL),(250,'admin','Your reply has been liked by admin',0,NULL),(251,'admin','Your reply has been liked by admin',0,NULL),(252,'admin','Your reply has been liked by admin',0,NULL),(253,'admin','Your reply has been liked by admin',0,NULL),(254,'admin','Your reply has been liked by admin',0,NULL),(255,'admin','Your reply has been liked by admin',0,NULL);
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_blob_triggers`
--

DROP TABLE IF EXISTS `qrtz_blob_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_blob_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Blob类型的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_blob_triggers`
--

LOCK TABLES `qrtz_blob_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_blob_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_blob_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_calendars`
--

DROP TABLE IF EXISTS `qrtz_calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_calendars` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`,`calendar_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='日历信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_calendars`
--

LOCK TABLES `qrtz_calendars` WRITE;
/*!40000 ALTER TABLE `qrtz_calendars` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_calendars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_cron_triggers`
--

DROP TABLE IF EXISTS `qrtz_cron_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_cron_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Cron类型的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_cron_triggers`
--

LOCK TABLES `qrtz_cron_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_cron_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_cron_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_fired_triggers`
--

DROP TABLE IF EXISTS `qrtz_fired_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_fired_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint NOT NULL COMMENT '触发的时间',
  `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',
  `priority` int NOT NULL COMMENT '优先级',
  `state` varchar(16) NOT NULL COMMENT '状态',
  `job_name` varchar(200) DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`,`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='已触发的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_fired_triggers`
--

LOCK TABLES `qrtz_fired_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_fired_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_fired_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_job_details`
--

DROP TABLE IF EXISTS `qrtz_job_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_job_details` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) NOT NULL COMMENT '任务组名',
  `description` varchar(250) DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`,`job_name`,`job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务详细信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_job_details`
--

LOCK TABLES `qrtz_job_details` WRITE;
/*!40000 ALTER TABLE `qrtz_job_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_job_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_locks`
--

DROP TABLE IF EXISTS `qrtz_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_locks` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`,`lock_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='存储的悲观锁信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_locks`
--

LOCK TABLES `qrtz_locks` WRITE;
/*!40000 ALTER TABLE `qrtz_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_paused_trigger_grps`
--

DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`,`trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='暂停的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_paused_trigger_grps`
--

LOCK TABLES `qrtz_paused_trigger_grps` WRITE;
/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_scheduler_state`
--

DROP TABLE IF EXISTS `qrtz_scheduler_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_scheduler_state` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`,`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='调度器状态表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_scheduler_state`
--

LOCK TABLES `qrtz_scheduler_state` WRITE;
/*!40000 ALTER TABLE `qrtz_scheduler_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_scheduler_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_simple_triggers`
--

DROP TABLE IF EXISTS `qrtz_simple_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_simple_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='简单触发器的信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_simple_triggers`
--

LOCK TABLES `qrtz_simple_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_simple_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_simple_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_simprop_triggers`
--

DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_simprop_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='同步机制的行锁表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_simprop_triggers`
--

LOCK TABLES `qrtz_simprop_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_simprop_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_simprop_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_triggers`
--

DROP TABLE IF EXISTS `qrtz_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) NOT NULL COMMENT '触发器的类型',
  `start_time` bigint NOT NULL COMMENT '开始时间',
  `end_time` bigint DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  KEY `sched_name` (`sched_name`,`job_name`,`job_group`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='触发器详细信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_triggers`
--

LOCK TABLES `qrtz_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_config`
--

DROP TABLE IF EXISTS `sys_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_config` (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='参数配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_config`
--

LOCK TABLES `sys_config` WRITE;
/*!40000 ALTER TABLE `sys_config` DISABLE KEYS */;
INSERT INTO `sys_config` VALUES (1,'主框架页-默认皮肤样式名称','sys.index.skinName','skin-blue','Y','admin','2024-01-30 16:47:13','',NULL,'蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow'),(2,'用户管理-账号初始密码','sys.user.initPassword','123456','Y','admin','2024-01-30 16:47:13','',NULL,'初始化密码 123456'),(3,'主框架页-侧边栏主题','sys.index.sideTheme','theme-dark','Y','admin','2024-01-30 16:47:13','',NULL,'深色主题theme-dark，浅色主题theme-light'),(4,'账号自助-验证码开关','sys.account.captchaEnabled','false','Y','admin','2024-01-30 16:47:13','admin','2024-01-31 13:58:02','是否开启验证码功能（true开启，false关闭）'),(5,'账号自助-是否开启用户注册功能','sys.account.registerUser','true','Y','admin','2024-01-30 16:47:13','admin','2024-01-31 13:49:49','是否开启注册用户功能（true开启，false关闭）'),(6,'用户登录-黑名单列表','sys.login.blackIPList','','Y','admin','2024-01-30 16:47:13','',NULL,'设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
/*!40000 ALTER TABLE `sys_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dept`
--

DROP TABLE IF EXISTS `sys_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dept` (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint DEFAULT '0' COMMENT '父部门id',
  `ancestors` varchar(50) DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) DEFAULT '' COMMENT '部门名称',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `leader` varchar(20) DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `status` char(1) DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='部门表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dept`
--

LOCK TABLES `sys_dept` WRITE;
/*!40000 ALTER TABLE `sys_dept` DISABLE KEYS */;
INSERT INTO `sys_dept` VALUES (100,0,'0','若依科技',0,'若依','15888888888','ry@qq.com','0','0','admin','2024-01-30 16:47:11','',NULL),(101,100,'0,100','深圳总公司',1,'若依','15888888888','ry@qq.com','0','0','admin','2024-01-30 16:47:11','',NULL),(102,100,'0,100','长沙分公司',2,'若依','15888888888','ry@qq.com','0','0','admin','2024-01-30 16:47:11','',NULL),(103,101,'0,100,101','研发部门',1,'若依','15888888888','ry@qq.com','0','0','admin','2024-01-30 16:47:12','',NULL),(104,101,'0,100,101','市场部门',2,'若依','15888888888','ry@qq.com','0','0','admin','2024-01-30 16:47:12','',NULL),(105,101,'0,100,101','测试部门',3,'若依','15888888888','ry@qq.com','0','0','admin','2024-01-30 16:47:12','',NULL),(106,101,'0,100,101','财务部门',4,'若依','15888888888','ry@qq.com','0','0','admin','2024-01-30 16:47:12','',NULL),(107,101,'0,100,101','运维部门',5,'若依','15888888888','ry@qq.com','0','0','admin','2024-01-30 16:47:12','',NULL),(108,102,'0,100,102','市场部门',1,'若依','15888888888','ry@qq.com','0','0','admin','2024-01-30 16:47:12','',NULL),(109,102,'0,100,102','财务部门',2,'若依','15888888888','ry@qq.com','0','0','admin','2024-01-30 16:47:12','',NULL);
/*!40000 ALTER TABLE `sys_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_data`
--

DROP TABLE IF EXISTS `sys_dict_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_data`
--

LOCK TABLES `sys_dict_data` WRITE;
/*!40000 ALTER TABLE `sys_dict_data` DISABLE KEYS */;
INSERT INTO `sys_dict_data` VALUES (1,1,'男','0','sys_user_sex','','','Y','0','admin','2024-01-30 16:47:13','',NULL,'性别男'),(2,2,'女','1','sys_user_sex','','','N','0','admin','2024-01-30 16:47:13','',NULL,'性别女'),(3,3,'未知','2','sys_user_sex','','','N','0','admin','2024-01-30 16:47:13','',NULL,'性别未知'),(4,1,'显示','0','sys_show_hide','','primary','Y','0','admin','2024-01-30 16:47:13','',NULL,'显示菜单'),(5,2,'隐藏','1','sys_show_hide','','danger','N','0','admin','2024-01-30 16:47:13','',NULL,'隐藏菜单'),(6,1,'正常','0','sys_normal_disable','','primary','Y','0','admin','2024-01-30 16:47:13','',NULL,'正常状态'),(7,2,'停用','1','sys_normal_disable','','danger','N','0','admin','2024-01-30 16:47:13','',NULL,'停用状态'),(8,1,'正常','0','sys_job_status','','primary','Y','0','admin','2024-01-30 16:47:13','',NULL,'正常状态'),(9,2,'暂停','1','sys_job_status','','danger','N','0','admin','2024-01-30 16:47:13','',NULL,'停用状态'),(10,1,'默认','DEFAULT','sys_job_group','','','Y','0','admin','2024-01-30 16:47:13','',NULL,'默认分组'),(11,2,'系统','SYSTEM','sys_job_group','','','N','0','admin','2024-01-30 16:47:13','',NULL,'系统分组'),(12,1,'是','Y','sys_yes_no','','primary','Y','0','admin','2024-01-30 16:47:13','',NULL,'系统默认是'),(13,2,'否','N','sys_yes_no','','danger','N','0','admin','2024-01-30 16:47:13','',NULL,'系统默认否'),(14,1,'通知','1','sys_notice_type','','warning','Y','0','admin','2024-01-30 16:47:13','',NULL,'通知'),(15,2,'公告','2','sys_notice_type','','success','N','0','admin','2024-01-30 16:47:13','',NULL,'公告'),(16,1,'正常','0','sys_notice_status','','primary','Y','0','admin','2024-01-30 16:47:13','',NULL,'正常状态'),(17,2,'关闭','1','sys_notice_status','','danger','N','0','admin','2024-01-30 16:47:13','',NULL,'关闭状态'),(18,99,'其他','0','sys_oper_type','','info','N','0','admin','2024-01-30 16:47:13','',NULL,'其他操作'),(19,1,'新增','1','sys_oper_type','','info','N','0','admin','2024-01-30 16:47:13','',NULL,'新增操作'),(20,2,'修改','2','sys_oper_type','','info','N','0','admin','2024-01-30 16:47:13','',NULL,'修改操作'),(21,3,'删除','3','sys_oper_type','','danger','N','0','admin','2024-01-30 16:47:13','',NULL,'删除操作'),(22,4,'授权','4','sys_oper_type','','primary','N','0','admin','2024-01-30 16:47:13','',NULL,'授权操作'),(23,5,'导出','5','sys_oper_type','','warning','N','0','admin','2024-01-30 16:47:13','',NULL,'导出操作'),(24,6,'导入','6','sys_oper_type','','warning','N','0','admin','2024-01-30 16:47:13','',NULL,'导入操作'),(25,7,'强退','7','sys_oper_type','','danger','N','0','admin','2024-01-30 16:47:13','',NULL,'强退操作'),(26,8,'生成代码','8','sys_oper_type','','warning','N','0','admin','2024-01-30 16:47:13','',NULL,'生成操作'),(27,9,'清空数据','9','sys_oper_type','','danger','N','0','admin','2024-01-30 16:47:13','',NULL,'清空操作'),(28,1,'成功','0','sys_common_status','','primary','N','0','admin','2024-01-30 16:47:13','',NULL,'正常状态'),(29,2,'失败','1','sys_common_status','','danger','N','0','admin','2024-01-30 16:47:13','',NULL,'停用状态');
/*!40000 ALTER TABLE `sys_dict_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_type`
--

DROP TABLE IF EXISTS `sys_dict_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `dict_type` (`dict_type`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_type`
--

LOCK TABLES `sys_dict_type` WRITE;
/*!40000 ALTER TABLE `sys_dict_type` DISABLE KEYS */;
INSERT INTO `sys_dict_type` VALUES (1,'用户性别','sys_user_sex','0','admin','2024-01-30 16:47:13','',NULL,'用户性别列表'),(2,'菜单状态','sys_show_hide','0','admin','2024-01-30 16:47:13','',NULL,'菜单状态列表'),(3,'系统开关','sys_normal_disable','0','admin','2024-01-30 16:47:13','',NULL,'系统开关列表'),(4,'任务状态','sys_job_status','0','admin','2024-01-30 16:47:13','',NULL,'任务状态列表'),(5,'任务分组','sys_job_group','0','admin','2024-01-30 16:47:13','',NULL,'任务分组列表'),(6,'系统是否','sys_yes_no','0','admin','2024-01-30 16:47:13','',NULL,'系统是否列表'),(7,'通知类型','sys_notice_type','0','admin','2024-01-30 16:47:13','',NULL,'通知类型列表'),(8,'通知状态','sys_notice_status','0','admin','2024-01-30 16:47:13','',NULL,'通知状态列表'),(9,'操作类型','sys_oper_type','0','admin','2024-01-30 16:47:13','',NULL,'操作类型列表'),(10,'系统状态','sys_common_status','0','admin','2024-01-30 16:47:13','',NULL,'登录状态列表');
/*!40000 ALTER TABLE `sys_dict_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_job`
--

DROP TABLE IF EXISTS `sys_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_job` (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`,`job_name`,`job_group`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='定时任务调度表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_job`
--

LOCK TABLES `sys_job` WRITE;
/*!40000 ALTER TABLE `sys_job` DISABLE KEYS */;
INSERT INTO `sys_job` VALUES (1,'系统默认（无参）','DEFAULT','ryTask.ryNoParams','0/10 * * * * ?','3','1','1','admin','2024-01-30 16:47:13','',NULL,''),(2,'系统默认（有参）','DEFAULT','ryTask.ryParams(\'ry\')','0/15 * * * * ?','3','1','1','admin','2024-01-30 16:47:13','',NULL,''),(3,'系统默认（多参）','DEFAULT','ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)','0/20 * * * * ?','3','1','1','admin','2024-01-30 16:47:13','',NULL,'');
/*!40000 ALTER TABLE `sys_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_job_log`
--

DROP TABLE IF EXISTS `sys_job_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_job_log` (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) DEFAULT NULL COMMENT '日志信息',
  `status` char(1) DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) DEFAULT '' COMMENT '异常信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='定时任务调度日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_job_log`
--

LOCK TABLES `sys_job_log` WRITE;
/*!40000 ALTER TABLE `sys_job_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_job_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_logininfor`
--

DROP TABLE IF EXISTS `sys_logininfor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_logininfor` (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) DEFAULT '' COMMENT '操作系统',
  `status` char(1) DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`),
  KEY `idx_sys_logininfor_s` (`status`),
  KEY `idx_sys_logininfor_lt` (`login_time`)
) ENGINE=InnoDB AUTO_INCREMENT=514 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统访问记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_logininfor`
--

LOCK TABLES `sys_logininfor` WRITE;
/*!40000 ALTER TABLE `sys_logininfor` DISABLE KEYS */;
INSERT INTO `sys_logininfor` VALUES (100,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-01-31 09:59:04'),(101,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-01-31 10:45:36'),(102,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-01-31 10:51:37'),(103,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-01-31 13:04:14'),(104,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','退出成功','2024-01-31 13:49:56'),(105,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-01-31 13:50:02'),(106,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','退出成功','2024-01-31 13:58:06'),(107,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-01-31 13:58:09'),(108,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','退出成功','2024-01-31 14:21:59'),(109,'ry','127.0.0.1','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2024-01-31 14:22:04'),(110,'ry','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-01-31 14:22:08'),(111,'ry','127.0.0.1','内网IP','Chrome 12','Windows 10','0','退出成功','2024-01-31 14:46:34'),(112,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-01-31 14:46:39'),(113,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-04 14:06:10'),(114,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-06-04 14:18:42'),(115,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-06-04 14:21:00'),(116,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-06-04 14:25:31'),(117,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-04 14:30:29'),(118,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-06-04 14:47:51'),(119,'kurofu0319','127.0.0.1','内网IP','Chrome 12','Windows 10','0','注册成功','2024-06-04 14:56:40'),(120,'kurofu0319','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-06-04 14:56:51'),(121,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-06-04 15:45:18'),(122,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-06-04 20:54:10'),(123,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-06-04 20:55:08'),(124,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-06-04 20:58:11'),(125,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-06-04 21:02:08'),(126,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-06-04 21:06:21'),(127,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-06-04 21:07:22'),(128,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-06-04 21:08:42'),(129,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-04 21:24:41'),(130,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-04 21:27:39'),(131,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-04 21:27:52'),(132,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-04 21:28:48'),(133,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-04 21:29:20'),(134,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-04 21:29:30'),(135,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-05 14:46:23'),(136,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-05 15:25:20'),(137,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-05 16:53:17'),(138,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-05 16:57:08'),(139,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','退出成功','2024-06-05 17:01:47'),(140,'kurofu0319','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-05 17:01:56'),(141,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-05 19:06:37'),(142,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-05 19:16:01'),(143,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','退出成功','2024-06-05 19:37:23'),(144,'kurofu0319','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-05 19:37:34'),(145,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-05 19:45:28'),(146,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','退出成功','2024-06-05 19:45:58'),(147,'kurofu0319','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-05 19:46:11'),(148,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-05 20:24:37'),(149,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-05 20:24:57'),(150,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-05 20:25:21'),(151,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-05 20:26:28'),(152,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-05 20:32:04'),(153,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-05 20:32:19'),(154,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-05 20:33:17'),(155,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-05 20:35:11'),(156,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-05 20:36:09'),(157,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-05 20:36:39'),(158,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-05 20:37:44'),(159,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-05 20:41:05'),(160,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-05 20:44:29'),(161,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-05 20:45:12'),(162,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-05 20:49:22'),(163,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-05 20:49:41'),(164,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','退出成功','2024-06-05 20:54:18'),(165,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-05 20:54:19'),(166,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-05 20:55:19'),(167,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-06-05 20:56:55'),(168,'admin','127.0.0.1','内网IP','Chrome Mobile','Android 8.x','0','登录成功','2024-06-05 21:14:22'),(169,'admin','127.0.0.1','内网IP','Chrome Mobile','Android 8.x','0','登录成功','2024-06-05 21:21:10'),(170,'admin','127.0.0.1','内网IP','Chrome Mobile','Android 8.x','0','登录成功','2024-06-05 21:25:59'),(171,'admin','127.0.0.1','内网IP','Chrome Mobile','Android 8.x','0','登录成功','2024-06-05 21:31:38'),(172,'admin','127.0.0.1','内网IP','Chrome Mobile','Android 8.x','0','登录成功','2024-06-05 21:39:22'),(173,'admin','127.0.0.1','内网IP','Chrome Mobile','Android 8.x','0','登录成功','2024-06-05 21:40:31'),(174,'admin','127.0.0.1','内网IP','Chrome Mobile','Android 8.x','0','登录成功','2024-06-05 21:51:44'),(175,'admin','127.0.0.1','内网IP','Chrome Mobile','Android 8.x','0','登录成功','2024-06-05 21:56:26'),(176,'admin','127.0.0.1','内网IP','Chrome Mobile','Android 8.x','0','登录成功','2024-06-05 22:01:09'),(177,'admin','127.0.0.1','内网IP','Chrome Mobile','Android 8.x','0','退出成功','2024-06-05 22:02:18'),(178,'kurofu0319','127.0.0.1','内网IP','Chrome Mobile','Android 8.x','0','登录成功','2024-06-05 22:02:33'),(179,'kurofu0319','127.0.0.1','内网IP','Chrome Mobile','Android 8.x','0','退出成功','2024-06-05 22:09:40'),(180,'admin','127.0.0.1','内网IP','Chrome Mobile','Android 8.x','0','登录成功','2024-06-05 22:09:52'),(181,'admin','127.0.0.1','内网IP','Chrome Mobile','Android 8.x','0','登录成功','2024-06-06 11:15:08'),(182,'admin','127.0.0.1','内网IP','Chrome Mobile','Android 8.x','0','登录成功','2024-06-06 11:27:03'),(183,'admin','127.0.0.1','内网IP','Chrome Mobile','Android 8.x','0','登录成功','2024-06-06 11:30:38'),(184,'admin','127.0.0.1','内网IP','Chrome Mobile','Android 8.x','0','登录成功','2024-06-06 12:34:04'),(185,'admin','127.0.0.1','内网IP','Chrome Mobile','Android 8.x','0','登录成功','2024-06-06 13:44:27'),(186,'admin','127.0.0.1','内网IP','Chrome Mobile','Android 8.x','0','登录成功','2024-06-06 14:37:39'),(187,'admin','127.0.0.1','内网IP','Chrome Mobile','Android 8.x','0','登录成功','2024-06-06 14:40:24'),(188,'admin','127.0.0.1','内网IP','Chrome Mobile','Android 8.x','0','登录成功','2024-06-06 14:40:59'),(189,'admin','127.0.0.1','内网IP','Chrome Mobile','Android 8.x','0','登录成功','2024-06-06 14:56:22'),(190,'admin','127.0.0.1','内网IP','Chrome Mobile','Android 8.x','0','登录成功','2024-06-06 15:05:19'),(191,'admin','127.0.0.1','内网IP','Chrome Mobile','Android 8.x','0','登录成功','2024-06-06 16:40:21'),(192,'admin','127.0.0.1','内网IP','Chrome Mobile','Android 8.x','0','退出成功','2024-06-06 16:44:43'),(193,'123','127.0.0.1','内网IP','Chrome Mobile','Android 8.x','0','注册成功','2024-06-06 16:44:53'),(194,'admin','127.0.0.1','内网IP','Chrome Mobile','Android 8.x','0','登录成功','2024-06-06 21:21:44'),(195,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-06-06 21:56:42'),(196,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-06-06 22:00:23'),(197,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-06-06 22:02:17'),(198,'admin','127.0.0.1','内网IP','Chrome Mobile','Android 8.x','0','登录成功','2024-06-06 23:12:18'),(199,'123456','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','注册成功','2024-06-07 14:24:41'),(200,'123456','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-07 14:24:53'),(201,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-07 15:00:46'),(202,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-07 17:11:47'),(203,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-06-07 19:03:38'),(204,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','退出成功','2024-06-07 19:03:55'),(205,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-08 14:22:31'),(206,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-08 14:34:33'),(207,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','退出成功','2024-06-08 14:51:38'),(208,'kurofu0319','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-08 14:57:27'),(209,'2021110667','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','注册成功','2024-06-08 14:58:53'),(210,'2021110670','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','注册成功','2024-06-08 15:00:23'),(211,'2021110667','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','用户不存在/密码错误','2024-06-08 15:05:02'),(212,'2021110667','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','用户不存在/密码错误','2024-06-08 15:05:21'),(213,'2021110667','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','用户不存在/密码错误','2024-06-08 15:05:26'),(214,'2021110667','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-08 15:06:06'),(215,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-08 20:47:25'),(216,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','退出成功','2024-06-08 20:52:17'),(217,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-08 20:52:22'),(218,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','退出成功','2024-06-08 20:53:25'),(219,'88888888','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','注册成功','2024-06-08 20:54:01'),(220,'88888888','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-08 20:54:24'),(221,'88888888','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','退出成功','2024-06-08 20:56:02'),(222,'88888888','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-08 20:56:15'),(223,'88888888','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','退出成功','2024-06-08 20:59:40'),(224,'00000000','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','注册成功','2024-06-08 21:01:13'),(225,'00000000','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','用户不存在/密码错误','2024-06-08 21:01:28'),(226,'00000000','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-08 21:01:37'),(227,'00000000','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','退出成功','2024-06-08 21:04:01'),(228,'00000000','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','用户不存在/密码错误','2024-06-08 21:04:19'),(229,'00000000','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-08 21:04:27'),(230,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-09 15:21:26'),(231,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-09 15:41:26'),(232,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','退出成功','2024-06-09 15:41:38'),(233,'123456','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-09 15:41:47'),(234,'123456','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','退出成功','2024-06-09 15:41:56'),(235,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-09 15:41:58'),(236,'kurofu0319','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-09 15:47:03'),(237,'kurofu0319','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-09 15:47:35'),(238,'2021110667','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','用户不存在/密码错误','2024-06-09 15:48:15'),(239,'00000000','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-09 15:48:25'),(240,'admin','127.0.0.1','内网IP','Chrome Mobile','Android 6.x','0','登录成功','2024-06-09 18:09:46'),(241,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-09 18:18:31'),(242,'admin','127.0.0.1','内网IP','Chrome Mobile','Android 6.x','0','登录成功','2024-06-09 18:42:23'),(243,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-09 18:46:16'),(244,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-09 18:55:46'),(245,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-09 18:59:31'),(246,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-09 19:10:42'),(247,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-09 19:25:23'),(248,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-09 19:54:24'),(249,'admin','127.0.0.1','内网IP','Chrome Mobile','Android 6.x','0','登录成功','2024-06-09 20:02:52'),(250,'admin','127.0.0.1','内网IP','Chrome Mobile','Android 6.x','0','登录成功','2024-06-09 20:07:53'),(251,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-09 20:41:42'),(252,'admin','127.0.0.1','内网IP','Chrome Mobile','Android 6.x','0','登录成功','2024-06-09 20:51:56'),(253,'00000000','127.0.0.1','内网IP','Chrome Mobile','Android 6.x','0','登录成功','2024-06-09 20:53:25'),(254,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-09 21:18:04'),(255,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-09 21:19:06'),(256,'admin','127.0.0.1','内网IP','Chrome Mobile','Android 6.x','0','登录成功','2024-06-09 22:02:06'),(257,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-09 22:04:44'),(258,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-09 22:15:00'),(259,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-10 15:58:10'),(260,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-16 19:01:51'),(261,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-16 19:40:04'),(262,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-16 19:44:37'),(263,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-16 20:39:00'),(264,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','退出成功','2024-06-16 20:39:38'),(265,'2021110667','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','用户不存在/密码错误','2024-06-16 20:39:47'),(266,'2021110667','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-16 20:39:54'),(267,'2021110667','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','退出成功','2024-06-16 20:42:03'),(268,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','用户不存在/密码错误','2024-06-16 20:42:09'),(269,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','用户不存在/密码错误','2024-06-16 20:42:13'),(270,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','用户不存在/密码错误','2024-06-16 20:42:46'),(271,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','用户不存在/密码错误','2024-06-16 20:42:50'),(272,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-16 20:44:34'),(273,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','退出成功','2024-06-16 20:45:59'),(274,'2021110667','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-16 20:46:08'),(275,'2021110667','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','退出成功','2024-06-16 20:46:13'),(276,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-16 20:46:16'),(277,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-16 21:12:19'),(278,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-16 21:14:23'),(279,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-16 21:15:53'),(280,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-16 22:05:32'),(281,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-16 22:10:15'),(282,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-16 22:12:09'),(283,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-16 22:49:43'),(284,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-17 13:06:55'),(285,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-17 13:07:18'),(286,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-17 13:50:35'),(287,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-17 14:03:50'),(288,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-17 14:07:13'),(289,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','退出成功','2024-06-17 15:38:44'),(290,'00000000','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','用户不存在/密码错误','2024-06-17 15:38:54'),(291,'00000000','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','用户不存在/密码错误','2024-06-17 15:38:59'),(292,'00000000','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','用户不存在/密码错误','2024-06-17 15:39:09'),(293,'00000000','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','用户不存在/密码错误','2024-06-17 15:39:20'),(294,'00000000','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','用户不存在/密码错误','2024-06-17 15:39:27'),(295,'kurofu0319','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-17 15:39:41'),(296,'kurofu0319','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','退出成功','2024-06-17 15:40:28'),(297,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-17 15:40:29'),(298,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-17 15:55:37'),(299,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-17 16:00:41'),(300,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-17 16:14:01'),(301,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-17 16:16:54'),(302,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-17 16:32:20'),(303,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-17 18:57:53'),(304,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-17 19:01:21'),(305,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-17 19:19:59'),(306,'admin','192.168.43.1','内网IP','Chrome Mobile','Android 1.x','0','登录成功','2024-06-17 23:30:13'),(307,'admin','192.168.43.1','内网IP','Chrome Mobile','Android 1.x','0','登录成功','2024-06-17 23:31:33'),(308,'admin','192.168.43.1','内网IP','Chrome Mobile','Android 1.x','0','登录成功','2024-06-17 23:36:17'),(309,'admin','192.168.43.1','内网IP','Chrome Mobile','Android 1.x','0','登录成功','2024-06-17 23:39:10'),(310,'admin','192.168.43.1','内网IP','Chrome Mobile','Android 1.x','0','登录成功','2024-06-17 23:44:24'),(311,'admin','192.168.43.1','内网IP','Chrome Mobile','Android 1.x','0','登录成功','2024-06-17 23:44:33'),(312,'admin','192.168.43.1','内网IP','Chrome Mobile','Android 1.x','0','登录成功','2024-06-17 23:50:36'),(313,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 13:04:17'),(314,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 13:07:32'),(315,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 13:14:16'),(316,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 13:19:51'),(317,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 13:30:48'),(318,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 13:46:12'),(319,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 13:51:17'),(320,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 14:01:07'),(321,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 14:11:47'),(322,'admin','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 14:23:45'),(323,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2024-06-18 14:38:00'),(324,'admin','192.168.43.1','内网IP','Chrome Mobile','Android 1.x','0','登录成功','2024-06-18 14:38:20'),(325,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 14:47:18'),(326,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 14:49:30'),(327,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 14:51:30'),(328,'admin','192.168.43.1','内网IP','Chrome Mobile','Android 1.x','0','登录成功','2024-06-18 14:53:12'),(329,'admin','192.168.43.1','内网IP','Chrome Mobile','Android 1.x','0','登录成功','2024-06-18 14:53:48'),(330,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 15:01:04'),(331,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 15:04:03'),(332,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 15:04:05'),(333,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 15:04:08'),(334,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 15:04:23'),(335,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 15:04:24'),(336,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 15:04:25'),(337,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 15:04:25'),(338,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 15:04:25'),(339,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 15:04:25'),(340,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 15:04:26'),(341,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 15:04:26'),(342,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 15:04:26'),(343,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 15:04:26'),(344,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 15:04:26'),(345,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 15:04:26'),(346,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 15:04:26'),(347,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 15:04:58'),(348,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 15:09:59'),(349,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 15:12:35'),(350,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 15:21:40'),(351,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 15:23:46'),(352,'admin','192.168.43.23','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 15:27:07'),(353,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 15:30:27'),(354,'admin','192.168.43.23','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 15:32:48'),(355,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 15:44:17'),(356,'admin','192.168.43.23','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 15:46:31'),(357,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 15:52:47'),(358,'admin','192.168.43.23','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 15:57:33'),(359,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 16:00:05'),(360,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 16:07:55'),(361,'admin','192.168.43.23','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 16:30:26'),(362,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 16:33:32'),(363,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 16:38:55'),(364,'admin','192.168.43.23','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 16:42:01'),(365,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 16:43:13'),(366,'admin','192.168.43.23','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 16:47:16'),(367,'admin','192.168.43.23','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 16:48:13'),(368,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 16:49:19'),(369,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 16:52:15'),(370,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 16:57:24'),(371,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 16:59:11'),(372,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 17:04:58'),(373,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 17:05:41'),(374,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 17:15:00'),(375,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 17:15:23'),(376,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 17:15:49'),(377,'admin','192.168.43.46','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-18 17:21:48'),(378,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 18:19:49'),(379,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 18:30:52'),(380,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 19:06:27'),(381,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 19:35:23'),(382,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 19:36:20'),(383,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 19:38:40'),(384,'777777','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','注册成功','2024-06-18 19:59:15'),(385,'777777','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 19:59:22'),(386,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 20:22:33'),(387,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 20:26:18'),(388,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 20:30:29'),(389,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 20:36:03'),(390,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 20:49:28'),(391,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 22:39:45'),(392,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 23:07:29'),(393,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-18 23:09:33'),(394,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-19 13:50:06'),(395,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-19 14:44:44'),(396,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-19 14:47:16'),(397,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-19 15:08:34'),(398,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-19 16:31:38'),(399,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-19 16:39:06'),(400,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-19 16:55:09'),(401,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-19 17:31:41'),(402,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-19 18:39:41'),(403,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-19 18:42:20'),(404,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-19 20:06:36'),(405,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-19 20:25:56'),(406,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-19 20:42:32'),(407,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-19 20:52:10'),(408,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-19 21:01:51'),(409,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-19 21:08:55'),(410,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-19 21:22:14'),(411,'admin','172.20.255.31','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-19 21:35:33'),(412,'admin','172.20.10.5','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-19 22:45:36'),(413,'admin','172.20.10.5','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-19 23:46:46'),(414,'admin','172.20.141.206','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-20 10:47:23'),(415,'admin','172.20.141.206','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-20 17:56:15'),(416,'admin','172.20.141.206','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-21 14:08:04'),(417,'admin','172.20.10.11','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-21 14:16:04'),(418,'admin','172.20.10.11','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-21 14:32:45'),(419,'admin','172.20.10.5','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-21 14:52:22'),(420,'admin','172.20.10.5','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-21 15:12:53'),(421,'admin','172.20.10.5','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-21 15:18:34'),(422,'admin','172.20.10.5','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-21 15:24:08'),(423,'admin','172.20.10.5','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-22 10:08:53'),(424,'admin','172.20.10.5','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-22 10:11:28'),(425,'admin','172.20.10.5','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-22 10:29:19'),(426,'admin','172.20.10.5','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-22 10:32:12'),(427,'admin','172.20.10.5','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-22 10:52:03'),(428,'admin','172.20.10.5','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-22 10:52:11'),(429,'admin','172.20.10.5','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-22 10:59:46'),(430,'admin','172.20.10.5','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-22 11:05:11'),(431,'admin','172.20.249.208','内网IP','Chrome Mobile','Android 6.x','0','登录成功','2024-06-26 18:54:39'),(432,'admin','172.20.249.208','内网IP','Chrome Mobile','Android 6.x','0','登录成功','2024-06-26 21:49:50'),(433,'admin','172.20.249.208','内网IP','Chrome Mobile','Android 6.x','0','登录成功','2024-06-27 12:19:55'),(434,'admin','172.20.249.208','内网IP','Chrome Mobile','Android 6.x','0','登录成功','2024-06-27 15:34:19'),(435,'admin','172.20.249.208','内网IP','Chrome Mobile','Android 6.x','0','登录成功','2024-06-27 18:50:08'),(436,'admin','172.20.249.208','内网IP','Chrome Mobile','Android 6.x','0','退出成功','2024-06-27 18:58:30'),(437,'wyd123456','172.20.249.208','内网IP','Chrome Mobile','Android 6.x','0','注册成功','2024-06-27 19:01:14'),(438,'wyd123456','172.20.249.208','内网IP','Chrome Mobile','Android 6.x','0','登录成功','2024-06-27 19:01:36'),(439,'admin','172.20.249.208','内网IP','Chrome 12','Windows 10','0','登录成功','2024-06-27 19:08:26'),(440,'fr123456','172.20.249.208','内网IP','Chrome 12','Windows 10','0','注册成功','2024-06-27 19:11:03'),(441,'fr123456','172.20.249.208','内网IP','Chrome 12','Windows 10','0','登录成功','2024-06-27 19:11:54'),(442,'fr123456','172.20.249.208','内网IP','Chrome Mobile','Android 6.x','0','退出成功','2024-06-27 19:14:07'),(443,'fr123456','172.20.249.208','内网IP','Chrome Mobile','Android 6.x','0','登录成功','2024-06-27 19:14:50'),(444,'fr123456','172.20.249.208','内网IP','Chrome 12','Windows 10','0','退出成功','2024-06-27 19:15:26'),(445,'admin','172.20.249.208','内网IP','Chrome Mobile','Android 6.x','0','登录成功','2024-06-27 19:15:33'),(446,'yzr123456','172.20.249.208','内网IP','Chrome Mobile','Android 6.x','0','注册成功','2024-06-27 19:17:51'),(447,'yzr123456','172.20.249.208','内网IP','Chrome Mobile','Android 6.x','0','登录成功','2024-06-27 19:18:09'),(448,'yzr123456','172.20.249.208','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-27 19:19:51'),(449,'yzr123456','172.20.249.208','内网IP','Chrome Mobile','Android 6.x','0','退出成功','2024-06-27 19:30:52'),(450,'admin','172.20.249.208','内网IP','Chrome Mobile','Android 6.x','0','登录成功','2024-06-27 19:30:53'),(451,'admin','172.20.249.208','内网IP','Mobile Safari','Mac OS X (iPhone)','0','退出成功','2024-06-27 19:40:26'),(452,'yzr123456','172.20.249.208','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-27 19:40:41'),(453,'yzr123456','172.20.249.208','内网IP','Mobile Safari','Mac OS X (iPhone)','0','退出成功','2024-06-27 19:42:53'),(454,'admin','172.20.249.208','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-27 19:42:54'),(455,'admin','172.20.249.208','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-27 20:04:14'),(456,'wyd123456','172.20.249.208','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-27 20:11:58'),(457,'yzr123456','172.20.249.208','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-27 20:12:40'),(458,'fr123456','172.20.249.208','内网IP','Chrome 12','Windows 10','1','用户不存在/密码错误','2024-06-27 20:13:11'),(459,'fr123456','172.20.249.208','内网IP','Chrome 12','Windows 10','0','登录成功','2024-06-27 20:13:19'),(460,'fr123456','172.20.249.208','内网IP','Mobile Safari','Mac OS X (iPhone)','0','退出成功','2024-06-27 20:33:00'),(461,'admin','172.20.249.208','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-27 20:33:02'),(462,'admin','172.20.249.208','内网IP','Mobile Safari','Mac OS X (iPhone)','0','退出成功','2024-06-27 20:33:47'),(463,'fr123456','172.20.249.208','内网IP','Mobile Safari','Mac OS X (iPhone)','1','用户不存在/密码错误','2024-06-27 20:34:01'),(464,'fr123456','172.20.249.208','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-27 20:34:57'),(465,'fr123456','172.20.249.208','内网IP','Mobile Safari','Mac OS X (iPhone)','0','退出成功','2024-06-27 20:50:05'),(466,'admin','172.20.249.208','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-27 20:52:44'),(467,'admin','172.20.249.208','内网IP','Mobile Safari','Mac OS X (iPhone)','0','退出成功','2024-06-27 21:22:27'),(468,'admin','172.20.249.208','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-27 21:23:43'),(469,'admin','172.20.249.208','内网IP','Mobile Safari','Mac OS X (iPhone)','0','退出成功','2024-06-27 21:35:44'),(470,'admin','172.20.249.208','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-27 21:36:16'),(471,'admin','172.20.10.11','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-27 21:57:55'),(472,'admin','172.20.10.11','内网IP','Chrome 9','Android 1.x','0','退出成功','2024-06-27 21:58:46'),(473,'admin','172.20.10.11','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-27 21:59:23'),(474,'admin','172.20.10.11','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-27 22:07:15'),(475,'admin','172.20.10.11','内网IP','Chrome 9','Android 1.x','0','退出成功','2024-06-27 22:07:26'),(476,'admin','172.20.10.11','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-27 22:08:15'),(477,'admin','172.20.10.2','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-27 22:25:27'),(478,'admin','172.20.10.11','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-27 22:33:10'),(479,'admin','172.20.10.11','内网IP','Chrome 9','Android 1.x','0','退出成功','2024-06-27 22:36:25'),(480,'admin','172.20.10.11','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-27 22:36:46'),(481,'admin','172.20.10.11','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-27 23:04:44'),(482,'admin','172.20.10.2','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-27 23:13:24'),(483,'admin','172.20.10.11','内网IP','Chrome 9','Android 1.x','0','退出成功','2024-06-27 23:15:12'),(484,'admin','172.20.10.11','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-27 23:15:29'),(485,'admin','172.20.10.11','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-27 23:19:43'),(486,'admin','172.20.10.11','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-28 21:01:04'),(487,'admin','172.20.10.3','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-28 21:10:16'),(488,'admin','172.20.10.3','内网IP','Chrome 9','Android 1.x','0','退出成功','2024-06-28 21:10:27'),(489,'yzr123456','172.20.10.3','内网IP','Chrome 9','Android 1.x','1','用户不存在/密码错误','2024-06-28 21:10:39'),(490,'yzr123456','172.20.10.3','内网IP','Chrome 9','Android 1.x','1','用户不存在/密码错误','2024-06-28 21:10:42'),(491,'yzr123456','172.20.10.3','内网IP','Chrome 9','Android 1.x','1','用户不存在/密码错误','2024-06-28 21:10:43'),(492,'yzr123456','172.20.10.3','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-28 21:10:49'),(493,'admin','172.20.10.3','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-28 21:11:05'),(494,'admin','172.20.10.3','内网IP','Chrome 9','Android 1.x','0','退出成功','2024-06-28 21:11:20'),(495,'yzr123456','172.20.10.3','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-28 21:11:47'),(496,'admin','172.20.10.11','内网IP','Chrome 9','Android 1.x','0','退出成功','2024-06-28 21:12:21'),(497,'admin','172.20.10.11','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-28 21:13:36'),(498,'admin','172.20.10.11','内网IP','Chrome 9','Android 1.x','0','退出成功','2024-06-28 21:24:15'),(499,'admin','172.20.10.11','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-28 21:24:27'),(500,'admin','172.20.10.2','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-28 21:38:00'),(501,'admin','172.20.10.2','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-28 21:54:09'),(502,'admin','172.20.10.2','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-28 21:54:15'),(503,'admin','172.20.10.2','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-06-28 22:06:32'),(504,'admin','172.20.10.11','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-28 22:16:36'),(505,'yzr123456','172.20.10.3','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-28 22:18:18'),(506,'admin','172.20.10.11','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-28 22:18:53'),(507,'admin','172.20.10.11','内网IP','Chrome 9','Android 1.x','0','退出成功','2024-06-28 22:29:56'),(508,'admin','172.20.10.11','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-28 22:30:21'),(509,'admin','172.20.10.11','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-29 08:44:37'),(510,'admin','172.20.10.11','内网IP','Chrome 9','Android 1.x','0','退出成功','2024-06-29 08:47:05'),(511,'admin','172.20.10.11','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-29 08:47:06'),(512,'admin','172.20.10.11','内网IP','Chrome 9','Android 1.x','0','退出成功','2024-06-29 08:59:34'),(513,'admin','172.20.10.11','内网IP','Chrome 9','Android 1.x','0','登录成功','2024-06-29 09:00:06');
/*!40000 ALTER TABLE `sys_logininfor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_menu` (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) NOT NULL COMMENT '菜单名称',
  `parent_id` bigint DEFAULT '0' COMMENT '父菜单ID',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `path` varchar(200) DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) DEFAULT NULL COMMENT '路由参数',
  `is_frame` int DEFAULT '1' COMMENT '是否为外链（0是 1否）',
  `is_cache` int DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='菜单权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (1,'系统管理',0,1,'system',NULL,'',1,0,'M','0','0','','system','admin','2024-01-30 16:47:12','',NULL,'系统管理目录'),(2,'系统监控',0,2,'monitor',NULL,'',1,0,'M','0','0','','monitor','admin','2024-01-30 16:47:12','',NULL,'系统监控目录'),(3,'系统工具',0,3,'tool',NULL,'',1,0,'M','0','0','','tool','admin','2024-01-30 16:47:12','',NULL,'系统工具目录'),(4,'若依官网',0,4,'http://ruoyi.vip',NULL,'',0,0,'M','0','0','','guide','admin','2024-01-30 16:47:12','',NULL,'若依官网地址'),(100,'用户管理',1,1,'user','system/user/index','',1,0,'C','0','0','system:user:list','user','admin','2024-01-30 16:47:12','',NULL,'用户管理菜单'),(101,'角色管理',1,2,'role','system/role/index','',1,0,'C','0','0','system:role:list','peoples','admin','2024-01-30 16:47:12','',NULL,'角色管理菜单'),(102,'菜单管理',1,3,'menu','system/menu/index','',1,0,'C','0','0','system:menu:list','tree-table','admin','2024-01-30 16:47:12','',NULL,'菜单管理菜单'),(103,'部门管理',1,4,'dept','system/dept/index','',1,0,'C','0','0','system:dept:list','tree','admin','2024-01-30 16:47:12','',NULL,'部门管理菜单'),(104,'岗位管理',1,5,'post','system/post/index','',1,0,'C','0','0','system:post:list','post','admin','2024-01-30 16:47:12','',NULL,'岗位管理菜单'),(105,'字典管理',1,6,'dict','system/dict/index','',1,0,'C','0','0','system:dict:list','dict','admin','2024-01-30 16:47:12','',NULL,'字典管理菜单'),(106,'参数设置',1,7,'config','system/config/index','',1,0,'C','0','0','system:config:list','edit','admin','2024-01-30 16:47:12','',NULL,'参数设置菜单'),(107,'通知公告',1,8,'notice','system/notice/index','',1,0,'C','0','0','system:notice:list','message','admin','2024-01-30 16:47:12','',NULL,'通知公告菜单'),(108,'日志管理',1,9,'log','','',1,0,'M','0','0','','log','admin','2024-01-30 16:47:12','',NULL,'日志管理菜单'),(109,'在线用户',2,1,'online','monitor/online/index','',1,0,'C','0','0','monitor:online:list','online','admin','2024-01-30 16:47:12','',NULL,'在线用户菜单'),(110,'定时任务',2,2,'job','monitor/job/index','',1,0,'C','0','0','monitor:job:list','job','admin','2024-01-30 16:47:12','',NULL,'定时任务菜单'),(111,'数据监控',2,3,'druid','monitor/druid/index','',1,0,'C','0','0','monitor:druid:list','druid','admin','2024-01-30 16:47:12','',NULL,'数据监控菜单'),(112,'服务监控',2,4,'server','monitor/server/index','',1,0,'C','0','0','monitor:server:list','server','admin','2024-01-30 16:47:12','',NULL,'服务监控菜单'),(113,'缓存监控',2,5,'cache','monitor/cache/index','',1,0,'C','0','0','monitor:cache:list','redis','admin','2024-01-30 16:47:12','',NULL,'缓存监控菜单'),(114,'缓存列表',2,6,'cacheList','monitor/cache/list','',1,0,'C','0','0','monitor:cache:list','redis-list','admin','2024-01-30 16:47:12','',NULL,'缓存列表菜单'),(115,'表单构建',3,1,'build','tool/build/index','',1,0,'C','0','0','tool:build:list','build','admin','2024-01-30 16:47:12','',NULL,'表单构建菜单'),(116,'代码生成',3,2,'gen','tool/gen/index','',1,0,'C','0','0','tool:gen:list','code','admin','2024-01-30 16:47:12','',NULL,'代码生成菜单'),(117,'系统接口',3,3,'swagger','tool/swagger/index','',1,0,'C','0','0','tool:swagger:list','swagger','admin','2024-01-30 16:47:12','',NULL,'系统接口菜单'),(500,'操作日志',108,1,'operlog','monitor/operlog/index','',1,0,'C','0','0','monitor:operlog:list','form','admin','2024-01-30 16:47:12','',NULL,'操作日志菜单'),(501,'登录日志',108,2,'logininfor','monitor/logininfor/index','',1,0,'C','0','0','monitor:logininfor:list','logininfor','admin','2024-01-30 16:47:12','',NULL,'登录日志菜单'),(1000,'用户查询',100,1,'','','',1,0,'F','0','0','system:user:query','#','admin','2024-01-30 16:47:12','',NULL,''),(1001,'用户新增',100,2,'','','',1,0,'F','0','0','system:user:add','#','admin','2024-01-30 16:47:12','',NULL,''),(1002,'用户修改',100,3,'','','',1,0,'F','0','0','system:user:edit','#','admin','2024-01-30 16:47:12','',NULL,''),(1003,'用户删除',100,4,'','','',1,0,'F','0','0','system:user:remove','#','admin','2024-01-30 16:47:12','',NULL,''),(1004,'用户导出',100,5,'','','',1,0,'F','0','0','system:user:export','#','admin','2024-01-30 16:47:12','',NULL,''),(1005,'用户导入',100,6,'','','',1,0,'F','0','0','system:user:import','#','admin','2024-01-30 16:47:12','',NULL,''),(1006,'重置密码',100,7,'','','',1,0,'F','0','0','system:user:resetPwd','#','admin','2024-01-30 16:47:12','',NULL,''),(1007,'角色查询',101,1,'','','',1,0,'F','0','0','system:role:query','#','admin','2024-01-30 16:47:12','',NULL,''),(1008,'角色新增',101,2,'','','',1,0,'F','0','0','system:role:add','#','admin','2024-01-30 16:47:12','',NULL,''),(1009,'角色修改',101,3,'','','',1,0,'F','0','0','system:role:edit','#','admin','2024-01-30 16:47:12','',NULL,''),(1010,'角色删除',101,4,'','','',1,0,'F','0','0','system:role:remove','#','admin','2024-01-30 16:47:12','',NULL,''),(1011,'角色导出',101,5,'','','',1,0,'F','0','0','system:role:export','#','admin','2024-01-30 16:47:12','',NULL,''),(1012,'菜单查询',102,1,'','','',1,0,'F','0','0','system:menu:query','#','admin','2024-01-30 16:47:12','',NULL,''),(1013,'菜单新增',102,2,'','','',1,0,'F','0','0','system:menu:add','#','admin','2024-01-30 16:47:12','',NULL,''),(1014,'菜单修改',102,3,'','','',1,0,'F','0','0','system:menu:edit','#','admin','2024-01-30 16:47:12','',NULL,''),(1015,'菜单删除',102,4,'','','',1,0,'F','0','0','system:menu:remove','#','admin','2024-01-30 16:47:12','',NULL,''),(1016,'部门查询',103,1,'','','',1,0,'F','0','0','system:dept:query','#','admin','2024-01-30 16:47:12','',NULL,''),(1017,'部门新增',103,2,'','','',1,0,'F','0','0','system:dept:add','#','admin','2024-01-30 16:47:12','',NULL,''),(1018,'部门修改',103,3,'','','',1,0,'F','0','0','system:dept:edit','#','admin','2024-01-30 16:47:12','',NULL,''),(1019,'部门删除',103,4,'','','',1,0,'F','0','0','system:dept:remove','#','admin','2024-01-30 16:47:12','',NULL,''),(1020,'岗位查询',104,1,'','','',1,0,'F','0','0','system:post:query','#','admin','2024-01-30 16:47:12','',NULL,''),(1021,'岗位新增',104,2,'','','',1,0,'F','0','0','system:post:add','#','admin','2024-01-30 16:47:12','',NULL,''),(1022,'岗位修改',104,3,'','','',1,0,'F','0','0','system:post:edit','#','admin','2024-01-30 16:47:12','',NULL,''),(1023,'岗位删除',104,4,'','','',1,0,'F','0','0','system:post:remove','#','admin','2024-01-30 16:47:12','',NULL,''),(1024,'岗位导出',104,5,'','','',1,0,'F','0','0','system:post:export','#','admin','2024-01-30 16:47:12','',NULL,''),(1025,'字典查询',105,1,'#','','',1,0,'F','0','0','system:dict:query','#','admin','2024-01-30 16:47:12','',NULL,''),(1026,'字典新增',105,2,'#','','',1,0,'F','0','0','system:dict:add','#','admin','2024-01-30 16:47:12','',NULL,''),(1027,'字典修改',105,3,'#','','',1,0,'F','0','0','system:dict:edit','#','admin','2024-01-30 16:47:12','',NULL,''),(1028,'字典删除',105,4,'#','','',1,0,'F','0','0','system:dict:remove','#','admin','2024-01-30 16:47:12','',NULL,''),(1029,'字典导出',105,5,'#','','',1,0,'F','0','0','system:dict:export','#','admin','2024-01-30 16:47:12','',NULL,''),(1030,'参数查询',106,1,'#','','',1,0,'F','0','0','system:config:query','#','admin','2024-01-30 16:47:12','',NULL,''),(1031,'参数新增',106,2,'#','','',1,0,'F','0','0','system:config:add','#','admin','2024-01-30 16:47:12','',NULL,''),(1032,'参数修改',106,3,'#','','',1,0,'F','0','0','system:config:edit','#','admin','2024-01-30 16:47:12','',NULL,''),(1033,'参数删除',106,4,'#','','',1,0,'F','0','0','system:config:remove','#','admin','2024-01-30 16:47:12','',NULL,''),(1034,'参数导出',106,5,'#','','',1,0,'F','0','0','system:config:export','#','admin','2024-01-30 16:47:12','',NULL,''),(1035,'公告查询',107,1,'#','','',1,0,'F','0','0','system:notice:query','#','admin','2024-01-30 16:47:12','',NULL,''),(1036,'公告新增',107,2,'#','','',1,0,'F','0','0','system:notice:add','#','admin','2024-01-30 16:47:12','',NULL,''),(1037,'公告修改',107,3,'#','','',1,0,'F','0','0','system:notice:edit','#','admin','2024-01-30 16:47:12','',NULL,''),(1038,'公告删除',107,4,'#','','',1,0,'F','0','0','system:notice:remove','#','admin','2024-01-30 16:47:12','',NULL,''),(1039,'操作查询',500,1,'#','','',1,0,'F','0','0','monitor:operlog:query','#','admin','2024-01-30 16:47:12','',NULL,''),(1040,'操作删除',500,2,'#','','',1,0,'F','0','0','monitor:operlog:remove','#','admin','2024-01-30 16:47:12','',NULL,''),(1041,'日志导出',500,3,'#','','',1,0,'F','0','0','monitor:operlog:export','#','admin','2024-01-30 16:47:12','',NULL,''),(1042,'登录查询',501,1,'#','','',1,0,'F','0','0','monitor:logininfor:query','#','admin','2024-01-30 16:47:12','',NULL,''),(1043,'登录删除',501,2,'#','','',1,0,'F','0','0','monitor:logininfor:remove','#','admin','2024-01-30 16:47:12','',NULL,''),(1044,'日志导出',501,3,'#','','',1,0,'F','0','0','monitor:logininfor:export','#','admin','2024-01-30 16:47:12','',NULL,''),(1045,'账户解锁',501,4,'#','','',1,0,'F','0','0','monitor:logininfor:unlock','#','admin','2024-01-30 16:47:12','',NULL,''),(1046,'在线查询',109,1,'#','','',1,0,'F','0','0','monitor:online:query','#','admin','2024-01-30 16:47:12','',NULL,''),(1047,'批量强退',109,2,'#','','',1,0,'F','0','0','monitor:online:batchLogout','#','admin','2024-01-30 16:47:12','',NULL,''),(1048,'单条强退',109,3,'#','','',1,0,'F','0','0','monitor:online:forceLogout','#','admin','2024-01-30 16:47:12','',NULL,''),(1049,'任务查询',110,1,'#','','',1,0,'F','0','0','monitor:job:query','#','admin','2024-01-30 16:47:12','',NULL,''),(1050,'任务新增',110,2,'#','','',1,0,'F','0','0','monitor:job:add','#','admin','2024-01-30 16:47:12','',NULL,''),(1051,'任务修改',110,3,'#','','',1,0,'F','0','0','monitor:job:edit','#','admin','2024-01-30 16:47:12','',NULL,''),(1052,'任务删除',110,4,'#','','',1,0,'F','0','0','monitor:job:remove','#','admin','2024-01-30 16:47:12','',NULL,''),(1053,'状态修改',110,5,'#','','',1,0,'F','0','0','monitor:job:changeStatus','#','admin','2024-01-30 16:47:12','',NULL,''),(1054,'任务导出',110,6,'#','','',1,0,'F','0','0','monitor:job:export','#','admin','2024-01-30 16:47:12','',NULL,''),(1055,'生成查询',116,1,'#','','',1,0,'F','0','0','tool:gen:query','#','admin','2024-01-30 16:47:12','',NULL,''),(1056,'生成修改',116,2,'#','','',1,0,'F','0','0','tool:gen:edit','#','admin','2024-01-30 16:47:12','',NULL,''),(1057,'生成删除',116,3,'#','','',1,0,'F','0','0','tool:gen:remove','#','admin','2024-01-30 16:47:12','',NULL,''),(1058,'导入代码',116,4,'#','','',1,0,'F','0','0','tool:gen:import','#','admin','2024-01-30 16:47:12','',NULL,''),(1059,'预览代码',116,5,'#','','',1,0,'F','0','0','tool:gen:preview','#','admin','2024-01-30 16:47:12','',NULL,''),(1060,'生成代码',116,6,'#','','',1,0,'F','0','0','tool:gen:code','#','admin','2024-01-30 16:47:12','',NULL,'');
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_notice`
--

DROP TABLE IF EXISTS `sys_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_notice` (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) NOT NULL COMMENT '公告标题',
  `notice_type` char(1) NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob COMMENT '公告内容',
  `status` char(1) DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='通知公告表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_notice`
--

LOCK TABLES `sys_notice` WRITE;
/*!40000 ALTER TABLE `sys_notice` DISABLE KEYS */;
INSERT INTO `sys_notice` VALUES (12,'应用已上线','1',_binary '知识库问答系统1.0上线','0','admin','2024-06-19 14:38:00','',NULL,NULL);
/*!40000 ALTER TABLE `sys_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_notification`
--

DROP TABLE IF EXISTS `sys_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_notification` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `post_id` bigint NOT NULL,
  `create_time` timestamp NOT NULL,
  `is_read` tinyint(1) DEFAULT '0',
  `reply_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_notification`
--

LOCK TABLES `sys_notification` WRITE;
/*!40000 ALTER TABLE `sys_notification` DISABLE KEYS */;
INSERT INTO `sys_notification` VALUES (44,'kurofu0319','Your post has been liked by admin',16,'2024-06-17 15:39:32',0,NULL),(52,'00000000','Your post has been replied by admin',18,'2024-06-18 06:12:15',0,71),(60,'00000000','Your post has been replied by admin',18,'2024-06-18 09:22:27',0,77),(61,'kurofu0319','Your post has been replied by admin',16,'2024-06-18 09:23:10',0,78),(64,'00000000','Your post has been replied by admin',18,'2024-06-18 10:30:08',0,79),(69,'kurofu0319','Your reply has been liked by admin',18,'2024-06-18 10:31:25',0,27),(80,'kurofu0319','Your post has been replied by admin',17,'2024-06-19 06:37:02',0,85),(81,'kurofu0319','Your post has been replied by admin',17,'2024-06-19 06:37:03',0,86),(82,'kurofu0319','Your post has been replied by admin',17,'2024-06-19 06:37:04',0,87),(88,'00000000','admin回复了你的帖子',19,'2024-06-19 08:32:30',0,88),(94,'00000000','admin回复了你的帖子',18,'2024-06-19 08:44:10',0,89),(107,'yzr123456','wyd123456回复了你的帖子',24,'2024-06-27 11:22:32',0,92),(109,'fr123456','wyd123456回复了你的帖子',26,'2024-06-27 11:29:00',0,94),(110,'fr123456','yzr123456回复了你的帖子',26,'2024-06-27 12:15:11',0,95),(111,'fr123456','admin回复了你的帖子',26,'2024-06-27 12:15:33',0,96),(112,'yzr123456','fr123456回复了你的帖子',24,'2024-06-27 12:16:20',0,97),(113,'yzr123456','admin回复了你的帖子',24,'2024-06-27 12:16:53',0,98),(114,'wyd123456','yzr123456回复了你的帖子',28,'2024-06-27 12:18:58',0,99),(115,'wyd123456','fr123456回复了你的帖子',28,'2024-06-27 12:19:58',0,100),(117,'wyd123456','admin回复了你的帖子',28,'2024-06-27 12:22:07',0,102),(122,'yzr123456','fr123456回复了你的帖子',30,'2024-06-27 12:27:52',0,107),(123,'yzr123456','wyd123456回复了你的帖子',30,'2024-06-27 12:28:09',0,108),(124,'yzr123456','admin回复了你的帖子',30,'2024-06-27 12:28:43',0,109),(151,'wyd123456','admin回复了你的帖子',28,'2024-06-29 01:02:06',0,125);
/*!40000 ALTER TABLE `sys_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_oper_log`
--

DROP TABLE IF EXISTS `sys_oper_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_oper_log` (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) DEFAULT '' COMMENT '模块标题',
  `business_type` int DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) DEFAULT '' COMMENT '请求方式',
  `operator_type` int DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) DEFAULT '' COMMENT '返回参数',
  `status` int DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint DEFAULT '0' COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`),
  KEY `idx_sys_oper_log_bt` (`business_type`),
  KEY `idx_sys_oper_log_s` (`status`),
  KEY `idx_sys_oper_log_ot` (`oper_time`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='操作日志记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_oper_log`
--

LOCK TABLES `sys_oper_log` WRITE;
/*!40000 ALTER TABLE `sys_oper_log` DISABLE KEYS */;
INSERT INTO `sys_oper_log` VALUES (100,'个人信息',2,'com.ruoyi.web.controller.system.SysProfileController.updateProfile()','PUT',1,'admin','研发部门','/system/user/profile','127.0.0.1','内网IP','{\"admin\":false,\"email\":\"ry@163.com\",\"nickName\":\"若依\",\"params\":{},\"phonenumber\":\"15888888888\",\"sex\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-31 10:00:19',22),(101,'在线用户',7,'com.ruoyi.web.controller.monitor.SysUserOnlineController.forceLogout()','DELETE',1,'admin','研发部门','/monitor/online/44c1c02f-814b-4f4a-812c-634cf11a9a8c','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-31 10:51:29',2),(102,'用户管理',5,'com.ruoyi.web.controller.system.SysUserController.export()','POST',1,'admin','研发部门','/system/user/export','127.0.0.1','内网IP','{\"pageSize\":\"10\",\"pageNum\":\"1\"}',NULL,0,NULL,'2024-01-31 10:52:04',514),(103,'参数管理',2,'com.ruoyi.web.controller.system.SysConfigController.edit()','PUT',1,'admin','研发部门','/system/config','127.0.0.1','内网IP','{\"configId\":5,\"configKey\":\"sys.account.registerUser\",\"configName\":\"账号自助-是否开启用户注册功能\",\"configType\":\"Y\",\"configValue\":\"true\",\"createBy\":\"admin\",\"createTime\":\"2024-01-30 16:47:13\",\"params\":{},\"remark\":\"是否开启注册用户功能（true开启，false关闭）\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-31 13:49:49',21),(104,'参数管理',2,'com.ruoyi.web.controller.system.SysConfigController.edit()','PUT',1,'admin','研发部门','/system/config','127.0.0.1','内网IP','{\"configId\":4,\"configKey\":\"sys.account.captchaEnabled\",\"configName\":\"账号自助-验证码开关\",\"configType\":\"Y\",\"configValue\":\"false\",\"createBy\":\"admin\",\"createTime\":\"2024-01-30 16:47:13\",\"params\":{},\"remark\":\"是否开启验证码功能（true开启，false关闭）\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-31 13:58:02',14),(105,'用户管理',2,'com.ruoyi.web.controller.system.SysUserController.resetPwd()','PUT',1,'admin','研发部门','/system/user/resetPwd','127.0.0.1','内网IP','{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":2}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-01-31 14:21:53',68),(106,'岗位管理',5,'com.ruoyi.web.controller.system.SysPostController.export()','POST',1,'ry','测试部门','/system/post/export','127.0.0.1','内网IP','{\"pageSize\":\"10\",\"pageNum\":\"1\"}',NULL,0,NULL,'2024-01-31 14:22:50',75),(107,'字典类型',5,'com.ruoyi.web.controller.system.SysDictTypeController.export()','POST',1,'ry','测试部门','/system/dict/type/export','127.0.0.1','内网IP','{\"pageSize\":\"10\",\"pageNum\":\"1\"}',NULL,0,NULL,'2024-01-31 14:23:01',55),(108,'用户头像',2,'com.ruoyi.web.controller.system.SysProfileController.avatar()','POST',1,'admin','研发部门','/system/user/profile/avatar','127.0.0.1','内网IP','','{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2024/06/06/1717680405788_20240606212645A001.png\",\"code\":200}',0,NULL,'2024-06-06 21:26:45',65),(109,'个人信息',2,'com.ruoyi.web.controller.system.SysProfileController.updateProfile()','PUT',1,'admin','研发部门','/system/user/profile','127.0.0.1','内网IP','{\"admin\":true,\"avatar\":\"/profile/avatar/2024/06/06/1717680405788_20240606212645A001.png\",\"createBy\":\"admin\",\"createTime\":\"2024-01-30 16:47:12\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"研发部门\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{\"@type\":\"java.util.HashMap\"},\"parentId\":101,\"status\":\"0\"},\"deptId\":103,\"email\":\"ry@163.com\",\"loginDate\":\"2024-06-06 16:40:21\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"若依\",\"params\":{\"@type\":\"java.util.HashMap\"},\"phonenumber\":\"15888888888\",\"remark\":\"管理员\",\"roles\":[{\"admin\":true,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{\"@type\":\"java.util.HashMap\"},\"roleId\":1,\"roleKey\":\"admin\",\"roleName\":\"超级管理员\",\"roleSort\":1,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"userId\":1,\"userName\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-06-06 21:27:58',16);
/*!40000 ALTER TABLE `sys_oper_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_post`
--

DROP TABLE IF EXISTS `sys_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_post` (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='岗位信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_post`
--

LOCK TABLES `sys_post` WRITE;
/*!40000 ALTER TABLE `sys_post` DISABLE KEYS */;
INSERT INTO `sys_post` VALUES (1,'ceo','董事长',1,'0','admin','2024-01-30 16:47:12','',NULL,''),(2,'se','项目经理',2,'0','admin','2024-01-30 16:47:12','',NULL,''),(3,'hr','人力资源',3,'0','admin','2024-01-30 16:47:12','',NULL,''),(4,'user','普通员工',4,'0','admin','2024-01-30 16:47:12','',NULL,'');
/*!40000 ALTER TABLE `sys_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role` (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
  `status` char(1) NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'超级管理员','admin',1,'1',1,1,'0','0','admin','2024-01-30 16:47:12','',NULL,'超级管理员'),(2,'普通角色','common',2,'2',1,1,'0','0','admin','2024-01-30 16:47:12','',NULL,'普通角色');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_dept`
--

DROP TABLE IF EXISTS `sys_role_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_dept` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色和部门关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_dept`
--

LOCK TABLES `sys_role_dept` WRITE;
/*!40000 ALTER TABLE `sys_role_dept` DISABLE KEYS */;
INSERT INTO `sys_role_dept` VALUES (2,100),(2,101),(2,105);
/*!40000 ALTER TABLE `sys_role_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_menu`
--

DROP TABLE IF EXISTS `sys_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色和菜单关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_menu`
--

LOCK TABLES `sys_role_menu` WRITE;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;
INSERT INTO `sys_role_menu` VALUES (2,1),(2,2),(2,3),(2,4),(2,100),(2,101),(2,102),(2,103),(2,104),(2,105),(2,106),(2,107),(2,108),(2,109),(2,110),(2,111),(2,112),(2,113),(2,114),(2,115),(2,116),(2,117),(2,500),(2,501),(2,1000),(2,1001),(2,1002),(2,1003),(2,1004),(2,1005),(2,1006),(2,1007),(2,1008),(2,1009),(2,1010),(2,1011),(2,1012),(2,1013),(2,1014),(2,1015),(2,1016),(2,1017),(2,1018),(2,1019),(2,1020),(2,1021),(2,1022),(2,1023),(2,1024),(2,1025),(2,1026),(2,1027),(2,1028),(2,1029),(2,1030),(2,1031),(2,1032),(2,1033),(2,1034),(2,1035),(2,1036),(2,1037),(2,1038),(2,1039),(2,1040),(2,1041),(2,1042),(2,1043),(2,1044),(2,1045),(2,1046),(2,1047),(2,1048),(2,1049),(2,1050),(2,1051),(2,1052),(2,1053),(2,1054),(2,1055),(2,1056),(2,1057),(2,1058),(2,1059),(2,1060);
/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) NOT NULL COMMENT '用户账号',
  `user_type` varchar(2) DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) DEFAULT '' COMMENT '手机号码',
  `sex` char(1) DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) DEFAULT 'profile/avatar/new_user.png' COMMENT '头像地址',
  `password` varchar(100) DEFAULT '' COMMENT '密码',
  `status` char(1) DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `nick_name` varchar(30) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,103,'admin','00','furui18114067757@163.com','18114067757','0','/profile/avatar/2024/06/27/1719488594708_20240627194314A008.png','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','172.20.10.11','2024-06-29 09:00:06','admin','2024-01-30 16:47:12','','2024-06-29 09:00:06','管理员','admin'),(2,105,'ry','00','ry@qq.com','15666666666','1','','$2a$10$bCddEcappmMF7ewTtG8o5eMjMSwE9l9m8uw9hPZEMR3h2zokhTpQm','0','2','127.0.0.1','2024-01-31 14:22:08','admin','2024-01-30 16:47:12','admin','2024-01-31 14:22:08','测试员',''),(101,NULL,'123','00','','','0','','$2a$10$VAhuhd6mQIOqoi1qXGK.6.IHLt6ncfIZO5kxFDqq0fwxglC8KDgFC','0','2','',NULL,'','2024-06-06 16:44:53','',NULL,NULL,''),(102,NULL,'123456','00','','','0','','$2a$10$D3rTecLCj.GZyxBd75BuwuAfilWGfbBus519BMdT79hzQBjBDKrxq','0','0','127.0.0.1','2024-06-09 15:41:47','','2024-06-07 14:24:41','','2024-06-09 15:41:47',NULL,''),(104,NULL,'2021110670','00','','','0','','$2a$10$8aSTYcN3gr79IfG3rHRTHeSOY447GKtej8z1nfx8syPJCdgtFWedW','0','0','',NULL,'','2024-06-08 15:00:23','',NULL,NULL,''),(105,NULL,'88888888','00','18114067757@qq.com','18111110005','0','/profile/avatar/2024/06/08/1717851281625_20240608205441A001.png','$2a$10$u8qWMQkZNaxYzYFJd0yRvuIXMHvQqsvK9aBhWiEZgPFJzGmk.tkJy','0','2','127.0.0.1','2024-06-08 20:56:15','','2024-06-08 20:54:01','admin','2024-06-16 19:44:52',NULL,'用户已注销'),(106,NULL,'00000000','00','furui3020476927@qq.com','18114067759','0','/profile/avatar/2024/06/08/1717851716230_20240608210156A002.png','$2a$10$N8nTJML.qgYCoWxZe.ou5eh7bfv3Bd9nHrAccB1EHdkDbJjXjxP8G','0','2','127.0.0.1','2024-06-09 20:53:26','','2024-06-08 21:01:13','admin','2024-06-16 19:44:32',NULL,'用户已注销'),(107,NULL,'999','00','999@qq.com','18111110009','0','','$2a$10$2Q3ONTMsoDeiRGLtd4vIk.ZisLzKnpNr98/fvsK6Yq3YOlpkFE2t2','0','2','',NULL,'admin','2024-06-16 19:41:39','',NULL,NULL,'用户已注销'),(108,NULL,'1111','00','11111@qq.com','111','0','','$2a$10$G44VFy2AZMV2GvO6/v0MvOrpXrEZEduRzEG48OBM5/l5qW9TbyLrK','0','2','',NULL,'admin','2024-06-18 18:47:23','',NULL,NULL,'用户已注销'),(109,NULL,'777777','00','','','0','','$2a$10$/sp9Vg9qkrpgwrBA8wvGe.pS9R173.vXXccLRKF5hdAJt9hqlH7eG','0','2','172.20.255.31','2024-06-18 19:59:23','','2024-06-18 19:59:15','','2024-06-18 19:59:22',NULL,'用户已注销'),(110,NULL,'wyd123456','00','','','0','/profile/avatar/2024/06/27/1719486142078_20240627190222A002.png','$2a$10$TPajw9o3SVAgI2nj6/qnJ.3f7wmfLI7nlXbTqyuE3HOM6m5fJLVIO','0','0','172.20.249.208','2024-06-27 20:11:58','','2024-06-27 19:01:14','','2024-06-27 20:11:58',NULL,'111'),(111,NULL,'fr123456','00','','','0','/profile/avatar/2024/06/27/1719486830119_20240627191350A003.png','$2a$10$hfxS3pVcsVkRROIqH4.HWunE1JNoTVUQAoEJIMhLyxBSPz1nGdhcm','0','0','172.20.249.208','2024-06-27 20:34:57','','2024-06-27 19:11:03','','2024-06-27 20:34:57',NULL,'fr123456'),(112,NULL,'yzr123456','00','','','0','/profile/avatar/2024/06/27/1719488551705_20240627194231A007.png','$2a$10$8TU5h6VKlcFNklhVzsuREeGRMMqNKXWkOJH7nng04woSQx3hZRy9S','0','2','172.20.10.3','2024-06-28 22:18:18','','2024-06-27 19:17:51','','2024-06-28 22:18:18',NULL,'用户已注销');
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_history`
--

DROP TABLE IF EXISTS `sys_user_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_history` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) NOT NULL,
  `search_keyword` varchar(255) NOT NULL,
  `results` text,
  `search_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_history`
--

LOCK TABLES `sys_user_history` WRITE;
/*!40000 ALTER TABLE `sys_user_history` DISABLE KEYS */;
INSERT INTO `sys_user_history` VALUES (119,'admin','一加一等于几','\"一加一等于二。\"','2024-06-29 01:00:53'),(120,'admin','2103501有几个人','\"无法确定2103501具体有多少人，因为这个身份证号不包含个人户籍信息。\"','2024-06-29 01:02:53'),(121,'admin','2103501有几个人','\"2103501班级有39个人。因此，这个班级一共有39个人。关于班主任信息，您提供的内容中并未明确提及。\"','2024-06-29 01:03:15'),(122,'admin','今年哪位领导人访问了哈工大','\"今年俄罗斯总统普京访问了哈工大。\"','2024-06-29 01:04:32');
/*!40000 ALTER TABLE `sys_user_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_post`
--

DROP TABLE IF EXISTS `sys_user_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_post` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户与岗位关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_post`
--

LOCK TABLES `sys_user_post` WRITE;
/*!40000 ALTER TABLE `sys_user_post` DISABLE KEYS */;
INSERT INTO `sys_user_post` VALUES (1,1);
/*!40000 ALTER TABLE `sys_user_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_role` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户和角色关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` VALUES (1,1);
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_file`
--

DROP TABLE IF EXISTS `user_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_file` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `upload_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `file_url` varchar(255) NOT NULL,
  `has_upload` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_file`
--

LOCK TABLES `user_file` WRITE;
/*!40000 ALTER TABLE `user_file` DISABLE KEYS */;
INSERT INTO `user_file` VALUES (47,'admin','2103501简介.txt','2024-06-29 01:02:49','http://172.20.10.2:8081/profile/upload/2024/06/29/2103501简介_20240629090248A003.txt',1);
/*!40000 ALTER TABLE `user_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'ry-vue'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-29 14:41:19
