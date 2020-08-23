/**
 * 3. Создайте дамп базы данных example из предыдущего задания, 
 * разверните содержимое дампа в новую базу данных sample.
 */

DROP DATABASE IF EXISTS example;
CREATE DATABASE example DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;

-- 1) Через интерфейс DBeaver делаю Dump database 'example'.
-- 2) Также через интерфейс DBeaver делаю Restore database в базу 'sample'.
-- 3) Все оказалось слишком просто - идем в консоль и пробуем это же самое сделать через mysqldump, 
-- (кстати DBeaver тоже использовал именно эту утилиту, когда делал дамп).
-- 