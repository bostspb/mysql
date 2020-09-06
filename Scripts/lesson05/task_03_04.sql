/**
 * «Операторы, фильтрация, сортировка и ограничение»
 * 4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
 * Месяцы заданы в виде списка английских названий (may, august)
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
  
SELECT *  
FROM users
WHERE DATE_FORMAT(birthday_at, '%M') IN ('May', 'August');
/*
id|name     |birthday_at|created_at           |updated_at           |
--|---------|-----------|---------------------|---------------------|
 3|Александр| 1985-05-20|2020-09-06 19:28:24.0|2020-09-06 19:28:24.0|
 6|Мария    | 1992-08-29|2020-09-06 19:28:24.0|2020-09-06 19:28:24.0|
*/
