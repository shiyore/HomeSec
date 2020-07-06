-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 06, 2020 at 02:37 AM
-- Server version: 5.7.24
-- PHP Version: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `homesec`
--

-- --------------------------------------------------------

--
-- Table structure for table `accesskeys`
--

CREATE TABLE `accesskeys` (
  `codeID` int(11) NOT NULL,
  `code` varchar(12) NOT NULL,
  `masterKey` tinyint(1) NOT NULL DEFAULT '0',
  `userID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `accesskeys`
--

INSERT INTO `accesskeys` (`codeID`, `code`, `masterKey`, `userID`) VALUES
(1, '323415', 1, 1),
(2, '123456', 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `devicedat`
--

CREATE TABLE `devicedat` (
  `DeviceID` int(11) NOT NULL,
  `deviceName` varchar(16) DEFAULT 'Default Name',
  `deviceType` varchar(16) DEFAULT NULL,
  `activated` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `devicedat`
--

INSERT INTO `devicedat` (`DeviceID`, `deviceName`, `deviceType`, `activated`) VALUES
(1, 'keypad1', 'keypad_type', 0),
(2, 'keypad2', 'keypad_type', 0),
(3, 'Front Door', 'movement_type', 0),
(4, 'Front Porch', 'motion_type', 0),
(5, 'Alarm', 'alarm_type', 0);

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `historyID` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `code` int(11) DEFAULT NULL,
  `data` varchar(32) DEFAULT NULL,
  `user` int(11) DEFAULT NULL,
  `device` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `history`
--

INSERT INTO `history` (`historyID`, `date`, `code`, `data`, `user`, `device`) VALUES
(1, '2020-07-04 13:37:55', 323415, '', 1, 1),
(2, '2020-07-05 16:37:55', 2237, '', NULL, 2),
(3, '2020-07-05 16:41:22', NULL, 'Sensor tripped: 3ft', NULL, 4),
(4, '2020-07-05 19:00:23', NULL, 'Motion Sensor Tripped', NULL, 3),
(5, '2020-07-04 13:37:55', 323415, NULL, NULL, 3);

-- --------------------------------------------------------

--
-- Table structure for table `userdat`
--

CREATE TABLE `userdat` (
  `UserID` int(11) NOT NULL,
  `firstName` varchar(16) NOT NULL,
  `lastName` varchar(16) NOT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `address` varchar(40) DEFAULT NULL,
  `item` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `userdat`
--

INSERT INTO `userdat` (`UserID`, `firstName`, `lastName`, `phone`, `address`, `item`) VALUES
(1, 'Aiden', 'Yoshioka', '6615423117', 'unknown', NULL),
(2, 'Alec', 'Sanchez', 'unknown', 'unknown', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accesskeys`
--
ALTER TABLE `accesskeys`
  ADD PRIMARY KEY (`codeID`),
  ADD KEY `userID_idx` (`userID`);

--
-- Indexes for table `devicedat`
--
ALTER TABLE `devicedat`
  ADD PRIMARY KEY (`DeviceID`);

--
-- Indexes for table `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`historyID`),
  ADD KEY `user_idx` (`user`),
  ADD KEY `device_idx` (`device`);

--
-- Indexes for table `userdat`
--
ALTER TABLE `userdat`
  ADD PRIMARY KEY (`UserID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accesskeys`
--
ALTER TABLE `accesskeys`
  MODIFY `codeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `devicedat`
--
ALTER TABLE `devicedat`
  MODIFY `DeviceID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `history`
--
ALTER TABLE `history`
  MODIFY `historyID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `userdat`
--
ALTER TABLE `userdat`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `accesskeys`
--
ALTER TABLE `accesskeys`
  ADD CONSTRAINT `userID` FOREIGN KEY (`userID`) REFERENCES `userdat` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `history`
--
ALTER TABLE `history`
  ADD CONSTRAINT `device` FOREIGN KEY (`device`) REFERENCES `devicedat` (`DeviceID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `user` FOREIGN KEY (`user`) REFERENCES `userdat` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
