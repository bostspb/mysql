/**
 * 	ТЕМА: Транзакции, переменные, представления
 * 
 *	4. (по желанию) Пусть имеется любая таблица с календарным полем created_at. 
 *     Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.
 *
 */


DROP TABLE IF EXISTS dummy_table;
CREATE TABLE dummy_table (
  id SERIAL PRIMARY KEY,
  created_at DATE
);

INSERT INTO dummy_table (created_at) VALUES
  ('2019-07-01'), -- !
  ('2016-08-04'),
  ('2017-08-16'),
  ('2018-06-27'), -- !
  ('2016-04-04'),
  ('2013-08-16'),
  ('2018-03-18'), -- !
  ('2016-08-04'),
  ('2019-06-16'), -- !
  ('2020-05-17'); -- !
  
  
DELETE FROM dummy_table
WHERE id NOT IN ( 
	SELECT most_recent_entries_5.* FROM (
		SELECT id
		FROM dummy_table
		ORDER BY created_at DESC
		LIMIT 5
	) most_recent_entries_5
); 

SELECT * FROM dummy_table;
/*
id|created_at|
--|----------|
 1|2019-07-01|
 4|2018-06-27|
 7|2018-03-18|
 9|2019-06-16|
10|2020-05-17|
*/
