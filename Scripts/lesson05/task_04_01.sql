/**
 * «Агрегация данных»
 * 1. Подсчитайте средний возраст пользователей в таблице users.
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
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');
 
SELECT TIMESTAMPDIFF(YEAR, birthday_at, NOW()) age FROM users;
/*
age|
---|
 29|
 35|
 35|
 32|
 22|
 28|
 */

SELECT ROUND(
			AVG(
				TIMESTAMPDIFF(YEAR, birthday_at, NOW())
			)
		) average_age 
FROM users;
/*
average_age|
-----------|
         30|
*/