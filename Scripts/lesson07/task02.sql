/**
 *	2. Выведите список товаров products и разделов catalogs, 
 *  который соответствует товару.
 */
 
select p.id, p.name product_name, c.name `catalog`
from products p
left join catalogs c on c.id = p.catalog_id;
/*
id|product_name           |catalog          |
--|-----------------------|-----------------|
 1|Intel Core i3-8100     |Процессоры       |
 2|Intel Core i5-7400     |Процессоры       |
 3|AMD FX-8320E           |Процессоры       |
 4|AMD FX-8320            |Процессоры       |
 5|ASUS ROG MAXIMUS X HERO|Материнские платы|
 6|Gigabyte H310M S2H     |Материнские платы|
 7|MSI B250M GAMING PRO   |Материнские платы|
 */

