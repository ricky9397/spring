-- MySQL dump 10.13  Distrib 8.0.19, for macos10.15 (x86_64)
--
-- Host: database-1.ckj7b1cenola.ap-northeast-2.rds.amazonaws.com    Database: gymcarry
-- ------------------------------------------------------
-- Server version	8.0.23

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';


DROP TABLE IF EXISTS `ADMIN`;
CREATE TABLE `admin` (
  `adminidx` int NOT NULL AUTO_INCREMENT,
  `adminid` varchar(45) COLLATE utf8_bin NOT NULL,
  `adminpw` varchar(45) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`adminidx`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;


--
-- Table structure for table `MEMBER`
--

DROP TABLE IF EXISTS `MEMBER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `MEMIDX` int NOT NULL AUTO_INCREMENT COMMENT '회원번호',
  `JOINKEY_STATUS` varchar(10) DEFAULT '0' COMMENT '인증키 여부',
  `JOINKEY` varchar(10) DEFAULT NULL COMMENT '인증키 저장',
  `MEMEMAIL` varchar(40) NOT NULL COMMENT '이메일',
  `MEMPW` varchar(30) NOT NULL COMMENT '비밀번호',
  `MEMNAME` varchar(50) NOT NULL COMMENT '이름',
  `MEMNICK` varchar(50) NOT NULL COMMENT '닉네임',
  `MEMPHONE` varchar(50) NOT NULL COMMENT '핸드폰번호',
  `MEMBIRTH` int NOT NULL COMMENT '생년월일',
  `MEMGENDER` varchar(5) NOT NULL COMMENT '성별',
  `MEMPHOTO` varchar(30) DEFAULT NULL COMMENT '회원사진',
  PRIMARY KEY (`MEMIDX`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='회원';

--
-- Table structure for table `MEMBERBODYINFO`
--

DROP TABLE IF EXISTS `MEMBERBODYINFO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `memberbodyinfo` (
  `MEMO` mediumtext COMMENT '타입',
  `MEMDATE` timestamp NULL DEFAULT NULL COMMENT '날짜',
  `MEMIDX` int NOT NULL COMMENT '회원번호',
  KEY `FK_MEMBER_TO_MEMBERBODYINFO` (`MEMIDX`),
  CONSTRAINT `FK_MEMBER_TO_MEMBERBODYINFO` FOREIGN KEY (`MEMIDX`) REFERENCES `member` (`MEMIDX`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='회원바디기록';




--
-- Table structure for table `BOARD`
--

DROP TABLE IF EXISTS `BOARD`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `board` (
  `POSTIDX` int NOT NULL AUTO_INCREMENT COMMENT '게시글IDX',
  `POSTNAME` varchar(255) NOT NULL COMMENT '제목',
  `POSTCONTENT` text NOT NULL COMMENT '글내용',
  `POSTNICK` varchar(50) NOT NULL COMMENT '닉네임',
  `MEMIDX` int NOT NULL COMMENT '회원번호',
  `UPLOADFILE` mediumblob COMMENT '첨부파일',
  `POSTDATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '작성일자',
  `POSTVIEW` int NOT NULL DEFAULT '0' COMMENT '조회수',
  `POSTLIKE` int DEFAULT NULL COMMENT '좋아요갯수',
  `BOARDCATEGORY` varchar(50) NOT NULL COMMENT '말머리',
  PRIMARY KEY (`POSTIDX`),
  KEY `FK_MEMBER_TO_BOARD` (`MEMIDX`),
  CONSTRAINT `FK_MEMBER_TO_BOARD` FOREIGN KEY (`MEMIDX`) REFERENCES `member` (`MEMIDX`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='게시판';

--
-- Table structure for table `BOARDCOMMENT`
--

DROP TABLE IF EXISTS `BOARDCOMMENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `boardcomment` (
  `COMMENTIDX` int NOT NULL AUTO_INCREMENT COMMENT '댓글IDX',
  `POSTIDX` int NOT NULL COMMENT '게시글IDX',
  `COMMENTNICK` varchar(50) NOT NULL COMMENT '닉네임',
  `COMMENTCONTENT` mediumtext NOT NULL COMMENT '댓글내용',
  `COMMENTDATE` timestamp NOT NULL COMMENT '댓글작성일자',
  PRIMARY KEY (`COMMENTIDX`),
  KEY `FK_BOARD_TO_BOARDCOMMENT` (`POSTIDX`),
  CONSTRAINT `FK_BOARD_TO_BOARDCOMMENT` FOREIGN KEY (`POSTIDX`) REFERENCES `board` (`POSTIDX`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='게시판댓글';



--
-- Table structure for table `PLACE`
--

DROP TABLE IF EXISTS `PLACE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `place` (
  `PLACENUM` int NOT NULL COMMENT '운동구분',
  `PLACEIDX` int NOT NULL AUTO_INCREMENT COMMENT '플레이스IDX',
  `PLACENAME` varchar(50) NOT NULL COMMENT '업체명',
  `PLACEADDRESS` mediumtext NOT NULL COMMENT '업체주소',
  `LATITUDE` decimal(13,10) NOT NULL COMMENT '위도',
  `LONGITUDE` decimal(13,10) NOT NULL COMMENT '경도',
  `PLACEPHONE` varchar(50) NOT NULL COMMENT '업체전화번호',
  `PLACEINFO` text NOT NULL COMMENT '이용정보',
  `PLACEINTRO` text NOT NULL COMMENT '업체소개',
  `OPENHOUR` text NOT NULL COMMENT '영업시간',
  `PLACEIMG` text NOT NULL COMMENT '이미지',
  PRIMARY KEY (`PLACEIDX`)
) ENGINE=InnoDB AUTO_INCREMENT=390 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='플레이스';



--
-- Table structure for table `carry`
--

DROP TABLE IF EXISTS `CARRY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carry` (
  `CRIDX` int NOT NULL AUTO_INCREMENT COMMENT '캐리IDX',
  `JOINKEY_STATUS` varchar(10) DEFAULT '0' COMMENT '인증키 여부',
  `JOINKEY` varchar(10) DEFAULT NULL COMMENT '인증키 저장',
  `CRPHOTO` varchar(30) DEFAULT 'photo.png' COMMENT '캐리사진',
  `CRBFPHOTO` varchar(30) DEFAULT 'photo.png' COMMENT '캐리 바디프로필 사진',
  `CREMAIL` varchar(30) NOT NULL COMMENT '캐리아이디',
  `CRPW` varchar(30) NOT NULL COMMENT '비밀번호',
  `CRNAME` varchar(50) DEFAULT NULL COMMENT '캐리실명',
  `CRNICK` varchar(50) DEFAULT NULL COMMENT '캐리닉네임',
  `CRGENDER` varchar(5) DEFAULT NULL COMMENT '성별',
  `CRPHONE` varchar(50) DEFAULT NULL COMMENT '캐리연락처',
  `CRINTRO` text COMMENT '소갯말',
  `CRDEPART` varchar(10) DEFAULT NULL COMMENT '전문분야',
  `CRFIELD` varchar(10) DEFAULT NULL COMMENT '종목',
  `FACEORNOT` tinyint(1) DEFAULT NULL COMMENT '비대면&대면',
  `PLACEIDX` int DEFAULT NULL COMMENT '플레이스IDX',
  PRIMARY KEY (`CRIDX`),
  KEY `FK_PLACE_TO_CARRY` (`PLACEIDX`),
  CONSTRAINT `FK_PLACE_TO_CARRY` FOREIGN KEY (`PLACEIDX`) REFERENCES `place` (`PLACEIDX`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='캐리정보';

--
-- Table structure for table `crcertification`
--

DROP TABLE IF EXISTS `CRCERTIFICATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `crcertification` (
  `CRIDX` int NOT NULL COMMENT '캐리번호',
  `CRCERTI1` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '자격및경력1',
  `CRCERTI2` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '자격및경력1',
  `CRCERTI3` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '자격및경력1',
  `CRCERTI4` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '자격및경력1',
  `CRCERTI5` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '자격및경력1',
  KEY `FK_CARRY_TO_CRCERTIFICATION` (`CRIDX`),
  CONSTRAINT `FK_CARRY_TO_CRCERTIFICATION` FOREIGN KEY (`CRIDX`) REFERENCES `carry` (`CRIDX`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
--
-- Table structure for table `crprice`
--

DROP TABLE IF EXISTS `CRPRICE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `crprice` (
  `CRIDX` int NOT NULL COMMENT '캐리번호',
  `PROCOUNT` int DEFAULT NULL COMMENT '수업 횟수',
  `PROPRICE` int DEFAULT NULL COMMENT '횟수당 가격',
  KEY `FK_CARRY_TO_CRPROGRAM` (`CRIDX`),
  CONSTRAINT `FK_CARRY_TO_CRPROGRAM` FOREIGN KEY (`CRIDX`) REFERENCES `carry` (`CRIDX`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `REVIEW`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REVIEW` (
  `REVIEWIDX` int NOT NULL AUTO_INCREMENT COMMENT '리뷰IDX',
  `REVIEWDATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '작성일자',
  `REVIEWCONTENT` mediumtext COMMENT '리뷰내용',
  `CRIDX` int DEFAULT NULL COMMENT '캐리IDX',
  `MEMIDX` int DEFAULT NULL COMMENT '회원번호',
  PRIMARY KEY (`REVIEWIDX`),
  KEY `FK_CARRY_TO_CARRYREVIEW` (`CRIDX`),
  KEY `FK_MEMBER_TO_CARRYREVIEW` (`MEMIDX`),
  CONSTRAINT `FK_CARRY_TO_CARRYREVIEW` FOREIGN KEY (`CRIDX`) REFERENCES `carry` (`CRIDX`) ON DELETE CASCADE,
  CONSTRAINT `FK_MEMBER_TO_CARRYREVIEW` FOREIGN KEY (`MEMIDX`) REFERENCES `member` (`MEMIDX`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='캐리상세페이지 리뷰댓글';




--
-- Table structure for table `CHATLIST`
--

DROP TABLE IF EXISTS `CHATLIST`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CHATLIST` (
  `CHATIDX` int NOT NULL auto_increment COMMENT '채팅방번호',
  `CRIDX` int NOT NULL COMMENT '캐리번호',
  `MEMIDX` int NOT NULL COMMENT '회원번호',
  `OUTCOUNT` INT DEFAULT 2 COMMENT '채팅방나감카운트',
  `OUTDATE` timestamp default current_timestamp on update current_timestamp COMMENT '채팅방 나간시간',
  PRIMARY KEY (`CHATIDX`),
  KEY `FK_CARRY_TO_CHATLIST` (`CRIDX`),
  KEY `FK_MEMBER_TO_CHATLIST` (`MEMIDX`),
  CONSTRAINT `FK_CARRY_TO_CHATLIST` FOREIGN KEY (`CRIDX`) REFERENCES `carry` (`CRIDX`) ON DELETE CASCADE,
  CONSTRAINT `FK_MEMBER_TO_CHATLIST` FOREIGN KEY (`MEMIDX`) REFERENCES `member` (`MEMIDX`) ON DELETE CASCADE
);



--
-- Table structure for table `CHATROOM`
--

DROP TABLE IF EXISTS `CHATROOM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CHATROOM` (
  `MESSAGEIDX` int NOT NULL AUTO_INCREMENT COMMENT '메세지 번호',
  `CHATIDX` int NOT NULL COMMENT '채팅방번호',
  `CHATCONTENT` mediumtext NOT NULL COMMENT '대화내용',
  `CHATDATE` timestamp default current_timestamp COMMENT '대화시간',
  `CRIDX` int NOT NULL COMMENT '캐리번호',
  `MEMIDX` int NOT NULL COMMENT '회원번호',
  `CONTENTTYPE` INT DEFAULT 0 COMMENT '0=유저대화, 1=캐리대화',
  `CHATREAD` INT DEFAULT 0 COMMENT '멤버메세지=0, 캐리메세지=1, 모두읽으면 2',
  PRIMARY KEY (`MESSAGEIDX`),
  KEY `FK_CARRY_TO_CHATROOM` (`CRIDX`),
  KEY `FK_MEMBER_TO_CHATROOM` (`MEMIDX`),
  KEY `FK_CHATLIST_TO_CHATROOM` (`CHATIDX`),
  CONSTRAINT `FK_CARRY_TO_CHATROOM` FOREIGN KEY (`CRIDX`) REFERENCES `carry` (`CRIDX`) ON DELETE CASCADE,
  CONSTRAINT `FK_CHATLIST_TO_CHATROOM` FOREIGN KEY (`CHATIDX`) REFERENCES `chatlist` (`CHATIDX`) ON DELETE CASCADE,
  CONSTRAINT `FK_MEMBER_TO_CHATROOM` FOREIGN KEY (`MEMIDX`) REFERENCES `member` (`MEMIDX`) ON DELETE CASCADE
);


--
-- Table structure for table `LIKELIST`
--

DROP TABLE IF EXISTS `LIKELIST`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likelist` (
  `LIKEIDX` int NOT NULL AUTO_INCREMENT COMMENT '좋아요IDX',
  `MEMIDX` int DEFAULT NULL COMMENT '회원번호',
  `CRIDX` int DEFAULT NULL COMMENT '캐리IDX',
  `LIKECHECK` tinyint(1) DEFAULT NULL COMMENT '좋아요체크',
  PRIMARY KEY (`LIKEIDX`),
  KEY `FK_MEMBER_TO_LIKELIST` (`MEMIDX`),
  KEY `FK_CARRY_TO_LIKELIST` (`CRIDX`),
  CONSTRAINT `likelist_ibfk_1` FOREIGN KEY (`CRIDX`) REFERENCES `carry` (`CRIDX`) ON DELETE CASCADE,
  CONSTRAINT `likelist_ibfk_2` FOREIGN KEY (`MEMIDX`) REFERENCES `member` (`MEMIDX`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='찜한리스트';


--
-- Table structure for table `PAYMENT`
--

DROP TABLE IF EXISTS `PAYMENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `PAYIDX` int NOT NULL AUTO_INCREMENT COMMENT '결제번호',
  `PAYDATE` timestamp NOT NULL COMMENT '결제날짜',
  `MEMIDX` int NOT NULL COMMENT '회원번호',
  `PAYNAME` varchar(10) NOT NULL COMMENT '결제자명',
  `PAYPHONE` varchar(20) NOT NULL COMMENT '결제자연락처',
  `CRIDX` int DEFAULT NULL COMMENT '캐리IDX',
  `PAYPRICE` int NOT NULL COMMENT '결제금액',
  `PAYNUM` int NOT NULL COMMENT '결제한 수업횟수',
  `FACEORNOT` tinyint(1) DEFAULT NULL COMMENT '비대면&대면',
  PRIMARY KEY (`PAYIDX`),
  KEY `FK_MEMBER_TO_PAYMENT` (`MEMIDX`),
  KEY `FK_CARRY_TO_LIKELIST` (`CRIDX`),
  CONSTRAINT `FK_CARRY_TO_PAYMENT` FOREIGN KEY (`CRIDX`) REFERENCES `carry` (`CRIDX`) ON DELETE CASCADE,
  CONSTRAINT `FK_MEMBER_TO_PAYMENT` FOREIGN KEY (`MEMIDX`) REFERENCES `member` (`MEMIDX`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='결제';



/*!40101 SET character_set_client = @saved_cs_client */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-09-06 14:54:18
