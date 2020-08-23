/** 
 * 4. (по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump. 
 * Создайте дамп единственной таблицы help_keyword базы данных mysql. 
 * Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.
 */

-- 1) Заходим в консоль. Нужно убедиться, что есть база mysql и таблица help_keyword в ней, 
-- а также достаточное количество строк для выполнения задания:
-- mysql -h 127.0.0.1 -P 3308 -u root -proot
-- show databases;
-- use  mysql;
-- show tables;
-- select count(*) from help_keyword;
-- Все, убедились, что в таблице 908 строк. Выходим:
-- exit;

-- 2) Делаем дамп:
-- mysqldump -uroot -h127.0.0.1 -P3308 -proot --where="true limit 100" mysql help_keyword > "e:\work\mysql\Scripts\lesson02\task04-help_keyword.sql"