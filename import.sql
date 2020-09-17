
INSERT INTO `items` (`name`, `label`, `weight`) VALUES 
('methkey', 'Key A', 1),
('cokekey', 'Key B', 1),
('methbag', 'Methbag (2G)', 100),
('cokebag', 'Cokebag (2G)', 100);

CREATE TABLE `storages` (
	`identifier` varchar(255) DEFAULT NULL,
	`methstorage` varchar(255) DEFAULT NULL,
	`cokestorage` varchar(255) DEFAULT NULL,

	PRIMARY KEY (`identifier`)
);
