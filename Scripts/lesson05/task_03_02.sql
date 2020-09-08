/**
 * «Операторы, фильтрация, сортировка и ограничение»
 * 2. Таблица users была неудачно спроектирована. 
 * Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10. 
 * Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.
 */

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	birthday_at DATE,
	created_at VARCHAR(24),
	updated_at VARCHAR(24)
);

INSERT INTO users (name, birthday_at, created_at, updated_at) VALUES
	('Геннадий', '1990-10-05', '20.10.2017 8:11', '20.11.2017 11:10'),
	('Наталья', '1984-11-12', '15.10.2018 8:10', '22.12.2018 16:45'),
	('Александр', '1985-05-20', '17.07.2019 13:10', '13.08.2019 8:10');

UPDATE users SET 
	created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'),
	updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i');

ALTER TABLE users CHANGE created_at created_at DATETIME;
ALTER TABLE users CHANGE updated_at updated_at DATETIME;

DESCRIBE users;
/*
Field      |Type               |Null|Key|Default|Extra         |
-----------|-------------------|----|---|-------|--------------|
id         |bigint(20) unsigned|NO  |PRI|       |auto_increment|
name       |varchar(255)       |YES |   |       |              |
birthday_at|date               |YES |   |       |              |
created_at |datetime           |YES |   |       |              |
updated_at |datetime           |YES |   |       |              |
*/

SELECT * FROM users;
/*
id|name     |birthday_at|created_at           |updated_at           |
--|---------|-----------|---------------------|---------------------|
 1|Геннадий | 1990-10-05|2017-10-20 08:11:00.0|2017-11-20 11:10:00.0|
 2|Наталья  | 1984-11-12|2018-10-15 08:10:00.0|2018-12-22 16:45:00.0|
 3|Александр| 1985-05-20|2019-07-17 13:10:00.0|2019-08-13 08:10:00.0|
*/	
