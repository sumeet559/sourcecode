-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	6.0.3-alpha-community


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema sourcecode
--

CREATE DATABASE IF NOT EXISTS sourcecode;
USE sourcecode;

--
-- Definition of table `approve_user`
--

DROP TABLE IF EXISTS `approve_user`;
CREATE TABLE `approve_user` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(45) NOT NULL,
  `pwd` varchar(45) NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `approve_user`
--

/*!40000 ALTER TABLE `approve_user` DISABLE KEYS */;
INSERT INTO `approve_user` (`uid`,`user_name`,`pwd`) VALUES 
 (11,'vicky','12345'),
 (23,'sumeet','asdfg');
/*!40000 ALTER TABLE `approve_user` ENABLE KEYS */;


--
-- Definition of table `movie`
--

DROP TABLE IF EXISTS `movie`;
CREATE TABLE `movie` (
  `rec_from` varchar(45) NOT NULL,
  `movie_watched` varchar(45) NOT NULL,
  `rec_to` varchar(45) NOT NULL,
  `uid` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `movie`
--

/*!40000 ALTER TABLE `movie` DISABLE KEYS */;
INSERT INTO `movie` (`rec_from`,`movie_watched`,`rec_to`,`uid`) VALUES 
 (' sumeet','Paa','vicky',23),
 (' sumeet','Dil','vicky',23),
 (' sumeet','Rocky','vicky',23),
 (' vicky','Kung Fu Panda','sumeet',11),
 (' vicky','Dostana','sumeet',11);
/*!40000 ALTER TABLE `movie` ENABLE KEYS */;


--
-- Definition of table `people`
--

DROP TABLE IF EXISTS `people`;
CREATE TABLE `people` (
  `user_name` varchar(45) NOT NULL DEFAULT 'a',
  `movie` varchar(45) NOT NULL DEFAULT 'a',
  `rating` varchar(45) NOT NULL DEFAULT '0',
  `uid` int(10) unsigned NOT NULL DEFAULT '0',
  `date` varchar(45) NOT NULL DEFAULT 'a'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `people`
--

/*!40000 ALTER TABLE `people` DISABLE KEYS */;
INSERT INTO `people` (`user_name`,`movie`,`rating`,`uid`,`date`) VALUES 
 (' sumeet','Faltu','4',23,'20 Sep 2015'),
 (' sumeet','Ghatak','7',23,'20 Sep 2015'),
 (' sumeet','Billu','6',23,'20 Sep 2015'),
 (' sumeet','Ghayal','3',23,'20 Sep 2015'),
 (' sumeet','Titanic','9',23,'20 Sep 2015'),
 (' sumeet','Rocky','9',23,'20 Sep 2015'),
 (' vicky','Devdas','7',11,'20 Sep 2015'),
 (' vicky','Rang De Basanti','9',11,'20 Sep 2015'),
 (' vicky','Beta','4',11,'20 Sep 2015'),
 (' vicky','Johnny','2',11,'20 Sep 2015');
/*!40000 ALTER TABLE `people` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
