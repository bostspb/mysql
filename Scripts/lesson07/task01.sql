/**
 *	1. Составьте список пользователей users, 
 *  которые осуществили хотя бы один заказ orders в интернет магазине.
 */
 
-- таблица orders пустая, наполним ее
INSERT INTO orders (user_id) VALUES (1), (2), (5);

-- решение задачи
select u.id, u.name
from users u
left join orders o on o.user_id = u.id 
where o.id is not null;
/*
id|name    |
--|--------|
 1|Геннадий|
 2|Наталья |
 5|Иван    |
*/
