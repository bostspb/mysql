/**
 * 	ТЕМА: Хранимые процедуры и функции, триггеры
 * 
 *	1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, 
 *     в зависимости от текущего времени суток. 
 *     С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
 *     с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
 *     с 18:00 до 00:00 — "Добрый вечер", 
 *     с 00:00 до 6:00 — "Доброй ночи".
 *
 */

DELIMITER //

DROP FUNCTION  IF EXISTS hello//
CREATE FUNCTION hello ()
RETURNS TEXT DETERMINISTIC
BEGIN
 	DECLARE hello_date DATETIME DEFAULT NOW();
	IF(HOUR(hello_date) >=  6 AND HOUR(hello_date) < 12) THEN
    	RETURN 'Доброе утро';
  	ELSEIF (HOUR(hello_date) >=  12 AND HOUR(hello_date) < 18) THEN
    	RETURN 'Добрый день';
  	ELSEIF (HOUR(hello_date) >=  18 AND HOUR(hello_date) < 24) THEN
    	RETURN 'Добрый вечер';
  	ELSEIF (HOUR(hello_date) >=  0 AND HOUR(hello_date) < 6) THEN
    	RETURN 'Доброй ночи';
  	ELSE
   		RETURN 'Ошибка';
  	END IF;
END//


DELIMITER ;

SELECT NOW();
/*
NOW()                |
---------------------|
2020-09-19 17:59:36.0|
 */

SELECT hello();
/*
hello()    |
-----------|
Добрый день|
*/

