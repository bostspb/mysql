/**
 * 2. �������� ���� ������ example, ���������� � ��� ������� users, 
 * ��������� �� ���� ��������, ��������� id � ���������� name.
 */

DROP DATABASE IF EXISTS example;
CREATE DATABASE example DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;

DROP TABLE IF EXISTS example.users;
CREATE TABLE IF NOT EXISTS example.users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT '���'
) ENGINE=INNODB COMMENT = '������������';

INSERT INTO example.users(name)
VALUES 
	('����'),
	('����'),
	('�����'),
	('�����'),
	('�����'),
	('��������');
