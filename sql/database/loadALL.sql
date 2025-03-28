-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: sports_retail
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) NOT NULL,
  `description` text,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_name` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'category_name','description'),(2,'Athletic Apparel','Clothing and footwear for sports activities'),(3,'Fitness Gear','Gym and workout equipment'),(4,'Outdoor Sports','Equipment for outdoor and adventure sports'),(5,'Accessories','Small sports accessories and protective gear');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_insert_category` BEFORE INSERT ON `categories` FOR EACH ROW BEGIN
    DECLARE next_id INT;
    SELECT IFNULL(MAX(category_id), 0) + 1 INTO next_id FROM categories;
    SET NEW.category_id = next_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_delete_category` BEFORE DELETE ON `categories` FOR EACH ROW BEGIN
    DELETE FROM products WHERE category_id = OLD.category_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `complaints`
--

DROP TABLE IF EXISTS `complaints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `complaints` (
  `complaint_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `product_id` int NOT NULL,
  `complaint` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`complaint_id`),
  KEY `customer_id` (`customer_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `complaints_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE CASCADE,
  CONSTRAINT `complaints_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complaints`
--

LOCK TABLES `complaints` WRITE;
/*!40000 ALTER TABLE `complaints` DISABLE KEYS */;
INSERT INTO `complaints` VALUES (1,3,1,'The football started deflating after just two uses. I expected better quality from this brand.','2025-03-27 23:51:14'),(2,7,5,'The running shoes are very uncomfortable. The cushioning feels hard and hurts my feet.','2025-03-27 23:51:14'),(3,10,8,'The treadmill makes a loud squeaking noise when in use. It’s very distracting while running.','2025-03-27 23:51:14'),(4,12,6,'Compression shorts material is too thin and loses elasticity after a few washes. Not worth it.','2025-03-27 23:51:14'),(5,15,2,'The basketball doesn’t bounce properly. It feels like it loses air too quickly during play.','2025-03-27 23:51:14'),(6,4,9,'The dumbbells have a strong chemical smell and the grip is uncomfortable for longer workouts.','2025-03-27 23:51:14'),(7,18,13,'The camping tent is smaller than advertised. It barely fits two people, let alone three.','2025-03-27 23:51:14'),(8,9,16,'The knee pads feel very flimsy. The padding is too thin to provide proper protection.','2025-03-27 23:51:14'),(9,1,10,'The resistance bands snapped after only two weeks of use. Really poor durability.','2025-03-27 23:51:14'),(10,5,3,'The tennis racket strings broke after a few games. Expected better quality for this price.','2025-03-27 23:51:14'),(11,20,7,'Gym gloves stitching is coming apart after a few workouts. Feels cheaply made.','2025-03-27 23:51:14'),(12,14,12,'The cycling helmet strap is uncomfortable and keeps loosening while riding. Unsafe to use.','2025-03-27 23:51:14'),(13,6,4,'Badminton shuttlecocks are not durable. Feathers come apart after a few rounds of play.','2025-03-27 23:51:14'),(14,2,14,'The climbing rope frays easily. I don’t trust it for safety. Not good for serious climbers.','2025-03-27 23:51:14'),(15,11,18,'The tennis balls lost their bounce after just a few matches. Not worth the price.','2025-03-27 23:51:14'),(16,19,22,'The skateboard deck started cracking after a few weeks. Expected better quality materials.','2025-03-27 23:51:14'),(17,8,25,'Shin guards are too stiff and uncomfortable. Hard to wear for long matches.','2025-03-27 23:51:14'),(18,16,29,'The jump rope handles broke within days. The rope itself feels cheap and flimsy.','2025-03-27 23:51:14'),(19,17,27,'The golf club has a bad grip and feels off-balanced. Not good for professional use.','2025-03-27 23:51:14'),(20,13,15,'Swimming goggles fog up instantly. The anti-fog coating does not work at all.','2025-03-27 23:51:14'),(21,21,13,'bad','2025-03-28 11:26:18');
/*!40000 ALTER TABLE `complaints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'John Doe','johndoe@example.com','111-222-3333','2025-03-27 23:15:52'),(2,'Jane Smith','janesmith@example.com','222-333-4444','2025-03-27 23:15:52'),(3,'Michael Johnson','michaelj@example.com','333-444-5555','2025-03-27 23:15:52'),(4,'Emily Davis','emilyd@example.com','444-555-6666','2025-03-27 23:15:52'),(5,'Daniel Brown','danielb@example.com','555-666-7777','2025-03-27 23:15:52'),(6,'Olivia Wilson','oliviaw@example.com','666-777-8888','2025-03-27 23:15:52'),(7,'William Taylor','williamt@example.com','777-888-9999','2025-03-27 23:15:52'),(8,'Sophia Anderson','sophiaa@example.com','888-999-0000','2025-03-27 23:15:52'),(9,'James Martinez','jamesm@example.com','999-000-1111','2025-03-27 23:15:52'),(10,'Isabella Thomas','isabellat@example.com','000-111-2222','2025-03-27 23:15:52'),(11,'Liam Garcia','liamg@example.com','111-222-3334','2025-03-27 23:15:52'),(12,'Emma Rodriguez','emmar@example.com','222-333-4445','2025-03-27 23:15:52'),(13,'Benjamin Lee','benjaminl@example.com','333-444-5556','2025-03-27 23:15:52'),(14,'Mia Walker','miaw@example.com','444-555-6667','2025-03-27 23:15:52'),(15,'Ethan Hall','ethanh@example.com','555-666-7778','2025-03-27 23:15:52'),(16,'Charlotte Young','charlottey@example.com','666-777-8889','2025-03-27 23:15:52'),(17,'Alexander Allen','alexandera@example.com','777-888-9990','2025-03-27 23:15:52'),(18,'Amelia Scott','amelias@example.com','888-999-0001','2025-03-27 23:15:52'),(19,'Henry Green','henryg@example.com','999-000-1112','2025-03-27 23:15:52'),(20,'Lucas Adams','lucasa@example.com','000-111-2223','2025-03-27 23:15:52'),(21,'Chris Taylor','christaylor@example.com','999-000-1111','2025-03-28 11:25:44');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_insert_customer` BEFORE INSERT ON `customers` FOR EACH ROW BEGIN
    DECLARE next_id INT;
    SELECT IFNULL(MAX(customer_id), 0) + 1 INTO next_id FROM customers;
    SET NEW.customer_id = next_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `discounts`
--

DROP TABLE IF EXISTS `discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discounts` (
  `discount_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `discount_percentage` decimal(5,2) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  PRIMARY KEY (`discount_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `discounts_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE,
  CONSTRAINT `discounts_chk_1` CHECK ((`discount_percentage` between 0 and 100))
) ENGINE=InnoDB AUTO_INCREMENT=205 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discounts`
--

LOCK TABLES `discounts` WRITE;
/*!40000 ALTER TABLE `discounts` DISABLE KEYS */;
INSERT INTO `discounts` VALUES (2,3,7.38,'2025-09-20','2025-10-07'),(3,19,38.82,'2025-06-05','2025-07-02'),(4,27,27.31,'2025-11-21','2025-12-08'),(5,2,45.94,'2025-06-22','2025-07-10'),(6,23,34.04,'2025-03-16','2025-04-12'),(7,8,8.38,'2025-10-24','2025-11-16'),(8,26,32.22,'2025-07-23','2025-07-31'),(9,16,29.75,'2025-08-08','2025-08-26'),(10,2,48.76,'2025-10-21','2025-11-07'),(11,19,10.38,'2025-03-26','2025-04-11'),(12,30,47.52,'2025-09-26','2025-10-24'),(13,8,17.21,'2025-03-27','2025-04-17'),(14,26,37.90,'2025-08-21','2025-09-20'),(15,2,35.53,'2025-09-15','2025-09-28'),(16,22,7.22,'2025-02-08','2025-02-18'),(17,27,21.70,'2025-09-14','2025-10-11'),(18,2,19.47,'2025-10-15','2025-10-31'),(19,12,9.07,'2025-01-10','2025-01-23'),(20,20,34.74,'2025-10-10','2025-11-08'),(21,12,39.77,'2025-12-06','2025-12-27'),(22,27,22.84,'2025-04-21','2025-05-12'),(23,22,49.82,'2025-09-07','2025-09-18'),(24,27,24.25,'2025-10-02','2025-10-25'),(25,24,32.22,'2025-07-22','2025-08-14'),(26,20,49.54,'2025-07-11','2025-08-10'),(27,10,50.00,'2025-04-10','2025-04-19'),(28,21,10.25,'2025-11-24','2025-12-15'),(29,16,13.10,'2025-11-13','2025-12-03'),(30,13,15.78,'2025-08-05','2025-08-12'),(31,23,25.47,'2025-02-11','2025-03-09'),(32,18,5.60,'2025-04-17','2025-05-01'),(33,17,5.99,'2025-05-10','2025-05-21'),(34,15,45.50,'2025-06-24','2025-07-01'),(35,5,16.98,'2025-08-07','2025-08-26'),(36,20,15.15,'2025-10-13','2025-11-01'),(37,10,47.52,'2025-07-20','2025-07-28'),(38,19,32.84,'2025-02-04','2025-02-23'),(39,12,41.38,'2025-08-07','2025-09-03'),(40,2,40.76,'2025-02-22','2025-03-21'),(41,16,10.11,'2025-04-18','2025-05-03'),(42,19,26.62,'2025-08-16','2025-09-15'),(43,18,23.15,'2025-05-17','2025-06-02'),(44,20,34.06,'2025-12-10','2025-12-31'),(45,16,10.36,'2025-09-01','2025-10-01'),(46,5,18.44,'2025-02-06','2025-03-05'),(47,6,33.71,'2025-04-15','2025-05-03'),(48,23,10.90,'2025-03-08','2025-03-30'),(49,22,29.53,'2025-04-17','2025-05-04'),(50,7,47.92,'2025-05-24','2025-06-16'),(51,9,12.52,'2025-01-23','2025-02-07'),(52,8,21.50,'2025-05-23','2025-06-17'),(53,27,42.97,'2025-01-23','2025-02-20'),(54,12,20.37,'2025-12-22','2026-01-11'),(55,23,18.96,'2025-12-12','2026-01-03'),(56,16,29.61,'2025-09-14','2025-09-26'),(57,26,38.51,'2025-11-18','2025-12-09'),(58,10,6.57,'2025-02-23','2025-03-23'),(59,19,24.63,'2025-05-26','2025-06-21'),(60,6,44.71,'2025-12-15','2025-12-22'),(61,15,30.86,'2025-03-01','2025-03-09'),(62,13,7.62,'2025-11-24','2025-12-01'),(63,16,24.23,'2025-05-11','2025-06-07'),(64,30,29.18,'2025-09-15','2025-10-08'),(65,24,27.02,'2025-04-15','2025-05-06'),(66,28,30.93,'2025-03-11','2025-03-24'),(67,8,45.21,'2025-08-08','2025-09-01'),(68,26,38.66,'2025-07-26','2025-08-04'),(69,20,13.58,'2025-02-16','2025-03-06'),(70,25,21.61,'2025-11-06','2025-11-28'),(71,13,17.55,'2025-04-15','2025-05-09'),(72,3,40.52,'2025-08-17','2025-09-12'),(73,26,24.50,'2025-04-22','2025-05-16'),(74,26,24.03,'2025-12-13','2026-01-08'),(75,29,28.62,'2025-09-23','2025-10-17'),(76,2,13.87,'2025-09-28','2025-10-23'),(77,28,39.93,'2025-11-13','2025-12-05'),(78,21,28.08,'2025-10-23','2025-11-04'),(79,26,34.75,'2025-06-20','2025-06-30'),(80,21,37.37,'2025-03-27','2025-04-12'),(81,26,39.58,'2025-06-02','2025-06-28'),(82,29,11.36,'2025-02-27','2025-03-19'),(83,22,39.45,'2025-08-08','2025-08-23'),(84,5,36.44,'2025-07-03','2025-07-17'),(85,13,34.29,'2025-04-16','2025-04-24'),(86,9,39.61,'2025-06-26','2025-07-07'),(87,19,11.00,'2025-04-12','2025-05-12'),(88,15,37.75,'2025-07-17','2025-08-04'),(89,15,10.22,'2025-08-07','2025-08-26'),(90,9,25.99,'2025-10-19','2025-11-05'),(91,1,17.94,'2025-03-12','2025-03-27'),(92,25,37.49,'2025-03-27','2025-04-15'),(93,15,11.34,'2025-04-20','2025-05-09'),(94,27,13.50,'2025-01-11','2025-01-23'),(95,18,45.31,'2025-08-20','2025-09-03'),(96,16,5.78,'2025-02-06','2025-03-03'),(97,1,25.23,'2025-09-03','2025-09-12'),(98,29,44.52,'2025-11-02','2025-11-11'),(99,2,19.44,'2025-02-14','2025-02-24'),(100,27,39.82,'2025-11-21','2025-12-01'),(101,20,34.72,'2025-10-22','2025-11-02'),(102,16,44.14,'2025-05-06','2025-05-29'),(103,9,30.72,'2025-02-01','2025-03-03'),(104,12,44.08,'2025-02-12','2025-02-25'),(105,17,45.70,'2025-03-19','2025-04-06'),(106,10,41.66,'2025-12-08','2025-12-20'),(107,17,6.62,'2025-05-18','2025-06-07'),(108,4,7.47,'2025-11-19','2025-12-18'),(109,21,29.08,'2025-11-16','2025-12-08'),(110,18,28.70,'2025-03-21','2025-04-20'),(111,4,36.37,'2025-07-18','2025-08-08'),(112,22,13.95,'2025-06-18','2025-06-25'),(113,8,5.94,'2025-05-09','2025-05-21'),(114,27,9.02,'2025-10-21','2025-11-02'),(115,10,47.80,'2025-07-10','2025-08-06'),(116,22,33.03,'2025-10-21','2025-11-11'),(117,29,6.81,'2025-11-20','2025-12-12'),(118,29,44.96,'2025-11-27','2025-12-22'),(119,24,22.68,'2025-12-26','2026-01-06'),(120,1,28.76,'2025-04-10','2025-04-17'),(121,22,41.36,'2025-03-24','2025-04-07'),(122,13,20.63,'2025-05-28','2025-06-10'),(123,10,7.57,'2025-03-02','2025-03-29'),(124,25,20.80,'2025-11-14','2025-11-26'),(125,17,14.12,'2025-04-08','2025-04-23'),(126,8,19.17,'2025-02-05','2025-03-06'),(127,1,8.22,'2025-11-02','2025-11-30'),(128,25,22.16,'2025-10-25','2025-11-22'),(129,10,44.89,'2025-04-08','2025-05-03'),(130,9,31.20,'2025-03-02','2025-03-30'),(131,27,24.76,'2025-10-25','2025-11-21'),(132,15,36.48,'2025-03-13','2025-04-12'),(133,26,12.31,'2025-07-05','2025-07-13'),(134,16,6.54,'2025-05-16','2025-05-27'),(135,22,10.27,'2025-01-19','2025-02-06'),(136,12,46.35,'2025-07-20','2025-08-08'),(137,1,26.69,'2025-01-09','2025-01-31'),(138,11,6.95,'2025-12-06','2025-12-22'),(139,7,46.37,'2025-07-04','2025-07-20'),(140,26,22.87,'2025-05-19','2025-06-15'),(141,29,10.65,'2025-04-10','2025-04-27'),(142,15,9.50,'2025-10-19','2025-11-09'),(143,4,39.95,'2025-08-18','2025-09-06'),(144,3,46.82,'2025-04-18','2025-05-03'),(145,27,9.12,'2025-10-01','2025-10-13'),(146,30,18.98,'2025-08-17','2025-09-09'),(147,1,13.21,'2025-01-04','2025-01-26'),(148,30,10.60,'2025-12-17','2026-01-05'),(149,30,32.55,'2025-12-10','2025-12-23'),(150,18,36.61,'2025-04-24','2025-05-17'),(151,23,34.61,'2025-12-10','2025-12-25'),(152,9,18.34,'2025-09-24','2025-10-09'),(153,28,47.95,'2025-09-13','2025-10-06'),(154,6,9.96,'2025-03-10','2025-04-09'),(155,1,6.38,'2025-08-10','2025-08-30'),(156,14,35.73,'2025-11-07','2025-11-23'),(157,12,42.12,'2025-07-20','2025-08-17'),(158,4,36.66,'2025-06-04','2025-06-21'),(159,25,9.24,'2025-07-27','2025-08-15'),(160,8,6.17,'2025-03-08','2025-04-05'),(161,29,22.52,'2025-05-12','2025-05-31'),(162,4,46.57,'2025-04-26','2025-05-06'),(163,5,40.94,'2025-03-22','2025-04-12'),(164,16,18.42,'2025-04-11','2025-04-28'),(165,20,5.45,'2025-06-05','2025-06-24'),(166,9,39.28,'2025-03-26','2025-04-24'),(167,12,34.83,'2025-12-06','2026-01-04'),(168,19,24.76,'2025-04-04','2025-04-26'),(169,14,17.35,'2025-09-09','2025-09-23'),(170,17,12.83,'2025-08-26','2025-09-13'),(171,6,43.81,'2025-11-16','2025-12-15'),(172,2,9.51,'2025-05-26','2025-06-10'),(173,11,43.96,'2025-06-14','2025-06-22'),(174,9,20.18,'2025-05-12','2025-05-21'),(175,28,28.28,'2025-03-08','2025-03-17'),(176,2,43.82,'2025-03-25','2025-04-21'),(177,20,46.21,'2025-11-19','2025-12-15'),(178,16,45.38,'2025-12-25','2026-01-10'),(179,20,40.26,'2025-11-10','2025-12-08'),(180,22,5.83,'2025-02-17','2025-03-11'),(181,2,39.03,'2025-05-07','2025-05-22'),(182,18,40.10,'2025-06-27','2025-07-13'),(183,22,27.26,'2025-07-21','2025-08-11'),(184,6,23.20,'2025-02-18','2025-03-16'),(185,20,22.01,'2025-03-28','2025-04-06'),(186,14,22.31,'2025-06-13','2025-07-09'),(187,4,36.14,'2025-07-19','2025-07-31'),(188,21,20.30,'2025-09-09','2025-10-01'),(189,26,22.47,'2025-08-09','2025-09-05'),(190,19,16.15,'2025-04-09','2025-04-21'),(191,24,34.42,'2025-09-10','2025-10-05'),(192,2,19.87,'2025-11-22','2025-12-22'),(193,26,42.84,'2025-07-17','2025-08-03'),(194,6,16.19,'2025-09-28','2025-10-13'),(195,16,30.67,'2025-03-24','2025-04-20'),(196,17,8.15,'2025-02-18','2025-02-26'),(197,8,47.18,'2025-08-11','2025-08-24'),(198,27,22.61,'2025-11-18','2025-12-14'),(199,30,15.69,'2025-03-04','2025-03-16'),(200,29,47.13,'2025-10-14','2025-10-26'),(201,3,15.00,'2024-04-01','2024-04-30'),(202,1,30.00,'2025-03-01','2025-03-31');
/*!40000 ALTER TABLE `discounts` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_insert_discount` BEFORE INSERT ON `discounts` FOR EACH ROW BEGIN
    DECLARE next_id INT;
    SELECT IFNULL(MAX(discount_id), 0) + 1 INTO next_id FROM discounts;
    SET NEW.discount_id = next_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `max_discounts`
--

DROP TABLE IF EXISTS `max_discounts`;
/*!50001 DROP VIEW IF EXISTS `max_discounts`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `max_discounts` AS SELECT 
 1 AS `product_id`,
 1 AS `max_discount`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `order_item_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int DEFAULT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_chk_1` CHECK ((`quantity` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=605 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,176,15,4,24.99),(2,59,8,5,899.99),(3,81,18,5,14.99),(4,21,4,4,12.99),(5,96,3,4,89.99),(6,28,6,4,29.99),(7,105,20,5,59.99),(8,147,30,3,89.99),(9,159,25,4,19.99),(10,101,4,3,12.99),(11,180,7,2,19.99),(12,155,14,1,99.99),(13,113,9,2,49.99),(14,11,20,5,59.99),(15,94,30,5,89.99),(16,151,11,4,79.99),(17,94,4,3,12.99),(18,17,3,5,89.99),(19,56,23,4,49.99),(20,61,18,5,14.99),(21,50,30,3,89.99),(22,159,30,4,89.99),(24,130,19,2,34.99),(25,187,30,5,89.99),(26,143,14,1,99.99),(27,2,13,3,149.99),(28,5,21,3,39.99),(29,63,16,5,18.99),(30,177,10,4,14.99),(31,188,21,1,39.99),(32,62,6,3,29.99),(33,75,2,2,39.99),(34,125,1,2,49.99),(35,1,22,5,89.99),(36,190,24,1,39.99),(37,156,4,1,12.99),(38,181,15,5,24.99),(39,32,17,1,9.99),(40,59,15,5,24.99),(41,127,8,2,899.99),(42,83,25,5,19.99),(43,189,19,3,34.99),(44,107,11,4,79.99),(45,136,3,1,89.99),(46,152,16,1,18.99),(47,15,22,5,89.99),(48,133,26,4,129.99),(49,39,13,1,149.99),(50,97,21,2,39.99),(51,153,13,2,149.99),(52,8,23,3,49.99),(53,126,2,5,39.99),(54,160,19,3,34.99),(55,47,16,4,18.99),(56,155,19,2,34.99),(57,71,29,5,12.99),(58,106,5,4,119.99),(59,166,19,4,34.99),(60,58,21,2,39.99),(61,140,20,1,59.99),(62,109,30,4,89.99),(63,60,6,1,29.99),(64,197,28,3,29.99),(65,145,27,1,179.99),(66,9,22,4,89.99),(67,141,18,4,14.99),(68,79,2,1,39.99),(69,42,17,3,9.99),(70,124,20,3,59.99),(71,45,23,3,49.99),(72,56,2,3,39.99),(73,114,15,3,24.99),(74,3,19,2,34.99),(75,90,6,1,29.99),(76,58,12,3,45.99),(77,48,1,5,49.99),(78,20,19,5,34.99),(79,193,11,4,79.99),(80,7,20,2,59.99),(81,88,12,5,45.99),(82,169,23,5,49.99),(83,134,26,5,129.99),(84,22,28,3,29.99),(85,30,25,2,19.99),(86,51,27,5,179.99),(87,118,18,2,14.99),(88,112,23,3,49.99),(89,104,29,3,12.99),(90,52,15,5,24.99),(91,152,3,4,89.99),(92,188,15,3,24.99),(93,156,2,5,39.99),(94,162,7,2,19.99),(95,134,28,2,29.99),(96,129,15,2,24.99),(97,84,14,3,99.99),(98,55,9,4,49.99),(99,4,7,4,19.99),(100,180,6,3,29.99),(101,91,3,5,89.99),(102,153,7,1,19.99),(103,165,8,2,899.99),(104,97,17,1,9.99),(105,138,20,2,59.99),(106,19,23,4,49.99),(107,164,7,4,19.99),(108,135,30,1,89.99),(109,165,1,4,49.99),(110,6,18,5,14.99),(111,64,30,5,89.99),(112,136,7,2,19.99),(113,32,16,3,18.99),(114,144,12,1,45.99),(115,70,7,2,19.99),(116,190,11,4,79.99),(117,54,16,1,18.99),(118,173,26,1,129.99),(119,60,8,4,899.99),(120,138,14,3,99.99),(121,177,9,5,49.99),(122,54,25,2,19.99),(123,174,5,3,119.99),(124,172,2,5,39.99),(125,17,10,4,14.99),(126,130,26,1,129.99),(127,52,22,3,89.99),(128,83,2,4,39.99),(129,2,15,3,24.99),(130,9,24,5,39.99),(131,164,6,5,29.99),(132,31,30,3,89.99),(133,130,20,5,59.99),(134,29,23,5,49.99),(135,14,8,3,899.99),(136,87,25,2,19.99),(137,185,12,1,45.99),(138,140,2,2,39.99),(139,92,12,1,45.99),(140,151,30,2,89.99),(141,151,23,1,49.99),(142,88,9,5,49.99),(143,43,27,1,179.99),(144,176,13,1,149.99),(145,145,11,4,79.99),(146,96,13,1,149.99),(147,112,12,1,45.99),(148,189,28,5,29.99),(149,126,15,5,24.99),(150,9,26,4,129.99),(151,200,20,3,59.99),(152,33,27,2,179.99),(153,6,19,3,34.99),(154,69,30,2,89.99),(155,180,10,1,14.99),(156,174,17,3,9.99),(157,31,1,3,49.99),(158,93,8,3,899.99),(159,164,28,5,29.99),(160,42,28,3,29.99),(161,93,26,1,129.99),(162,58,27,2,179.99),(163,27,23,2,49.99),(164,24,4,5,12.99),(165,23,26,1,129.99),(166,150,7,3,19.99),(167,77,6,2,29.99),(168,147,5,4,119.99),(169,72,8,2,899.99),(170,134,19,4,34.99),(171,38,28,3,29.99),(172,84,11,2,79.99),(173,196,6,2,29.99),(174,78,21,1,39.99),(175,184,1,5,49.99),(176,40,1,5,49.99),(177,132,30,2,89.99),(178,104,14,3,99.99),(179,56,25,1,19.99),(180,159,13,3,149.99),(181,167,17,4,9.99),(182,76,10,1,14.99),(183,84,1,4,49.99),(184,30,29,2,12.99),(185,160,11,2,79.99),(186,1,10,1,14.99),(187,27,18,4,14.99),(188,124,12,1,45.99),(189,76,6,5,29.99),(190,146,29,1,12.99),(191,185,17,4,9.99),(192,111,26,5,129.99),(193,77,1,1,49.99),(194,95,29,3,12.99),(195,7,20,4,59.99),(196,49,26,2,129.99),(197,166,30,2,89.99),(198,87,5,5,119.99),(199,144,29,3,12.99),(200,142,2,4,39.99),(201,3,8,4,899.99),(202,28,20,2,59.99),(203,83,24,3,39.99),(204,54,14,2,99.99),(205,52,12,1,45.99),(206,187,19,4,34.99),(207,89,27,2,179.99),(208,83,28,4,29.99),(209,200,24,4,39.99),(210,56,2,1,39.99),(211,50,3,4,89.99),(212,148,4,2,12.99),(213,163,18,5,14.99),(214,151,2,3,39.99),(215,17,24,5,39.99),(216,50,4,1,12.99),(217,103,17,2,9.99),(218,150,16,1,18.99),(219,67,19,1,34.99),(220,9,10,5,14.99),(221,123,2,5,39.99),(222,10,22,3,89.99),(223,39,6,1,29.99),(224,102,10,4,14.99),(225,148,14,3,99.99),(226,22,13,2,149.99),(227,52,10,4,14.99),(228,101,27,3,179.99),(229,67,26,3,129.99),(230,39,11,4,79.99),(231,42,12,2,45.99),(232,117,27,5,179.99),(233,177,26,5,129.99),(234,153,3,4,89.99),(235,160,17,4,9.99),(236,192,16,2,18.99),(237,3,20,3,59.99),(238,56,9,3,49.99),(239,200,29,4,12.99),(240,198,13,1,149.99),(241,23,28,1,29.99),(242,143,1,1,49.99),(243,191,29,5,12.99),(244,175,25,5,19.99),(245,99,13,2,149.99),(246,30,14,3,99.99),(247,73,15,5,24.99),(248,27,29,5,12.99),(249,65,21,2,39.99),(250,12,12,2,45.99),(251,36,30,1,89.99),(252,14,16,1,18.99),(253,114,28,2,29.99),(254,112,13,3,149.99),(255,67,10,2,14.99),(256,181,28,2,29.99),(257,128,29,2,12.99),(258,132,15,2,24.99),(259,31,22,3,89.99),(260,163,9,2,49.99),(261,17,28,1,29.99),(262,192,22,5,89.99),(263,104,26,4,129.99),(264,26,18,2,14.99),(265,85,25,4,19.99),(266,29,28,1,29.99),(267,20,29,5,12.99),(268,106,21,3,39.99),(269,24,7,2,19.99),(270,184,18,5,14.99),(271,163,15,4,24.99),(272,122,26,3,129.99),(273,59,10,3,14.99),(274,57,18,3,14.99),(275,106,18,5,14.99),(276,150,3,5,89.99),(277,67,21,3,39.99),(278,165,10,4,14.99),(279,120,19,2,34.99),(280,67,12,5,45.99),(281,69,22,3,89.99),(282,51,1,2,49.99),(283,52,23,4,49.99),(284,16,23,5,49.99),(285,56,26,4,129.99),(286,199,6,5,29.99),(287,109,7,5,19.99),(288,122,18,3,14.99),(289,20,25,4,19.99),(290,88,8,1,899.99),(291,183,1,1,49.99),(292,109,4,1,12.99),(293,128,26,4,129.99),(294,166,28,5,29.99),(295,156,9,2,49.99),(296,160,7,2,19.99),(297,177,2,1,39.99),(298,148,9,2,49.99),(299,167,27,4,179.99),(300,67,28,3,29.99),(301,60,11,5,79.99),(302,133,16,4,18.99),(303,17,13,2,149.99),(304,150,19,2,34.99),(305,11,6,3,29.99),(306,60,1,3,49.99),(307,34,16,3,18.99),(308,183,18,4,14.99),(309,120,7,3,19.99),(310,38,28,4,29.99),(311,115,17,3,9.99),(312,119,28,2,29.99),(313,51,18,1,14.99),(314,165,18,1,14.99),(315,75,22,5,89.99),(316,178,16,5,18.99),(317,14,14,3,99.99),(318,38,14,5,99.99),(319,108,29,2,12.99),(320,188,6,2,29.99),(321,196,13,5,149.99),(322,154,28,4,29.99),(323,113,25,3,19.99),(324,35,10,5,14.99),(325,138,27,2,179.99),(326,9,30,2,89.99),(327,90,24,3,39.99),(328,74,25,1,19.99),(329,97,12,4,45.99),(330,97,16,3,18.99),(331,76,3,1,89.99),(332,166,10,2,14.99),(333,60,6,3,29.99),(334,163,19,5,34.99),(335,94,16,3,18.99),(336,198,8,2,899.99),(337,144,9,5,49.99),(338,189,13,2,149.99),(339,83,8,3,899.99),(340,178,10,5,14.99),(341,94,9,1,49.99),(342,76,17,3,9.99),(343,194,10,3,14.99),(344,49,1,5,49.99),(345,116,1,1,49.99),(346,146,9,4,49.99),(347,162,8,1,899.99),(348,76,23,4,49.99),(349,49,30,3,89.99),(350,60,26,4,129.99),(351,86,10,1,14.99),(352,57,14,5,99.99),(353,30,2,1,39.99),(354,107,11,2,79.99),(355,21,4,2,12.99),(356,131,9,3,49.99),(357,104,27,2,179.99),(358,90,6,1,29.99),(359,7,13,4,149.99),(360,88,17,2,9.99),(361,36,19,3,34.99),(362,195,20,2,59.99),(363,87,16,1,18.99),(364,65,24,3,39.99),(365,67,13,4,149.99),(366,189,3,1,89.99),(367,144,13,5,149.99),(368,62,19,3,34.99),(369,128,7,3,19.99),(370,99,30,2,89.99),(371,125,23,2,49.99),(372,65,2,4,39.99),(373,147,13,3,149.99),(374,65,12,4,45.99),(375,170,29,3,12.99),(376,198,29,3,12.99),(377,194,29,2,12.99),(378,122,10,3,14.99),(379,39,8,3,899.99),(380,21,17,4,9.99),(381,108,6,1,29.99),(382,43,6,2,29.99),(383,96,28,1,29.99),(384,158,30,5,89.99),(385,82,30,3,89.99),(386,8,13,1,149.99),(387,28,20,2,59.99),(388,172,24,1,39.99),(389,44,16,5,18.99),(390,125,29,2,12.99),(391,50,19,5,34.99),(392,93,21,1,39.99),(393,152,28,2,29.99),(394,29,10,3,14.99),(395,146,2,1,39.99),(396,64,13,1,149.99),(397,187,27,4,179.99),(398,181,4,3,12.99),(399,70,2,4,39.99),(400,172,30,2,89.99),(401,59,16,3,18.99),(402,183,26,1,129.99),(403,75,4,2,12.99),(404,42,6,2,29.99),(405,13,1,3,49.99),(406,28,27,3,179.99),(407,26,16,2,18.99),(408,10,16,1,18.99),(409,93,19,1,34.99),(410,35,15,1,24.99),(411,110,26,3,129.99),(412,11,2,5,39.99),(413,10,8,1,899.99),(414,4,22,5,89.99),(415,178,2,4,39.99),(416,142,2,4,39.99),(417,44,28,1,29.99),(418,17,29,5,12.99),(419,193,8,1,899.99),(420,32,28,3,29.99),(421,183,19,3,34.99),(422,136,17,5,9.99),(423,176,18,1,14.99),(424,6,15,4,24.99),(425,161,12,3,45.99),(426,32,6,4,29.99),(427,109,5,2,119.99),(428,67,16,5,18.99),(429,67,13,3,149.99),(430,132,27,5,179.99),(431,42,5,1,119.99),(432,88,26,5,129.99),(433,54,4,3,12.99),(434,186,4,2,12.99),(435,196,19,2,34.99),(436,70,25,3,19.99),(437,188,7,5,19.99),(438,60,18,1,14.99),(439,171,18,4,14.99),(440,140,8,5,899.99),(441,108,23,3,49.99),(442,38,5,2,119.99),(443,152,9,3,49.99),(444,19,30,1,89.99),(445,64,3,2,89.99),(446,182,11,5,79.99),(447,5,16,1,18.99),(448,178,27,4,179.99),(449,126,19,2,34.99),(450,95,14,4,99.99),(451,163,28,1,29.99),(452,82,30,5,89.99),(453,16,29,5,12.99),(454,144,5,5,119.99),(455,47,19,2,34.99),(456,126,1,4,49.99),(457,55,27,5,179.99),(458,33,3,5,89.99),(459,32,19,3,34.99),(460,182,22,4,89.99),(461,105,24,5,39.99),(462,82,25,4,19.99),(463,98,21,1,39.99),(464,33,18,5,14.99),(465,152,14,5,99.99),(466,35,27,4,179.99),(467,59,29,1,12.99),(468,196,2,3,39.99),(469,26,21,1,39.99),(470,177,24,4,39.99),(471,103,5,5,119.99),(472,117,29,2,12.99),(473,183,5,4,119.99),(474,135,28,1,29.99),(475,29,19,4,34.99),(476,37,13,4,149.99),(477,105,21,5,39.99),(478,98,4,2,12.99),(479,42,4,3,12.99),(480,158,13,2,149.99),(481,101,20,4,59.99),(482,11,3,4,89.99),(483,3,3,4,89.99),(484,68,21,1,39.99),(485,157,16,3,18.99),(486,32,12,4,45.99),(487,53,3,4,89.99),(488,23,17,1,9.99),(489,186,7,4,19.99),(490,30,7,3,19.99),(491,163,21,3,39.99),(492,130,29,3,12.99),(493,56,29,2,12.99),(494,82,1,2,49.99),(495,60,24,1,39.99),(496,4,24,1,39.99),(497,109,8,4,899.99),(498,84,15,1,24.99),(499,25,28,1,29.99),(500,79,28,5,29.99),(501,89,29,1,12.99),(502,143,24,2,39.99),(503,196,21,2,39.99),(504,165,30,3,89.99),(505,181,28,2,29.99),(506,179,25,1,19.99),(507,79,30,2,89.99),(508,41,15,2,24.99),(509,22,8,2,899.99),(510,48,9,4,49.99),(511,145,4,5,12.99),(512,145,10,5,14.99),(513,51,29,4,12.99),(514,25,23,2,49.99),(515,114,20,3,59.99),(516,84,29,2,12.99),(517,49,9,3,49.99),(518,197,6,5,29.99),(519,78,18,5,14.99),(520,153,24,5,39.99),(521,93,13,3,149.99),(522,19,11,2,79.99),(523,132,13,4,149.99),(524,29,5,3,119.99),(525,168,24,1,39.99),(526,69,13,5,149.99),(527,92,1,4,49.99),(528,44,25,2,19.99),(529,122,23,1,49.99),(530,177,22,3,89.99),(531,72,3,1,89.99),(532,155,29,4,12.99),(533,20,10,2,14.99),(534,34,5,4,119.99),(535,84,15,4,24.99),(536,10,22,3,89.99),(537,164,2,3,39.99),(538,190,7,2,19.99),(539,1,25,2,19.99),(540,107,15,2,24.99),(541,82,30,5,89.99),(542,98,13,4,149.99),(543,36,26,2,129.99),(544,13,17,1,9.99),(545,46,13,2,149.99),(546,185,10,4,14.99),(547,107,20,4,59.99),(548,162,1,5,49.99),(549,141,14,1,99.99),(550,109,21,2,39.99),(551,104,27,5,179.99),(552,139,16,4,18.99),(553,92,8,5,899.99),(554,134,4,4,12.99),(555,193,3,5,89.99),(556,63,26,1,129.99),(557,183,14,2,99.99),(558,93,30,5,89.99),(559,37,7,2,19.99),(560,81,19,1,34.99),(561,162,3,1,89.99),(562,73,21,2,39.99),(563,200,23,5,49.99),(564,133,23,2,49.99),(565,40,8,1,899.99),(566,112,3,5,89.99),(567,128,13,3,149.99),(568,17,9,5,49.99),(569,46,12,5,45.99),(570,103,6,3,29.99),(571,169,20,2,59.99),(572,187,30,2,89.99),(573,36,1,1,49.99),(574,95,28,1,29.99),(575,89,24,4,39.99),(576,6,16,3,18.99),(577,62,2,1,39.99),(578,47,20,2,59.99),(579,134,12,5,45.99),(580,116,25,2,19.99),(581,135,28,5,29.99),(582,51,19,5,34.99),(583,126,14,5,99.99),(584,20,6,2,29.99),(585,138,1,5,49.99),(586,59,18,4,14.99),(587,76,11,3,79.99),(588,172,19,2,34.99),(589,6,7,5,19.99),(590,22,2,2,39.99),(591,52,4,4,12.99),(592,18,2,4,39.99),(593,25,19,3,34.99),(594,13,9,3,49.99),(595,126,21,1,39.99),(596,157,1,3,49.99),(597,163,21,1,39.99),(598,130,29,3,12.99),(599,160,21,5,39.99),(600,95,17,1,9.99),(601,201,6,10,29.99),(602,202,20,10,59.99),(603,203,6,3,29.99);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_insert_order_items_unit_price` BEFORE INSERT ON `order_items` FOR EACH ROW BEGIN
    DECLARE actual_price DECIMAL(10,2);

    SELECT price INTO actual_price
    FROM products
    WHERE product_id = NEW.product_id;

    SET NEW.unit_price = actual_price;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_insert_order_item_stock_check` BEFORE INSERT ON `order_items` FOR EACH ROW BEGIN
    DECLARE available_stock INT;

    SELECT stock_quantity INTO available_stock
    FROM products
    WHERE product_id = NEW.product_id;

    IF available_stock < NEW.quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient stock for this product!';
    ELSE
        UPDATE products
        SET stock_quantity = stock_quantity - NEW.quantity
        WHERE product_id = NEW.product_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_insert_order_item` BEFORE INSERT ON `order_items` FOR EACH ROW BEGIN
    DECLARE next_id INT;
    SELECT IFNULL(MAX(order_item_id), 0) + 1 INTO next_id FROM order_items;
    SET NEW.order_item_id = next_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_insert_order_items_total_sum` AFTER INSERT ON `order_items` FOR EACH ROW BEGIN
    DECLARE discount DECIMAL(5,2);
    DECLARE order_total DECIMAL(10,2);

    DECLARE order_date TIMESTAMP;
    SELECT order_date INTO order_date FROM orders WHERE order_id = NEW.order_id;

    SELECT COALESCE(MAX(md.max_discount), 0) INTO discount
    FROM max_discounts md
    WHERE md.product_id = NEW.product_id;

    SET order_total = NEW.quantity * NEW.unit_price * (1 - discount / 100);

    UPDATE orders 
    SET total_amount = (
        SELECT SUM(oi.quantity * oi.unit_price * (1 - COALESCE(md.max_discount, 0) / 100))
        FROM order_items oi
        LEFT JOIN max_discounts md ON oi.product_id = md.product_id
        WHERE oi.order_id = NEW.order_id
    )
    WHERE order_id = NEW.order_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_delete_order_items_total_sum` AFTER DELETE ON `order_items` FOR EACH ROW BEGIN
    DECLARE discount DECIMAL(5,2);
    DECLARE item_total DECIMAL(10,2);

    DECLARE order_date TIMESTAMP;
    SELECT order_date INTO order_date FROM orders WHERE order_id = OLD.order_id;

    SELECT COALESCE(MAX(md.max_discount), 0) INTO discount
    FROM max_discounts md
    WHERE md.product_id = OLD.product_id;

    SET item_total = OLD.quantity * OLD.unit_price * (1 - discount / 100);

    UPDATE orders 
    SET total_amount = total_amount - item_total
    WHERE order_id = OLD.order_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `total_amount` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `idx_order_date` (`order_date`),
  KEY `idx_order_customer` (`customer_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,11,'2025-10-06 22:23:51',30513.80),(2,4,'2025-09-02 12:46:11',15217.88),(3,3,'2025-02-04 10:17:38',236757.69),(4,15,'2025-08-04 06:53:40',30360.75),(5,3,'2025-07-02 15:29:17',5181.53),(6,19,'2025-08-10 06:45:22',17707.46),(7,12,'2025-02-02 21:52:35',34470.40),(8,17,'2025-01-24 17:40:01',8127.66),(9,3,'2025-09-06 22:33:39',73554.31),(10,20,'2025-06-26 09:47:58',88937.54),(11,1,'2025-06-16 01:37:32',44560.54),(12,16,'2025-07-17 02:55:59',3090.41),(13,16,'2025-04-08 08:21:16',15687.26),(14,3,'2025-10-18 22:54:37',169638.68),(15,4,'2025-03-17 13:37:14',28559.09),(16,3,'2025-10-11 06:15:19',10979.06),(17,6,'2025-09-01 10:05:24',46699.84),(18,11,'2025-12-05 03:23:16',11150.70),(19,7,'2025-12-03 22:47:45',10960.52),(20,20,'2025-11-23 02:35:04',18976.95),(21,5,'2025-01-09 23:38:48',4044.09),(22,3,'2025-10-01 17:51:53',121784.27),(23,19,'2025-08-08 02:35:11',9496.55),(24,16,'2025-08-09 14:01:37',2478.41),(25,12,'2025-01-13 13:04:43',8879.34),(26,11,'2025-11-26 07:09:19',4996.55),(27,12,'2025-08-23 20:16:45',8603.05),(28,4,'2025-04-16 04:36:35',53851.45),(29,5,'2025-09-07 00:30:55',28109.67),(30,10,'2025-04-10 04:24:03',14333.43),(31,14,'2025-03-18 22:59:21',35621.88),(32,8,'2025-10-09 19:47:19',23367.51),(33,10,'2025-04-23 04:55:55',38886.05),(34,7,'2025-02-01 06:17:33',19529.95),(35,14,'2025-03-03 16:27:42',50953.21),(36,9,'2025-03-03 22:30:21',28308.75),(37,11,'2025-08-21 09:27:46',15074.00),(38,16,'2025-06-18 07:15:32',26632.63),(39,15,'2025-09-23 14:59:22',167885.16),(40,15,'2025-01-17 23:32:35',65856.30),(41,7,'2025-04-01 14:11:12',2703.50),(42,2,'2025-07-22 12:58:53',14162.77),(43,12,'2025-11-06 14:26:19',14504.10),(44,10,'2025-06-08 15:41:17',9107.22),(45,10,'2025-04-26 07:47:38',4406.78),(46,16,'2025-03-11 13:11:38',15167.77),(47,12,'2025-10-05 06:13:03',15424.27),(48,12,'2025-03-27 21:53:35',22991.90),(49,19,'2025-09-19 12:42:57',48258.64),(50,5,'2025-07-01 18:06:11',30354.65),(51,15,'2025-08-10 01:05:10',76072.94),(52,4,'2025-09-08 00:37:55',35113.61),(53,17,'2025-03-19 06:09:13',10221.57),(54,2,'2025-06-28 07:36:39',9750.20),(55,19,'2025-10-17 08:38:06',69376.40),(56,9,'2025-12-16 16:09:06',60884.92),(57,14,'2025-12-23 01:43:59',15429.03),(58,3,'2025-02-17 05:01:34',30758.99),(59,15,'2025-11-18 22:11:03',281620.90),(60,12,'2025-12-10 01:09:30',265561.88),(61,3,'2025-09-17 09:41:12',2538.46),(62,15,'2025-08-05 09:48:14',12094.45),(63,3,'2025-12-03 06:57:22',15220.99),(64,12,'2025-01-14 01:08:50',27100.31),(65,6,'2025-11-26 08:53:22',24146.28),(66,9,'2025-06-20 09:27:28',0.00),(67,4,'2025-02-20 18:24:14',74605.93),(68,2,'2025-06-27 12:15:32',1276.38),(69,20,'2025-09-09 15:53:54',43047.30),(70,6,'2025-10-24 20:52:07',13535.19),(71,10,'2025-05-01 23:15:39',3634.43),(72,14,'2025-08-19 02:42:41',109183.87),(73,6,'2025-11-16 13:59:01',9311.50),(74,13,'2025-06-24 21:51:25',731.33),(75,14,'2025-12-24 13:30:15',35049.61),(76,7,'2025-07-24 06:34:03',18840.68),(77,15,'2025-02-16 21:40:52',5227.20),(78,19,'2025-04-17 23:09:30',3814.84),(79,10,'2025-10-24 13:01:18',13659.62),(80,3,'2025-06-22 17:00:28',0.00),(81,8,'2025-01-08 05:41:19',4281.32),(82,6,'2025-02-04 09:04:30',55440.64),(83,17,'2025-08-01 11:07:06',181863.68),(84,2,'2025-05-07 02:26:46',28020.83),(85,11,'2025-09-27 12:54:23',2925.34),(86,5,'2025-09-08 19:54:33',492.04),(87,17,'2025-11-13 05:12:47',22156.01),(88,18,'2025-08-02 21:20:10',117046.88),(89,7,'2025-09-20 01:10:45',29980.19),(90,18,'2025-10-25 10:10:59',6980.80),(91,18,'2025-05-18 04:14:42',12776.96),(92,6,'2025-07-16 13:04:01',278150.05),(93,16,'2025-04-03 05:41:05',200852.24),(94,8,'2025-02-26 05:51:45',26311.04),(95,6,'2025-08-07 13:31:50',14342.97),(96,5,'2025-05-17 06:45:07',14655.34),(97,18,'2025-11-09 20:46:58',13115.40),(98,16,'2025-05-14 06:36:25',17075.05),(99,14,'2025-12-08 10:28:16',14749.21),(100,14,'2025-06-09 05:54:07',0.00),(101,7,'2025-02-07 09:49:33',49786.62),(102,3,'2025-01-09 01:36:46',1968.16),(103,20,'2025-05-23 05:42:39',24068.43),(104,18,'2025-05-02 09:04:55',126857.46),(105,6,'2025-11-11 10:47:04',29807.64),(106,12,'2025-08-05 08:11:32',21840.35),(107,6,'2025-10-21 06:17:19',20054.68),(108,4,'2025-07-15 11:03:14',7219.95),(109,12,'2025-06-21 12:08:04',239094.82),(110,1,'2025-08-23 10:18:02',25377.02),(111,11,'2025-12-01 22:40:00',42295.04),(112,7,'2025-08-07 11:23:17',29891.57),(113,20,'2025-04-30 18:58:10',7418.92),(114,3,'2025-01-23 19:38:44',15274.49),(115,12,'2025-09-25 19:43:37',973.94),(116,8,'2025-05-02 22:30:48',3971.08),(117,10,'2025-05-10 08:20:16',60380.34),(118,17,'2025-04-01 04:37:34',1015.38),(119,13,'2025-03-09 08:39:39',1425.80),(120,11,'2025-12-22 14:00:45',3771.46),(121,9,'2025-05-14 08:10:24',0.00),(122,20,'2025-08-26 01:30:27',29845.15),(123,8,'2025-03-05 18:35:00',13938.37),(124,13,'2025-08-13 22:28:10',11338.65),(125,12,'2025-03-16 14:35:03',9408.45),(126,10,'2025-02-06 00:42:23',49398.83),(127,3,'2025-01-15 04:41:14',106628.48),(128,3,'2025-06-21 18:21:35',46738.18),(129,16,'2025-09-05 06:05:38',2703.50),(130,19,'2025-11-19 04:42:43',32628.46),(131,13,'2025-09-19 15:13:19',7837.37),(132,6,'2025-11-22 10:56:04',83821.03),(133,19,'2025-06-09 10:53:54',42183.47),(134,17,'2025-01-17 09:41:20',60248.65),(135,16,'2025-05-22 15:30:40',7931.12),(136,9,'2025-02-16 22:22:28',4369.11),(137,2,'2025-04-25 15:25:25',0.00),(138,19,'2025-10-27 05:58:39',50985.23),(139,18,'2025-09-15 18:30:06',5409.58),(140,3,'2025-10-10 19:41:02',275411.02),(141,3,'2025-05-16 13:56:17',4811.96),(142,5,'2025-05-05 19:25:38',22301.40),(143,14,'2025-08-08 22:36:37',8130.94),(144,9,'2025-04-17 02:42:59',54733.48),(145,9,'2025-03-06 12:26:54',19395.61),(146,3,'2025-12-02 17:55:01',13964.39),(147,16,'2025-08-23 22:02:06',37596.58),(148,9,'2025-05-18 00:42:47',14483.66),(149,14,'2025-03-03 12:55:38',0.00),(150,15,'2025-09-19 16:59:35',17900.82),(151,6,'2025-09-26 18:06:11',20001.58),(152,19,'2025-08-28 16:09:02',34743.09),(153,16,'2025-10-06 11:42:12',24861.91),(154,18,'2025-04-24 03:52:05',2851.59),(155,15,'2025-07-10 09:50:38',9174.46),(156,12,'2025-07-05 02:47:17',19620.87),(157,5,'2025-09-23 22:46:38',11582.43),(158,16,'2025-09-17 03:49:09',25710.40),(159,1,'2025-09-06 03:19:56',28702.88),(160,4,'2025-11-16 12:28:32',14530.63),(161,5,'2025-03-26 16:54:51',4635.61),(162,16,'2025-10-26 21:57:20',68602.19),(163,20,'2025-12-21 04:08:50',27703.09),(164,4,'2025-05-10 10:35:47',19105.48),(165,7,'2025-11-11 04:33:21',130099.17),(166,16,'2025-08-12 08:52:01',18827.48),(167,17,'2025-03-16 22:06:15',48439.83),(168,10,'2025-09-13 13:52:08',1420.67),(169,13,'2025-08-11 03:02:10',13873.59),(170,7,'2025-01-13 22:21:04',2180.66),(171,4,'2025-09-22 19:35:58',2030.77),(172,8,'2025-04-18 18:28:58',26152.23),(173,4,'2025-10-01 20:07:51',8459.01),(174,18,'2025-01-22 18:11:02',12578.50),(175,2,'2025-05-19 10:01:27',3656.67),(176,13,'2025-02-03 13:22:09',9635.57),(177,4,'2025-06-19 11:40:35',82931.30),(178,5,'2025-11-04 20:32:49',67514.13),(179,7,'2025-08-04 11:03:47',731.33),(180,12,'2025-11-07 12:43:19',4760.72),(181,3,'2025-06-27 21:01:11',10983.09),(182,11,'2025-08-15 13:42:58',26424.99),(183,6,'2025-03-04 05:40:29',39261.92),(184,4,'2025-12-20 17:36:41',15080.53),(185,1,'2025-08-12 01:50:58',4811.95),(186,10,'2025-09-20 10:48:39',1296.15),(187,10,'2025-10-05 18:22:00',79688.81),(188,11,'2025-11-09 17:12:42',8526.65),(189,3,'2025-05-20 19:52:10',18790.22),(190,5,'2025-08-23 17:34:29',4473.33),(191,18,'2025-04-22 11:19:22',3634.43),(192,16,'2025-10-04 10:44:20',31263.88),(193,18,'2025-08-12 03:46:18',68953.37),(194,19,'2025-12-16 23:14:40',2929.90),(195,4,'2025-03-11 05:21:59',6528.96),(196,15,'2025-10-12 20:44:41',35724.68),(197,19,'2025-07-22 12:07:53',8935.67),(198,18,'2025-05-28 02:34:53',112530.01),(199,9,'2025-02-06 23:33:32',6796.98),(200,11,'2025-08-03 23:07:44',25728.30),(201,4,'2025-03-27 18:30:00',13863.99),(202,2,'2025-03-27 18:30:00',33112.68),(203,19,'2025-03-27 18:30:00',4159.20);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_insert_order` BEFORE INSERT ON `orders` FOR EACH ROW BEGIN
    DECLARE next_id INT;
    SELECT IFNULL(MAX(order_id), 0) + 1 INTO next_id FROM orders;
    SET NEW.order_id = next_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_delete_order_cascade` AFTER DELETE ON `orders` FOR EACH ROW BEGIN
    DELETE FROM order_items WHERE order_id = OLD.order_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `category_id` int DEFAULT NULL,
  `supplier_id` int DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock_quantity` int NOT NULL DEFAULT '0',
  `rating` decimal(3,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`),
  KEY `category_id` (`category_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `idx_product_name` (`name`),
  KEY `idx_stock_level` (`stock_quantity`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE SET NULL,
  CONSTRAINT `products_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`) ON DELETE SET NULL,
  CONSTRAINT `products_chk_1` CHECK ((`rating` between 0 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Football',1,1,49.99,32,2.90,'2025-03-27 23:15:52'),(2,'Basketball',1,2,39.99,103,3.09,'2025-03-27 23:15:52'),(3,'Tennis Racket',1,3,89.99,85,2.93,'2025-03-27 23:15:52'),(4,'Badminton Shuttlecock',1,4,12.99,150,2.79,'2025-03-27 23:15:52'),(5,'Running Shoes',2,5,119.99,108,2.62,'2025-03-27 23:15:52'),(6,'Compression Shorts',2,6,29.99,47,3.32,'2025-03-27 23:15:52'),(7,'Gym Gloves',3,7,19.99,92,3.46,'2025-03-27 23:15:52'),(8,'Treadmill',3,8,899.99,46,3.45,'2025-03-27 23:15:52'),(9,'Dumbbells (10kg)',3,9,49.99,119,2.95,'2025-03-27 23:15:52'),(10,'Resistance Bands',3,10,14.99,134,2.86,'2025-03-27 23:15:52'),(11,'Hiking Backpack',4,1,79.99,255,3.09,'2025-03-27 23:15:52'),(12,'Cycling Helmet',4,2,45.99,352,3.23,'2025-03-27 23:15:52'),(13,'Camping Tent',4,3,149.99,24,3.37,'2025-03-27 23:15:52'),(14,'Climbing Rope',4,4,99.99,201,3.32,'2025-03-27 23:15:52'),(15,'Swimming Goggles',5,5,24.99,40,2.93,'2025-03-27 23:15:52'),(16,'Knee Pads',5,6,18.99,46,3.06,'2025-03-27 23:15:52'),(17,'Wristbands',5,7,9.99,208,3.00,'2025-03-27 23:15:52'),(18,'Tennis Balls (Pack of 3)',1,8,14.99,106,3.00,'2025-03-27 23:15:52'),(19,'Yoga Mat',3,9,34.99,819,2.72,'2025-03-27 23:15:52'),(20,'Boxing Gloves',1,10,59.99,429,3.12,'2025-03-27 23:15:52'),(21,'Weightlifting Belt',3,1,39.99,558,2.91,'2025-03-27 23:15:52'),(22,'Skateboard',4,2,89.99,89,2.81,'2025-03-27 23:15:52'),(23,'Cycling Jersey',2,3,49.99,112,2.73,'2025-03-27 23:15:52'),(24,'Soccer Jersey',2,4,39.99,132,2.95,'2025-03-27 23:15:52'),(25,'Shin Guards',5,5,19.99,103,2.57,'2025-03-27 23:15:52'),(26,'Cricket Bat',1,6,129.99,239,2.86,'2025-03-27 23:15:52'),(27,'Golf Club',1,7,179.99,191,2.65,'2025-03-27 23:15:52'),(28,'Table Tennis Paddle',1,8,29.99,114,2.83,'2025-03-27 23:15:52'),(29,'Jump Rope',3,9,12.99,118,2.92,'2025-03-27 23:15:52'),(30,'Ski Goggles',4,10,89.99,268,3.17,'2025-03-27 23:15:52');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_insert_product` BEFORE INSERT ON `products` FOR EACH ROW BEGIN
    DECLARE next_id INT;
    SELECT IFNULL(MAX(product_id), 0) + 1 INTO next_id FROM products;
    SET NEW.product_id = next_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_delete_product_reviews` BEFORE DELETE ON `products` FOR EACH ROW BEGIN
    DELETE FROM reviews WHERE product_id = OLD.product_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_delete_product_order_items` BEFORE DELETE ON `products` FOR EACH ROW BEGIN
    DELETE FROM order_items WHERE product_id = OLD.product_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_delete_product_discounts` AFTER DELETE ON `products` FOR EACH ROW BEGIN
    DELETE FROM discounts WHERE product_id = OLD.product_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `review_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `product_id` int NOT NULL,
  `rating` decimal(3,2) DEFAULT NULL,
  `review_text` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`review_id`),
  KEY `customer_id` (`customer_id`),
  KEY `idx_review_product` (`product_id`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE CASCADE,
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE,
  CONSTRAINT `reviews_chk_1` CHECK ((`rating` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,3,24,2.00,'Could be improved with better materials.','2025-03-27 23:16:19'),(2,11,10,2.00,'Functional but very flimsy.','2025-03-27 23:16:19'),(3,1,23,2.00,'Not as advertised, but usable.','2025-03-27 23:16:19'),(4,11,20,2.00,'Shipping delay ruined the experience.','2025-03-27 23:16:19'),(5,7,15,4.00,'Met my expectations.','2025-03-27 23:16:19'),(6,15,30,2.00,'Expected better, slightly disappointed.','2025-03-27 23:16:19'),(7,15,5,1.00,'Shipping took forever, and item was damaged.','2025-03-27 23:16:19'),(8,12,26,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:19'),(9,12,13,5.00,'Amazing! Totally worth it.','2025-03-27 23:16:19'),(10,19,19,5.00,'Best purchase Ive made!','2025-03-27 23:16:19'),(11,3,11,3.00,'Decent quality for the price.','2025-03-27 23:16:19'),(12,20,27,2.00,'Expected better, slightly disappointed.','2025-03-27 23:16:19'),(13,18,11,1.00,'Doesnt work at all, total scam!','2025-03-27 23:16:19'),(14,11,3,5.00,'Superb quality, will buy again.','2025-03-27 23:16:19'),(15,20,1,3.00,'Decent quality for the price.','2025-03-27 23:16:19'),(16,11,16,4.00,'Satisfied with my purchase.','2025-03-27 23:16:19'),(17,8,14,5.00,'Superb quality, will buy again.','2025-03-27 23:16:19'),(18,2,18,5.00,'Absolutely fantastic, love it!','2025-03-27 23:16:19'),(19,13,23,1.00,'Customer support was unhelpful.','2025-03-27 23:16:19'),(20,5,8,4.00,'Impressive for this price range.','2025-03-27 23:16:19'),(21,10,22,1.00,'Shipping took forever, and item was damaged.','2025-03-27 23:16:19'),(22,6,27,4.00,'Will probably buy again.','2025-03-27 23:16:19'),(23,16,9,3.00,'Okay product, nothing special.','2025-03-27 23:16:19'),(24,19,14,4.00,'Impressive for this price range.','2025-03-27 23:16:19'),(25,15,17,3.00,'Somewhat satisfied, minor flaws.','2025-03-27 23:16:19'),(26,15,8,4.00,'Better than expected!','2025-03-27 23:16:19'),(27,5,12,3.00,'Decent quality for the price.','2025-03-27 23:16:19'),(28,1,21,1.00,'False advertising, nothing like the pictures.','2025-03-27 23:16:19'),(29,2,20,4.00,'Impressive for this price range.','2025-03-27 23:16:19'),(30,7,13,4.00,'Solid product, performs well.','2025-03-27 23:16:19'),(31,8,22,2.00,'Expected better, slightly disappointed.','2025-03-27 23:16:19'),(32,18,21,5.00,'Highly recommend to everyone.','2025-03-27 23:16:19'),(33,8,29,1.00,'Terrible quality, completely disappointed.','2025-03-27 23:16:19'),(34,16,2,1.00,'Worst product Ive ever bought!','2025-03-27 23:16:19'),(35,11,12,2.00,'Average at best, wouldnt repurchase.','2025-03-27 23:16:19'),(36,5,10,4.00,'Pretty good, would recommend.','2025-03-27 23:16:19'),(37,15,4,2.00,'Not great, but at least it works.','2025-03-27 23:16:19'),(38,8,10,3.00,'Meh, its just alright.','2025-03-27 23:16:19'),(39,9,10,1.00,'Terrible quality, completely disappointed.','2025-03-27 23:16:19'),(40,8,26,1.00,'Useless product, never buying again.','2025-03-27 23:16:19'),(41,9,3,5.00,'Absolutely fantastic, love it!','2025-03-27 23:16:19'),(42,5,3,1.00,'Terrible quality, completely disappointed.','2025-03-27 23:16:19'),(43,14,19,5.00,'Perfect in every way.','2025-03-27 23:16:19'),(44,18,17,3.00,'Reasonable for the price point.','2025-03-27 23:16:19'),(45,4,19,1.00,'Shipping took forever, and item was damaged.','2025-03-27 23:16:19'),(46,8,28,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:19'),(47,11,22,2.00,'Average at best, wouldnt repurchase.','2025-03-27 23:16:19'),(48,13,20,3.00,'Okay product, nothing special.','2025-03-27 23:16:19'),(49,18,27,2.00,'Not as advertised, but usable.','2025-03-27 23:16:19'),(50,3,3,3.00,'Not bad, but not amazing either.','2025-03-27 23:16:19'),(51,1,20,3.00,'Could be better, but acceptable.','2025-03-27 23:16:19'),(52,7,3,4.00,'Met my expectations.','2025-03-27 23:16:19'),(53,7,12,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:19'),(54,7,3,4.00,'Nice quality, worth buying.','2025-03-27 23:16:19'),(55,17,5,2.00,'Average at best, wouldnt repurchase.','2025-03-27 23:16:19'),(56,2,26,2.00,'Does the job but feels cheap.','2025-03-27 23:16:19'),(57,11,19,1.00,'Absolutely awful experience!','2025-03-27 23:16:19'),(58,20,28,1.00,'Customer support was unhelpful.','2025-03-27 23:16:19'),(59,15,12,2.00,'Had issues, but customer service helped.','2025-03-27 23:16:19'),(60,19,18,4.00,'Will probably buy again.','2025-03-27 23:16:19'),(61,9,10,3.00,'Meh, its just alright.','2025-03-27 23:16:19'),(62,17,22,1.00,'Terrible quality, completely disappointed.','2025-03-27 23:16:19'),(63,3,21,3.00,'Reasonable for the price point.','2025-03-27 23:16:19'),(64,18,7,5.00,'Amazing! Totally worth it.','2025-03-27 23:16:19'),(65,1,5,2.00,'Functional but very flimsy.','2025-03-27 23:16:19'),(66,12,27,3.00,'Reasonable for the price point.','2025-03-27 23:16:19'),(67,10,12,1.00,'Worst product Ive ever bought!','2025-03-27 23:16:19'),(68,7,11,2.00,'Expected better, slightly disappointed.','2025-03-27 23:16:19'),(69,2,25,2.00,'Poor build quality, wouldnt recommend.','2025-03-27 23:16:19'),(70,12,21,3.00,'Neither good nor bad, just okay.','2025-03-27 23:16:19'),(71,17,3,3.00,'Fair value for money.','2025-03-27 23:16:19'),(72,15,1,5.00,'Amazing! Totally worth it.','2025-03-27 23:16:19'),(73,14,3,1.00,'Customer support was unhelpful.','2025-03-27 23:16:19'),(74,2,25,4.00,'Good value for money.','2025-03-27 23:16:19'),(75,13,11,3.00,'Meh, its just alright.','2025-03-27 23:16:19'),(76,8,18,2.00,'Shipping delay ruined the experience.','2025-03-27 23:16:19'),(77,10,4,3.00,'Neither good nor bad, just okay.','2025-03-27 23:16:19'),(78,7,11,2.00,'Functional but very flimsy.','2025-03-27 23:16:19'),(79,8,3,2.00,'Could be improved with better materials.','2025-03-27 23:16:19'),(80,10,26,1.00,'Broke within a day, waste of money.','2025-03-27 23:16:19'),(81,11,24,5.00,'Simply the best!','2025-03-27 23:16:19'),(82,13,1,2.00,'Functional but very flimsy.','2025-03-27 23:16:19'),(83,15,24,5.00,'Superb quality, will buy again.','2025-03-27 23:16:19'),(84,6,7,2.00,'Had issues, but customer service helped.','2025-03-27 23:16:19'),(85,17,5,4.00,'Pretty good, would recommend.','2025-03-27 23:16:19'),(86,7,10,4.00,'Solid product, performs well.','2025-03-27 23:16:19'),(87,5,24,4.00,'Solid product, performs well.','2025-03-27 23:16:19'),(88,11,5,5.00,'Superb quality, will buy again.','2025-03-27 23:16:19'),(89,19,4,4.00,'Impressive for this price range.','2025-03-27 23:16:19'),(90,19,23,5.00,'Exceeded all expectations!','2025-03-27 23:16:19'),(91,20,22,4.00,'Good value for money.','2025-03-27 23:16:19'),(92,1,21,1.00,'Shipping took forever, and item was damaged.','2025-03-27 23:16:19'),(93,5,9,2.00,'Could be improved with better materials.','2025-03-27 23:16:19'),(94,3,16,1.00,'Absolutely awful experience!','2025-03-27 23:16:19'),(95,9,29,2.00,'Not as advertised, but usable.','2025-03-27 23:16:19'),(96,3,28,3.00,'Meh, its just alright.','2025-03-27 23:16:19'),(97,7,21,5.00,'Simply the best!','2025-03-27 23:16:19'),(98,20,12,3.00,'Reasonable for the price point.','2025-03-27 23:16:19'),(99,4,13,4.00,'Met my expectations.','2025-03-27 23:16:19'),(100,6,26,1.00,'Doesnt work at all, total scam!','2025-03-27 23:16:19'),(101,12,2,3.00,'Decent quality for the price.','2025-03-27 23:16:19'),(102,19,29,5.00,'Exceeded all expectations!','2025-03-27 23:16:19'),(103,12,10,4.00,'Will probably buy again.','2025-03-27 23:16:19'),(104,16,18,5.00,'Absolutely fantastic, love it!','2025-03-27 23:16:19'),(105,13,16,1.00,'Shipping took forever, and item was damaged.','2025-03-27 23:16:19'),(106,19,1,2.00,'Expected better, slightly disappointed.','2025-03-27 23:16:19'),(107,3,16,4.00,'Satisfied with my purchase.','2025-03-27 23:16:19'),(108,7,30,3.00,'Mediocre, works fine but expected more.','2025-03-27 23:16:19'),(109,20,22,4.00,'Nice quality, worth buying.','2025-03-27 23:16:19'),(110,5,12,3.00,'Fair value for money.','2025-03-27 23:16:19'),(111,14,13,4.00,'Satisfied with my purchase.','2025-03-27 23:16:19'),(112,14,23,4.00,'Impressive for this price range.','2025-03-27 23:16:19'),(113,11,23,1.00,'Useless product, never buying again.','2025-03-27 23:16:19'),(114,10,3,5.00,'Best purchase Ive made!','2025-03-27 23:16:19'),(115,12,10,3.00,'Not bad, but not amazing either.','2025-03-27 23:16:19'),(116,13,5,3.00,'Could be better, but acceptable.','2025-03-27 23:16:19'),(117,1,18,2.00,'Does the job but feels cheap.','2025-03-27 23:16:19'),(118,13,23,4.00,'Nice quality, worth buying.','2025-03-27 23:16:19'),(119,12,18,5.00,'Best purchase Ive made!','2025-03-27 23:16:19'),(120,4,18,3.00,'Neither good nor bad, just okay.','2025-03-27 23:16:19'),(121,3,6,2.00,'Could be improved with better materials.','2025-03-27 23:16:19'),(122,14,10,3.00,'Okay product, nothing special.','2025-03-27 23:16:19'),(123,12,20,3.00,'Reasonable for the price point.','2025-03-27 23:16:19'),(124,6,17,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:19'),(125,13,27,1.00,'Doesnt work at all, total scam!','2025-03-27 23:16:19'),(126,15,26,5.00,'Perfect in every way.','2025-03-27 23:16:19'),(127,19,3,3.00,'Fair value for money.','2025-03-27 23:16:19'),(128,3,23,2.00,'Does the job but feels cheap.','2025-03-27 23:16:19'),(129,10,30,1.00,'Absolutely awful experience!','2025-03-27 23:16:19'),(130,8,22,3.00,'Could be better, but acceptable.','2025-03-27 23:16:19'),(131,10,27,2.00,'Average at best, wouldnt repurchase.','2025-03-27 23:16:19'),(132,8,17,2.00,'Could be improved with better materials.','2025-03-27 23:16:19'),(133,11,26,4.00,'Solid product, performs well.','2025-03-27 23:16:19'),(134,5,30,5.00,'Superb quality, will buy again.','2025-03-27 23:16:19'),(135,10,28,2.00,'Does the job but feels cheap.','2025-03-27 23:16:19'),(136,10,4,2.00,'Poor build quality, wouldnt recommend.','2025-03-27 23:16:19'),(137,9,20,1.00,'Shipping took forever, and item was damaged.','2025-03-27 23:16:19'),(138,18,10,1.00,'False advertising, nothing like the pictures.','2025-03-27 23:16:19'),(139,20,29,2.00,'Not great, but at least it works.','2025-03-27 23:16:19'),(140,13,21,4.00,'Better than expected!','2025-03-27 23:16:19'),(141,4,12,5.00,'Exceeded all expectations!','2025-03-27 23:16:19'),(142,20,20,5.00,'Highly recommend to everyone.','2025-03-27 23:16:19'),(143,13,4,1.00,'Shipping took forever, and item was damaged.','2025-03-27 23:16:19'),(144,14,29,3.00,'Could be better, but acceptable.','2025-03-27 23:16:19'),(145,13,9,5.00,'Exceeded all expectations!','2025-03-27 23:16:19'),(146,12,8,1.00,'Broke within a day, waste of money.','2025-03-27 23:16:19'),(147,7,13,2.00,'Not great, but at least it works.','2025-03-27 23:16:19'),(148,16,3,5.00,'Absolutely fantastic, love it!','2025-03-27 23:16:19'),(149,9,30,1.00,'Absolutely awful experience!','2025-03-27 23:16:19'),(150,20,3,2.00,'Shipping delay ruined the experience.','2025-03-27 23:16:19'),(151,15,19,5.00,'Perfect in every way.','2025-03-27 23:16:19'),(152,20,14,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:19'),(153,2,7,3.00,'Not bad, but not amazing either.','2025-03-27 23:16:19'),(154,12,27,4.00,'Impressive for this price range.','2025-03-27 23:16:19'),(155,6,25,1.00,'Shipping took forever, and item was damaged.','2025-03-27 23:16:19'),(156,19,10,2.00,'Does the job but feels cheap.','2025-03-27 23:16:19'),(157,3,26,2.00,'Not great, but at least it works.','2025-03-27 23:16:19'),(158,8,27,4.00,'Nice quality, worth buying.','2025-03-27 23:16:19'),(159,11,20,5.00,'Perfect in every way.','2025-03-27 23:16:19'),(160,1,6,2.00,'Expected better, slightly disappointed.','2025-03-27 23:16:19'),(161,16,23,1.00,'Worst product Ive ever bought!','2025-03-27 23:16:19'),(162,4,8,4.00,'Satisfied with my purchase.','2025-03-27 23:16:19'),(163,4,11,2.00,'Could be improved with better materials.','2025-03-27 23:16:19'),(164,15,14,5.00,'Simply the best!','2025-03-27 23:16:19'),(165,10,21,3.00,'Neither good nor bad, just okay.','2025-03-27 23:16:19'),(166,15,14,5.00,'Amazing! Totally worth it.','2025-03-27 23:16:19'),(167,8,20,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:19'),(168,17,26,2.00,'Functional but very flimsy.','2025-03-27 23:16:19'),(169,2,2,2.00,'Average at best, wouldnt repurchase.','2025-03-27 23:16:19'),(170,17,23,3.00,'Reasonable for the price point.','2025-03-27 23:16:19'),(171,8,15,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:19'),(172,2,22,3.00,'Fair value for money.','2025-03-27 23:16:19'),(173,18,26,4.00,'Satisfied with my purchase.','2025-03-27 23:16:19'),(174,3,24,1.00,'Shipping took forever, and item was damaged.','2025-03-27 23:16:19'),(175,10,3,1.00,'Absolutely awful experience!','2025-03-27 23:16:19'),(176,7,14,2.00,'Does the job but feels cheap.','2025-03-27 23:16:19'),(177,1,14,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:19'),(178,1,2,5.00,'Superb quality, will buy again.','2025-03-27 23:16:19'),(179,6,15,4.00,'Nice quality, worth buying.','2025-03-27 23:16:19'),(180,11,24,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:19'),(181,2,6,3.00,'Meh, its just alright.','2025-03-27 23:16:19'),(182,8,29,2.00,'Poor build quality, wouldnt recommend.','2025-03-27 23:16:19'),(183,2,16,2.00,'Poor build quality, wouldnt recommend.','2025-03-27 23:16:19'),(184,20,10,4.00,'Good value for money.','2025-03-27 23:16:19'),(185,17,5,2.00,'Could be improved with better materials.','2025-03-27 23:16:19'),(186,14,11,2.00,'Could be improved with better materials.','2025-03-27 23:16:19'),(187,15,4,3.00,'Decent quality for the price.','2025-03-27 23:16:19'),(188,8,21,1.00,'Doesnt work at all, total scam!','2025-03-27 23:16:19'),(189,2,20,4.00,'Satisfied with my purchase.','2025-03-27 23:16:19'),(190,11,18,5.00,'Best purchase Ive made!','2025-03-27 23:16:19'),(191,7,3,3.00,'Meh, its just alright.','2025-03-27 23:16:19'),(192,6,11,3.00,'Fair value for money.','2025-03-27 23:16:19'),(193,2,24,3.00,'Fair value for money.','2025-03-27 23:16:19'),(194,4,6,5.00,'Outstanding product and service.','2025-03-27 23:16:19'),(195,16,13,5.00,'Highly recommend to everyone.','2025-03-27 23:16:19'),(196,4,6,4.00,'Met my expectations.','2025-03-27 23:16:19'),(197,18,11,2.00,'Not as advertised, but usable.','2025-03-27 23:16:19'),(198,13,2,3.00,'Neither good nor bad, just okay.','2025-03-27 23:16:19'),(199,7,6,2.00,'Could be improved with better materials.','2025-03-27 23:16:19'),(200,13,16,2.00,'Could be improved with better materials.','2025-03-27 23:16:19'),(201,14,5,3.00,'Not bad, but not amazing either.','2025-03-27 23:16:19'),(202,14,6,1.00,'Terrible quality, completely disappointed.','2025-03-27 23:16:19'),(203,20,22,3.00,'Decent quality for the price.','2025-03-27 23:16:19'),(204,6,26,4.00,'Impressive for this price range.','2025-03-27 23:16:19'),(205,7,25,5.00,'Superb quality, will buy again.','2025-03-27 23:16:19'),(206,18,5,1.00,'Absolutely awful experience!','2025-03-27 23:16:19'),(207,1,5,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:19'),(208,17,3,1.00,'Worst product Ive ever bought!','2025-03-27 23:16:19'),(209,4,15,4.00,'Will probably buy again.','2025-03-27 23:16:19'),(210,5,7,4.00,'Will probably buy again.','2025-03-27 23:16:19'),(211,10,26,1.00,'Worst product Ive ever bought!','2025-03-27 23:16:19'),(212,14,18,2.00,'Poor build quality, wouldnt recommend.','2025-03-27 23:16:19'),(213,19,10,2.00,'Average at best, wouldnt repurchase.','2025-03-27 23:16:19'),(214,2,4,4.00,'Impressive for this price range.','2025-03-27 23:16:19'),(215,20,3,1.00,'Useless product, never buying again.','2025-03-27 23:16:19'),(216,14,25,4.00,'Good value for money.','2025-03-27 23:16:19'),(217,6,5,1.00,'Worst product Ive ever bought!','2025-03-27 23:16:19'),(218,16,18,4.00,'Better than expected!','2025-03-27 23:16:19'),(219,8,18,5.00,'Absolutely fantastic, love it!','2025-03-27 23:16:19'),(220,15,6,1.00,'Doesnt work at all, total scam!','2025-03-27 23:16:19'),(221,3,14,5.00,'Absolutely fantastic, love it!','2025-03-27 23:16:19'),(222,11,6,4.00,'Solid product, performs well.','2025-03-27 23:16:19'),(223,3,13,5.00,'Highly recommend to everyone.','2025-03-27 23:16:19'),(224,3,29,4.00,'Better than expected!','2025-03-27 23:16:19'),(225,3,10,1.00,'Broke within a day, waste of money.','2025-03-27 23:16:19'),(226,1,30,2.00,'Shipping delay ruined the experience.','2025-03-27 23:16:19'),(227,10,17,3.00,'Fair value for money.','2025-03-27 23:16:19'),(228,4,4,4.00,'Better than expected!','2025-03-27 23:16:19'),(229,7,27,1.00,'Absolutely awful experience!','2025-03-27 23:16:19'),(230,19,21,5.00,'Highly recommend to everyone.','2025-03-27 23:16:19'),(231,10,25,2.00,'Could be improved with better materials.','2025-03-27 23:16:19'),(232,17,8,3.00,'Mediocre, works fine but expected more.','2025-03-27 23:16:19'),(233,12,15,1.00,'Customer support was unhelpful.','2025-03-27 23:16:19'),(234,2,17,1.00,'Useless product, never buying again.','2025-03-27 23:16:19'),(235,17,15,4.00,'Works as described, happy with it.','2025-03-27 23:16:19'),(236,15,6,2.00,'Shipping delay ruined the experience.','2025-03-27 23:16:19'),(237,1,1,5.00,'Best purchase Ive made!','2025-03-27 23:16:19'),(238,7,12,2.00,'Poor build quality, wouldnt recommend.','2025-03-27 23:16:19'),(239,9,12,3.00,'Reasonable for the price point.','2025-03-27 23:16:19'),(240,9,26,5.00,'Absolutely fantastic, love it!','2025-03-27 23:16:19'),(241,15,14,4.00,'Nice quality, worth buying.','2025-03-27 23:16:19'),(242,6,24,2.00,'Not great, but at least it works.','2025-03-27 23:16:19'),(243,7,11,5.00,'Simply the best!','2025-03-27 23:16:19'),(244,4,11,4.00,'Will probably buy again.','2025-03-27 23:16:19'),(245,18,6,5.00,'Flawless, couldnt be happier.','2025-03-27 23:16:19'),(246,10,2,4.00,'Pretty good, would recommend.','2025-03-27 23:16:19'),(247,2,16,4.00,'Nice quality, worth buying.','2025-03-27 23:16:19'),(248,9,14,1.00,'Useless product, never buying again.','2025-03-27 23:16:19'),(249,15,1,3.00,'Fair value for money.','2025-03-27 23:16:19'),(250,17,21,3.00,'Decent quality for the price.','2025-03-27 23:16:19'),(251,15,4,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:19'),(252,10,12,3.00,'Fair value for money.','2025-03-27 23:16:19'),(253,18,8,4.00,'Good value for money.','2025-03-27 23:16:19'),(254,10,20,4.00,'Will probably buy again.','2025-03-27 23:16:19'),(255,4,3,5.00,'Exceeded all expectations!','2025-03-27 23:16:19'),(256,2,23,4.00,'Nice quality, worth buying.','2025-03-27 23:16:19'),(257,4,30,2.00,'Expected better, slightly disappointed.','2025-03-27 23:16:19'),(258,2,12,4.00,'Pretty good, would recommend.','2025-03-27 23:16:19'),(259,19,20,2.00,'Poor build quality, wouldnt recommend.','2025-03-27 23:16:19'),(260,20,22,5.00,'Exceeded all expectations!','2025-03-27 23:16:19'),(261,10,30,1.00,'Broke within a day, waste of money.','2025-03-27 23:16:19'),(262,15,29,5.00,'Absolutely fantastic, love it!','2025-03-27 23:16:19'),(263,9,12,5.00,'Amazing! Totally worth it.','2025-03-27 23:16:19'),(264,18,1,4.00,'Good value for money.','2025-03-27 23:16:19'),(265,15,2,3.00,'Fair value for money.','2025-03-27 23:16:19'),(266,10,23,4.00,'Better than expected!','2025-03-27 23:16:19'),(267,12,6,5.00,'Amazing! Totally worth it.','2025-03-27 23:16:19'),(268,2,24,4.00,'Solid product, performs well.','2025-03-27 23:16:19'),(269,11,3,2.00,'Could be improved with better materials.','2025-03-27 23:16:19'),(270,16,16,5.00,'Perfect in every way.','2025-03-27 23:16:19'),(271,16,23,4.00,'Will probably buy again.','2025-03-27 23:16:19'),(272,3,10,3.00,'Mediocre, works fine but expected more.','2025-03-27 23:16:19'),(273,17,30,1.00,'Useless product, never buying again.','2025-03-27 23:16:19'),(274,14,18,1.00,'Shipping took forever, and item was damaged.','2025-03-27 23:16:19'),(275,14,22,4.00,'Better than expected!','2025-03-27 23:16:19'),(276,17,9,1.00,'Useless product, never buying again.','2025-03-27 23:16:19'),(277,10,29,5.00,'Outstanding product and service.','2025-03-27 23:16:19'),(278,1,19,1.00,'Shipping took forever, and item was damaged.','2025-03-27 23:16:19'),(279,11,28,3.00,'Somewhat satisfied, minor flaws.','2025-03-27 23:16:19'),(280,19,8,2.00,'Not as advertised, but usable.','2025-03-27 23:16:19'),(281,10,27,4.00,'Nice quality, worth buying.','2025-03-27 23:16:19'),(282,8,18,3.00,'Meh, its just alright.','2025-03-27 23:16:19'),(283,13,19,1.00,'False advertising, nothing like the pictures.','2025-03-27 23:16:19'),(284,4,27,1.00,'Customer support was unhelpful.','2025-03-27 23:16:19'),(285,9,14,2.00,'Shipping delay ruined the experience.','2025-03-27 23:16:19'),(286,19,24,3.00,'Mediocre, works fine but expected more.','2025-03-27 23:16:19'),(287,19,18,2.00,'Average at best, wouldnt repurchase.','2025-03-27 23:16:19'),(288,1,20,1.00,'Customer support was unhelpful.','2025-03-27 23:16:19'),(289,17,15,4.00,'Met my expectations.','2025-03-27 23:16:19'),(290,14,22,4.00,'Pretty good, would recommend.','2025-03-27 23:16:19'),(291,16,3,5.00,'Outstanding product and service.','2025-03-27 23:16:19'),(292,11,20,3.00,'Meh, its just alright.','2025-03-27 23:16:19'),(293,11,24,5.00,'Simply the best!','2025-03-27 23:16:19'),(294,8,3,3.00,'Okay product, nothing special.','2025-03-27 23:16:19'),(295,18,30,5.00,'Highly recommend to everyone.','2025-03-27 23:16:19'),(296,1,18,2.00,'Not great, but at least it works.','2025-03-27 23:16:19'),(297,16,3,2.00,'Does the job but feels cheap.','2025-03-27 23:16:19'),(298,20,23,1.00,'Broke within a day, waste of money.','2025-03-27 23:16:19'),(299,17,30,5.00,'Simply the best!','2025-03-27 23:16:19'),(300,18,22,1.00,'Useless product, never buying again.','2025-03-27 23:16:19'),(301,20,5,1.00,'Doesnt work at all, total scam!','2025-03-27 23:16:19'),(302,16,18,2.00,'Poor build quality, wouldnt recommend.','2025-03-27 23:16:19'),(303,19,30,3.00,'Mediocre, works fine but expected more.','2025-03-27 23:16:19'),(304,7,24,3.00,'Not bad, but not amazing either.','2025-03-27 23:16:19'),(305,20,10,1.00,'Absolutely awful experience!','2025-03-27 23:16:19'),(306,19,15,2.00,'Shipping delay ruined the experience.','2025-03-27 23:16:19'),(307,5,15,3.00,'Not bad, but not amazing either.','2025-03-27 23:16:19'),(308,7,21,1.00,'Customer support was unhelpful.','2025-03-27 23:16:19'),(309,16,5,5.00,'Exceeded all expectations!','2025-03-27 23:16:19'),(310,17,26,3.00,'Mediocre, works fine but expected more.','2025-03-27 23:16:19'),(311,11,19,5.00,'Perfect in every way.','2025-03-27 23:16:19'),(312,6,5,5.00,'Outstanding product and service.','2025-03-27 23:16:19'),(313,18,17,5.00,'Best purchase Ive made!','2025-03-27 23:16:19'),(314,12,8,4.00,'Good value for money.','2025-03-27 23:16:19'),(315,18,13,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:19'),(316,14,29,5.00,'Outstanding product and service.','2025-03-27 23:16:19'),(317,5,21,2.00,'Poor build quality, wouldnt recommend.','2025-03-27 23:16:19'),(318,19,11,2.00,'Had issues, but customer service helped.','2025-03-27 23:16:19'),(319,20,30,3.00,'Reasonable for the price point.','2025-03-27 23:16:19'),(320,8,8,3.00,'Okay product, nothing special.','2025-03-27 23:16:19'),(321,17,15,2.00,'Average at best, wouldnt repurchase.','2025-03-27 23:16:19'),(322,1,15,5.00,'Simply the best!','2025-03-27 23:16:19'),(323,16,7,2.00,'Not great, but at least it works.','2025-03-27 23:16:19'),(324,20,24,1.00,'Shipping took forever, and item was damaged.','2025-03-27 23:16:19'),(325,11,11,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:19'),(326,19,24,1.00,'Shipping took forever, and item was damaged.','2025-03-27 23:16:19'),(327,6,17,4.00,'Works as described, happy with it.','2025-03-27 23:16:19'),(328,13,16,5.00,'Absolutely fantastic, love it!','2025-03-27 23:16:19'),(329,9,23,4.00,'Good value for money.','2025-03-27 23:16:19'),(330,5,3,1.00,'Absolutely awful experience!','2025-03-27 23:16:19'),(331,9,20,4.00,'Satisfied with my purchase.','2025-03-27 23:16:19'),(332,13,9,4.00,'Met my expectations.','2025-03-27 23:16:19'),(333,2,15,2.00,'Average at best, wouldnt repurchase.','2025-03-27 23:16:19'),(334,9,16,3.00,'Decent quality for the price.','2025-03-27 23:16:19'),(335,5,12,2.00,'Does the job but feels cheap.','2025-03-27 23:16:19'),(336,2,6,5.00,'Simply the best!','2025-03-27 23:16:19'),(337,17,20,5.00,'Highly recommend to everyone.','2025-03-27 23:16:19'),(338,4,18,4.00,'Pretty good, would recommend.','2025-03-27 23:16:19'),(339,9,13,2.00,'Not as advertised, but usable.','2025-03-27 23:16:19'),(340,1,4,2.00,'Shipping delay ruined the experience.','2025-03-27 23:16:19'),(341,9,30,5.00,'Perfect in every way.','2025-03-27 23:16:19'),(342,18,22,2.00,'Had issues, but customer service helped.','2025-03-27 23:16:19'),(343,18,13,4.00,'Satisfied with my purchase.','2025-03-27 23:16:19'),(344,11,21,2.00,'Had issues, but customer service helped.','2025-03-27 23:16:19'),(345,18,27,1.00,'Terrible quality, completely disappointed.','2025-03-27 23:16:19'),(346,18,18,2.00,'Does the job but feels cheap.','2025-03-27 23:16:19'),(347,11,13,3.00,'Somewhat satisfied, minor flaws.','2025-03-27 23:16:19'),(348,11,15,1.00,'Customer support was unhelpful.','2025-03-27 23:16:19'),(349,13,30,4.00,'Good value for money.','2025-03-27 23:16:19'),(350,18,20,5.00,'Amazing! Totally worth it.','2025-03-27 23:16:19'),(351,14,18,1.00,'Shipping took forever, and item was damaged.','2025-03-27 23:16:19'),(352,12,7,3.00,'Not bad, but not amazing either.','2025-03-27 23:16:19'),(353,3,8,5.00,'Perfect in every way.','2025-03-27 23:16:19'),(354,19,8,2.00,'Not as advertised, but usable.','2025-03-27 23:16:19'),(355,18,1,3.00,'Okay product, nothing special.','2025-03-27 23:16:19'),(356,5,20,4.00,'Good value for money.','2025-03-27 23:16:19'),(357,5,1,5.00,'Flawless, couldnt be happier.','2025-03-27 23:16:19'),(358,8,27,2.00,'Poor build quality, wouldnt recommend.','2025-03-27 23:16:19'),(359,18,5,1.00,'Useless product, never buying again.','2025-03-27 23:16:19'),(360,8,7,3.00,'Could be better, but acceptable.','2025-03-27 23:16:19'),(361,9,21,4.00,'Pretty good, would recommend.','2025-03-27 23:16:19'),(362,14,16,3.00,'Reasonable for the price point.','2025-03-27 23:16:19'),(363,12,28,4.00,'Impressive for this price range.','2025-03-27 23:16:19'),(364,18,23,5.00,'Absolutely fantastic, love it!','2025-03-27 23:16:19'),(365,13,23,2.00,'Functional but very flimsy.','2025-03-27 23:16:19'),(366,4,17,2.00,'Not great, but at least it works.','2025-03-27 23:16:19'),(367,3,27,5.00,'Highly recommend to everyone.','2025-03-27 23:16:19'),(368,19,8,5.00,'Perfect in every way.','2025-03-27 23:16:19'),(369,2,13,2.00,'Had issues, but customer service helped.','2025-03-27 23:16:19'),(370,10,13,5.00,'Best purchase Ive made!','2025-03-27 23:16:19'),(371,4,1,3.00,'Could be better, but acceptable.','2025-03-27 23:16:19'),(372,17,15,3.00,'Somewhat satisfied, minor flaws.','2025-03-27 23:16:19'),(373,13,24,1.00,'Shipping took forever, and item was damaged.','2025-03-27 23:16:19'),(374,20,16,5.00,'Best purchase Ive made!','2025-03-27 23:16:19'),(375,15,26,4.00,'Impressive for this price range.','2025-03-27 23:16:19'),(376,17,21,3.00,'Okay product, nothing special.','2025-03-27 23:16:19'),(377,15,8,5.00,'Flawless, couldnt be happier.','2025-03-27 23:16:19'),(378,10,10,2.00,'Not great, but at least it works.','2025-03-27 23:16:19'),(379,20,12,4.00,'Solid product, performs well.','2025-03-27 23:16:19'),(380,20,15,3.00,'Meh, its just alright.','2025-03-27 23:16:19'),(381,4,24,4.00,'Pretty good, would recommend.','2025-03-27 23:16:19'),(382,3,17,3.00,'Not bad, but not amazing either.','2025-03-27 23:16:19'),(383,7,24,3.00,'Mediocre, works fine but expected more.','2025-03-27 23:16:19'),(384,7,28,1.00,'Useless product, never buying again.','2025-03-27 23:16:19'),(385,3,24,3.00,'Mediocre, works fine but expected more.','2025-03-27 23:16:19'),(386,3,11,4.00,'Works as described, happy with it.','2025-03-27 23:16:19'),(387,2,9,2.00,'Could be improved with better materials.','2025-03-27 23:16:19'),(388,20,5,1.00,'False advertising, nothing like the pictures.','2025-03-27 23:16:19'),(389,5,20,5.00,'Perfect in every way.','2025-03-27 23:16:19'),(390,19,6,1.00,'Useless product, never buying again.','2025-03-27 23:16:19'),(391,20,20,2.00,'Average at best, wouldnt repurchase.','2025-03-27 23:16:19'),(392,8,10,2.00,'Not great, but at least it works.','2025-03-27 23:16:19'),(393,4,8,2.00,'Poor build quality, wouldnt recommend.','2025-03-27 23:16:19'),(394,14,29,5.00,'Simply the best!','2025-03-27 23:16:19'),(395,15,10,1.00,'Broke within a day, waste of money.','2025-03-27 23:16:19'),(396,10,8,5.00,'Outstanding product and service.','2025-03-27 23:16:19'),(397,13,15,3.00,'Mediocre, works fine but expected more.','2025-03-27 23:16:19'),(398,18,29,1.00,'Broke within a day, waste of money.','2025-03-27 23:16:19'),(399,11,16,5.00,'Outstanding product and service.','2025-03-27 23:16:19'),(400,5,8,5.00,'Perfect in every way.','2025-03-27 23:16:19'),(401,19,20,4.00,'Will probably buy again.','2025-03-27 23:16:19'),(402,20,25,2.00,'Not great, but at least it works.','2025-03-27 23:16:19'),(403,18,21,2.00,'Does the job but feels cheap.','2025-03-27 23:16:19'),(404,11,23,5.00,'Perfect in every way.','2025-03-27 23:16:19'),(405,1,3,3.00,'Okay product, nothing special.','2025-03-27 23:16:19'),(406,5,4,4.00,'Nice quality, worth buying.','2025-03-27 23:16:19'),(407,4,21,3.00,'Fair value for money.','2025-03-27 23:16:19'),(408,19,16,1.00,'Customer support was unhelpful.','2025-03-27 23:16:19'),(409,20,6,5.00,'Best purchase Ive made!','2025-03-27 23:16:19'),(410,20,27,5.00,'Simply the best!','2025-03-27 23:16:19'),(411,3,2,4.00,'Better than expected!','2025-03-27 23:16:19'),(412,14,21,3.00,'Reasonable for the price point.','2025-03-27 23:16:19'),(413,4,29,1.00,'Shipping took forever, and item was damaged.','2025-03-27 23:16:19'),(414,12,7,5.00,'Perfect in every way.','2025-03-27 23:16:19'),(415,19,16,3.00,'Fair value for money.','2025-03-27 23:16:19'),(416,15,14,3.00,'Meh, its just alright.','2025-03-27 23:16:19'),(417,9,15,3.00,'Decent quality for the price.','2025-03-27 23:16:19'),(418,3,22,2.00,'Functional but very flimsy.','2025-03-27 23:16:19'),(419,9,22,3.00,'Not bad, but not amazing either.','2025-03-27 23:16:19'),(420,15,27,5.00,'Flawless, couldnt be happier.','2025-03-27 23:16:19'),(421,8,10,2.00,'Not great, but at least it works.','2025-03-27 23:16:19'),(422,1,3,5.00,'Perfect in every way.','2025-03-27 23:16:19'),(423,16,22,5.00,'Highly recommend to everyone.','2025-03-27 23:16:19'),(424,1,16,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:19'),(425,6,6,3.00,'Okay product, nothing special.','2025-03-27 23:16:19'),(426,14,12,4.00,'Satisfied with my purchase.','2025-03-27 23:16:19'),(427,9,27,3.00,'Could be better, but acceptable.','2025-03-27 23:16:19'),(428,5,17,3.00,'Somewhat satisfied, minor flaws.','2025-03-27 23:16:19'),(429,4,6,1.00,'Broke within a day, waste of money.','2025-03-27 23:16:19'),(430,5,11,4.00,'Good value for money.','2025-03-27 23:16:19'),(431,18,12,3.00,'Could be better, but acceptable.','2025-03-27 23:16:19'),(432,8,29,4.00,'Good value for money.','2025-03-27 23:16:19'),(433,10,11,5.00,'Highly recommend to everyone.','2025-03-27 23:16:19'),(434,7,2,3.00,'Neither good nor bad, just okay.','2025-03-27 23:16:19'),(435,5,8,5.00,'Simply the best!','2025-03-27 23:16:19'),(436,1,16,4.00,'Will probably buy again.','2025-03-27 23:16:19'),(437,3,23,5.00,'Amazing! Totally worth it.','2025-03-27 23:16:19'),(438,9,1,1.00,'Shipping took forever, and item was damaged.','2025-03-27 23:16:19'),(439,13,28,1.00,'Useless product, never buying again.','2025-03-27 23:16:19'),(440,19,8,5.00,'Absolutely fantastic, love it!','2025-03-27 23:16:19'),(441,4,17,4.00,'Pretty good, would recommend.','2025-03-27 23:16:19'),(442,20,12,2.00,'Does the job but feels cheap.','2025-03-27 23:16:19'),(443,16,14,2.00,'Had issues, but customer service helped.','2025-03-27 23:16:19'),(444,6,13,5.00,'Superb quality, will buy again.','2025-03-27 23:16:19'),(445,17,14,4.00,'Impressive for this price range.','2025-03-27 23:16:19'),(446,20,22,2.00,'Had issues, but customer service helped.','2025-03-27 23:16:19'),(447,5,30,4.00,'Works as described, happy with it.','2025-03-27 23:16:19'),(448,17,16,3.00,'Meh, its just alright.','2025-03-27 23:16:19'),(449,19,12,4.00,'Will probably buy again.','2025-03-27 23:16:19'),(450,2,7,1.00,'Useless product, never buying again.','2025-03-27 23:16:19'),(451,11,28,4.00,'Nice quality, worth buying.','2025-03-27 23:16:19'),(452,9,1,2.00,'Had issues, but customer service helped.','2025-03-27 23:16:19'),(453,7,28,4.00,'Met my expectations.','2025-03-27 23:16:19'),(454,19,11,1.00,'Customer support was unhelpful.','2025-03-27 23:16:19'),(455,19,5,4.00,'Pretty good, would recommend.','2025-03-27 23:16:19'),(456,7,22,1.00,'False advertising, nothing like the pictures.','2025-03-27 23:16:19'),(457,2,30,5.00,'Superb quality, will buy again.','2025-03-27 23:16:19'),(458,6,8,3.00,'Meh, its just alright.','2025-03-27 23:16:19'),(459,10,14,5.00,'Highly recommend to everyone.','2025-03-27 23:16:19'),(460,16,7,3.00,'Neither good nor bad, just okay.','2025-03-27 23:16:19'),(461,12,11,3.00,'Meh, its just alright.','2025-03-27 23:16:19'),(462,11,20,1.00,'False advertising, nothing like the pictures.','2025-03-27 23:16:19'),(463,3,9,3.00,'Not bad, but not amazing either.','2025-03-27 23:16:19'),(464,4,30,2.00,'Average at best, wouldnt repurchase.','2025-03-27 23:16:19'),(465,9,6,4.00,'Better than expected!','2025-03-27 23:16:19'),(466,10,22,5.00,'Simply the best!','2025-03-27 23:16:19'),(467,10,17,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:19'),(468,17,5,5.00,'Absolutely fantastic, love it!','2025-03-27 23:16:19'),(469,2,4,1.00,'Customer support was unhelpful.','2025-03-27 23:16:20'),(470,19,26,3.00,'Not bad, but not amazing either.','2025-03-27 23:16:20'),(471,13,14,3.00,'Reasonable for the price point.','2025-03-27 23:16:20'),(472,5,19,4.00,'Will probably buy again.','2025-03-27 23:16:20'),(473,13,11,2.00,'Average at best, wouldnt repurchase.','2025-03-27 23:16:20'),(474,16,21,3.00,'Reasonable for the price point.','2025-03-27 23:16:20'),(475,7,23,2.00,'Functional but very flimsy.','2025-03-27 23:16:20'),(476,13,2,5.00,'Superb quality, will buy again.','2025-03-27 23:16:20'),(477,3,15,4.00,'Pretty good, would recommend.','2025-03-27 23:16:20'),(478,19,12,4.00,'Nice quality, worth buying.','2025-03-27 23:16:20'),(479,11,15,5.00,'Superb quality, will buy again.','2025-03-27 23:16:20'),(480,3,17,1.00,'Customer support was unhelpful.','2025-03-27 23:16:20'),(481,16,23,3.00,'Okay product, nothing special.','2025-03-27 23:16:20'),(482,5,9,5.00,'Simply the best!','2025-03-27 23:16:20'),(483,18,17,1.00,'Customer support was unhelpful.','2025-03-27 23:16:20'),(484,8,30,2.00,'Had issues, but customer service helped.','2025-03-27 23:16:20'),(485,6,12,5.00,'Outstanding product and service.','2025-03-27 23:16:20'),(486,1,2,5.00,'Best purchase Ive made!','2025-03-27 23:16:20'),(487,5,18,4.00,'Satisfied with my purchase.','2025-03-27 23:16:20'),(488,18,2,1.00,'False advertising, nothing like the pictures.','2025-03-27 23:16:20'),(489,16,4,1.00,'Terrible quality, completely disappointed.','2025-03-27 23:16:20'),(490,12,17,5.00,'Superb quality, will buy again.','2025-03-27 23:16:20'),(491,19,14,5.00,'Exceeded all expectations!','2025-03-27 23:16:20'),(492,20,27,4.00,'Pretty good, would recommend.','2025-03-27 23:16:20'),(493,15,20,4.00,'Will probably buy again.','2025-03-27 23:16:20'),(494,10,30,2.00,'Shipping delay ruined the experience.','2025-03-27 23:16:20'),(495,13,14,3.00,'Not bad, but not amazing either.','2025-03-27 23:16:20'),(496,8,18,5.00,'Highly recommend to everyone.','2025-03-27 23:16:20'),(497,9,17,3.00,'Meh, its just alright.','2025-03-27 23:16:20'),(498,2,2,4.00,'Met my expectations.','2025-03-27 23:16:20'),(499,11,26,4.00,'Met my expectations.','2025-03-27 23:16:20'),(500,6,18,1.00,'False advertising, nothing like the pictures.','2025-03-27 23:16:20'),(501,17,29,2.00,'Had issues, but customer service helped.','2025-03-27 23:16:20'),(502,2,4,4.00,'Better than expected!','2025-03-27 23:16:20'),(503,19,22,2.00,'Not great, but at least it works.','2025-03-27 23:16:20'),(504,13,17,1.00,'False advertising, nothing like the pictures.','2025-03-27 23:16:20'),(505,17,26,5.00,'Amazing! Totally worth it.','2025-03-27 23:16:20'),(506,7,11,5.00,'Absolutely fantastic, love it!','2025-03-27 23:16:20'),(507,5,6,5.00,'Exceeded all expectations!','2025-03-27 23:16:20'),(508,1,1,5.00,'Perfect in every way.','2025-03-27 23:16:20'),(509,1,24,5.00,'Superb quality, will buy again.','2025-03-27 23:16:20'),(510,1,29,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:20'),(511,2,30,3.00,'Not bad, but not amazing either.','2025-03-27 23:16:20'),(512,14,6,4.00,'Solid product, performs well.','2025-03-27 23:16:20'),(513,6,4,5.00,'Best purchase Ive made!','2025-03-27 23:16:20'),(514,17,24,5.00,'Outstanding product and service.','2025-03-27 23:16:20'),(515,11,29,5.00,'Amazing! Totally worth it.','2025-03-27 23:16:20'),(516,5,3,3.00,'Mediocre, works fine but expected more.','2025-03-27 23:16:20'),(517,8,11,5.00,'Best purchase Ive made!','2025-03-27 23:16:20'),(518,15,2,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:20'),(519,15,28,1.00,'Terrible quality, completely disappointed.','2025-03-27 23:16:20'),(520,19,19,2.00,'Not great, but at least it works.','2025-03-27 23:16:20'),(521,10,20,4.00,'Nice quality, worth buying.','2025-03-27 23:16:20'),(522,19,17,4.00,'Nice quality, worth buying.','2025-03-27 23:16:20'),(523,10,14,2.00,'Functional but very flimsy.','2025-03-27 23:16:20'),(524,8,29,2.00,'Could be improved with better materials.','2025-03-27 23:16:20'),(525,9,11,2.00,'Shipping delay ruined the experience.','2025-03-27 23:16:20'),(526,7,21,2.00,'Had issues, but customer service helped.','2025-03-27 23:16:20'),(527,8,28,1.00,'Terrible quality, completely disappointed.','2025-03-27 23:16:20'),(528,9,13,2.00,'Could be improved with better materials.','2025-03-27 23:16:20'),(529,9,22,2.00,'Had issues, but customer service helped.','2025-03-27 23:16:20'),(530,7,19,1.00,'Absolutely awful experience!','2025-03-27 23:16:20'),(531,8,8,2.00,'Functional but very flimsy.','2025-03-27 23:16:20'),(532,1,12,3.00,'Neither good nor bad, just okay.','2025-03-27 23:16:20'),(533,3,23,3.00,'Not bad, but not amazing either.','2025-03-27 23:16:20'),(534,4,26,2.00,'Could be improved with better materials.','2025-03-27 23:16:20'),(535,14,4,3.00,'Somewhat satisfied, minor flaws.','2025-03-27 23:16:20'),(536,14,18,4.00,'Nice quality, worth buying.','2025-03-27 23:16:20'),(537,12,30,4.00,'Met my expectations.','2025-03-27 23:16:20'),(538,16,30,2.00,'Not as advertised, but usable.','2025-03-27 23:16:20'),(539,9,5,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:20'),(540,8,24,3.00,'Somewhat satisfied, minor flaws.','2025-03-27 23:16:20'),(541,5,21,2.00,'Not as advertised, but usable.','2025-03-27 23:16:20'),(542,8,18,5.00,'Outstanding product and service.','2025-03-27 23:16:20'),(543,10,8,1.00,'Doesnt work at all, total scam!','2025-03-27 23:16:20'),(544,7,17,2.00,'Not as advertised, but usable.','2025-03-27 23:16:20'),(545,10,9,3.00,'Could be better, but acceptable.','2025-03-27 23:16:20'),(546,12,25,4.00,'Will probably buy again.','2025-03-27 23:16:20'),(547,17,1,5.00,'Perfect in every way.','2025-03-27 23:16:20'),(548,18,22,3.00,'Not bad, but not amazing either.','2025-03-27 23:16:20'),(549,2,16,5.00,'Simply the best!','2025-03-27 23:16:20'),(550,1,17,3.00,'Reasonable for the price point.','2025-03-27 23:16:20'),(551,6,5,1.00,'Absolutely awful experience!','2025-03-27 23:16:20'),(552,1,14,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:20'),(553,4,30,1.00,'Useless product, never buying again.','2025-03-27 23:16:20'),(554,12,19,2.00,'Average at best, wouldnt repurchase.','2025-03-27 23:16:20'),(555,20,3,3.00,'Neither good nor bad, just okay.','2025-03-27 23:16:20'),(556,3,24,4.00,'Impressive for this price range.','2025-03-27 23:16:20'),(557,13,14,4.00,'Impressive for this price range.','2025-03-27 23:16:20'),(558,5,17,3.00,'Reasonable for the price point.','2025-03-27 23:16:20'),(559,14,12,2.00,'Could be improved with better materials.','2025-03-27 23:16:20'),(560,4,17,2.00,'Had issues, but customer service helped.','2025-03-27 23:16:20'),(561,19,10,2.00,'Does the job but feels cheap.','2025-03-27 23:16:20'),(562,17,19,2.00,'Shipping delay ruined the experience.','2025-03-27 23:16:20'),(563,3,24,3.00,'Mediocre, works fine but expected more.','2025-03-27 23:16:20'),(564,3,18,5.00,'Absolutely fantastic, love it!','2025-03-27 23:16:20'),(565,16,1,2.00,'Shipping delay ruined the experience.','2025-03-27 23:16:20'),(566,16,17,5.00,'Best purchase Ive made!','2025-03-27 23:16:20'),(567,13,9,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:20'),(568,9,25,4.00,'Met my expectations.','2025-03-27 23:16:20'),(569,13,4,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:20'),(570,4,20,2.00,'Poor build quality, wouldnt recommend.','2025-03-27 23:16:20'),(571,3,24,1.00,'Absolutely awful experience!','2025-03-27 23:16:20'),(572,11,20,4.00,'Met my expectations.','2025-03-27 23:16:20'),(573,3,19,1.00,'Useless product, never buying again.','2025-03-27 23:16:20'),(574,15,17,5.00,'Superb quality, will buy again.','2025-03-27 23:16:20'),(575,11,4,3.00,'Reasonable for the price point.','2025-03-27 23:16:20'),(576,15,10,2.00,'Does the job but feels cheap.','2025-03-27 23:16:20'),(577,17,8,3.00,'Not bad, but not amazing either.','2025-03-27 23:16:20'),(578,4,21,5.00,'Absolutely fantastic, love it!','2025-03-27 23:16:20'),(579,15,5,5.00,'Exceeded all expectations!','2025-03-27 23:16:20'),(580,8,17,2.00,'Shipping delay ruined the experience.','2025-03-27 23:16:20'),(581,6,6,5.00,'Amazing! Totally worth it.','2025-03-27 23:16:20'),(582,7,20,4.00,'Met my expectations.','2025-03-27 23:16:20'),(583,8,14,5.00,'Highly recommend to everyone.','2025-03-27 23:16:20'),(584,2,10,1.00,'Shipping took forever, and item was damaged.','2025-03-27 23:16:20'),(585,16,20,4.00,'Works as described, happy with it.','2025-03-27 23:16:20'),(586,18,26,3.00,'Reasonable for the price point.','2025-03-27 23:16:20'),(587,17,3,3.00,'Meh, its just alright.','2025-03-27 23:16:20'),(588,5,1,2.00,'Expected better, slightly disappointed.','2025-03-27 23:16:20'),(589,8,29,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:20'),(590,3,15,3.00,'Could be better, but acceptable.','2025-03-27 23:16:20'),(591,14,5,2.00,'Not great, but at least it works.','2025-03-27 23:16:20'),(592,8,1,3.00,'Mediocre, works fine but expected more.','2025-03-27 23:16:20'),(593,17,4,1.00,'Terrible quality, completely disappointed.','2025-03-27 23:16:20'),(594,16,9,5.00,'Simply the best!','2025-03-27 23:16:20'),(595,1,10,5.00,'Simply the best!','2025-03-27 23:16:20'),(596,8,25,4.00,'Good value for money.','2025-03-27 23:16:20'),(597,2,10,1.00,'Absolutely awful experience!','2025-03-27 23:16:20'),(598,6,13,4.00,'Solid product, performs well.','2025-03-27 23:16:20'),(599,16,4,2.00,'Average at best, wouldnt repurchase.','2025-03-27 23:16:20'),(600,6,30,4.00,'Nice quality, worth buying.','2025-03-27 23:16:20'),(601,16,15,1.00,'Broke within a day, waste of money.','2025-03-27 23:16:20'),(602,9,16,1.00,'Useless product, never buying again.','2025-03-27 23:16:20'),(603,14,11,5.00,'Perfect in every way.','2025-03-27 23:16:20'),(604,5,27,1.00,'False advertising, nothing like the pictures.','2025-03-27 23:16:20'),(605,18,7,4.00,'Works as described, happy with it.','2025-03-27 23:16:20'),(606,2,19,1.00,'False advertising, nothing like the pictures.','2025-03-27 23:16:20'),(607,20,26,5.00,'Absolutely fantastic, love it!','2025-03-27 23:16:20'),(608,1,20,1.00,'Worst product Ive ever bought!','2025-03-27 23:16:20'),(609,3,28,2.00,'Expected better, slightly disappointed.','2025-03-27 23:16:20'),(610,1,15,2.00,'Functional but very flimsy.','2025-03-27 23:16:20'),(611,19,4,2.00,'Not great, but at least it works.','2025-03-27 23:16:20'),(612,7,27,2.00,'Not as advertised, but usable.','2025-03-27 23:16:20'),(613,2,16,5.00,'Best purchase Ive made!','2025-03-27 23:16:20'),(614,14,15,3.00,'Somewhat satisfied, minor flaws.','2025-03-27 23:16:20'),(615,11,28,5.00,'Amazing! Totally worth it.','2025-03-27 23:16:20'),(616,17,13,4.00,'Will probably buy again.','2025-03-27 23:16:20'),(617,19,10,3.00,'Neither good nor bad, just okay.','2025-03-27 23:16:20'),(618,18,30,4.00,'Works as described, happy with it.','2025-03-27 23:16:20'),(619,17,28,4.00,'Good value for money.','2025-03-27 23:16:20'),(620,3,21,4.00,'Met my expectations.','2025-03-27 23:16:20'),(621,19,28,2.00,'Poor build quality, wouldnt recommend.','2025-03-27 23:16:20'),(622,8,25,3.00,'Fair value for money.','2025-03-27 23:16:20'),(623,15,5,2.00,'Had issues, but customer service helped.','2025-03-27 23:16:20'),(624,14,14,5.00,'Absolutely fantastic, love it!','2025-03-27 23:16:20'),(625,1,15,3.00,'Meh, its just alright.','2025-03-27 23:16:20'),(626,13,7,5.00,'Amazing! Totally worth it.','2025-03-27 23:16:20'),(627,19,1,4.00,'Better than expected!','2025-03-27 23:16:20'),(628,10,9,1.00,'False advertising, nothing like the pictures.','2025-03-27 23:16:20'),(629,12,17,5.00,'Amazing! Totally worth it.','2025-03-27 23:16:20'),(630,20,18,3.00,'Fair value for money.','2025-03-27 23:16:20'),(631,13,1,4.00,'Works as described, happy with it.','2025-03-27 23:16:20'),(632,8,16,2.00,'Could be improved with better materials.','2025-03-27 23:16:20'),(633,11,11,4.00,'Impressive for this price range.','2025-03-27 23:16:20'),(634,17,2,3.00,'Okay product, nothing special.','2025-03-27 23:16:20'),(635,3,5,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:20'),(636,18,26,1.00,'Doesnt work at all, total scam!','2025-03-27 23:16:20'),(637,20,30,3.00,'Not bad, but not amazing either.','2025-03-27 23:16:20'),(638,2,6,2.00,'Not as advertised, but usable.','2025-03-27 23:16:20'),(639,3,15,3.00,'Neither good nor bad, just okay.','2025-03-27 23:16:20'),(640,19,6,3.00,'Fair value for money.','2025-03-27 23:16:20'),(641,4,15,2.00,'Functional but very flimsy.','2025-03-27 23:16:20'),(642,2,15,3.00,'Reasonable for the price point.','2025-03-27 23:16:20'),(643,7,29,2.00,'Had issues, but customer service helped.','2025-03-27 23:16:20'),(644,3,17,5.00,'Best purchase Ive made!','2025-03-27 23:16:20'),(645,12,27,1.00,'Useless product, never buying again.','2025-03-27 23:16:20'),(646,20,30,3.00,'Okay product, nothing special.','2025-03-27 23:16:20'),(647,3,25,1.00,'Absolutely awful experience!','2025-03-27 23:16:20'),(648,7,29,4.00,'Nice quality, worth buying.','2025-03-27 23:16:20'),(649,10,16,5.00,'Absolutely fantastic, love it!','2025-03-27 23:16:20'),(650,5,12,1.00,'Doesnt work at all, total scam!','2025-03-27 23:16:20'),(651,3,30,4.00,'Good value for money.','2025-03-27 23:16:20'),(652,18,24,2.00,'Not as advertised, but usable.','2025-03-27 23:16:20'),(653,20,15,1.00,'Doesnt work at all, total scam!','2025-03-27 23:16:20'),(654,11,10,5.00,'Flawless, couldnt be happier.','2025-03-27 23:16:20'),(655,18,15,3.00,'Not bad, but not amazing either.','2025-03-27 23:16:20'),(656,9,8,3.00,'Could be better, but acceptable.','2025-03-27 23:16:20'),(657,8,18,1.00,'False advertising, nothing like the pictures.','2025-03-27 23:16:20'),(658,13,7,3.00,'Okay product, nothing special.','2025-03-27 23:16:20'),(659,13,1,2.00,'Functional but very flimsy.','2025-03-27 23:16:20'),(660,18,26,1.00,'Doesnt work at all, total scam!','2025-03-27 23:16:20'),(661,4,10,4.00,'Met my expectations.','2025-03-27 23:16:20'),(662,15,26,3.00,'Reasonable for the price point.','2025-03-27 23:16:20'),(663,6,29,3.00,'Okay product, nothing special.','2025-03-27 23:16:20'),(664,14,15,1.00,'Shipping took forever, and item was damaged.','2025-03-27 23:16:20'),(665,1,19,1.00,'Customer support was unhelpful.','2025-03-27 23:16:20'),(666,3,15,2.00,'Functional but very flimsy.','2025-03-27 23:16:20'),(667,18,4,3.00,'Meh, its just alright.','2025-03-27 23:16:20'),(668,13,17,4.00,'Works as described, happy with it.','2025-03-27 23:16:20'),(669,17,8,4.00,'Nice quality, worth buying.','2025-03-27 23:16:20'),(670,2,30,5.00,'Amazing! Totally worth it.','2025-03-27 23:16:20'),(671,16,13,2.00,'Could be improved with better materials.','2025-03-27 23:16:20'),(672,6,15,4.00,'Solid product, performs well.','2025-03-27 23:16:20'),(673,6,23,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:20'),(674,9,25,3.00,'Reasonable for the price point.','2025-03-27 23:16:20'),(675,14,27,2.00,'Average at best, wouldnt repurchase.','2025-03-27 23:16:20'),(676,17,6,3.00,'Fair value for money.','2025-03-27 23:16:20'),(677,4,9,3.00,'Not bad, but not amazing either.','2025-03-27 23:16:20'),(678,3,4,4.00,'Satisfied with my purchase.','2025-03-27 23:16:20'),(679,2,13,3.00,'Somewhat satisfied, minor flaws.','2025-03-27 23:16:20'),(680,6,28,2.00,'Expected better, slightly disappointed.','2025-03-27 23:16:20'),(681,9,17,1.00,'Useless product, never buying again.','2025-03-27 23:16:20'),(682,14,8,2.00,'Expected better, slightly disappointed.','2025-03-27 23:16:20'),(683,20,13,4.00,'Good value for money.','2025-03-27 23:16:20'),(684,6,2,1.00,'Doesnt work at all, total scam!','2025-03-27 23:16:20'),(685,10,18,5.00,'Absolutely fantastic, love it!','2025-03-27 23:16:20'),(686,6,18,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:20'),(687,4,5,3.00,'Mediocre, works fine but expected more.','2025-03-27 23:16:20'),(688,10,24,1.00,'Doesnt work at all, total scam!','2025-03-27 23:16:20'),(689,3,7,3.00,'Neither good nor bad, just okay.','2025-03-27 23:16:20'),(690,1,1,3.00,'Not bad, but not amazing either.','2025-03-27 23:16:20'),(691,16,15,1.00,'Shipping took forever, and item was damaged.','2025-03-27 23:16:20'),(692,2,25,3.00,'Decent quality for the price.','2025-03-27 23:16:20'),(693,17,12,4.00,'Nice quality, worth buying.','2025-03-27 23:16:20'),(694,11,21,4.00,'Solid product, performs well.','2025-03-27 23:16:20'),(695,6,19,2.00,'Average at best, wouldnt repurchase.','2025-03-27 23:16:20'),(696,12,6,2.00,'Shipping delay ruined the experience.','2025-03-27 23:16:20'),(697,6,23,1.00,'Absolutely awful experience!','2025-03-27 23:16:20'),(698,13,13,4.00,'Pretty good, would recommend.','2025-03-27 23:16:20'),(699,2,5,3.00,'Could be better, but acceptable.','2025-03-27 23:16:20'),(700,17,1,5.00,'Flawless, couldnt be happier.','2025-03-27 23:16:20'),(701,16,20,5.00,'Outstanding product and service.','2025-03-27 23:16:20'),(702,15,7,4.00,'Solid product, performs well.','2025-03-27 23:16:20'),(703,17,21,5.00,'Exceeded all expectations!','2025-03-27 23:16:20'),(704,14,26,1.00,'False advertising, nothing like the pictures.','2025-03-27 23:16:20'),(705,8,28,4.00,'Impressive for this price range.','2025-03-27 23:16:20'),(706,19,30,3.00,'Mediocre, works fine but expected more.','2025-03-27 23:16:20'),(707,3,7,5.00,'Outstanding product and service.','2025-03-27 23:16:20'),(708,1,22,1.00,'Customer support was unhelpful.','2025-03-27 23:16:20'),(709,2,30,3.00,'Reasonable for the price point.','2025-03-27 23:16:20'),(710,18,29,2.00,'Not great, but at least it works.','2025-03-27 23:16:20'),(711,3,14,3.00,'Reasonable for the price point.','2025-03-27 23:16:20'),(712,2,12,4.00,'Good value for money.','2025-03-27 23:16:20'),(713,14,6,4.00,'Good value for money.','2025-03-27 23:16:20'),(714,2,16,3.00,'Decent quality for the price.','2025-03-27 23:16:20'),(715,1,3,4.00,'Impressive for this price range.','2025-03-27 23:16:20'),(716,20,4,3.00,'Mediocre, works fine but expected more.','2025-03-27 23:16:20'),(717,7,13,5.00,'Highly recommend to everyone.','2025-03-27 23:16:20'),(718,12,4,4.00,'Nice quality, worth buying.','2025-03-27 23:16:20'),(719,10,23,3.00,'Reasonable for the price point.','2025-03-27 23:16:20'),(720,17,17,5.00,'Exceeded all expectations!','2025-03-27 23:16:20'),(721,20,22,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:20'),(722,9,19,4.00,'Works as described, happy with it.','2025-03-27 23:16:20'),(723,16,30,5.00,'Superb quality, will buy again.','2025-03-27 23:16:20'),(724,13,30,2.00,'Functional but very flimsy.','2025-03-27 23:16:20'),(725,11,13,2.00,'Shipping delay ruined the experience.','2025-03-27 23:16:20'),(726,9,16,3.00,'Not bad, but not amazing either.','2025-03-27 23:16:20'),(727,10,25,1.00,'Absolutely awful experience!','2025-03-27 23:16:20'),(728,9,30,4.00,'Good value for money.','2025-03-27 23:16:20'),(729,5,17,3.00,'Could be better, but acceptable.','2025-03-27 23:16:20'),(730,19,22,5.00,'Absolutely fantastic, love it!','2025-03-27 23:16:20'),(731,20,3,3.00,'Neither good nor bad, just okay.','2025-03-27 23:16:20'),(732,11,26,4.00,'Nice quality, worth buying.','2025-03-27 23:16:20'),(733,11,7,4.00,'Pretty good, would recommend.','2025-03-27 23:16:20'),(734,14,19,4.00,'Good value for money.','2025-03-27 23:16:20'),(735,13,18,2.00,'Functional but very flimsy.','2025-03-27 23:16:20'),(736,7,10,4.00,'Works as described, happy with it.','2025-03-27 23:16:20'),(737,2,6,1.00,'False advertising, nothing like the pictures.','2025-03-27 23:16:20'),(738,20,20,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:20'),(739,8,18,1.00,'False advertising, nothing like the pictures.','2025-03-27 23:16:20'),(740,13,1,2.00,'Functional but very flimsy.','2025-03-27 23:16:20'),(741,2,14,2.00,'Does the job but feels cheap.','2025-03-27 23:16:20'),(742,13,26,5.00,'Superb quality, will buy again.','2025-03-27 23:16:20'),(743,8,24,5.00,'Exceeded all expectations!','2025-03-27 23:16:20'),(744,8,24,2.00,'Shipping delay ruined the experience.','2025-03-27 23:16:20'),(745,20,16,5.00,'Exceeded all expectations!','2025-03-27 23:16:20'),(746,9,10,2.00,'Had issues, but customer service helped.','2025-03-27 23:16:20'),(747,7,12,4.00,'Good value for money.','2025-03-27 23:16:20'),(748,16,5,4.00,'Met my expectations.','2025-03-27 23:16:20'),(749,6,8,4.00,'Nice quality, worth buying.','2025-03-27 23:16:20'),(750,2,30,2.00,'Expected better, slightly disappointed.','2025-03-27 23:16:20'),(751,17,13,4.00,'Impressive for this price range.','2025-03-27 23:16:20'),(752,7,6,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:20'),(753,17,24,3.00,'Somewhat satisfied, minor flaws.','2025-03-27 23:16:20'),(754,13,11,4.00,'Will probably buy again.','2025-03-27 23:16:20'),(755,6,13,4.00,'Pretty good, would recommend.','2025-03-27 23:16:20'),(756,11,22,1.00,'Broke within a day, waste of money.','2025-03-27 23:16:20'),(757,12,14,1.00,'Broke within a day, waste of money.','2025-03-27 23:16:20'),(758,7,26,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:20'),(759,15,15,4.00,'Better than expected!','2025-03-27 23:16:20'),(760,17,14,4.00,'Better than expected!','2025-03-27 23:16:20'),(761,15,19,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:20'),(762,3,28,2.00,'Had issues, but customer service helped.','2025-03-27 23:16:20'),(763,14,28,2.00,'Not great, but at least it works.','2025-03-27 23:16:20'),(764,18,15,5.00,'Perfect in every way.','2025-03-27 23:16:20'),(765,6,4,4.00,'Impressive for this price range.','2025-03-27 23:16:20'),(766,4,27,3.00,'Could be better, but acceptable.','2025-03-27 23:16:20'),(767,1,1,2.00,'Average at best, wouldnt repurchase.','2025-03-27 23:16:20'),(768,10,6,5.00,'Outstanding product and service.','2025-03-27 23:16:20'),(769,4,7,3.00,'Meh, its just alright.','2025-03-27 23:16:20'),(770,17,3,3.00,'Fair value for money.','2025-03-27 23:16:20'),(771,4,25,1.00,'Customer support was unhelpful.','2025-03-27 23:16:20'),(772,9,4,1.00,'Doesnt work at all, total scam!','2025-03-27 23:16:20'),(773,3,26,5.00,'Simply the best!','2025-03-27 23:16:20'),(774,16,2,4.00,'Will probably buy again.','2025-03-27 23:16:20'),(775,18,11,1.00,'Absolutely awful experience!','2025-03-27 23:16:20'),(776,12,7,4.00,'Will probably buy again.','2025-03-27 23:16:20'),(777,16,17,4.00,'Satisfied with my purchase.','2025-03-27 23:16:20'),(778,15,12,5.00,'Exceeded all expectations!','2025-03-27 23:16:20'),(779,12,14,4.00,'Works as described, happy with it.','2025-03-27 23:16:20'),(780,5,24,2.00,'Shipping delay ruined the experience.','2025-03-27 23:16:20'),(781,15,7,3.00,'Somewhat satisfied, minor flaws.','2025-03-27 23:16:20'),(782,8,26,4.00,'Solid product, performs well.','2025-03-27 23:16:20'),(783,20,9,4.00,'Pretty good, would recommend.','2025-03-27 23:16:20'),(784,14,5,1.00,'Terrible quality, completely disappointed.','2025-03-27 23:16:20'),(785,20,4,1.00,'Useless product, never buying again.','2025-03-27 23:16:20'),(786,16,23,1.00,'Absolutely awful experience!','2025-03-27 23:16:20'),(787,4,15,5.00,'Flawless, couldnt be happier.','2025-03-27 23:16:20'),(788,3,25,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:20'),(789,17,26,1.00,'Customer support was unhelpful.','2025-03-27 23:16:20'),(790,15,9,1.00,'Broke within a day, waste of money.','2025-03-27 23:16:20'),(791,15,23,3.00,'Fair value for money.','2025-03-27 23:16:20'),(792,20,1,2.00,'Shipping delay ruined the experience.','2025-03-27 23:16:20'),(793,1,10,5.00,'Highly recommend to everyone.','2025-03-27 23:16:20'),(794,17,10,5.00,'Superb quality, will buy again.','2025-03-27 23:16:20'),(795,6,8,3.00,'Reasonable for the price point.','2025-03-27 23:16:20'),(796,4,27,4.00,'Will probably buy again.','2025-03-27 23:16:20'),(797,19,21,3.00,'Meh, its just alright.','2025-03-27 23:16:20'),(798,16,17,4.00,'Satisfied with my purchase.','2025-03-27 23:16:20'),(799,19,22,5.00,'Absolutely fantastic, love it!','2025-03-27 23:16:20'),(800,14,20,1.00,'Useless product, never buying again.','2025-03-27 23:16:20'),(801,3,14,5.00,'Absolutely fantastic, love it!','2025-03-27 23:16:20'),(802,16,21,2.00,'Poor build quality, wouldnt recommend.','2025-03-27 23:16:20'),(803,12,8,4.00,'Satisfied with my purchase.','2025-03-27 23:16:20'),(804,19,25,4.00,'Pretty good, would recommend.','2025-03-27 23:16:20'),(805,17,4,5.00,'Absolutely fantastic, love it!','2025-03-27 23:16:20'),(806,10,24,1.00,'Terrible quality, completely disappointed.','2025-03-27 23:16:20'),(807,5,20,5.00,'Amazing! Totally worth it.','2025-03-27 23:16:20'),(808,3,28,2.00,'Had issues, but customer service helped.','2025-03-27 23:16:20'),(809,20,30,3.00,'Fair value for money.','2025-03-27 23:16:20'),(810,14,19,4.00,'Satisfied with my purchase.','2025-03-27 23:16:20'),(811,3,17,2.00,'Shipping delay ruined the experience.','2025-03-27 23:16:20'),(812,6,14,1.00,'Doesnt work at all, total scam!','2025-03-27 23:16:20'),(813,5,17,4.00,'Met my expectations.','2025-03-27 23:16:20'),(814,5,7,5.00,'Best purchase Ive made!','2025-03-27 23:16:20'),(815,20,8,5.00,'Simply the best!','2025-03-27 23:16:20'),(816,4,27,5.00,'Perfect in every way.','2025-03-27 23:16:20'),(817,14,20,1.00,'Broke within a day, waste of money.','2025-03-27 23:16:20'),(818,5,28,5.00,'Outstanding product and service.','2025-03-27 23:16:20'),(819,20,19,5.00,'Highly recommend to everyone.','2025-03-27 23:16:20'),(820,6,9,5.00,'Exceeded all expectations!','2025-03-27 23:16:20'),(821,4,13,3.00,'Fair value for money.','2025-03-27 23:16:20'),(822,16,10,1.00,'Terrible quality, completely disappointed.','2025-03-27 23:16:20'),(823,11,14,4.00,'Met my expectations.','2025-03-27 23:16:20'),(824,20,20,2.00,'Functional but very flimsy.','2025-03-27 23:16:20'),(825,19,12,2.00,'Functional but very flimsy.','2025-03-27 23:16:20'),(826,11,1,1.00,'Worst product Ive ever bought!','2025-03-27 23:16:20'),(827,1,23,1.00,'Useless product, never buying again.','2025-03-27 23:16:20'),(828,13,23,3.00,'Fair value for money.','2025-03-27 23:16:20'),(829,12,29,3.00,'Not bad, but not amazing either.','2025-03-27 23:16:20'),(830,3,9,2.00,'Not as advertised, but usable.','2025-03-27 23:16:20'),(831,14,27,1.00,'Broke within a day, waste of money.','2025-03-27 23:16:20'),(832,4,10,4.00,'Satisfied with my purchase.','2025-03-27 23:16:20'),(833,17,9,1.00,'False advertising, nothing like the pictures.','2025-03-27 23:16:20'),(834,15,6,4.00,'Works as described, happy with it.','2025-03-27 23:16:20'),(835,8,22,2.00,'Not as advertised, but usable.','2025-03-27 23:16:20'),(836,11,19,2.00,'Had issues, but customer service helped.','2025-03-27 23:16:20'),(837,10,11,5.00,'Exceeded all expectations!','2025-03-27 23:16:20'),(838,1,11,4.00,'Will probably buy again.','2025-03-27 23:16:20'),(839,6,28,5.00,'Exceeded all expectations!','2025-03-27 23:16:20'),(840,14,20,3.00,'Okay product, nothing special.','2025-03-27 23:16:20'),(841,5,24,3.00,'Reasonable for the price point.','2025-03-27 23:16:20'),(842,13,26,3.00,'Mediocre, works fine but expected more.','2025-03-27 23:16:20'),(843,6,24,1.00,'Absolutely awful experience!','2025-03-27 23:16:20'),(844,11,1,2.00,'Not as advertised, but usable.','2025-03-27 23:16:20'),(845,14,26,1.00,'Broke within a day, waste of money.','2025-03-27 23:16:20'),(846,19,27,1.00,'False advertising, nothing like the pictures.','2025-03-27 23:16:20'),(847,15,3,4.00,'Satisfied with my purchase.','2025-03-27 23:16:20'),(848,3,21,2.00,'Not as advertised, but usable.','2025-03-27 23:16:20'),(849,9,3,3.00,'Meh, its just alright.','2025-03-27 23:16:20'),(850,11,6,3.00,'Fair value for money.','2025-03-27 23:16:20'),(851,15,25,1.00,'Shipping took forever, and item was damaged.','2025-03-27 23:16:20'),(852,5,5,5.00,'Flawless, couldnt be happier.','2025-03-27 23:16:20'),(853,20,24,5.00,'Best purchase Ive made!','2025-03-27 23:16:20'),(854,5,15,1.00,'Doesnt work at all, total scam!','2025-03-27 23:16:20'),(855,20,13,2.00,'Could be improved with better materials.','2025-03-27 23:16:20'),(856,14,26,2.00,'Poor build quality, wouldnt recommend.','2025-03-27 23:16:20'),(857,11,22,5.00,'Highly recommend to everyone.','2025-03-27 23:16:20'),(858,11,17,1.00,'Customer support was unhelpful.','2025-03-27 23:16:20'),(859,6,9,2.00,'Not as advertised, but usable.','2025-03-27 23:16:20'),(860,6,7,5.00,'Best purchase Ive made!','2025-03-27 23:16:20'),(861,1,15,5.00,'Superb quality, will buy again.','2025-03-27 23:16:20'),(862,3,15,5.00,'Absolutely fantastic, love it!','2025-03-27 23:16:20'),(863,6,9,4.00,'Satisfied with my purchase.','2025-03-27 23:16:20'),(864,3,13,3.00,'Mediocre, works fine but expected more.','2025-03-27 23:16:20'),(865,2,27,2.00,'Shipping delay ruined the experience.','2025-03-27 23:16:20'),(866,20,20,4.00,'Good value for money.','2025-03-27 23:16:20'),(867,18,19,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:20'),(868,4,11,5.00,'Exceeded all expectations!','2025-03-27 23:16:20'),(869,12,1,1.00,'Absolutely awful experience!','2025-03-27 23:16:20'),(870,13,3,2.00,'Not as advertised, but usable.','2025-03-27 23:16:20'),(871,8,21,1.00,'Useless product, never buying again.','2025-03-27 23:16:20'),(872,18,17,5.00,'Outstanding product and service.','2025-03-27 23:16:20'),(873,5,8,4.00,'Good value for money.','2025-03-27 23:16:20'),(874,17,11,1.00,'Absolutely awful experience!','2025-03-27 23:16:20'),(875,15,16,4.00,'Good value for money.','2025-03-27 23:16:20'),(876,18,22,2.00,'Does the job but feels cheap.','2025-03-27 23:16:20'),(877,1,6,4.00,'Will probably buy again.','2025-03-27 23:16:20'),(878,10,20,2.00,'Average at best, wouldnt repurchase.','2025-03-27 23:16:20'),(879,11,10,2.00,'Shipping delay ruined the experience.','2025-03-27 23:16:20'),(880,4,30,4.00,'Satisfied with my purchase.','2025-03-27 23:16:20'),(881,8,18,4.00,'Solid product, performs well.','2025-03-27 23:16:20'),(882,8,19,4.00,'Better than expected!','2025-03-27 23:16:20'),(883,10,24,2.00,'Average at best, wouldnt repurchase.','2025-03-27 23:16:20'),(884,8,2,5.00,'Amazing! Totally worth it.','2025-03-27 23:16:20'),(885,14,23,1.00,'Shipping took forever, and item was damaged.','2025-03-27 23:16:20'),(886,17,22,1.00,'Terrible quality, completely disappointed.','2025-03-27 23:16:20'),(887,13,19,5.00,'Simply the best!','2025-03-27 23:16:20'),(888,13,7,2.00,'Average at best, wouldnt repurchase.','2025-03-27 23:16:20'),(889,14,5,4.00,'Impressive for this price range.','2025-03-27 23:16:20'),(890,19,28,5.00,'Simply the best!','2025-03-27 23:16:20'),(891,16,10,5.00,'Exceeded all expectations!','2025-03-27 23:16:20'),(892,6,23,3.00,'Fair value for money.','2025-03-27 23:16:20'),(893,18,14,5.00,'Exceeded all expectations!','2025-03-27 23:16:20'),(894,9,11,3.00,'Meh, its just alright.','2025-03-27 23:16:20'),(895,5,6,3.00,'Somewhat satisfied, minor flaws.','2025-03-27 23:16:20'),(896,1,2,2.00,'Had issues, but customer service helped.','2025-03-27 23:16:20'),(897,17,2,4.00,'Better than expected!','2025-03-27 23:16:20'),(898,18,21,2.00,'Not great, but at least it works.','2025-03-27 23:16:20'),(899,10,3,2.00,'Could be improved with better materials.','2025-03-27 23:16:20'),(900,13,8,1.00,'Terrible quality, completely disappointed.','2025-03-27 23:16:20'),(901,17,15,3.00,'Not bad, but not amazing either.','2025-03-27 23:16:20'),(902,4,3,2.00,'Functional but very flimsy.','2025-03-27 23:16:20'),(903,16,10,5.00,'Outstanding product and service.','2025-03-27 23:16:20'),(904,3,12,3.00,'Okay product, nothing special.','2025-03-27 23:16:20'),(905,10,28,1.00,'Worst product Ive ever bought!','2025-03-27 23:16:20'),(906,2,10,2.00,'Not as advertised, but usable.','2025-03-27 23:16:20'),(907,1,13,2.00,'Had issues, but customer service helped.','2025-03-27 23:16:20'),(908,4,27,2.00,'Not great, but at least it works.','2025-03-27 23:16:20'),(909,3,3,5.00,'Absolutely fantastic, love it!','2025-03-27 23:16:20'),(910,7,1,1.00,'Absolutely awful experience!','2025-03-27 23:16:20'),(911,18,21,5.00,'Flawless, couldnt be happier.','2025-03-27 23:16:20'),(912,5,30,5.00,'Superb quality, will buy again.','2025-03-27 23:16:20'),(913,5,2,2.00,'Shipping delay ruined the experience.','2025-03-27 23:16:20'),(914,15,26,5.00,'Amazing! Totally worth it.','2025-03-27 23:16:20'),(915,19,21,5.00,'Flawless, couldnt be happier.','2025-03-27 23:16:20'),(916,7,17,1.00,'Worst product Ive ever bought!','2025-03-27 23:16:20'),(917,18,29,5.00,'Perfect in every way.','2025-03-27 23:16:20'),(918,3,5,1.00,'Useless product, never buying again.','2025-03-27 23:16:20'),(919,19,13,2.00,'Expected better, slightly disappointed.','2025-03-27 23:16:20'),(920,20,6,5.00,'Exceeded all expectations!','2025-03-27 23:16:20'),(921,18,26,2.00,'Expected better, slightly disappointed.','2025-03-27 23:16:20'),(922,3,5,2.00,'Poor build quality, wouldnt recommend.','2025-03-27 23:16:20'),(923,18,15,4.00,'Good value for money.','2025-03-27 23:16:20'),(924,7,19,1.00,'Doesnt work at all, total scam!','2025-03-27 23:16:20'),(925,4,25,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:20'),(926,1,22,4.00,'Impressive for this price range.','2025-03-27 23:16:20'),(927,7,30,3.00,'Could be better, but acceptable.','2025-03-27 23:16:20'),(928,4,30,5.00,'Highly recommend to everyone.','2025-03-27 23:16:20'),(929,19,6,4.00,'Works as described, happy with it.','2025-03-27 23:16:20'),(930,17,28,5.00,'Amazing! Totally worth it.','2025-03-27 23:16:20'),(931,11,7,5.00,'Perfect in every way.','2025-03-27 23:16:20'),(932,14,17,3.00,'Somewhat satisfied, minor flaws.','2025-03-27 23:16:20'),(933,11,14,4.00,'Better than expected!','2025-03-27 23:16:20'),(934,16,20,3.00,'Could be better, but acceptable.','2025-03-27 23:16:20'),(935,10,27,3.00,'Reasonable for the price point.','2025-03-27 23:16:20'),(936,2,12,5.00,'Perfect in every way.','2025-03-27 23:16:20'),(937,9,14,2.00,'Not as advertised, but usable.','2025-03-27 23:16:20'),(938,8,15,1.00,'Doesnt work at all, total scam!','2025-03-27 23:16:20'),(939,10,3,1.00,'Worst product Ive ever bought!','2025-03-27 23:16:20'),(940,3,16,1.00,'Absolutely awful experience!','2025-03-27 23:16:20'),(941,2,19,3.00,'Mediocre, works fine but expected more.','2025-03-27 23:16:20'),(942,19,11,4.00,'Solid product, performs well.','2025-03-27 23:16:20'),(943,9,12,5.00,'Exceeded all expectations!','2025-03-27 23:16:20'),(944,15,26,5.00,'Perfect in every way.','2025-03-27 23:16:20'),(945,6,21,2.00,'Could be improved with better materials.','2025-03-27 23:16:20'),(946,6,3,5.00,'Exceeded all expectations!','2025-03-27 23:16:20'),(947,6,17,3.00,'Meh, its just alright.','2025-03-27 23:16:20'),(948,14,4,2.00,'Shipping delay ruined the experience.','2025-03-27 23:16:20'),(949,7,5,4.00,'Works as described, happy with it.','2025-03-27 23:16:20'),(950,20,10,3.00,'Meh, its just alright.','2025-03-27 23:16:20'),(951,7,4,3.00,'Mediocre, works fine but expected more.','2025-03-27 23:16:20'),(952,1,19,4.00,'Good value for money.','2025-03-27 23:16:20'),(953,20,29,1.00,'Absolutely awful experience!','2025-03-27 23:16:20'),(954,14,14,1.00,'False advertising, nothing like the pictures.','2025-03-27 23:16:20'),(955,11,10,5.00,'Exceeded all expectations!','2025-03-27 23:16:20'),(956,20,7,1.00,'Doesnt work at all, total scam!','2025-03-27 23:16:20'),(957,7,22,4.00,'Met my expectations.','2025-03-27 23:16:20'),(958,17,16,1.00,'Broke within a day, waste of money.','2025-03-27 23:16:20'),(959,7,24,5.00,'Outstanding product and service.','2025-03-27 23:16:20'),(960,17,18,3.00,'Mediocre, works fine but expected more.','2025-03-27 23:16:20'),(961,14,16,1.00,'Absolutely awful experience!','2025-03-27 23:16:20'),(962,9,3,1.00,'Useless product, never buying again.','2025-03-27 23:16:20'),(963,18,28,1.00,'Doesnt work at all, total scam!','2025-03-27 23:16:20'),(964,10,17,4.00,'Nice quality, worth buying.','2025-03-27 23:16:20'),(965,12,7,3.00,'Neither good nor bad, just okay.','2025-03-27 23:16:20'),(966,12,21,1.00,'Doesnt work at all, total scam!','2025-03-27 23:16:20'),(967,9,19,1.00,'Very poor quality, not worth it.','2025-03-27 23:16:20'),(968,4,22,2.00,'Expected better, slightly disappointed.','2025-03-27 23:16:20'),(969,4,4,3.00,'Meh, its just alright.','2025-03-27 23:16:20'),(970,2,20,2.00,'Had issues, but customer service helped.','2025-03-27 23:16:20'),(971,16,18,1.00,'Customer support was unhelpful.','2025-03-27 23:16:20'),(972,15,5,3.00,'Not bad, but not amazing either.','2025-03-27 23:16:20'),(973,19,20,5.00,'Absolutely fantastic, love it!','2025-03-27 23:16:20'),(974,13,16,1.00,'Worst product Ive ever bought!','2025-03-27 23:16:20'),(975,12,14,5.00,'Outstanding product and service.','2025-03-27 23:16:20'),(976,12,12,5.00,'Amazing! Totally worth it.','2025-03-27 23:16:20'),(977,19,22,4.00,'Works as described, happy with it.','2025-03-27 23:16:20'),(978,10,9,5.00,'Best purchase Ive made!','2025-03-27 23:16:20'),(979,10,28,4.00,'Satisfied with my purchase.','2025-03-27 23:16:20'),(980,19,25,3.00,'Could be better, but acceptable.','2025-03-27 23:16:20'),(981,11,2,3.00,'Neither good nor bad, just okay.','2025-03-27 23:16:20'),(982,5,19,4.00,'Met my expectations.','2025-03-27 23:16:21'),(983,20,12,3.00,'Fair value for money.','2025-03-27 23:16:21'),(984,15,3,1.00,'Doesnt work at all, total scam!','2025-03-27 23:16:21'),(985,4,4,4.00,'Impressive for this price range.','2025-03-27 23:16:21'),(986,10,19,4.00,'Good value for money.','2025-03-27 23:16:21'),(987,9,16,5.00,'Superb quality, will buy again.','2025-03-27 23:16:21'),(988,7,16,3.00,'Fair value for money.','2025-03-27 23:16:21'),(989,17,28,5.00,'Amazing! Totally worth it.','2025-03-27 23:16:21'),(990,20,6,5.00,'Outstanding product and service.','2025-03-27 23:16:21'),(991,18,6,5.00,'Flawless, couldnt be happier.','2025-03-27 23:16:21'),(992,19,10,4.00,'Impressive for this price range.','2025-03-27 23:16:21'),(993,12,18,1.00,'Useless product, never buying again.','2025-03-27 23:16:21'),(994,7,24,5.00,'Best purchase Ive made!','2025-03-27 23:16:21'),(995,12,4,5.00,'Simply the best!','2025-03-27 23:16:21'),(996,13,12,2.00,'Average at best, wouldnt repurchase.','2025-03-27 23:16:21'),(997,16,18,3.00,'Neither good nor bad, just okay.','2025-03-27 23:16:21'),(998,4,27,2.00,'Not great, but at least it works.','2025-03-27 23:16:21'),(999,16,14,5.00,'Absolutely fantastic, love it!','2025-03-27 23:16:21'),(1000,13,10,2.00,'Poor build quality, wouldnt recommend.','2025-03-27 23:16:21');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_insert_review` BEFORE INSERT ON `reviews` FOR EACH ROW BEGIN
    DECLARE next_id INT;
    SELECT IFNULL(MAX(review_id), 0) + 1 INTO next_id FROM reviews;
    SET NEW.review_id = next_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_product_rating` AFTER INSERT ON `reviews` FOR EACH ROW BEGIN
    UPDATE Products
    SET rating = (SELECT AVG(rating) FROM Reviews WHERE product_id = NEW.product_id)
    WHERE product_id = NEW.product_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suppliers` (
  `supplier_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `contact_email` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` text NOT NULL,
  PRIMARY KEY (`supplier_id`),
  UNIQUE KEY `contact_email` (`contact_email`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suppliers`
--

LOCK TABLES `suppliers` WRITE;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
INSERT INTO `suppliers` VALUES (1,'Nike Suppliers','nike@example.com','123-456-7890','123 Sports Street'),(2,'Adidas Distributors','adidas@example.com','234-567-8901','456 Athletic Ave'),(3,'Puma Sports','puma@example.com','345-678-9012','789 Gym Lane'),(4,'Reebok Gear','reebok@example.com','456-789-0123','101 Fitness Blvd'),(5,'Under Armour','ua@example.com','567-890-1234','202 Outdoor Rd'),(6,'Decathlon','decathlon@example.com','678-901-2345','303 Equipment St'),(7,'New Balance','nb@example.com','789-012-3456','404 Running Way'),(8,'Asics Wholesale','asics@example.com','890-123-4567','505 Track Circle'),(9,'Wilson Sports','wilson@example.com','901-234-5678','606 Tennis Court'),(10,'Yonex Distributors','yonex@example.com','012-345-6789','707 Badminton Plaza'),(11,'gundu','646464','3232323','3232323');
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_insert_supplier` BEFORE INSERT ON `suppliers` FOR EACH ROW BEGIN
    DECLARE next_id INT;
    SELECT IFNULL(MAX(supplier_id), 0) + 1 INTO next_id FROM suppliers;
    SET NEW.supplier_id = next_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_delete_supplier` BEFORE DELETE ON `suppliers` FOR EACH ROW BEGIN
    DELETE FROM products WHERE supplier_id = OLD.supplier_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('admin','marketing_analyst','sales_manager','customer_support') NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (2,'admin','admin','admin','admin','2025-03-28 13:05:05'),(3,'ma','ma','ma','marketing_analyst','2025-03-28 13:05:37'),(4,'sm','sm','sm','sales_manager','2025-03-28 13:08:28'),(5,'csm','csm','csm','customer_support','2025-03-28 13:08:44'),(6,'marketing_analyst','marketing_analyst','marketing_analyst','admin','2025-03-28 13:10:16'),(7,'sales_manager','sales_manager','sales_manager','sales_manager','2025-03-28 13:10:32'),(8,'customer_support','customer_support','customer_support','admin','2025-03-28 13:10:45'),(9,'a','a','a','admin','2025-03-28 13:24:16'),(10,'as','iith@iith.ac.in','iith','customer_support','2025-03-28 15:39:33');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_insert_user` BEFORE INSERT ON `users` FOR EACH ROW BEGIN
    DECLARE next_id INT;
    SELECT IFNULL(MAX(user_id), 0) + 1 INTO next_id FROM users;
    SET NEW.user_id = next_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'sports_retail'
--

--
-- Dumping routines for database 'sports_retail'
--
/*!50003 DROP PROCEDURE IF EXISTS `AddStock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddStock`(
    IN prod_id INT,
    IN stock_amount INT
)
BEGIN
    UPDATE Products 
    SET stock_quantity = stock_quantity + stock_amount
    WHERE product_id = prod_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AnalyzeReviewImpact` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AnalyzeReviewImpact`()
BEGIN
    SELECT 
        p.product_id, 
        p.name, 
        COALESCE(r.avg_rating, 0) AS avg_rating,
        COALESCE(s.total_sales, 0) AS total_sales
    FROM products p
    LEFT JOIN (
        SELECT product_id, AVG(rating) AS avg_rating
        FROM reviews
        GROUP BY product_id
    ) r ON p.product_id = r.product_id
    LEFT JOIN (
        SELECT oi.product_id, SUM(oi.quantity) AS total_sales
        FROM order_items oi
        JOIN orders o ON oi.order_id = o.order_id
        WHERE YEAR(o.order_date) = 2025
        GROUP BY oi.product_id
    ) s ON p.product_id = s.product_id
    ORDER BY avg_rating DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ApplyDiscounts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ApplyDiscounts`(
    IN high_stock_discount DECIMAL(5,2), 
    IN low_rating_discount DECIMAL(5,2), 
    IN clearance_discount DECIMAL(5,2), 
    IN seasonal_discount DECIMAL(5,2)
)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE pid INT;
    DECLARE pstock INT;
    DECLARE psales INT;
    DECLARE avg_rating DECIMAL(3,2);
    DECLARE product_age INT;
    DECLARE current_price DECIMAL(10,2);
    DECLARE discount_percent DECIMAL(5,2);
    DECLARE discounted_price DECIMAL(10,2);

    DECLARE cur CURSOR FOR 
        SELECT p.product_id, p.stock_quantity, p.price, 
               COALESCE(SUM(oi.quantity), 0) AS total_sales, 
               COALESCE(AVG(r.rating), 3.0) AS avg_rating,
               DATEDIFF(NOW(), p.created_at) AS product_age
        FROM products p
        LEFT JOIN order_items oi ON p.product_id = oi.product_id
        LEFT JOIN reviews r ON p.product_id = r.product_id
        GROUP BY p.product_id, p.stock_quantity, p.price, p.created_at;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO pid, pstock, current_price, psales, avg_rating, product_age;
        IF done THEN 
            LEAVE read_loop;
        END IF;

        SET discount_percent = GREATEST(
            CASE WHEN pstock > 200 AND psales < 20 THEN high_stock_discount ELSE 0 END,
            CASE WHEN avg_rating < 3.0 THEN low_rating_discount ELSE 0 END,
            CASE WHEN product_age > 365 THEN clearance_discount ELSE 0 END,
            seasonal_discount
        );


        SET discounted_price = current_price * (1 - discount_percent / 100);

        
        SELECT pid AS product_id, discounted_price AS new_price, discount_percent AS applied_discount;
    
    END LOOP;

    CLOSE cur;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ApplyDynamicPricing` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ApplyDynamicPricing`(
    IN demand_factor DECIMAL(5,2)
)
BEGIN
    UPDATE products p
    JOIN (
        SELECT oi.product_id, COUNT(oi.order_id) AS total_orders
        FROM order_items oi
        GROUP BY oi.product_id
    ) AS order_stats
    ON p.product_id = order_stats.product_id
    SET p.price = p.price * (1 + (order_stats.total_orders / 100) * demand_factor);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CheckStockDemandMismatch` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CheckStockDemandMismatch`()
BEGIN
    SELECT 
        p.product_id, 
        p.name, 
        p.stock_quantity, 
        COALESCE(SUM(oi.quantity), 0) AS total_sold,
        CASE 
            WHEN p.stock_quantity > (SUM(oi.quantity) * 2) THEN 'Overstocked'
            WHEN p.stock_quantity < (SUM(oi.quantity) * 0.5) THEN 'Understocked'
            ELSE 'Balanced'
        END AS stock_status
    FROM products p
    LEFT JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY p.product_id, p.name, p.stock_quantity
    HAVING stock_status != 'Balanced';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EditCategory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EditCategory`(
    IN cat_id INT, 
    IN cat_name VARCHAR(100), 
    IN cat_desc TEXT
)
BEGIN
    UPDATE Categories 
    SET category_name = cat_name, 
        description = cat_desc 
    WHERE category_id = cat_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EditProduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EditProduct`(
    IN prod_id INT,
    IN prod_name VARCHAR(100),
    IN prod_price DECIMAL(10,2),
    IN prod_stock INT,
    IN prod_category INT,
    IN prod_supplier INT
)
BEGIN
    UPDATE Products 
    SET name = prod_name, 
        price = prod_price, 
        stock_quantity = prod_stock, 
        category_id = prod_category, 
        supplier_id = prod_supplier 
    WHERE product_id = prod_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllCategories` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllCategories`()
BEGIN
    SELECT category_id, category_name FROM Categories;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllDiscounts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllDiscounts`()
BEGIN
    SELECT d.discount_id, d.product_id, d.discount_percentage, d.start_date, d.end_date, p.name AS product_name
    FROM discounts d
    JOIN Products p ON d.product_id = p.product_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAllProducts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllProducts`()
BEGIN
    SELECT product_id, name FROM Products;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetLowStockProducts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetLowStockProducts`(IN min_stock INT)
BEGIN
    SELECT 
        product_id, 
        name, 
        stock_quantity 
    FROM products
    WHERE stock_quantity < min_stock;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetOverstockedSlowMovers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetOverstockedSlowMovers`(IN min_sales INT, IN max_stock INT)
BEGIN
    SELECT 
        p.product_id, 
        p.name, 
        p.stock_quantity, 
        COALESCE(SUM(oi.quantity), 0) AS total_sold
    FROM products p
    LEFT JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY p.product_id, p.name, p.stock_quantity
    HAVING total_sold < min_sales AND stock_quantity > max_stock;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetPricingTrends` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPricingTrends`()
BEGIN
    SELECT p.product_id, p.name, p.price, AVG(oi.unit_price) AS avg_selling_price,
           COUNT(oi.order_id) AS total_orders
    FROM products p
    LEFT JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY p.product_id, p.name, p.price
    ORDER BY total_orders DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetPricingTrends2025` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPricingTrends2025`()
BEGIN
    SELECT 
        MONTH(o.order_date) AS month,
        oi.product_id, 
        p.name AS product_name,
        p.price AS original_price,
        COALESCE(MAX(d.discount_percentage), 0) AS max_discount,
        p.price * (1 - COALESCE(MAX(d.discount_percentage), 0) / 100) AS final_price,
        CASE 
            WHEN MAX(d.discount_percentage) > 0 THEN "Discounted"
            ELSE "Original"
        END AS price_type
    FROM order_items oi
    JOIN orders o ON oi.order_id = o.order_id
    JOIN products p ON oi.product_id = p.product_id
    LEFT JOIN discounts d 
        ON p.product_id = d.product_id 
        AND YEAR(d.start_date) <= 2025  -- Discount should start in or before 2025
        AND YEAR(d.end_date) >= 2025  -- Discount should still be active in 2025
        AND MONTH(d.start_date) <= MONTH(o.order_date)  -- Discount should have started before or in this month
        AND MONTH(d.end_date) >= MONTH(o.order_date)  -- Discount should still be active in this month
    WHERE YEAR(o.order_date) = 2025
    GROUP BY month, oi.product_id
    ORDER BY month, product_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetProductDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetProductDetails`(IN prod_id INT)
BEGIN
    SELECT 
        p.product_id, 
        p.name AS product_name, 
        p.price, 
        p.stock_quantity, 
        c.category_name, 
        s.name AS supplier_name, 
        s.contact_email, 
        s.phone 
    FROM Products p
    JOIN Categories c ON p.category_id = c.category_id
    JOIN Suppliers s ON p.supplier_id = s.supplier_id
    WHERE p.product_id = prod_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetProductReviews` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetProductReviews`(
    IN product_id_param INT,
    IN sort_order_param VARCHAR(4)
)
BEGIN
    IF sort_order_param NOT IN ('ASC', 'DESC') THEN
        SET sort_order_param = 'DESC';
    END IF;

    SELECT review_id, product_id, customer_id, 
           COALESCE(rating, 0) AS rating, 
           review_text, created_at
    FROM reviews
    WHERE product_id = product_id_param
    ORDER BY rating IS NULL, rating * 1  
    COLLATE utf8mb4_general_ci, rating * (CASE WHEN sort_order_param = 'ASC' THEN 1 ELSE -1 END);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetProductSales2025` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetProductSales2025`()
BEGIN
    SELECT 
        MONTH(o.order_date) AS month,
        oi.product_id, 
        p.name AS product_name,
        SUM(oi.quantity) AS total_units_sold
    FROM order_items oi
    JOIN orders o ON oi.order_id = o.order_id
    JOIN products p ON oi.product_id = p.product_id
    WHERE YEAR(o.order_date) = 2025
    GROUP BY month, oi.product_id
    ORDER BY month, total_units_sold DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetTopSellingProducts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTopSellingProducts`()
BEGIN
    SELECT p.product_id, p.name, SUM(oi.quantity) AS total_sold
    FROM Order_Items oi
    JOIN Products p ON oi.product_id = p.product_id
    GROUP BY p.product_id, p.name
    ORDER BY total_sold DESC
    LIMIT 10;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetWholeCategory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetWholeCategory`(IN cat_id INT)
BEGIN
    SELECT * FROM Categories WHERE category_id = cat_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetWholeProduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetWholeProduct`(IN prod_id INT)
BEGIN
    SELECT * FROM Products WHERE product_id = prod_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `OptimizeDiscounts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OptimizeDiscounts`(
    IN base_discount DECIMAL(5,2), 
    IN bulk_discount DECIMAL(5,2),
    IN low_demand_discount DECIMAL(5,2)
)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE pid INT;
    DECLARE pstock INT;
    DECLARE psales INT;
    DECLARE current_price DECIMAL(10,2);
    DECLARE discount_percent DECIMAL(5,2);
    DECLARE discounted_price DECIMAL(10,2);
    
    DECLARE cur CURSOR FOR 
        SELECT p.product_id, p.stock_quantity, p.price, 
               COALESCE(SUM(oi.quantity), 0) AS total_sales
        FROM products p
        LEFT JOIN order_items oi ON p.product_id = oi.product_id
        GROUP BY p.product_id, p.stock_quantity, p.price;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO pid, pstock, current_price, psales;
        IF done THEN LEAVE read_loop; END IF;

        SET discount_percent = GREATEST(
            CASE WHEN pstock > 100 THEN bulk_discount ELSE 0 END,
            CASE WHEN psales < 10 THEN low_demand_discount ELSE 0 END,
            base_discount
        );
        SET discounted_price = current_price * (1 - discount_percent / 100);
        UPDATE products SET price = discounted_price WHERE product_id = pid;
    END LOOP;
    CLOSE cur;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RecommendReviewCollection` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RecommendReviewCollection`(IN min_reviews INT, IN min_sales INT)
BEGIN
    WITH SalesSummary AS (
        SELECT 
            oi.product_id, 
            SUM(oi.quantity) AS total_sales
        FROM order_items oi
        JOIN orders o ON oi.order_id = o.order_id
        WHERE YEAR(o.order_date) = 2025
        GROUP BY oi.product_id
    ),
    ReviewSummary AS (
        SELECT 
            r.product_id, 
            COUNT(r.review_id) AS total_reviews
        FROM reviews r
        GROUP BY r.product_id
    )
    SELECT 
        p.product_id, 
        p.name, 
        COALESCE(rs.total_reviews, 0) AS total_reviews, 
        COALESCE(ss.total_sales, 0) AS total_sales
    FROM products p
    LEFT JOIN SalesSummary ss ON p.product_id = ss.product_id
    LEFT JOIN ReviewSummary rs ON p.product_id = rs.product_id
    WHERE COALESCE(rs.total_reviews, 0) < min_reviews 
      AND COALESCE(ss.total_sales, 0) > min_sales
    ORDER BY total_sales DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ReviewBasedSalesTrends` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ReviewBasedSalesTrends`(IN min_high_reviews INT)
BEGIN

    IF min_high_reviews IS NULL THEN
        SET min_high_reviews = 35;
    END IF;

    WITH ProductReviewCounts AS (
        SELECT 
            p.product_id,
            COUNT(r.review_id) AS review_count
        FROM products p
        LEFT JOIN reviews r ON p.product_id = r.product_id
        GROUP BY p.product_id
    )

    SELECT 
        CASE 
            WHEN pr.review_count >= min_high_reviews THEN 'High Reviews' 
            ELSE 'Low Reviews' 
        END AS review_category,
        COUNT(DISTINCT oi.product_id) AS total_products,
        SUM(oi.quantity) AS total_sales,
        ROUND(SUM(oi.quantity) / COUNT(DISTINCT oi.product_id), 2) AS avg_sales_per_product
    FROM ProductReviewCounts pr
    LEFT JOIN order_items oi ON pr.product_id = oi.product_id
    GROUP BY review_category;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `max_discounts`
--

/*!50001 DROP VIEW IF EXISTS `max_discounts`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `max_discounts` AS select `d`.`product_id` AS `product_id`,coalesce(max(`d`.`discount_percentage`),0) AS `max_discount` from (`discounts` `d` join `orders` `o` on((`o`.`order_date` between `d`.`start_date` and `d`.`end_date`))) group by `d`.`product_id`,`o`.`order_date` */;
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

-- Dump completed on 2025-03-28 23:04:12
