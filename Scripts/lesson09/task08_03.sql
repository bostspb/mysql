/**
 * 	ТЕМА: Хранимые процедуры и функции, триггеры
 * 
 *	3. (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
 *     Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. 
 *     Вызов функции FIBONACCI(10) должен возвращать число 55.
 *
 */

DELIMITER //
DROP FUNCTION  IF EXISTS fibonacci_recursive//
CREATE FUNCTION fibonacci_recursive (value INT)
RETURNS INT DETERMINISTIC
BEGIN 	
	IF(value < 3) THEN
    	RETURN 1;
  	ELSE
   		RETURN (SELECT fibonacci_recursive(value - 1)) + (SELECT fibonacci_recursive(value - 2));
  	END IF;
END//

SELECT fibonacci_recursive(10)//
-- SQL Error [1424] [HY000]: Recursive stored functions and triggers are not allowed.
-- SQL он такой SQL :)
-- интересно - в других СУБД рекурсии поддерживаются?


DELIMITER //
DROP FUNCTION  IF EXISTS fibonacci//
CREATE FUNCTION fibonacci (value INT)
RETURNS INT DETERMINISTIC
BEGIN 
	DECLARE i INT DEFAULT 0;
  	DECLARE f INT DEFAULT 0;
  	DECLARE f1 INT DEFAULT 0;
  	DECLARE f2 INT DEFAULT 1;
  	cycle: LOOP
		SET f = f1 + f2;
		SET f2 = f1;	
		SET f1 = f;
		SET i = i + 1;
		IF i = value THEN LEAVE cycle;
		END IF;    	
  	END LOOP cycle;	
	RETURN f;
END//

SELECT fibonacci(10)//
/*
fibonacci(10)|
-------------|
           55|
*/






