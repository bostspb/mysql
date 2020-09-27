/**
 * 	ТЕМА: NoSQL
 * 
 *	3. Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.
 *
 */
  

--
-- Подготовка
--

Устанавливаем MongoDB
docker pull mongo
docker run -d -p 127.0.0.1:27017:27017 --name mongo_gb mongo

Устанавливаем простой графический клиент Robo 3T
https://robomongo.org/

Или можно работать в консольном клиенте `mongo` в консоли контейнера


--
-- Решение задачи
--

Создаем БД
use shop


Добавляем товары
db.products.insertMany([
	{name: 'Intel Core i3-8100', description: 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', price: 7890.00, catalog_id: 1},
	{name: 'Intel Core i5-7400', description: 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', price: 12700.00, catalog_id: 1},
	{name: 'AMD FX-8320E', description: 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', price: 4780.00, catalog_id: 1},
	{name: 'AMD FX-8320', description: 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', price: 7120.00, catalog_id: 1},
	{name: 'ASUS ROG MAXIMUS X HERO', description: 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', price: 19310.00, catalog_id: 2},
	{name: 'Gigabyte H310M S2H', description: 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', price: 4790.00, catalog_id: 2},
	{name: 'MSI B250M GAMING PRO', description: 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', price: 5060.00, catalog_id: 2}
])


Добавляем категории
db.catalogs.insertMany([
	{_id: 1, name: 'Процессоры'},
	{_id: 2, name: 'Материнские платы'},
	{_id: 3, name: 'Видеокарты'},
	{_id: 4, name: 'Жесткие диски'},
	{_id: 5, name: 'Оперативная память'}
])



Проверяем - запрос на выдачу всех товаров категории 'Процессоры', у которой id = 1
db.products.find({ 'catalog_id': 1 })

Результат:
/* 1 */
{
    "_id" : ObjectId("5f701e8cad68112178fdbadf"),
    "name" : "Intel Core i3-8100",
    "description" : "Процессор для настольных персональных компьютеров, основанных на платформе Intel.",
    "price" : 7890.0,
    "catalog_id" : 1.0
}

/* 2 */
{
    "_id" : ObjectId("5f701e8cad68112178fdbae0"),
    "name" : "Intel Core i5-7400",
    "description" : "Процессор для настольных персональных компьютеров, основанных на платформе Intel.",
    "price" : 12700.0,
    "catalog_id" : 1.0
}

/* 3 */
{
    "_id" : ObjectId("5f701e8cad68112178fdbae1"),
    "name" : "AMD FX-8320E",
    "description" : "Процессор для настольных персональных компьютеров, основанных на платформе AMD.",
    "price" : 4780.0,
    "catalog_id" : 1.0
}

/* 4 */
{
    "_id" : ObjectId("5f701e8cad68112178fdbae2"),
    "name" : "AMD FX-8320",
    "description" : "Процессор для настольных персональных компьютеров, основанных на платформе AMD.",
    "price" : 7120.0,
    "catalog_id" : 1.0
}
