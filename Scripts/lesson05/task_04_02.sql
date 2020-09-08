/**
 * «Агрегация данных»
 * 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
 * Следует учесть, что необходимы дни недели текущего года, а не года рождения.
 */

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Александр', '1985-05-26'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-11'),
  ('Мария', '1992-08-29');
  
SELECT DAYNAME(
			DATE(
				CONCAT(YEAR(NOW()), '-', MONTH(birthday_at), '-', DAY(birthday_at))
			)
		)`date`
FROM users;
/*
date     |
---------|
Monday   |
Thursday |
Wednesday|
Tuesday  |
Friday   |
Saturday |
Saturday |
 */

SELECT 	DAYNAME(
				DATE(
					CONCAT(YEAR(NOW()), '-', MONTH(birthday_at), '-', DAY(birthday_at))
				)
			) `date`, 
		COUNT(*) cnt
FROM users
GROUP BY `date`;
/*
date     |cnt|
---------|---|
Friday   |  1|
Monday   |  1|
Saturday |  2|
Thursday |  1|
Tuesday  |  1|
Wednesday|  1|
*/





