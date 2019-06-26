CREATE TABLE IF NOT EXISTS `darkspider_log` (
  `transaction_time` datetime DEFAULT NULL,
  `customer` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `profit` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
