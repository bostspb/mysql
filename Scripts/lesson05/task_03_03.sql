/**
 * «Операторы, фильтрация, сортировка и ограничение»
 * 3. В таблице складских запасов storehouses_products в поле value могут встречаться 
 * самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. 
 * Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
 * Однако нулевые запасы должны выводиться в конце, после всех записей.
 */

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO storehouses_products (storehouse_id, product_id, value) VALUES
(11, 357, 2500),
(11, 654, 20),
(11, 955, 150),
(11, 984, 0),
(11, 987, 5),
(11, 879, 0);

SELECT *
FROM storehouses_products 
ORDER BY IF(value > 0, 0, 1), value;
/*
id|storehouse_id|product_id|value|created_at           |updated_at           |
--|-------------|----------|-----|---------------------|---------------------|
 5|           11|       987|    5|2020-09-06 19:20:57.0|2020-09-06 19:20:57.0|
 2|           11|       654|   20|2020-09-06 19:20:57.0|2020-09-06 19:20:57.0|
 3|           11|       955|  150|2020-09-06 19:20:57.0|2020-09-06 19:20:57.0|
 1|           11|       357| 2500|2020-09-06 19:20:57.0|2020-09-06 19:20:57.0|
 4|           11|       984|    0|2020-09-06 19:20:57.0|2020-09-06 19:20:57.0|
 6|           11|       879|    0|2020-09-06 19:20:57.0|2020-09-06 19:20:57.0|
 */

