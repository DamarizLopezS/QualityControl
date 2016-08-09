-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Aug 08, 2016 at 07:08 AM
-- Server version: 10.1.13-MariaDB
-- PHP Version: 7.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `quality_control`
--

-- --------------------------------------------------------

--
-- Table structure for table `answers`
--

CREATE TABLE `answers` (
  `anw_id` int(11) NOT NULL,
  `anw_value` tinyint(4) NOT NULL DEFAULT '0',
  `itm_serie` int(11) NOT NULL,
  `que_id` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `cli_rfc` varchar(13) NOT NULL,
  `cli_name` varchar(18) NOT NULL,
  `cli_lastName` varchar(15) NOT NULL,
  `cli_phone` varchar(10) NOT NULL,
  `cli_email` varchar(50) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`cli_rfc`, `cli_name`, `cli_lastName`, `cli_phone`, `cli_email`) VALUES
('1234567890123', 'Christian', 'Camacho', '1234567890', 'xentyo@hotmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `composition`
--

CREATE TABLE `composition` (
  `comp_id` int(11) NOT NULL,
  `pie_code` bigint(20) DEFAULT NULL,
  `prod_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `composition`
--

INSERT INTO `composition` (`comp_id`, `pie_code`, `prod_code`) VALUES
(1, 9001, 5000),
(2, 9002, 5000);

-- --------------------------------------------------------

--
-- Table structure for table `inspection`
--

CREATE TABLE `inspection` (
  `ins_id` bigint(20) NOT NULL,
  `ins_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `anw_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Stand-in structure for view `inspection_answers`
--
CREATE TABLE `inspection_answers` (
`ins_id` bigint(20)
,`ins_date` datetime
,`que_id` smallint(6)
,`que_number` tinyint(4)
,`que_text` varchar(50)
,`anw_id` int(11)
,`anw_value` tinyint(4)
,`itm_serie` int(11)
,`lot_code` int(11)
,`itm_status` tinyint(4)
);

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `itm_serie` int(11) NOT NULL,
  `lot_code` int(11) NOT NULL,
  `itm_status` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`itm_serie`, `lot_code`, `itm_status`) VALUES
(150021, 1, 0),
(150022, 1, 0),
(150023, 1, 0),
(150024, 1, 0),
(150025, 1, 0),
(150026, 2, 0),
(150027, 2, 0);

-- --------------------------------------------------------

--
-- Stand-in structure for view `line_operators`
--
CREATE TABLE `line_operators` (
`ope_id` smallint(6)
,`ope_name` varchar(20)
,`ope_lastname` varchar(20)
,`ope_mothers_lastname` varchar(20)
,`lin_code` int(11)
,`lin_name` varchar(30)
);

-- --------------------------------------------------------

--
-- Table structure for table `lots`
--

CREATE TABLE `lots` (
  `lot_code` int(11) NOT NULL,
  `lot_date` datetime NOT NULL,
  `lot_status` tinyint(4) NOT NULL DEFAULT '0',
  `lot_quantity` int(11) NOT NULL,
  `lin_code` int(11) NOT NULL,
  `prod_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lots`
--

INSERT INTO `lots` (`lot_code`, `lot_date`, `lot_status`, `lot_quantity`, `lin_code`, `prod_code`) VALUES
(1, '2016-08-11 17:37:44', 0, 5, 1000, 5000),
(2, '2016-08-04 16:54:46', 0, 2, 1000, 5000);

-- --------------------------------------------------------

--
-- Table structure for table `operatingline`
--

CREATE TABLE `operatingline` (
  `opl_code` bigint(20) NOT NULL,
  `opl_date` datetime NOT NULL,
  `ope_id` smallint(6) NOT NULL,
  `lin_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `operatingline`
--

INSERT INTO `operatingline` (`opl_code`, `opl_date`, `ope_id`, `lin_code`) VALUES
(1, '2016-08-01 12:43:51', 1, 1000);

-- --------------------------------------------------------

--
-- Table structure for table `operators`
--

CREATE TABLE `operators` (
  `ope_id` smallint(6) NOT NULL,
  `ope_name` varchar(20) NOT NULL,
  `ope_lastname` varchar(20) NOT NULL,
  `ope_mothers_lastname` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `operators`
--

INSERT INTO `operators` (`ope_id`, `ope_name`, `ope_lastname`, `ope_mothers_lastname`) VALUES
(1, 'Damariz', 'Lopez', 'Soriano');

-- --------------------------------------------------------

--
-- Table structure for table `orderline`
--

CREATE TABLE `orderline` (
  `orli_date` datetime NOT NULL,
  `ord_number` int(11) DEFAULT NULL,
  `lin_code` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `orderline`
--

INSERT INTO `orderline` (`orli_date`, `ord_number`, `lin_code`) VALUES
('2016-07-30 15:30:00', 1, 1000),
('2016-07-31 15:30:00', 2, 1000);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `ord_number` int(11) NOT NULL,
  `cli_id` varchar(13) NOT NULL,
  `ord_stardate` date NOT NULL,
  `ord_enddate` date NOT NULL,
  `ord_quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`ord_number`, `cli_id`, `ord_stardate`, `ord_enddate`, `ord_quantity`) VALUES
(1, '1', '2016-07-30', '2016-08-13', 0),
(2, '1', '2016-07-30', '2016-08-06', 0);

-- --------------------------------------------------------

--
-- Table structure for table `pieces`
--

CREATE TABLE `pieces` (
  `pie_code` bigint(20) NOT NULL,
  `pie_name` varchar(30) NOT NULL,
  `pie_size` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pieces`
--

INSERT INTO `pieces` (`pie_code`, `pie_name`, `pie_size`) VALUES
(9001, 'intel processor', 2),
(9002, 'mobo Gigabyte S320', 3);

-- --------------------------------------------------------

--
-- Stand-in structure for view `pieces_product`
--
CREATE TABLE `pieces_product` (
`prod_code` int(11)
,`prod_name` varchar(50)
,`prod_description` text
,`pie_code` bigint(20)
,`pie_name` varchar(30)
,`pie_size` smallint(6)
);

-- --------------------------------------------------------

--
-- Table structure for table `productionlines`
--

CREATE TABLE `productionlines` (
  `lin_code` int(11) NOT NULL,
  `lin_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `productionlines`
--

INSERT INTO `productionlines` (`lin_code`, `lin_name`) VALUES
(1000, 'Electronic devices');

-- --------------------------------------------------------

--
-- Table structure for table `productquestions`
--

CREATE TABLE `productquestions` (
  `prod_code` int(11) NOT NULL,
  `que_id` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `productquestions`
--

INSERT INTO `productquestions` (`prod_code`, `que_id`) VALUES
(5000, 1),
(5000, 2),
(5000, 3),
(5000, 4);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `prod_code` int(11) NOT NULL,
  `prod_name` varchar(50) NOT NULL,
  `prod_description` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`prod_code`, `prod_name`, `prod_description`) VALUES
(5000, 'Ultra basic pc composition', 'Its only the mother board and a averange processor');

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `que_id` smallint(6) NOT NULL,
  `que_number` tinyint(4) NOT NULL,
  `que_text` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`que_id`, `que_number`, `que_text`) VALUES
(1, 1, 'have it processor?'),
(2, 2, 'have it mother board?'),
(3, 3, 'Does the processor right?'),
(4, 4, 'Does the mother board right?');

-- --------------------------------------------------------

--
-- Stand-in structure for view `questions_product`
--
CREATE TABLE `questions_product` (
`prod_code` int(11)
,`prod_name` varchar(50)
,`prod_description` text
,`que_id` smallint(6)
,`que_number` tinyint(4)
,`que_text` varchar(50)
);

-- --------------------------------------------------------

--
-- Structure for view `inspection_answers`
--
DROP TABLE IF EXISTS `inspection_answers`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `inspection_answers`  AS  select `ins`.`ins_id` AS `ins_id`,`ins`.`ins_date` AS `ins_date`,`que`.`que_id` AS `que_id`,`que`.`que_number` AS `que_number`,`que`.`que_text` AS `que_text`,`ans`.`anw_id` AS `anw_id`,`ans`.`anw_value` AS `anw_value`,`itm`.`itm_serie` AS `itm_serie`,`itm`.`lot_code` AS `lot_code`,`itm`.`itm_status` AS `itm_status` from (((`inspection` `ins` join `answers` `ans` on((`ins`.`ins_id` = `ans`.`anw_id`))) join `questions` `que` on((`ans`.`que_id` = `que`.`que_id`))) join `items` `itm` on((`ans`.`itm_serie` = `itm`.`itm_serie`))) ;

-- --------------------------------------------------------

--
-- Structure for view `line_operators`
--
DROP TABLE IF EXISTS `line_operators`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `line_operators`  AS  (select `op`.`ope_id` AS `ope_id`,`op`.`ope_name` AS `ope_name`,`op`.`ope_lastname` AS `ope_lastname`,`op`.`ope_mothers_lastname` AS `ope_mothers_lastname`,`li`.`lin_code` AS `lin_code`,`li`.`lin_name` AS `lin_name` from ((`operators` `op` join `operatingline` `ol` on((`ol`.`ope_id` = `op`.`ope_id`))) join `productionlines` `li` on((`li`.`lin_code` = `ol`.`lin_code`)))) ;

-- --------------------------------------------------------

--
-- Structure for view `pieces_product`
--
DROP TABLE IF EXISTS `pieces_product`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pieces_product`  AS  (select `pr`.`prod_code` AS `prod_code`,`pr`.`prod_name` AS `prod_name`,`pr`.`prod_description` AS `prod_description`,`pi`.`pie_code` AS `pie_code`,`pi`.`pie_name` AS `pie_name`,`pi`.`pie_size` AS `pie_size` from ((`pieces` `pi` join `composition` `co` on((`pi`.`pie_code` = `co`.`pie_code`))) join `products` `pr` on((`co`.`prod_code` = `pr`.`prod_code`)))) ;

-- --------------------------------------------------------

--
-- Structure for view `questions_product`
--
DROP TABLE IF EXISTS `questions_product`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `questions_product`  AS  (select `pr`.`prod_code` AS `prod_code`,`pr`.`prod_name` AS `prod_name`,`pr`.`prod_description` AS `prod_description`,`qu`.`que_id` AS `que_id`,`qu`.`que_number` AS `que_number`,`qu`.`que_text` AS `que_text` from ((`questions` `qu` join `productquestions` `pq` on((`qu`.`que_id` = `pq`.`que_id`))) join `products` `pr` on((`pr`.`prod_code` = `pr`.`prod_code`)))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `answers`
--
ALTER TABLE `answers`
  ADD PRIMARY KEY (`anw_id`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`cli_rfc`);

--
-- Indexes for table `composition`
--
ALTER TABLE `composition`
  ADD PRIMARY KEY (`comp_id`,`prod_code`);

--
-- Indexes for table `inspection`
--
ALTER TABLE `inspection`
  ADD PRIMARY KEY (`ins_id`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`itm_serie`);

--
-- Indexes for table `lots`
--
ALTER TABLE `lots`
  ADD PRIMARY KEY (`lot_code`);

--
-- Indexes for table `operatingline`
--
ALTER TABLE `operatingline`
  ADD PRIMARY KEY (`opl_code`);

--
-- Indexes for table `operators`
--
ALTER TABLE `operators`
  ADD PRIMARY KEY (`ope_id`);

--
-- Indexes for table `orderline`
--
ALTER TABLE `orderline`
  ADD KEY `IXFK_OrderLine_Orders` (`ord_number`),
  ADD KEY `IXFK_OrderLine_ProductionLines` (`lin_code`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`ord_number`),
  ADD KEY `IXFK_Orders_Clients` (`cli_id`);

--
-- Indexes for table `pieces`
--
ALTER TABLE `pieces`
  ADD PRIMARY KEY (`pie_code`);

--
-- Indexes for table `productionlines`
--
ALTER TABLE `productionlines`
  ADD PRIMARY KEY (`lin_code`);

--
-- Indexes for table `productquestions`
--
ALTER TABLE `productquestions`
  ADD PRIMARY KEY (`prod_code`,`que_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`prod_code`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`que_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `composition`
--
ALTER TABLE `composition`
  MODIFY `comp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `lots`
--
ALTER TABLE `lots`
  MODIFY `lot_code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `ord_number` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `prod_code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5001;
--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `que_id` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
