INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_gouvernor','State',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_gouvernor','State',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_gouvernor','State', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('gouvernor','State')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('gouvernor',0,'bogyguard','Agent',900,'{}','{}'),
  	('gouvernor',1,'secretary','Secretary',800,'{}','{}'),
	('gouvernor',2,'minister','Minister',1000,'{}','{}'),
	('gouvernor',3,'boss','President',1400,'{}','{}')
;

CREATE TABLE IF NOT EXISTS `central_account` (
`id` int(11) NOT NULL,
  `job` varchar(100) NOT NULL,
  `responsable` varchar(100) NOT NULL,
  `montant` varchar(100) NOT NULL,
  `status` varchar(10) NOT NULL DEFAULT '0',
  `status2` varchar(100) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;


CREATE TABLE IF NOT EXISTS `gouv_taxe` (
`id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `montant` varchar(100) NOT NULL,
  `job` varchar(100) NOT NULL DEFAULT '2'
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

INSERT INTO `gouv_taxe` (`id`, `name`, `montant`, `job`) VALUES
(13, 'TVA', '20', '1'),
(14, 'Salaires', '15', '2');
