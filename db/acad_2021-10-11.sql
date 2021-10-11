# ************************************************************
# Sequel Pro SQL dump
# Version 5446
#
# https://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.27)
# Database: acad
# Generation Time: 2021-10-11 14:45:31 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table blocks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `blocks`;

CREATE TABLE `blocks` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `blocks` WRITE;
/*!40000 ALTER TABLE `blocks` DISABLE KEYS */;

INSERT INTO `blocks` (`id`, `name`, `start_date`, `end_date`)
VALUES
	(1,'4th grade','2021-08-30','2022-06-30');

/*!40000 ALTER TABLE `blocks` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table people
# ------------------------------------------------------------

DROP TABLE IF EXISTS `people`;

CREATE TABLE `people` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `people` WRITE;
/*!40000 ALTER TABLE `people` DISABLE KEYS */;

INSERT INTO `people` (`id`, `name`, `updated_at`, `created_at`)
VALUES
	(1,'Ian','2021-09-11 04:03:42','2021-09-11 00:00:00');

/*!40000 ALTER TABLE `people` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table student_course
# ------------------------------------------------------------

DROP TABLE IF EXISTS `student_course`;

CREATE TABLE `student_course` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `subject_block_id` int(10) unsigned NOT NULL DEFAULT '0',
  `student_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `subject_block_id` (`subject_block_id`,`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `student_course` WRITE;
/*!40000 ALTER TABLE `student_course` DISABLE KEYS */;

INSERT INTO `student_course` (`id`, `subject_block_id`, `student_id`)
VALUES
	(1,1,1),
	(2,2,1),
	(3,3,1),
	(4,4,1),
	(5,5,1);

/*!40000 ALTER TABLE `student_course` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table subject_block
# ------------------------------------------------------------

DROP TABLE IF EXISTS `subject_block`;

CREATE TABLE `subject_block` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `subject_id` int(11) unsigned NOT NULL DEFAULT '0',
  `block_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `subject_id` (`subject_id`,`block_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `subject_block` WRITE;
/*!40000 ALTER TABLE `subject_block` DISABLE KEYS */;

INSERT INTO `subject_block` (`id`, `subject_id`, `block_id`)
VALUES
	(1,1,1),
	(2,2,1),
	(3,3,1),
	(4,4,1),
	(5,5,1);

/*!40000 ALTER TABLE `subject_block` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table subjects
# ------------------------------------------------------------

DROP TABLE IF EXISTS `subjects`;

CREATE TABLE `subjects` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `subjects` WRITE;
/*!40000 ALTER TABLE `subjects` DISABLE KEYS */;

INSERT INTO `subjects` (`id`, `name`, `updated_at`, `created_at`)
VALUES
	(1,'programming','2021-09-11 04:45:08','0000-00-00 00:00:00'),
	(2,'math','2021-09-11 04:45:24','0000-00-00 00:00:00'),
	(3,'phys ed','2021-09-11 04:45:31','0000-00-00 00:00:00'),
	(4,'german','2021-09-11 04:45:40','0000-00-00 00:00:00'),
	(5,'music','2021-09-11 04:45:54','0000-00-00 00:00:00');

/*!40000 ALTER TABLE `subjects` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table time_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `time_log`;

CREATE TABLE `time_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL DEFAULT '0000-00-00',
  `student_course_id` int(10) unsigned NOT NULL DEFAULT '0',
  `minutes` int(10) unsigned NOT NULL DEFAULT '0',
  `points` decimal(6,2) unsigned NOT NULL DEFAULT '0.00',
  `notes` varchar(8000) NOT NULL DEFAULT '',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `date` (`date`,`student_course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `time_log` WRITE;
/*!40000 ALTER TABLE `time_log` DISABLE KEYS */;

INSERT INTO `time_log` (`id`, `date`, `student_course_id`, `minutes`, `points`, `notes`, `updated_at`, `created_at`)
VALUES
	(1,'2021-08-30',1,22,0.00,'html & css basics','2021-09-11 04:54:06','0000-00-00 00:00:00'),
	(2,'2021-08-30',3,25,0.00,'bike & weights','2021-09-11 04:54:06','0000-00-00 00:00:00'),
	(3,'2021-08-30',5,20,0.00,'i-iv-v; clementi','2021-09-11 04:54:06','0000-00-00 00:00:00'),
	(4,'2021-08-31',2,15,0.00,'problem 1 new book','2021-09-11 04:54:06','0000-00-00 00:00:00'),
	(5,'2021-08-31',4,25,0.00,'dlg 1 new book','2021-09-11 04:54:06','0000-00-00 00:00:00'),
	(6,'2021-09-01',3,20,0.00,'dance with Mom; weights','2021-09-11 04:54:06','0000-00-00 00:00:00'),
	(7,'2021-09-01',4,15,0.00,'begin story 1; revw dlg 1','2021-09-11 04:54:06','0000-00-00 00:00:00'),
	(8,'2021-09-01',5,20,0.00,'bass riff can\'t touch this; clementi','2021-09-11 04:54:06','0000-00-00 00:00:00'),
	(9,'2021-09-02',3,10,0.00,'run around the house','2021-09-11 04:54:06','0000-00-00 00:00:00'),
	(10,'2021-09-02',2,10,0.00,'percentages','2021-09-11 04:54:06','0000-00-00 00:00:00'),
	(11,'2021-09-03',3,20,0.00,'stretch, calesthenics, weights, punching','2021-09-11 04:54:06','0000-00-00 00:00:00'),
	(12,'2021-09-03',4,20,0.00,'dlg 3','2021-09-11 04:54:06','0000-00-00 00:00:00'),
	(13,'2021-09-03',2,25,0.00,'problem 2 new book','2021-09-11 04:54:06','0000-00-00 00:00:00'),
	(14,'2021-09-03',5,25,0.00,'chords to waymaker; clementi; jam','2021-09-11 04:54:06','0000-00-00 00:00:00'),
	(15,'2021-09-06',2,20,0.00,'averages','2021-09-11 04:54:06','0000-00-00 00:00:00'),
	(16,'2021-09-06',3,15,0.00,'9m HIIT; 1m weights','2021-09-11 04:54:06','0000-00-00 00:00:00'),
	(17,'2021-09-06',4,20,0.00,'dlg 2','2021-09-11 04:54:06','0000-00-00 00:00:00'),
	(18,'2021-09-06',5,20,0.00,'clementi + jams','2021-09-11 04:54:06','0000-00-00 00:00:00'),
	(19,'2021-09-07',3,15,0.00,'stretching, abs, weights','2021-09-11 04:54:06','0000-00-00 00:00:00'),
	(20,'2021-09-08',4,20,0.00,'dlg2 questions; memorize 4 lines','2021-09-11 04:54:06','0000-00-00 00:00:00'),
	(21,'2021-09-08',2,20,0.00,'book problem 3','2021-09-11 04:54:06','0000-00-00 00:00:00'),
	(22,'2021-09-08',3,10,0.00,'weights; plank 30s','2021-09-11 04:54:06','0000-00-00 00:00:00'),
	(23,'2021-09-09',3,30,0.00,'katas, jumps, punching, 30s push-up position','2021-09-11 04:54:06','0000-00-00 00:00:00'),
	(24,'2021-09-09',2,20,0.00,'book problem 4','2021-09-11 04:54:06','0000-00-00 00:00:00'),
	(25,'2021-09-09',5,30,0.00,'drums ritmos 1-8; jams on piano','2021-09-11 04:54:06','0000-00-00 00:00:00'),
	(26,'2021-09-10',1,30,0.00,'processing little men','2021-09-11 04:54:06','0000-00-00 00:00:00'),
	(27,'2021-09-10',4,20,0.00,'test 1','2021-09-11 04:54:06','0000-00-00 00:00:00'),
	(28,'2021-09-10',3,5,0.00,'jumping and sit-ups','2021-09-11 04:54:06','0000-00-00 00:00:00'),
	(29,'2021-09-13',5,30,0.00,'clementi up thru bar 5; guitar Em','2021-09-13 14:54:06','0000-00-00 00:00:00'),
	(30,'2021-09-13',3,10,0.00,'various stuff','2021-09-13 14:54:06','0000-00-00 00:00:00'),
	(31,'2021-09-13',2,10,0.00,'read problem 5','2021-09-13 14:54:06','0000-00-00 00:00:00'),
	(33,'2021-09-14',2,15,0.00,'do problem 5','2021-09-13 14:54:06','0000-00-00 00:00:00'),
	(34,'2021-09-14',3,15,0.00,'basketball dribbling','2021-09-13 14:54:06','0000-00-00 00:00:00'),
	(36,'2021-09-15',3,15,0.00,'basketball dribbling; bungee defense','2021-09-13 14:54:06','0000-00-00 00:00:00'),
	(37,'2021-09-15',1,30,0.00,'processing cars','2021-09-13 14:54:06','0000-00-00 00:00:00'),
	(38,'2021-09-16',3,15,0.00,'basketball dribbling; bungee defense, weights, abs','2021-09-13 14:54:06','0000-00-00 00:00:00'),
	(39,'2021-09-16',2,20,0.00,'percents etc','2021-09-13 14:54:06','0000-00-00 00:00:00'),
	(40,'2021-09-17',3,25,0.00,'basketball dribbling; bungee defense, weights, abs','2021-09-13 14:54:06','0000-00-00 00:00:00'),
	(41,'2021-09-18',5,30,0.00,'a very painful clementi session','2021-09-13 14:54:06','0000-00-00 00:00:00'),
	(42,'2021-09-20',2,20,0.00,'problem 6','2021-09-13 14:54:06','0000-00-00 00:00:00'),
	(43,'2021-09-20',4,10,0.00,'review for test 2','2021-09-11 04:54:06','0000-00-00 00:00:00'),
	(44,'2021-09-21',4,20,0.00,'test 2','2021-09-11 04:54:06','0000-00-00 00:00:00'),
	(45,'2021-09-21',1,15,0.00,'cars -- add name, change colors...','2021-09-22 05:37:21','2021-09-21 00:00:00'),
	(46,'2021-09-21',3,20,0.00,'basketball dribbling; bungee defense','2021-09-13 14:54:06','0000-00-00 00:00:00'),
	(47,'2021-09-22',4,10,0.00,'video lesson 6','2021-09-23 07:10:22','2021-09-23 07:10:22'),
	(48,'2021-09-22',3,15,0.00,'abs, punches, kicks','2021-09-23 07:17:04','2021-09-21 07:12:21'),
	(53,'2021-09-22',5,20,0.00,'clementi sonatina 1 mv 2, holst jupiter','2021-09-23 07:17:56','2021-09-23 07:17:33'),
	(56,'2021-09-23',2,20,0.00,'division  -- 1/7 etc','2021-09-24 07:32:26','2021-09-24 07:31:17'),
	(65,'2021-09-23',5,20,0.00,'guitar','2021-09-24 07:32:52','2021-09-24 07:32:48'),
	(68,'2021-09-24',2,20,0.00,'a is what % of b','2021-09-24 17:03:28','2021-09-24 17:03:08'),
	(72,'2021-09-24',4,15,0.00,'video lesson 7','2021-09-24 18:49:02','2021-09-24 17:03:32'),
	(78,'2021-09-27',4,15,0.00,'lesson 8 video','2021-09-27 14:48:56','2021-09-27 14:48:42'),
	(80,'2021-09-27',2,20,0.00,'problem 7','2021-09-27 14:49:05','2021-09-27 14:48:59'),
	(83,'2021-09-27',3,20,0.00,'HR video, b-ball, abs','2021-09-27 15:50:15','2021-09-27 15:50:03'),
	(85,'2021-09-28',1,30,0.00,'cars, change lanes, monster','2021-09-29 04:24:56','2021-09-29 04:24:26'),
	(87,'2021-09-28',5,20,0.00,'clementi','2021-09-29 04:25:13','2021-09-29 04:25:05'),
	(90,'2021-09-29',4,10,0.00,'https://www.youtube.com/playlist?list=PLk1fjOl39-50WX8xiXwIBUcbdtMjlaZSj','2021-09-29 17:43:22','2021-09-29 04:34:15'),
	(93,'2021-09-29',2,15,0.00,'review percentages','2021-09-29 17:43:39','2021-09-29 17:43:30'),
	(95,'2021-09-29',3,5,0.00,'weights','2021-09-29 17:43:49','2021-09-29 17:43:41'),
	(97,'2021-09-30',2,15,0.00,'1/8 of 3 is done; how muh left to do?','2021-09-30 13:53:10','2021-09-30 13:52:51'),
	(99,'2021-09-30',4,10,0.00,'ich sage, du sagst, er macht...','2021-09-30 13:53:34','2021-09-30 13:53:17'),
	(103,'2021-09-30',5,10,0.00,'clementi','2021-10-01 12:30:41','2021-10-01 12:30:33'),
	(105,'2021-10-01',4,15,0.00,'same video as the other day plus one more plus conjugations','2021-10-01 13:46:48','2021-10-01 13:46:21'),
	(107,'2021-10-01',3,5,0.00,'weights','2021-10-01 14:35:31','2021-10-01 14:35:27'),
	(109,'2021-10-01',5,10,0.00,'clementi','2021-10-01 14:38:42','2021-10-01 14:38:34'),
	(111,'2021-10-04',2,15,0.00,'multiplying fractions','2021-10-04 14:10:04','2021-10-04 14:09:11'),
	(114,'2021-10-04',4,15,0.00,'german list oct 2021','2021-10-04 14:10:13','2021-10-04 14:09:36'),
	(120,'2021-10-05',5,20,0.00,'clementi, guitar','2021-10-05 14:51:50','2021-10-05 14:51:42'),
	(122,'2021-10-05',3,10,0.00,'weights, abs','2021-10-05 14:51:57','2021-10-05 14:51:52'),
	(124,'2021-10-05',1,30,0.00,'improve monster motion in cars','2021-10-05 14:52:13','2021-10-05 14:52:02'),
	(126,'2021-10-06',4,20,0.00,'add to list; easy german video','2021-10-06 14:10:47','2021-10-06 14:10:23'),
	(130,'2021-10-06',3,10,0.00,'weights & abs','2021-10-06 18:08:05','2021-10-06 18:07:58'),
	(132,'2021-10-07',5,20,0.00,'clementi + mmbop drum part investigate','2021-10-07 17:40:22','2021-10-07 17:39:51'),
	(136,'2021-10-07',2,15,0.00,'more on mult fractions; why 0.999... = 1','2021-10-07 17:40:51','2021-10-07 17:40:28'),
	(138,'2021-10-08',4,20,0.00,'gehen plus longer list','2021-10-08 14:25:35','2021-10-08 14:25:25'),
	(140,'2021-10-08',3,5,0.00,'abs with madfit','2021-10-08 15:12:04','2021-10-08 14:25:44');

/*!40000 ALTER TABLE `time_log` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
