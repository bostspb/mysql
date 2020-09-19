/**
 * 	ТЕМА: Администрирование MySQL
 * 
 *	2. (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password, 
 *     содержащие первичный ключ, имя пользователя и его пароль. 
 * 
 *     Создайте представление username таблицы accounts, предоставляющий доступ к столбца id и name.
 *  
 *     Создайте пользователя user_read, который бы не имел доступа к таблице accounts, однако, 
 *     мог бы извлекать записи из представления username.
 *
 */

DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  `password` VARCHAR(255)
);

INSERT INTO accounts (name, password) VALUES
  ('Геннадий', '9cb6d063fb98b570f203f42d939a4ac6'),
  ('Наталья', 'e25b95bfaea95978dc5321d8582eae7b'),
  ('Александр', '5820d8df0f966b37e0716509821b9a77'),
  ('Сергей', '01217a39221665c6e8f006c2ccb18191'),
  ('Иван', 'c365700914278365dddc437db98b907a'),
  ('Мария', '3ad95df172783de57a235ea90f525474');
  
CREATE VIEW username (id, name) AS 
	SELECT id, name
	FROM accounts;

GRANT SELECT ON shop.username TO 'user_read'@'172.20.0.1' IDENTIFIED  BY '778899';

-- проверил запросы на Phyton - все работает согласно заданию