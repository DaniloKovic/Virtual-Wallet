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

-- Dump completed on 2023-03-16 10:39:07
