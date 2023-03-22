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

--
-- Dumping data for table `budzet`
--

LOCK TABLES `budzet` WRITE;
/*!40000 ALTER TABLE `budzet` DISABLE KEYS */;
INSERT INTO `budzet` VALUES (1,1,'2023-02-01','2023-02-28',800.00,140.00),(2,1,'2023-03-01','2023-03-31',800.00,0.00),(3,1,'2023-04-01','2023-04-30',900.00,0.00),(4,1,'2023-05-01','2023-05-31',960.00,0.00);
/*!40000 ALTER TABLE `budzet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `budzet_bilans`
--

LOCK TABLES `budzet_bilans` WRITE;
/*!40000 ALTER TABLE `budzet_bilans` DISABLE KEYS */;
/*!40000 ALTER TABLE `budzet_bilans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `budzet_zajednice`
--

LOCK TABLES `budzet_zajednice` WRITE;
/*!40000 ALTER TABLE `budzet_zajednice` DISABLE KEYS */;
INSERT INTO `budzet_zajednice` VALUES (1,2,3000.00,'2023-03-01','2023-03-31',0),(2,2,3000.00,'2023-04-01','2023-04-30',0);
/*!40000 ALTER TABLE `budzet_zajednice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `kategorija_akcije`
--

LOCK TABLES `kategorija_akcije` WRITE;
/*!40000 ALTER TABLE `kategorija_akcije` DISABLE KEYS */;
INSERT INTO `kategorija_akcije` VALUES (1,'Uplata'),(2,'Isplata');
/*!40000 ALTER TABLE `kategorija_akcije` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `kategorija_stavke`
--

LOCK TABLES `kategorija_stavke` WRITE;
/*!40000 ALTER TABLE `kategorija_stavke` DISABLE KEYS */;
INSERT INTO `kategorija_stavke` VALUES (1,NULL,'Struja'),(2,NULL,'Telefon'),(3,NULL,'Voda'),(4,NULL,'Voda'),(5,NULL,'Internet'),(6,NULL,'Gorivo'),(7,NULL,'Hrana'),(8,NULL,'Kafenisanje'),(9,8,'Bakšiš'),(10,NULL,'Garderoba'),(11,10,'Odjeća'),(12,10,'Obuća'),(13,NULL,'Pokloni'),(14,NULL,'Putovanja'),(15,NULL,'Sport'),(16,15,'Fitpass');
/*!40000 ALTER TABLE `kategorija_stavke` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `korisnik`
--

LOCK TABLES `korisnik` WRITE;
/*!40000 ALTER TABLE `korisnik` DISABLE KEYS */;
INSERT INTO `korisnik` VALUES (1,2,'Danilo','Kovic','dak23','lozinka','danilok@gmail.com','065194287',0),(2,2,'Dragoljub','Kovic','kod62','lozinka62','dragoljubk@gmail.com','065603193',0),(3,1,'Jovo','Markovic','jovo45','jovo45','jovo@gmail.com','065999888',0),(4,1,'Marko','Markovic','marko442','marko442','marko@gmail.com','065555333',0),(5,2,'Rada','Ković','rada007','rada0077','rada.k@gmail.com','065588024',0);
/*!40000 ALTER TABLE `korisnik` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `log_activity`
--

LOCK TABLES `log_activity` WRITE;
/*!40000 ALTER TABLE `log_activity` DISABLE KEYS */;
INSERT INTO `log_activity` VALUES (1,'INSERT # RacunID: 3 # UPLATA # 2200.00 # 2023-03-13 19:48:48 # '),(2,'INSERT # RacunID: 4 # ISPLATA # 35.00 # 2023-03-13 19:50:13 # '),(3,'INSERT # RacunID: 4 # UPLATA # IznosAkcije: 25.00 # 2023-03-13 20:23:51 # '),(4,'INSERT # RacunID: 1 # ISPLATA # IznosAkcije: 20.00 # 2023-03-13 20:32:57 # '),(5,'INSERT # RacunID: 1 # ISPLATA # IznosAkcije: 40.00 # 2023-03-13 20:43:00 # '),(6,'TRANSFER # Sa_Racuna: 4 # Na_Racun: 1 # Iznos: 25.00 # 2023-03-13 21:24:03');
/*!40000 ALTER TABLE `log_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `podsjetnik`
--

LOCK TABLES `podsjetnik` WRITE;
/*!40000 ALTER TABLE `podsjetnik` DISABLE KEYS */;
INSERT INTO `podsjetnik` VALUES (1,1,'Vratit pare komšiji Peri',1,'2023-03-01','2023-03-31'),(6,1,'Kupiti trimer za bradu',1,'2023-03-01','2023-03-31'),(7,1,'Kupiti pumpu za bicikl',0,'2023-03-01','2023-03-31'),(8,1,'Uplatiti mjesečnu kartu za autobus - 35 KM',1,'2023-03-01','2023-03-31');
/*!40000 ALTER TABLE `podsjetnik` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `racun`
--

LOCK TABLES `racun` WRITE;
/*!40000 ALTER TABLE `racun` DISABLE KEYS */;
INSERT INTO `racun` VALUES (1,1,1,45.00,'2023-02-19 20:40:09','BAM'),(2,1,2,0.10,'2023-02-19 20:40:51','BAM'),(3,1,3,12000.00,'2023-02-19 20:42:59','BAM'),(4,1,4,300.00,'2023-02-19 20:42:59','BAM');
/*!40000 ALTER TABLE `racun` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `stavka_budzeta`
--

LOCK TABLES `stavka_budzeta` WRITE;
/*!40000 ALTER TABLE `stavka_budzeta` DISABLE KEYS */;
INSERT INTO `stavka_budzeta` VALUES (1,1,100.00,0.00,'kova'),(1,2,110.00,0.00,'Bez opisa'),(2,1,20.00,0.00,'Bez opisa'),(2,2,20.00,0.00,'Bez opisa'),(6,1,130.00,110.00,'Bez opisa'),(6,2,130.00,0.00,'Bez opisa'),(16,1,30.00,30.00,'Bez opisa'),(16,2,30.00,0.00,'Bez opisa');
/*!40000 ALTER TABLE `stavka_budzeta` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `stavka_budzeta_AFTER_UPDATE` AFTER UPDATE ON `stavka_budzeta` FOR EACH ROW BEGIN
	if(new.TrenutniIznos <> old.TrenutniIznos) then
		
		if (new.TrenutniIznos > old.TrenutniIznos) then
			update budzet b
			set b.TrenutniIznos = b.TrenutniIznos + (new.TrenutniIznos - old.TrenutniIznos)
			where new.BUDZET_Id = b.Id;
		elseif (new.TrenutniIznos < old.TrenutniIznos) then
			update budzet b
			set b.TrenutniIznos = b.TrenutniIznos - (old.TrenutniIznos - new.TrenutniIznos)
			where new.BUDZET_Id = b.Id;
		end if;
        
	end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping data for table `tip_racuna`
--

LOCK TABLES `tip_racuna` WRITE;
/*!40000 ALTER TABLE `tip_racuna` DISABLE KEYS */;
INSERT INTO `tip_racuna` VALUES (1,'Tekući račun','Nova Banka'),(2,'Štednja po viđenju','Nova Banka'),(3,'Oročena štednja','Nova Banka'),(4,'Slobodna štednja','');
/*!40000 ALTER TABLE `tip_racuna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `transfer`
--

LOCK TABLES `transfer` WRITE;
/*!40000 ALTER TABLE `transfer` DISABLE KEYS */;
INSERT INTO `transfer` VALUES (6,'2023-02-28 16:41:04',50.00,1,2),(7,'2023-02-28 16:41:34',50.00,2,1),(8,'2023-02-28 17:24:09',50.00,3,4),(9,'2023-02-28 17:24:46',50.00,3,4),(10,'2023-02-28 17:24:48',50.00,3,4),(11,'2023-02-28 17:24:49',50.00,3,4),(12,'2023-02-28 17:24:51',50.00,3,4),(13,'2023-02-28 17:26:19',50.00,3,4),(14,'2023-02-28 17:26:22',50.00,3,4),(15,'2023-02-28 17:26:24',50.00,3,4),(16,'2023-02-28 17:26:31',50.00,3,4),(17,'2023-02-28 17:26:36',200.00,4,3),(18,'2023-02-28 17:28:35',50.00,3,4),(19,'2023-02-28 18:10:25',250.00,4,3),(20,'2023-02-28 18:10:52',50.00,4,3),(21,'2023-02-28 18:41:59',50.00,3,4),(22,'2023-02-28 18:44:17',25.00,3,4),(23,'2023-02-28 18:50:58',25.00,3,4),(24,'2023-02-28 18:52:01',100.00,4,3),(25,'2023-02-28 19:04:02',100.00,3,4),(26,'2023-02-28 19:23:33',100.00,3,4),(27,'2023-02-28 19:25:23',100.00,3,4),(28,'2023-02-28 19:28:20',300.00,4,3),(29,'2023-02-28 19:42:19',100.00,3,4),(30,'2023-02-28 19:42:35',100.00,3,4),(31,'2023-02-28 19:44:04',100.00,3,4),(32,'2023-02-28 19:46:27',300.00,4,3),(33,'2023-02-28 19:52:32',20.00,3,1),(34,'2023-02-28 20:04:20',80.00,3,1),(35,'2023-02-28 20:07:02',100.00,1,3),(36,'2023-02-28 20:08:58',20.00,3,1),(37,'2023-02-28 20:10:25',20.00,1,3),(38,'2023-02-28 20:13:26',10.00,1,2),(39,'2023-02-28 20:16:07',10.00,2,1),(40,'2023-02-28 20:19:52',20.00,3,1),(41,'2023-02-28 20:22:45',20.00,1,3),(42,'2023-02-28 20:27:06',100.00,3,4),(43,'2023-02-28 20:30:31',100.00,3,4),(44,'2023-03-13 21:24:03',25.00,4,1);
/*!40000 ALTER TABLE `transfer` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `transfer_AFTER_INSERT` AFTER INSERT ON `transfer` FOR EACH ROW BEGIN
	declare Racun1_ID char(20);
	declare Racun2_ID char(20);
	declare IznosTransfera char(20);
	declare DatumTransfera char(45);
    
    set Racun1_ID = convert(new.RACUN1_Id, char(20));
    set Racun2_ID = convert(new.RACUN2_Id, char(20));
    set IznosTransfera = convert(new.IznosTransfera, char(20));
    set DatumTransfera = convert(new.DatumTransfera, char(45));

	insert into log_activity (LogDescription) 
		        values ( CONCAT("TRANSFER # Sa_Racuna: " , Racun1_ID, " # Na_Racun: ",  Racun2_ID, " # Iznos: ", IznosTransfera,  " # ", DatumTransfera ));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping data for table `zajednica`
--

LOCK TABLES `zajednica` WRITE;
/*!40000 ALTER TABLE `zajednica` DISABLE KEYS */;
INSERT INTO `zajednica` VALUES (2,'Kovic'),(1,'Markovic');
/*!40000 ALTER TABLE `zajednica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'virtual_wallet'
--

--
-- Dumping routines for database 'virtual_wallet'
--
/*!50003 DROP PROCEDURE IF EXISTS `RegitracijaKorisnika` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RegitracijaKorisnika`(in ime varchar(45), in prezime varchar(45), in korisnickoIme varchar(45), in lozinka varchar(45),
                                      in sifraZajednice varchar(45), in email varchar(45), in telefon varchar(45), out registrationResult int)
BEGIN
	 
     declare userId int;
     declare userCount int;
     declare zajednicaId int;
     declare zajednicaCount int;
     
     select count(*) from zajednica z where z.SifraZajednice = sifraZajednice into zajednicaCount;
     if zajednicaCount > 0 then
		select z.Id  from zajednica z where z.SifraZajednice = sifraZajednice into zajednicaId;
	 elseif zajednicaCount = 0 then
		set zajednicaId = 0;
     end if;
     
     select count(*) from korisnik k where k.KorisnickoIme = korisnickoIme into userCount;
     if userCount > 0 then
		select k.Id from korisnik k where k.KorisnickoIme = korisnickoIme into userId;
	elseif userCount = 0 then
		set userId = 0;
	end if;
    
    set registrationResult = 0;
    if zajednicaId <> 0 and userId = 0 then
		insert into korisnik (Ime, Prezime, KorisnickoIme, Lozinka, ZAJEDNICA_Id, Email, Telefon) values (ime, prezime, korisnickoIme, lozinka, zajednicaId, email, telefon);
		set registrationResult = 1;
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TransferNovca` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TransferNovca`(in saRacunaId int, in naRacunId int, in iznosTransfera double, out transferLastId int)
BEGIN
    declare iznosSaRacuna double ;
    
    select r.Iznos
    from racun r
    where r.Id = saRacunaId into iznosSaRacuna;
    
    if iznosTransfera <= iznosSaRacuna and saRacunaId <> naRacunId then
		update racun r 
			set r.Iznos = r.Iznos + iznosTransfera
			where r.Id = naRacunId;
			
		update racun r 
			set r.Iznos = r.Iznos - iznosTransfera
			where r.Id = saRacunaId;

		insert into transfer (DatumTransfera, IznosTransfera, RACUN1_Id, RACUN2_Id) values (now(), iznosTransfera, saRacunaId, naRacunId);
		
		select last_insert_id() into transferLastId;
    else
		set transferLastId = 0;
    end if;
END ;;
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

-- Dump completed on 2023-03-16 10:43:25
