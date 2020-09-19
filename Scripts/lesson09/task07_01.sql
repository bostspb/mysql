/**
 * 	ТЕМА: Администрирование MySQL
 * 
 *	1. Создайте двух пользователей которые имеют доступ к базе данных shop. 
 *     Первому пользователю shop_read должны быть доступны только запросы на чтение данных,  
 *     второму пользователю shop — любые операции в пределах базы данных shop.
 *
 */


GRANT SELECT ON shop.* TO 'shop_read'@'172.20.0.1' IDENTIFIED  BY '112233';
GRANT ALL ON shop.* TO 'shop'@'172.20.0.1' IDENTIFIED BY '445566';

-- проверил запросы на Phyton - все работает согласно заданию

-- DROP USER 'shop_read'@'172.20.0.1';
-- DROP USER 'shop'@'172.20.0.1';