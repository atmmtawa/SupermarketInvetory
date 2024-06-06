-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jun 05, 2024 at 04:38 PM
-- Server version: 10.1.13-MariaDB
-- PHP Version: 7.0.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `supermarketinvetorydb`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `categoryID` int(11) NOT NULL,
  `categoryName` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`categoryID`, `categoryName`) VALUES
(1, 'nyama');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customerID` int(11) NOT NULL,
  `firstname` varchar(30) NOT NULL,
  `lastname` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customerID`, `firstname`, `lastname`) VALUES
(1, 'alex', 'ziya');

-- --------------------------------------------------------

--
-- Table structure for table `customercontact`
--

CREATE TABLE `customercontact` (
  `contactId` int(11) NOT NULL,
  `customerID` int(11) DEFAULT NULL,
  `phoneNumber` int(11) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `invetory`
--

CREATE TABLE `invetory` (
  `invertoryID` int(11) NOT NULL,
  `productId` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `lastUpdated` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `productId` int(11) NOT NULL,
  `productName` varchar(30) NOT NULL,
  `categoryID` int(11) DEFAULT NULL,
  `supplierID` int(11) DEFAULT NULL,
  `unitMeasure` varchar(30) DEFAULT NULL,
  `totalUnit` int(11) DEFAULT NULL,
  `unitPrice` int(11) DEFAULT NULL,
  `costPrice` int(11) DEFAULT '0',
  `sellingPrice` int(11) DEFAULT '0',
  `ExpireDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`productId`, `productName`, `categoryID`, `supplierID`, `unitMeasure`, `totalUnit`, `unitPrice`, `costPrice`, `sellingPrice`, `ExpireDate`) VALUES
(3, 'nyama ya kuk', 1, 1, 'kg', 1, 8000, 8000, 12000, '2024-06-07'),
(4, 'nyama ya ngombe', 1, NULL, 'kg', 2, 8000, 16000, 24000, '2024-06-07'),
(5, 'mchele', 1, 1, 'kg', -3, 2000, -6000, -9000, '2024-06-07');

--
-- Triggers `product`
--
DELIMITER $$
CREATE TRIGGER `notification` AFTER UPDATE ON `product` FOR EACH ROW BEGIN
if new.totalUnit <= 1 THEN
INSERT INTO productstatus(productId,messege) VALUES(new.productId,concat(new.productName," inakaribia kuisha wasiliana na wasambazaji wetu"));
ELSE
DELETE FROM productstatus WHERE productId=new.productId;
END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_before_insert_costPrice` BEFORE INSERT ON `product` FOR EACH ROW BEGIN
  SET NEW.costPrice = NEW.unitPrice * new.totalUnit;
  SET NEW.sellingPrice = NEW.costPrice * 1.5;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_before_update_costPrice` BEFORE UPDATE ON `product` FOR EACH ROW BEGIN
  SET NEW.costPrice = NEW.unitPrice * new.totalUnit;
  SET NEW.sellingPrice = NEW.costPrice * 1.5;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `productstatus`
--

CREATE TABLE `productstatus` (
  `notificationID` int(11) NOT NULL,
  `productId` int(11) DEFAULT NULL,
  `messege` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `productstatus`
--

INSERT INTO `productstatus` (`notificationID`, `productId`, `messege`) VALUES
(4, 3, 'nyama ya kuk inakaribia kuisha wasiliana na wasambazaji wetu'),
(7, 5, 'mchele inakaribia kuisha wasiliana na wasambazaji wetu');

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `saleID` int(11) NOT NULL,
  `productId` int(11) DEFAULT NULL,
  `customerID` int(11) DEFAULT NULL,
  `QuanitySolid` int(11) DEFAULT '0',
  `dateOfSale` timestamp NULL DEFAULT NULL,
  `TotalAmount` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`saleID`, `productId`, `customerID`, `QuanitySolid`, `dateOfSale`, `TotalAmount`) VALUES
(1, 3, 1, 3, '2024-06-04 21:00:00', NULL),
(2, 3, 1, 3, '2024-06-04 21:00:00', NULL),
(3, 3, 1, 4, '2024-06-05 21:00:00', NULL),
(4, 5, 1, 3, '2024-06-04 21:00:00', NULL),
(5, 5, 1, 40, '2024-06-04 21:00:00', NULL),
(6, 5, 1, 30, '2024-06-04 21:00:00', NULL),
(7, 5, 1, 8, '2024-06-04 21:00:00', NULL),
(8, 5, 1, 1, '2024-06-05 21:00:00', NULL),
(9, 5, 1, 5, '2024-06-05 21:00:00', NULL),
(10, 4, 1, -6, '2024-06-04 21:00:00', NULL),
(11, 4, 1, 0, '2024-06-04 21:00:00', NULL),
(12, 4, 1, -3, '2024-06-04 21:00:00', NULL),
(13, 4, 1, -1, '2024-06-05 21:00:00', NULL),
(14, 4, 1, 13, '2024-06-05 21:00:00', NULL),
(15, 4, 1, 3, '2024-06-04 21:00:00', 24000),
(16, 4, 1, 1, '2024-06-05 21:00:00', 8000);

--
-- Triggers `sales`
--
DELIMITER $$
CREATE TRIGGER `trg_update_total_unit_and_cost_price` AFTER INSERT ON `sales` FOR EACH ROW BEGIN
    UPDATE product
  SET totalUnit = totalUnit - NEW.QuanitySolid,
      costPrice = (totalUnit - NEW.QuanitySolid) * unitPrice
  WHERE productId = NEW.productId;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_validate_quantity` BEFORE INSERT ON `sales` FOR EACH ROW BEGIN
  DECLARE available_units INT;
  DECLARE unitPrices int;
  SELECT unitPrice INTO unitPrices FROM product WHERE productId = new.productId;
  SET new.TotalAmount=new.QuanitySolid * unitPrices;
   SELECT totalUnit INTO available_units FROM product WHERE productId = NEW.productId; 
    IF NEW.QuanitySolid > available_units THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Not enough product in stock';
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `supplierID` int(11) NOT NULL,
  `supplierFName` varchar(30) NOT NULL,
  `supplierLName` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`supplierID`, `supplierFName`, `supplierLName`) VALUES
(1, 'gwakila', 'eliah');

-- --------------------------------------------------------

--
-- Table structure for table `suppliercontactinfo`
--

CREATE TABLE `suppliercontactinfo` (
  `infoID` int(11) NOT NULL,
  `phoneNumber` int(11) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `supplierID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `supplierorder`
--

CREATE TABLE `supplierorder` (
  `orderID` int(11) NOT NULL,
  `supplierID` int(11) DEFAULT NULL,
  `productId` int(11) DEFAULT NULL,
  `orderDate` date DEFAULT NULL,
  `deliveryDate` date DEFAULT NULL,
  `orderStatus` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `userlogin`
--

CREATE TABLE `userlogin` (
  `userId` int(11) NOT NULL,
  `userEmail` varchar(30) NOT NULL,
  `userPassword` varchar(30) DEFAULT NULL,
  `UserRole` varchar(30) DEFAULT 'normal'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`categoryID`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customerID`);

--
-- Indexes for table `customercontact`
--
ALTER TABLE `customercontact`
  ADD PRIMARY KEY (`contactId`),
  ADD UNIQUE KEY `phoneNumber` (`phoneNumber`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `customerID` (`customerID`);

--
-- Indexes for table `invetory`
--
ALTER TABLE `invetory`
  ADD PRIMARY KEY (`invertoryID`),
  ADD KEY `productId` (`productId`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`productId`),
  ADD KEY `categoryID` (`categoryID`),
  ADD KEY `supplierID` (`supplierID`);

--
-- Indexes for table `productstatus`
--
ALTER TABLE `productstatus`
  ADD PRIMARY KEY (`notificationID`),
  ADD KEY `productId` (`productId`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`saleID`),
  ADD KEY `productId` (`productId`),
  ADD KEY `customerID` (`customerID`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`supplierID`);

--
-- Indexes for table `suppliercontactinfo`
--
ALTER TABLE `suppliercontactinfo`
  ADD PRIMARY KEY (`infoID`),
  ADD UNIQUE KEY `phoneNumber` (`phoneNumber`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `supplierID` (`supplierID`);

--
-- Indexes for table `supplierorder`
--
ALTER TABLE `supplierorder`
  ADD PRIMARY KEY (`orderID`),
  ADD KEY `supplierID` (`supplierID`),
  ADD KEY `productId` (`productId`);

--
-- Indexes for table `userlogin`
--
ALTER TABLE `userlogin`
  ADD PRIMARY KEY (`userId`),
  ADD UNIQUE KEY `userEmail` (`userEmail`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `categoryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customerID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `customercontact`
--
ALTER TABLE `customercontact`
  MODIFY `contactId` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `invetory`
--
ALTER TABLE `invetory`
  MODIFY `invertoryID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `productId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `productstatus`
--
ALTER TABLE `productstatus`
  MODIFY `notificationID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `saleID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `supplier`
--
ALTER TABLE `supplier`
  MODIFY `supplierID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `suppliercontactinfo`
--
ALTER TABLE `suppliercontactinfo`
  MODIFY `infoID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `supplierorder`
--
ALTER TABLE `supplierorder`
  MODIFY `orderID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `userlogin`
--
ALTER TABLE `userlogin`
  MODIFY `userId` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `customercontact`
--
ALTER TABLE `customercontact`
  ADD CONSTRAINT `customercontact_ibfk_1` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `invetory`
--
ALTER TABLE `invetory`
  ADD CONSTRAINT `invetory_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`categoryID`) REFERENCES `category` (`categoryID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `product_ibfk_2` FOREIGN KEY (`supplierID`) REFERENCES `supplier` (`supplierID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `productstatus`
--
ALTER TABLE `productstatus`
  ADD CONSTRAINT `productstatus_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sales_ibfk_2` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `suppliercontactinfo`
--
ALTER TABLE `suppliercontactinfo`
  ADD CONSTRAINT `suppliercontactinfo_ibfk_1` FOREIGN KEY (`supplierID`) REFERENCES `supplier` (`supplierID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `supplierorder`
--
ALTER TABLE `supplierorder`
  ADD CONSTRAINT `supplierorder_ibfk_1` FOREIGN KEY (`supplierID`) REFERENCES `supplier` (`supplierID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `supplierorder_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
