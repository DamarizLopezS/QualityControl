-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 04-08-2016 a las 07:16:20
-- Versión del servidor: 10.1.13-MariaDB
-- Versión de PHP: 7.0.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `quality_control`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `answers`
--

CREATE TABLE `answers` (
  `anw_id` int(11) NOT NULL,
  `anw_value` char(1) DEFAULT NULL,
  `itm_serie` int(11) NOT NULL,
  `que_id` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clients`
--

CREATE TABLE `clients` (
  `cli_id` int(11) NOT NULL,
  `cli_name` varchar(18) NOT NULL,
  `cli_lastName` varchar(15) NOT NULL,
  `cli_rfc` varchar(13) NOT NULL,
  `cli_phone` varchar(10) NOT NULL,
  `cli_email` varchar(50) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `clients`
--

INSERT INTO `clients` (`cli_id`, `cli_name`, `cli_lastName`, `cli_rfc`, `cli_phone`, `cli_email`) VALUES
(1, 'Christian', 'Camacho', '1234567890123', '1234567890', 'xentyo@hotmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `composition`
--

CREATE TABLE `composition` (
  `comp_id` int(11) NOT NULL,
  `pie_code` bigint(20) DEFAULT NULL,
  `prod_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `composition`
--

INSERT INTO `composition` (`comp_id`, `pie_code`, `prod_code`) VALUES
(1, 9001, 5000),
(2, 9002, 5000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `items`
--

CREATE TABLE `items` (
  `itm_serie` int(11) NOT NULL,
  `lot_code` int(11) NOT NULL,
  `itm_status` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `items`
--

INSERT INTO `items` (`itm_serie`, `lot_code`, `itm_status`) VALUES
(150021, 1, 0),
(150022, 1, 0),
(150023, 1, 0),
(150024, 1, 0),
(150025, 1, 0);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `line_operators`
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
-- Estructura de tabla para la tabla `lots`
--

CREATE TABLE `lots` (
  `lot_code` int(11) NOT NULL,
  `lot_date` datetime DEFAULT NULL,
  `lot_quantity` int(11) NOT NULL,
  `lin_code` int(11) NOT NULL,
  `prod_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `lots`
--

INSERT INTO `lots` (`lot_code`, `lot_date`, `lot_quantity`, `lin_code`, `prod_code`) VALUES
(1, '2016-08-11 17:37:44', 5, 1000, 5000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `operatingline`
--

CREATE TABLE `operatingline` (
  `opl_code` bigint(20) NOT NULL,
  `opl_date` datetime NOT NULL,
  `ope_id` smallint(6) NOT NULL,
  `lin_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `operatingline`
--

INSERT INTO `operatingline` (`opl_code`, `opl_date`, `ope_id`, `lin_code`) VALUES
(1, '2016-08-01 12:43:51', 1, 1000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `operators`
--

CREATE TABLE `operators` (
  `ope_id` smallint(6) NOT NULL,
  `ope_name` varchar(20) NOT NULL,
  `ope_lastname` varchar(20) NOT NULL,
  `ope_mothers_lastname` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `operators`
--

INSERT INTO `operators` (`ope_id`, `ope_name`, `ope_lastname`, `ope_mothers_lastname`) VALUES
(1, 'Damariz', 'Lopez', 'Soriano');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orderline`
--

CREATE TABLE `orderline` (
  `orli_date` datetime NOT NULL,
  `ord_number` int(11) DEFAULT NULL,
  `lin_code` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `orderline`
--

INSERT INTO `orderline` (`orli_date`, `ord_number`, `lin_code`) VALUES
('2016-07-30 15:30:00', 1, 1000),
('2016-07-31 15:30:00', 2, 1000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orders`
--

CREATE TABLE `orders` (
  `ord_number` int(11) NOT NULL,
  `cli_id` int(11) DEFAULT NULL,
  `ord_stardate` date NOT NULL,
  `ord_enddate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `orders`
--

INSERT INTO `orders` (`ord_number`, `cli_id`, `ord_stardate`, `ord_enddate`) VALUES
(1, 1, '2016-07-30', '2016-08-13'),
(2, 1, '2016-07-30', '2016-08-06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pieces`
--

CREATE TABLE `pieces` (
  `pie_code` bigint(20) NOT NULL,
  `pie_name` varchar(30) NOT NULL,
  `pie_size` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `pieces`
--

INSERT INTO `pieces` (`pie_code`, `pie_name`, `pie_size`) VALUES
(9001, 'intel processor', 2),
(9002, 'mobo Gigabyte S320', 3);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `pieces_product`
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
-- Estructura de tabla para la tabla `productionlines`
--

CREATE TABLE `productionlines` (
  `lin_code` int(11) NOT NULL,
  `lin_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `productionlines`
--

INSERT INTO `productionlines` (`lin_code`, `lin_name`) VALUES
(1000, 'Electronic devices');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productquestions`
--

CREATE TABLE `productquestions` (
  `prod_code` int(11) NOT NULL,
  `que_id` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `productquestions`
--

INSERT INTO `productquestions` (`prod_code`, `que_id`) VALUES
(5000, 1),
(5000, 2),
(5000, 3),
(5000, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `products`
--

CREATE TABLE `products` (
  `prod_code` int(11) NOT NULL,
  `prod_name` varchar(50) NOT NULL,
  `prod_description` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `products`
--

INSERT INTO `products` (`prod_code`, `prod_name`, `prod_description`) VALUES
(5000, 'Ultra basic pc composition', 'Its only the mother board and a averange processor');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `questions`
--

CREATE TABLE `questions` (
  `que_id` smallint(6) NOT NULL,
  `que_number` tinyint(4) NOT NULL,
  `que_text` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `questions`
--

INSERT INTO `questions` (`que_id`, `que_number`, `que_text`) VALUES
(1, 1, 'have it processor?'),
(2, 2, 'have it mother board?'),
(3, 3, 'Does the processor right?'),
(4, 4, 'Does the mother board right?');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `questions_product`
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
-- Estructura para la vista `line_operators`
--
DROP TABLE IF EXISTS `line_operators`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `line_operators`  AS  (select `op`.`ope_id` AS `ope_id`,`op`.`ope_name` AS `ope_name`,`op`.`ope_lastname` AS `ope_lastname`,`op`.`ope_mothers_lastname` AS `ope_mothers_lastname`,`li`.`lin_code` AS `lin_code`,`li`.`lin_name` AS `lin_name` from ((`operators` `op` join `operatingline` `ol` on((`ol`.`ope_id` = `op`.`ope_id`))) join `productionlines` `li` on((`li`.`lin_code` = `ol`.`lin_code`)))) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `pieces_product`
--
DROP TABLE IF EXISTS `pieces_product`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pieces_product`  AS  (select `pr`.`prod_code` AS `prod_code`,`pr`.`prod_name` AS `prod_name`,`pr`.`prod_description` AS `prod_description`,`pi`.`pie_code` AS `pie_code`,`pi`.`pie_name` AS `pie_name`,`pi`.`pie_size` AS `pie_size` from ((`pieces` `pi` join `composition` `co` on((`pi`.`pie_code` = `co`.`pie_code`))) join `products` `pr` on((`co`.`prod_code` = `pr`.`prod_code`)))) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `questions_product`
--
DROP TABLE IF EXISTS `questions_product`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `questions_product`  AS  (select `pr`.`prod_code` AS `prod_code`,`pr`.`prod_name` AS `prod_name`,`pr`.`prod_description` AS `prod_description`,`qu`.`que_id` AS `que_id`,`qu`.`que_number` AS `que_number`,`qu`.`que_text` AS `que_text` from ((`questions` `qu` join `productquestions` `pq` on((`qu`.`que_id` = `pq`.`que_id`))) join `products` `pr` on((`pr`.`prod_code` = `pr`.`prod_code`)))) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `answers`
--
ALTER TABLE `answers`
  ADD PRIMARY KEY (`anw_id`);

--
-- Indices de la tabla `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`cli_id`);

--
-- Indices de la tabla `composition`
--
ALTER TABLE `composition`
  ADD PRIMARY KEY (`comp_id`,`prod_code`);

--
-- Indices de la tabla `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`itm_serie`);

--
-- Indices de la tabla `lots`
--
ALTER TABLE `lots`
  ADD PRIMARY KEY (`lot_code`);

--
-- Indices de la tabla `operatingline`
--
ALTER TABLE `operatingline`
  ADD PRIMARY KEY (`opl_code`);

--
-- Indices de la tabla `operators`
--
ALTER TABLE `operators`
  ADD PRIMARY KEY (`ope_id`);

--
-- Indices de la tabla `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`ord_number`);

--
-- Indices de la tabla `pieces`
--
ALTER TABLE `pieces`
  ADD PRIMARY KEY (`pie_code`);

--
-- Indices de la tabla `productionlines`
--
ALTER TABLE `productionlines`
  ADD PRIMARY KEY (`lin_code`);

--
-- Indices de la tabla `productquestions`
--
ALTER TABLE `productquestions`
  ADD PRIMARY KEY (`prod_code`,`que_id`);

--
-- Indices de la tabla `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`prod_code`);

--
-- Indices de la tabla `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`que_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clients`
--
ALTER TABLE `clients`
  MODIFY `cli_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `composition`
--
ALTER TABLE `composition`
  MODIFY `comp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `lots`
--
ALTER TABLE `lots`
  MODIFY `lot_code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `orders`
--
ALTER TABLE `orders`
  MODIFY `ord_number` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `products`
--
ALTER TABLE `products`
  MODIFY `prod_code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5001;
--
-- AUTO_INCREMENT de la tabla `questions`
--
ALTER TABLE `questions`
  MODIFY `que_id` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
