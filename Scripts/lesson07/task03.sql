/**
 *	3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
 *  Поля from, to и label содержат английские названия городов, поле name — русское.
 *  Выведите список рейсов flights с русскими названиями городов.
 */
 
DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  `from` VARCHAR(64),
  `to` VARCHAR(64)
);

INSERT INTO flights (`from`, `to`) VALUES
  ('moscow', 'omsk'),
  ('novgorog', 'kazan'),
  ('irkutsk', 'moscow'),
  ('omsk', 'irkutsk'),
  ('moscow', 'kazan'); 
 
 
 
DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  label VARCHAR(64),
  name VARCHAR(64)
);

INSERT INTO cities (label, name) VALUES
  ('moscow', 'Москва'),
  ('novgorog', 'Новгород'),
  ('irkutsk', 'Иркутск'),
  ('omsk', 'Омск'),
  ('kazan', 'Казань'); 
 
 
 select id, 
 	(select c1.name from cities c1 where c1.label = f.`from`) `from`,
 	(select c2.name from cities c2 where c2.label = f.`to`) `to`
 from flights f;
 /*
id|from    |to     |
--|--------|-------|
 1|Москва  |Омск   |
 2|Новгород|Казань |
 3|Иркутск |Москва |
 4|Омск    |Иркутск|
 5|Москва  |Казань |
  */
 