INSERT INTO `addon_account` (name, label, shared) VALUES 
	('society_hitman','Hitman',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
	('society_hitman','Hitman',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
	('society_hitman', 'Hitman', 1)
;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('hitman', 'Hitman', 1);

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('hitman', 0, 'assassin', 'Assassin', 1500, '{}', '{}'),
('hitman', 1, 'soldier', 'Soldier', 1800, '{}', '{}'),
('hitman', 2, 'coleader', 'Co-Leader', 2100, '{}', '{}'),
('hitman', 3, 'boss', 'Boss', 2700, '{}', '{}');
CREATE TABLE `fine_types_hitman` (
  
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  
  PRIMARY KEY (`id`)
);

INSERT INTO `fine_types_hitman` (label, amount, category) VALUES 
	('Assasination Invoice',100000,3)
;

