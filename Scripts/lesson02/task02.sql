/**
 * 2. Создайте базу данных example, разместите в ней таблицу users, 
 * состо¤щую из двух столбцов, числового id и строкового name.
 */

DROP DATABASE IF EXISTS example;
CREATE DATABASE example DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;

DROP TABLE IF EXISTS example.users;
CREATE TABLE IF NOT EXISTS example.users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя'
) ENGINE=INNODB COMMENT = 'Пользователи';

INSERT INTO example.users(name)
VALUES 
	('Иван'),
	('Петр'),
	('Ольга'),
	('Павел'),
	('Игнат'),
	('Светлана');
