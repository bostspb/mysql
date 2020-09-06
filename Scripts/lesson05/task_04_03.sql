/**
 * «Агрегация данных»
 * 3. (по желанию) Подсчитайте произведение чисел в столбце таблицы.
 */

-- Погуглил, сам бы никогда не додумался.
-- Очень интересно где это может понадобиться...

DROP TABLE IF EXISTS tmp;
CREATE TABLE tmp ( 
	digit int
);

INSERT INTO tmp (digit) VALUES
  (2),
  (2),
  (3),
  (5);
 
select round(exp(sum(ln(digit)))) multiplication from tmp;
/*
multiplication|
--------------|
          60.0|
 */

