/** 
 * 4. (�� �������) ������������ ����� �������� � ������������� ������� mysqldump. 
 * �������� ���� ������������ ������� help_keyword ���� ������ mysql. 
 * ������ ��������� ����, ����� ���� �������� ������ ������ 100 ����� �������.
 */

-- 1) ������� � �������. ����� ���������, ��� ���� ���� mysql � ������� help_keyword � ���, 
-- � ����� ����������� ���������� ����� ��� ���������� �������:
-- mysql -h 127.0.0.1 -P 3308 -u root -proot
-- show databases;
-- use  mysql;
-- show tables;
-- select count(*) from help_keyword;
-- ���, ���������, ��� � ������� 908 �����. �������:
-- exit;

-- 2) ������ ����:
-- mysqldump -uroot -h127.0.0.1 -P3308 -proot --where="true limit 100" mysql help_keyword > "e:\work\mysql\Scripts\lesson02\task04-help_keyword.sql"