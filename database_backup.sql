-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: online_store
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `o_id` int NOT NULL AUTO_INCREMENT,
  `p_id` int DEFAULT NULL,
  `u_id` int DEFAULT NULL,
  `o_quantity` int DEFAULT NULL,
  `o_date` varchar(50) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `address` text,
  `city` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `size` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`o_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,1,1,'2026-01-14',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,1,1,1,'2026-01-14',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,1,1,1,'2026-01-14',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,1,1,1,'2026-01-14',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,1,1,1,'2026-01-15',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,1,1,1,'2026-01-15',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,1,1,1,'2026-01-15',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,1,2,1,'2026-01-15',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,1,1,1,'2026-01-15','P.G Pathum Himesha Prasad','Subasigha','Iguruoya, Nawalapitiya','Nawalapitiya','0757242536','COD',NULL),(10,1,1,1,'2026-01-15','P.G Pathum Himesha Prasad','Subasigha','Iguruoya, Nawalapitiya','Nawalapitiya','0757242536','CARD',NULL),(11,1,1,1,'2026-01-15','P.G Pathum Himesha Prasad','Subasigha','Iguruoya, Nawalapitiya','Nawalapitiya','0757242536','COD',NULL),(12,5,1,2,'2026-01-15','P.G Pathum Himesha Prasad','Subasigha','Iguruoya, Nawalapitiya','Nawalapitiya','0757242536','COD',NULL),(13,6,1,1,'2026-01-15','P.G Pathum Himesha Prasad','Subasigha','Iguruoya, Nawalapitiya','Nawalapitiya','0757242536','COD',NULL),(14,2,1,1,'2026-01-15','P.G Pathum Himesha Prasad','Subasigha','Iguruoya, Nawalapitiya','Nawalapitiya','0757242536','CARD','M'),(15,1,1,1,'2026-01-15','P.G Pathum Himesha Prasad','Subasigha','Iguruoya, Nawalapitiya','Nawalapitiya','0757242536','CARD','S'),(16,2,1,1,'2026-01-15','P.G Pathum Himesha Prasad','Subasigha','Iguruoya, Nawalapitiya','Nawalapitiya','0757242536','COD','S'),(17,14,1,2,'2026-01-15','P.G Pathum Himesha Prasad','Subasigha','Iguruoya, Nawalapitiya','Nawalapitiya','0757242536','COD','M'),(18,2,1,1,'2026-01-15','P.G Pathum Himesha Prasad','Subasigha','Iguruoya, Nawalapitiya','Nawalapitiya','0757242536','COD','S');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `image` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Gold\'s Gym Men\'s T-Shirt','Men',3500,'images/Gold\'s Gym Men\'s T-Shirt.webp'),(2,'Gorilla Wear Saginaw Oversized T-Shirt','Men',3000,'images/Gorilla Wear Saginaw Oversized T-Shirt.webp'),(3,'Gym Baggy Pant','Men',6000,'images/Gym Baggy Pant.avif'),(4,'Gym Pump Tee','Men',3600,'images/Gym Pump Tees.avif'),(5,'Gymshark Men\'s Seamless T-Shirt','Men',4500,'images/Gymshark Men\'s T I.webp'),(6,'Gymshark Pumper Pants','Men',12500,'images/Gymshark Pumper Pants.webp'),(7,'Gymshark Men Stringer Vest','Men',3800,'images/Men\'s Stringer Vests.webp'),(9,'Lifting Club Oversized Tee','Women',4200,'images/Lifting Club Oversized Tee - Black.webp'),(10,'RORF Midnight Black Oversized','Men',4500,'images/RORF Midnight Black Oversized.webp'),(11,'Men\'s Performance Track Pant','Men',6500,'images/Track Pant.webp'),(12,'Versatile Workout Trousers','Men',7200,'images/Versatile and Durable Workout Trouser.avif'),(13,'Wholesale Baggy Gym Pant','Men',7500,'images/Wholesale Baggy Gym Pant.avif'),(14,'Seamless Tracksuit & Legging Set','Women',8500,'images/Tracksuit With Legging.webp'),(16,'Gymshark Vital Seamless T-Shirt','Women',5500,'images/Gymshark Vital Seamless T Shirt.jpg'),(18,'Gymshark Women\'s Training T-Shirt','Women',5800,'images/gymshark_white_tee.webp'),(19,'Gymshark Black Gym Leggings','Women',7500,'images/Gymshark Leggings Womens Black Gym Leggings.webp'),(20,'Karhu FUSION 2.0 - Black','Shoes',18500,'images/FUSION 2.0.webp'),(21,'Karhu MEN\'S IKONI 3.5','Shoes',19500,'images/MEN\'S IKONI 3.5.webp'),(22,'Karhu MESTARI RUN 2.0','Shoes',21500,'images/MEN\'S MESTARI RUN 2.0.webp'),(23,'Karhu SUPER FULCRUM CORDURA','Shoes',22500,'images/SUPER FULCRUM CORDURA.webp'),(24,'Gymshark Black Bra & Leggings Set','Women',11500,'images/Gym Bra And Leggings Black.webp'),(25,'Leakproof Gym Water Bottle','Accessories',3200,'images/Leakproof Gym Water Bottle.webp'),(26,'Women\'s Performance Leggings','Women',4800,'images/leggings.jpeg'),(27,'Women\'s Flared Pants','Women',5500,'images/Flared Pant.jpeg'),(28,'Women\'s Aeris Skort','Women',5200,'images/Aeris Skort.jpeg'),(29,'Women\'s Square Neck Romper','Women',5800,'images/Square Neck Romper.jpeg'),(30,'Casual Sneakers','Shoes',12500,'images/Casual Sneakers.jpeg'),(31,'Strap Slides','Shoes',6500,'images/Strap Slides.jpeg'),(32,'Women\'s Softform Cropped Hoodie','Women',6200,'images/Softform Cropped Hoodie.jpeg'),(33,'AVI Men Running Lacing Shoes','Shoes',8500,'images/AVI Men Running Lacing Shoes Black.jpeg'),(34,'Women\'s Revline Crop Tank','Women',4500,'images/Revline Crop Tank.jpeg');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'pathum','prasadhphs@gmail.com','123'),(2,'shakuna','shakuna@gmail.com','321');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-15 11:33:01
