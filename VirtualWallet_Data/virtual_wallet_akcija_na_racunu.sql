CREATE DATABASE  IF NOT EXISTS `virtual_wallet` /*!40100 DEFAULT CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `virtual_wallet`;
-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: localhost    Database: virtual_wallet
-- ------------------------------------------------------
-- Server version	8.0.29

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
-- Dumping data for table `akcija_na_racunu`
--

LOCK TABLES `akcija_na_racunu` WRITE;
/*!40000 ALTER TABLE `akcija_na_racunu` DISABLE KEYS */;
INSERT INTO `akcija_na_racunu` VALUES (1,4,1,'2023-03-13 19:12:46',135.00),(2,3,1,'2023-03-13 19:48:48',2200.00),(3,4,2,'2023-03-13 19:50:13',35.00),(4,4,1,'2023-03-13 20:23:51',25.00),(5,1,2,'2023-03-13 20:32:57',20.00),(6,1,2,'2023-03-13 20:43:00',40.00);
/*!40000 ALTER TABLE `akcija_na_racunu` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `akcija_na_racunu_AFTER_INSERT` AFTER INSERT ON `akcija_na_racunu` FOR EACH ROW BEGIN

	declare RacunID char(20);
	declare IznosAkcije char(20);
	declare DatumAkcije char(45);
    
    set RacunID = convert(new.RACUN_Id, char(20));
    set IznosAkcije = convert(new.IznosAkcije, char(20));
    set DatumAkcije = convert(new.DatumAkcije, char(45));
    
	if new.KATEGORIJA_AKCIJE_Id = 1 then
		update racun r set r.Iznos = r.Iznos + new.IznosAkcije where r.Id = new.RACUN_Id;
		insert into log_activity (LogDescription) values ( CONCAT("INSERT # RacunID: " , RacunID, " # UPLATA # IznosAkcije: ",  IznosAkcije, " # ", DatumAkcije, " # " ));
	elseif new.KATEGORIJA_AKCIJE_Id = 2 then
		update racun r set r.Iznos = r.Iznos - new.IznosAkcije where r.Id = new.RACUN_Id;
        insert into log_activity (LogDescription) values ( CONCAT("INSERT # RacunID: " , RacunID, " # ISPLATA # IznosAkcije: ",  IznosAkcije, " # ", DatumAkcije, " # " ));
	end if;
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-16 10:39:04
