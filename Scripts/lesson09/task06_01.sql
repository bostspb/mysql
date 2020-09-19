/**
 * 	ТЕМА: Транзакции, переменные, представления
 * 
 *	1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
 *     Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. 
 *     Используйте транзакции.
 *
 */

START TRANSACTION;

INSERT INTO sample.users (sample.users.name, sample.users.birthday_at)    
SELECT su.name, su.birthday_at 
FROM shop.users su
WHERE su.id = 1;

DELETE FROM shop.users
WHERE id = 1;

COMMIT;