/**
 *	1. Выполнить CRUD операции, аналогичные сделанным на уроке, 
 * но с типами данных array и json (и/или другими интересными для вас 
 * типами данных: uuid, сетевые адреса, xml, геоданные)
 * 
 * Оф. документация на русском языке для PostgreSQL 12
 * Типы данных  - глава 8, стр 125 
 * https://postgrespro.ru/media/docs/postgresql/12/ru/postgres-A4.pdf
 * 
 * Оф. документация на русском языке для PostgreSQL других версий
 * https://postgrespro.ru/docs/postgresql
 */

-- С JSON поработать уже успел на текущей работе, а вот с массивами еще нет, хотя тоже используются.

create table offers(
    id serial primary key,
    title varchar(128),
    bank varchar(30),
    tags varchar(32)[]
);


insert into offers(title, bank, tags) values
('Кредит "Кооперативный"', 'ОТП Банк', '{"Молодой семье", "Без справок и поручителей", "Без справки о доходах", "По двум документам", "Большой"}'),
('Кредит "Выгодный 2020"', 'СОВКОМБАНК', '{"Без справок и поручителей", "По двум документам", "Большой", "200 000"}'),
('Кредит "Для всей семьи"', 'УБРиР', '{"Для бюджетников", "Без справок и поручителей", "400 000", "По двум документам", "Быстрый"}');
select * from offers;
/*
 id|title                  |bank      |tags                                                                                      |
--|-----------------------|----------|------------------------------------------------------------------------------------------|
 1|Кредит "Кооперативный" |ОТП Банк  |{Молодой семье,Без справок и поручителей,Без справки о доходах,По двум документам,Большой}|
 2|Кредит "Выгодный 2020" |СОВКОМБАНК|{Без справок и поручителей,По двум документам,Большой,200 000}                            |
 3|Кредит "Для всей семьи"|УБРиР     |{Для бюджетников,Без справок и поручителей,400 000,По двум документам,Быстрый}            |
 */


select tags[2:4] from offers where id=3;
/*
 tags                                                  |
------------------------------------------------------|
{Без справок и поручителей,400 000,По двум документам}|
 */


update offers set tags='{}' where id=1;
select * from offers;
/*
 id|title                  |bank      |tags                                                                          |
--|-----------------------|----------|------------------------------------------------------------------------------|
 2|Кредит "Выгодный 2020" |СОВКОМБАНК|{Без справок и поручителей,По двум документам,Большой,200 000}                |
 3|Кредит "Для всей семьи"|УБРиР     |{Для бюджетников,Без справок и поручителей,400 000,По двум документам,Быстрый}|
 1|Кредит "Кооперативный" |ОТП Банк  |{}                                                                            |
 */


update offers set tags[3]='7 лет' where id=2;
select * from offers;
/*
id|title                  |bank      |tags                                                                          |
--|-----------------------|----------|------------------------------------------------------------------------------|
 3|Кредит "Для всей семьи"|УБРиР     |{Для бюджетников,Без справок и поручителей,400 000,По двум документам,Быстрый}|
 1|Кредит "Кооперативный" |ОТП Банк  |{}                                                                            |
 2|Кредит "Выгодный 2020" |СОВКОМБАНК|{Без справок и поручителей,По двум документам,7 лет,200 000}                  |
*/
