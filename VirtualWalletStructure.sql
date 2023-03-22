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
-- Table structure for table `akcija_na_racunu`
--

DROP TABLE IF EXISTS `akcija_na_racunu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `akcija_na_racunu` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT,
  `RACUN_Id` int unsigned NOT NULL,
  `KATEGORIJA_AKCIJE_Id` int unsigned NOT NULL,
  `DatumAkcije` datetime NOT NULL,
  `IznosAkcije` decimal(9,2) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `fk_AKCIJA_NA_RACUNU_RACUN1_idx` (`RACUN_Id`),
  KEY `fk_AKCIJA_NA_RACUNU_KATEGORIJA_AKCIJE1_idx` (`KATEGORIJA_AKCIJE_Id`),
  CONSTRAINT `fk_AKCIJA_NA_RACUNU_KATEGORIJA_AKCIJE` FOREIGN KEY (`KATEGORIJA_AKCIJE_Id`) REFERENCES `kategorija_akcije` (`Id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_AKCIJA_NA_RACUNU_RACUN` FOREIGN KEY (`RACUN_Id`) REFERENCES `racun` (`Id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
-- Table structure for table `budzet`
--

DROP TABLE IF EXISTS `budzet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `budzet` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT,
  `KORISNIK_Id` int unsigned NOT NULL,
  `DatumOd` date NOT NULL,
  `DatumDo` date NOT NULL,
  `PredvidjeniIznos` decimal(9,2) unsigned NOT NULL,
  `TrenutniIznos` decimal(9,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`Id`),
  KEY `fk_predvidjeni_budzet_korisnik1_idx` (`KORISNIK_Id`),
  CONSTRAINT `fk_predvidjeni_budzet_korisnik1` FOREIGN KEY (`KORISNIK_Id`) REFERENCES `korisnik` (`Id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `budzet_bilans`
--

DROP TABLE IF EXISTS `budzet_bilans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `budzet_bilans` (
  `BUDZET_Id` int unsigned NOT NULL,
  `IznosBilansa` decimal(9,2) NOT NULL,
  `IsPrekoračen` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`BUDZET_Id`),
  KEY `fk_budzet_bilans_budzet_idx` (`BUDZET_Id`) /*!80000 INVISIBLE */,
  CONSTRAINT `fk_budzet_bilans_budzet` FOREIGN KEY (`BUDZET_Id`) REFERENCES `budzet` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 KEY_BLOCK_SIZE=16;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `budzet_zajednice`
--

DROP TABLE IF EXISTS `budzet_zajednice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `budzet_zajednice` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT,
  `ZAJEDNICA_Id` int unsigned NOT NULL,
  `IznosBudzeta` decimal(9,2) unsigned NOT NULL,
  `DatumOd` date NOT NULL,
  `DatumDo` date NOT NULL,
  `IsPrekoracen` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`,`ZAJEDNICA_Id`),
  KEY `fk_BUDZET_ZAJEDNICE_ZAJEDNICA1_idx` (`ZAJEDNICA_Id`),
  CONSTRAINT `fk_BUDZET_ZAJEDNICE_ZAJEDNICA` FOREIGN KEY (`ZAJEDNICA_Id`) REFERENCES `zajednica` (`Id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kategorija_akcije`
--

DROP TABLE IF EXISTS `kategorija_akcije`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kategorija_akcije` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT,
  `NazivAkcije` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Za potrošnju',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kategorija_stavke`
--

DROP TABLE IF EXISTS `kategorija_stavke`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kategorija_stavke` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT,
  `kategorija_stavke_Id` int unsigned DEFAULT NULL,
  `Naziv` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `fk_tip_stavke_tip_stavke1_idx` (`kategorija_stavke_Id`),
  CONSTRAINT `fk_tip_stavke_tip_stavke1` FOREIGN KEY (`kategorija_stavke_Id`) REFERENCES `kategorija_stavke` (`Id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `korisnik`
--

DROP TABLE IF EXISTS `korisnik`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `korisnik` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT,
  `ZAJEDNICA_Id` int unsigned NOT NULL,
  `Ime` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci NOT NULL,
  `Prezime` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci NOT NULL,
  `KorisnickoIme` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci NOT NULL,
  `Lozinka` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci NOT NULL,
  `Email` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `telefon` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `IsAdmin` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Lozinka_UNIQUE` (`Lozinka`),
  UNIQUE KEY `Korisničko_Ime_UNIQUE` (`KorisnickoIme`),
  KEY `fk_KORISNIK_ZAJEDNICA_idx` (`ZAJEDNICA_Id`),
  CONSTRAINT `fk_KORISNIK_ZAJEDNICA` FOREIGN KEY (`ZAJEDNICA_Id`) REFERENCES `zajednica` (`Id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_activity`
--

DROP TABLE IF EXISTS `log_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_activity` (
  `LogId` int NOT NULL AUTO_INCREMENT,
  `LogDescription` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`LogId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `podsjetnik`
--

DROP TABLE IF EXISTS `podsjetnik`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `podsjetnik` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT,
  `KORISNIK_Id` int unsigned NOT NULL,
  `Opis` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci NOT NULL,
  `Zavrseno` tinyint(1) NOT NULL DEFAULT '0',
  `DatumOd` date DEFAULT NULL,
  `DatumDo` date DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `fk_PODSJETNIK_KORISNIK1_idx` (`KORISNIK_Id`),
  CONSTRAINT `fk_PODSJETNIK_KORISNIK1` FOREIGN KEY (`KORISNIK_Id`) REFERENCES `korisnik` (`Id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `racun`
--

DROP TABLE IF EXISTS `racun`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `racun` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT,
  `KORISNIK_Id` int unsigned NOT NULL,
  `TIP_RACUNA_Id` int unsigned NOT NULL,
  `Iznos` decimal(9,2) NOT NULL DEFAULT '0.00',
  `DatumKreiranja` datetime NOT NULL,
  `Valuta` varchar(3) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'BAM',
  PRIMARY KEY (`Id`),
  KEY `fk_RACUN_TIP_RACUNA1_idx` (`TIP_RACUNA_Id`),
  KEY `fk_RACUN_KORISNIK1_idx` (`KORISNIK_Id`),
  CONSTRAINT `fk_RACUN_KORISNIK` FOREIGN KEY (`KORISNIK_Id`) REFERENCES `korisnik` (`Id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_RACUN_TIP_RACUNA` FOREIGN KEY (`TIP_RACUNA_Id`) REFERENCES `tip_racuna` (`Id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stavka_budzeta`
--

DROP TABLE IF EXISTS `stavka_budzeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stavka_budzeta` (
  `KATEGORIJA_STAVKE_Id` int unsigned NOT NULL,
  `BUDZET_Id` int unsigned NOT NULL,
  `PredvidjeniIznos` decimal(9,2) unsigned NOT NULL,
  `TrenutniIznos` decimal(9,2) unsigned NOT NULL DEFAULT '0.00',
  `Opis` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'Bez opisa',
  PRIMARY KEY (`KATEGORIJA_STAVKE_Id`,`BUDZET_Id`),
  KEY `fk_STAVKA_BUDZETA_KATEGORIJA_STAVKE1_idx` (`KATEGORIJA_STAVKE_Id`),
  KEY `fk_stavka_budzeta_budzet1_idx` (`BUDZET_Id`) /*!80000 INVISIBLE */,
  CONSTRAINT `fk_STAVKA_BUDZETA_KATEGORIJA_STAVKE` FOREIGN KEY (`KATEGORIJA_STAVKE_Id`) REFERENCES `kategorija_stavke` (`Id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_stavka_budzeta_predvidjeni_budzet1` FOREIGN KEY (`BUDZET_Id`) REFERENCES `budzet` (`Id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
-- Table structure for table `tip_racuna`
--

DROP TABLE IF EXISTS `tip_racuna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tip_racuna` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT,
  `NazivRacuna` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci NOT NULL,
  `NazivBanke` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transfer`
--

DROP TABLE IF EXISTS `transfer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transfer` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT,
  `DatumTransfera` datetime NOT NULL,
  `IznosTransfera` decimal(9,2) unsigned NOT NULL,
  `RACUN1_Id` int unsigned NOT NULL,
  `RACUN2_Id` int unsigned NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `fk_TRANSFER_RACUN1_idx` (`RACUN1_Id`),
  KEY `fk_TRANSFER_RACUN2_idx` (`RACUN2_Id`),
  CONSTRAINT `fk_TRANSFER_RACUN1` FOREIGN KEY (`RACUN1_Id`) REFERENCES `racun` (`Id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_TRANSFER_RACUN2` FOREIGN KEY (`RACUN2_Id`) REFERENCES `racun` (`Id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
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
-- Table structure for table `zajednica`
--

DROP TABLE IF EXISTS `zajednica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zajednica` (
  `Id` int unsigned NOT NULL AUTO_INCREMENT,
  `Naziv` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Naziv_UNIQUE` (`Naziv`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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

-- Dump completed on 2023-03-16 10:43:03
