/**
 * 	ТЕМА: Хранимые процедуры и функции, триггеры
 * 
 *	2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
 *     Допустимо присутствие обоих полей или одно из них. 
 *     Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
 *     Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
 *     При попытке присвоить полям NULL-значение необходимо отменить операцию.
 *
 */

DELIMITER //
CREATE TRIGGER products_defender BEFORE INSERT ON products
FOR EACH ROW BEGIN  
  IF NEW.name IS NULL AND NEW.description IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled';
  END IF;
END//


DELIMITER ;
INSERT INTO products (name, description, price, catalog_id)
VALUES (NULL, NULL, 7897, 10);
 /*
Error occurred during SQL query execution
Причина:
SQL Error [1644] [45000]: INSERT canceled
 */
 