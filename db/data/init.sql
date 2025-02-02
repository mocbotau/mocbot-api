-- MySQL dump 10.13  Distrib 8.0.35, for Linux (x86_64)
--
-- Host: localhost    Database: MOCBOT
-- ------------------------------------------------------
-- Server version	8.0.35-0ubuntu0.20.04.1

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
-- Table structure for table `AFK`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `AFK` (
  `UserGuildID` int NOT NULL,
  `MessageID` bigint NOT NULL,
  `ChannelID` bigint NOT NULL,
  `OldName` text NOT NULL,
  `Reason` text NOT NULL,
  PRIMARY KEY (`UserGuildID`),
  CONSTRAINT `FKUserInGuildsAFK` FOREIGN KEY (`UserGuildID`) REFERENCES `UserInGuilds` (`UserGuildID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `APIKeys`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `APIKeys` (
  `Identifier` varchar(255) NOT NULL,
  `Token` varchar(255) NOT NULL,
  PRIMARY KEY (`Token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Developers`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `Developers` (
  `UserID` bigint NOT NULL,
  PRIMARY KEY (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `GuildSettings`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `GuildSettings` (
  `GuildID` bigint unsigned NOT NULL,
  `SettingsData` json NOT NULL DEFAULT (json_object()),
  PRIMARY KEY (`GuildID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Lobbies`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `Lobbies` (
  `LobbyID` int NOT NULL AUTO_INCREMENT,
  `GuildID` bigint NOT NULL,
  `LeaderID` bigint NOT NULL,
  PRIMARY KEY (`LobbyID`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `LobbyAndGuilds`
--


/*!50001 DROP VIEW IF EXISTS `LobbyAndGuilds`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `LobbyAndGuilds` AS SELECT 
 1 AS `LobbyID`,
 1 AS `LobbyName`,
 1 AS `VoiceChannelID`,
 1 AS `TextChannelID`,
 1 AS `RoleID`,
 1 AS `InviteOnly`,
 1 AS `LeaderID`,
 1 AS `GuildID`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `LobbyAndUsers`
--


/*!50001 DROP VIEW IF EXISTS `LobbyAndUsers`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `LobbyAndUsers` AS SELECT 
 1 AS `LobbyID`,
 1 AS `UserID`,
 1 AS `LeaderID`,
 1 AS `GuildID`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `LobbyDetails`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `LobbyDetails` (
  `LobbyID` int NOT NULL,
  `LobbyName` varchar(255) NOT NULL,
  `VoiceChannelID` bigint unsigned NOT NULL,
  `TextChannelID` bigint unsigned NOT NULL,
  `RoleID` bigint unsigned NOT NULL,
  `InviteOnly` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`LobbyID`),
  CONSTRAINT `LobbyDetailsFK` FOREIGN KEY (`LobbyID`) REFERENCES `Lobbies` (`LobbyID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `LobbyUsers`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `LobbyUsers` (
  `LobbyID` int NOT NULL AUTO_INCREMENT,
  `UserID` bigint unsigned NOT NULL,
  PRIMARY KEY (`LobbyID`,`UserID`),
  CONSTRAINT `LobbyUsersFK` FOREIGN KEY (`LobbyID`) REFERENCES `Lobbies` (`LobbyID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Roles`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `Roles` (
  `GuildID` bigint NOT NULL,
  `LevelRoles` json DEFAULT NULL,
  `JoinRoles` json DEFAULT NULL,
  PRIMARY KEY (`GuildID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Support`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `Support` (
  `ID` varchar(255) NOT NULL,
  `UserID` bigint NOT NULL,
  `MessageID` bigint NOT NULL,
  `Contents` text NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `UserGuildAFK`
--


/*!50001 DROP VIEW IF EXISTS `UserGuildAFK`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `UserGuildAFK` AS SELECT 
 1 AS `UserGuildID`,
 1 AS `MessageID`,
 1 AS `ChannelID`,
 1 AS `OldName`,
 1 AS `Reason`,
 1 AS `UserID`,
 1 AS `GuildID`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `UserGuildVerification`
--


/*!50001 DROP VIEW IF EXISTS `UserGuildVerification`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `UserGuildVerification` AS SELECT 
 1 AS `UserGuildID`,
 1 AS `MessageID`,
 1 AS `ChannelID`,
 1 AS `JoinTime`,
 1 AS `UserID`,
 1 AS `GuildID`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `UserGuildWarnings`
--


/*!50001 DROP VIEW IF EXISTS `UserGuildWarnings`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `UserGuildWarnings` AS SELECT 
 1 AS `WarningID`,
 1 AS `UserGuildID`,
 1 AS `Reason`,
 1 AS `Time`,
 1 AS `AdminID`,
 1 AS `UserID`,
 1 AS `GuildID`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `UserGuildXP`
--


/*!50001 DROP VIEW IF EXISTS `UserGuildXP`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `UserGuildXP` AS SELECT 
 1 AS `UserGuildID`,
 1 AS `XP`,
 1 AS `Level`,
 1 AS `XPLock`,
 1 AS `VoiceChannelXPLock`,
 1 AS `UserID`,
 1 AS `GuildID`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `UserInGuilds`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `UserInGuilds` (
  `UserGuildID` int NOT NULL AUTO_INCREMENT,
  `UserID` bigint NOT NULL,
  `GuildID` bigint NOT NULL,
  PRIMARY KEY (`UserGuildID`),
  UNIQUE KEY `UserID` (`UserID`,`GuildID`)
) ENGINE=InnoDB AUTO_INCREMENT=1589 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Verification`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `Verification` (
  `UserGuildID` int NOT NULL,
  `MessageID` bigint DEFAULT NULL,
  `ChannelID` bigint DEFAULT NULL,
  `JoinTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`UserGuildID`),
  CONSTRAINT `UserInGuildVerificationFK` FOREIGN KEY (`UserGuildID`) REFERENCES `UserInGuilds` (`UserGuildID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Warnings`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `Warnings` (
  `WarningID` varchar(255) NOT NULL,
  `UserGuildID` int NOT NULL,
  `Reason` text NOT NULL,
  `Time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `AdminID` bigint NOT NULL,
  PRIMARY KEY (`WarningID`),
  KEY `WarningsUserGuildFK` (`UserGuildID`),
  CONSTRAINT `WarningsUserGuildFK` FOREIGN KEY (`UserGuildID`) REFERENCES `UserInGuilds` (`UserGuildID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `XP`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `XP` (
  `UserGuildID` int NOT NULL AUTO_INCREMENT,
  `XP` bigint unsigned NOT NULL DEFAULT '0',
  `Level` bigint unsigned NOT NULL DEFAULT '0',
  `XPLock` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `VoiceChannelXPLock` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`UserGuildID`),
  CONSTRAINT `FKUserInGuildsXP` FOREIGN KEY (`UserGuildID`) REFERENCES `UserInGuilds` (`UserGuildID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=1589 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `LobbyAndGuilds`
--

/*!50001 DROP VIEW IF EXISTS `LobbyAndGuilds`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `LobbyAndGuilds` AS select `d`.`LobbyID` AS `LobbyID`,`d`.`LobbyName` AS `LobbyName`,`d`.`VoiceChannelID` AS `VoiceChannelID`,`d`.`TextChannelID` AS `TextChannelID`,`d`.`RoleID` AS `RoleID`,`d`.`InviteOnly` AS `InviteOnly`,`l`.`LeaderID` AS `LeaderID`,`l`.`GuildID` AS `GuildID` from (`LobbyDetails` `d` join `Lobbies` `l` on((`l`.`LobbyID` = `d`.`LobbyID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `LobbyAndUsers`
--

/*!50001 DROP VIEW IF EXISTS `LobbyAndUsers`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `LobbyAndUsers` AS select `u`.`LobbyID` AS `LobbyID`,`u`.`UserID` AS `UserID`,`l`.`LeaderID` AS `LeaderID`,`l`.`GuildID` AS `GuildID` from (`LobbyUsers` `u` join `Lobbies` `l` on((`l`.`LobbyID` = `u`.`LobbyID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `UserGuildAFK`
--

/*!50001 DROP VIEW IF EXISTS `UserGuildAFK`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `UserGuildAFK` AS select `a`.`UserGuildID` AS `UserGuildID`,`a`.`MessageID` AS `MessageID`,`a`.`ChannelID` AS `ChannelID`,`a`.`OldName` AS `OldName`,`a`.`Reason` AS `Reason`,`u`.`UserID` AS `UserID`,`u`.`GuildID` AS `GuildID` from (`AFK` `a` join `UserInGuilds` `u` on((`u`.`UserGuildID` = `a`.`UserGuildID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `UserGuildVerification`
--

/*!50001 DROP VIEW IF EXISTS `UserGuildVerification`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `UserGuildVerification` AS select `v`.`UserGuildID` AS `UserGuildID`,`v`.`MessageID` AS `MessageID`,`v`.`ChannelID` AS `ChannelID`,`v`.`JoinTime` AS `JoinTime`,`u`.`UserID` AS `UserID`,`u`.`GuildID` AS `GuildID` from (`Verification` `v` join `UserInGuilds` `u` on((`u`.`UserGuildID` = `v`.`UserGuildID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `UserGuildWarnings`
--

/*!50001 DROP VIEW IF EXISTS `UserGuildWarnings`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `UserGuildWarnings` AS select `w`.`WarningID` AS `WarningID`,`w`.`UserGuildID` AS `UserGuildID`,`w`.`Reason` AS `Reason`,unix_timestamp(`w`.`Time`) AS `Time`,`w`.`AdminID` AS `AdminID`,`u`.`UserID` AS `UserID`,`u`.`GuildID` AS `GuildID` from (`Warnings` `w` join `UserInGuilds` `u` on((`u`.`UserGuildID` = `w`.`UserGuildID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `UserGuildXP`
--

/*!50001 DROP VIEW IF EXISTS `UserGuildXP`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 */
/*!50001 VIEW `UserGuildXP` AS select `x`.`UserGuildID` AS `UserGuildID`,`x`.`XP` AS `XP`,`x`.`Level` AS `Level`,unix_timestamp(`x`.`XPLock`) AS `XPLock`,unix_timestamp(`x`.`VoiceChannelXPLock`) AS `VoiceChannelXPLock`,`u`.`UserID` AS `UserID`,`u`.`GuildID` AS `GuildID` from (`XP` `x` join `UserInGuilds` `u` on((`u`.`UserGuildID` = `x`.`UserGuildID`))) */;
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

-- Dump completed on 2024-01-25 15:10:44
