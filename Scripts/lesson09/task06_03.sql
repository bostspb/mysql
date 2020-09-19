/**
 * 	ТЕМА: Транзакции, переменные, представления
 * 
 *	3. (по желанию) Пусть имеется таблица с календарным полем created_at. 
 *     В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17.  
 *     Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, 
 *     если дата присутствует в исходном таблице и 0, если она отсутствует.
 *
 */


DROP TABLE IF EXISTS dummy_table;
CREATE TABLE dummy_table (
  id SERIAL PRIMARY KEY,
  created_at DATE
);

INSERT INTO dummy_table (created_at) VALUES
  ('2018-08-01'),
  ('2018-08-04'),
  ('2018-08-16'),
  ('2018-08-17');
       
       
SELECT 
	DATE_ADD('2018-08-01', INTERVAL g.n DAY) month_date, 
	CASE
		WHEN dt.created_at IS  NULL THEN 0
		WHEN dt.created_at IS NOT NULL THEN 1
	END 'date_included'
FROM (SELECT 0 n  UNION ALL
	SELECT 1    UNION ALL SELECT 2  UNION ALL SELECT 3  UNION ALL SELECT 4  UNION ALL SELECT 5  UNION ALL
	SELECT 6    UNION ALL SELECT 7  UNION ALL SELECT 8  UNION ALL SELECT 9  UNION ALL SELECT 10 UNION ALL 
	SELECT 11   UNION ALL SELECT 12 UNION ALL SELECT 13 UNION ALL SELECT 14 UNION ALL SELECT 15 UNION ALL
	SELECT 16   UNION ALL SELECT 17 UNION ALL SELECT 18 UNION ALL SELECT 19 UNION ALL SELECT 20 UNION ALL
	SELECT 21   UNION ALL SELECT 22 UNION ALL SELECT 23 UNION ALL SELECT 24 UNION ALL SELECT 25 UNION ALL
	SELECT 26   UNION ALL SELECT 27 UNION ALL SELECT 28 UNION ALL SELECT 29 UNION ALL SELECT 30) g
LEFT JOIN dummy_table dt ON dt.created_at = DATE_ADD('2018-08-01', INTERVAL g.n DAY)
WHERE DATE_ADD('2018-08-01', INTERVAL g.n DAY) < DATE_ADD('2020-08-01', INTERVAL 1 MONTH)
ORDER BY month_date;
/*
month_date|date_included|
----------|-------------|
2018-08-01|            1|
2018-08-02|            0|
2018-08-03|            0|
2018-08-04|            1|
2018-08-05|            0|
2018-08-06|            0|
2018-08-07|            0|
2018-08-08|            0|
2018-08-09|            0|
2018-08-10|            0|
2018-08-11|            0|
2018-08-12|            0|
2018-08-13|            0|
2018-08-14|            0|
2018-08-15|            0|
2018-08-16|            1|
2018-08-17|            1|
2018-08-18|            0|
2018-08-19|            0|
2018-08-20|            0|
2018-08-21|            0|
2018-08-22|            0|
2018-08-23|            0|
2018-08-24|            0|
2018-08-25|            0|
2018-08-26|            0|
2018-08-27|            0|
2018-08-28|            0|
2018-08-29|            0|
2018-08-30|            0|
2018-08-31|            0|
*/

