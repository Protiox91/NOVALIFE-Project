INSERT INTO `addon_account` (name, label, shared) VALUES 
	('society_gouvernor','Gouvernement',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
	('society_gouvernor','Gouvernement',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
	('society_gouvernor', 'Gouvernement', 1)
;

INSERT INTO `jobs` (name, label) VALUES 
	('gouvernor','Gouvernement')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('gouvernor',0,'security_gouvernor','Garde du Corps',350,'{}','{}'),
	('gouvernor',1,'ministre','Pr�fet',450,'{}','{}'),
	('gouvernor',2,'boss','Vice-Président',550,'{}','{}'),
	('gouvernor',3,'boss','Gouverneur',550,'{}','{}')
;
