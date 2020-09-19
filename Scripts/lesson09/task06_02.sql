/**
 * 	ТЕМА: Транзакции, переменные, представления
 * 
 *	2. Создайте представление, которое выводит название name товарной позиции из таблицы products и 
 *     соответствующее название каталога name из таблицы catalogs.
 *
 */


CREATE VIEW products_view (id, product_name, catalog_name) AS 
	SELECT p.id, p.name product_name, c.name `catalog`
	FROM products p
	LEFT JOIN catalogs c on c.id = p.catalog_id;


SELECT * FROM products_view;
/**
id|product_name           |catalog_name     |
--|-----------------------|-----------------|
 1|Intel Core i3-8100     |Процессоры       |
 2|Intel Core i5-7400     |Процессоры       |
 3|AMD FX-8320E           |Процессоры       |
 4|AMD FX-8320            |Процессоры       |
 5|ASUS ROG MAXIMUS X HERO|Материнские платы|
 6|Gigabyte H310M S2H     |Материнские платы|
 7|MSI B250M GAMING PRO   |Материнские платы|
 */
