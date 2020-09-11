/**
 *	2. Выведите список товаров products и разделов catalogs, 
 *  который соответствует товару.
 */
 
select p.id, p.name, c.name 
from products p
left join catalogs c on c.id = p.catalog_id;


