/**
 * Наполнение базы данными осуществляется путем их переноса из старой базы.
 */

-- Обе БД распологаются на одном сервере, но по-умолчанию для каждой БД 
-- создается отдельный пользователь с правами только на свою базу.
-- Поэтому для переноса данных нужно дать временный доступ на чтение владельцу 
-- новой БД credits2 к старой БД credits (имя пользователя и имя БД совпадают)
-- 
-- Заходим под root на сервер и выполняем команду:
-- GRANT SELECT ON credits.* TO credits2;
-- 
-- После выполнения скрипта забираем права обратно:
-- REVOKE SELECT ON credits.* FROM credits2;



-- 
--  1. Сайты и их страницы
--  

SET foreign_key_checks = 0;
TRUNCATE TABLE credits2.sites;
INSERT INTO credits2.sites (
	id,name,region,city,city_name_rp,city_name_pp,city_id,footer_text,address,
	yandex_metrika_id,google_analitics_id,rating_mailru_id,yandex_verification,google_verification,
	mailru_verification,li_pwd,host,pages_count,yandex_indexed,google_indexed)
SELECT id,name,region,city,city_name_rp,city_name_pp, IF(city_id > 0, city_id, NULL),footer_text,
	address,yandex_metrika_id,google_analitics_id,rating_mailru_id,yandex_verification,
	google_verification,mailru_verification,li_pwd,host,pages_count,yandex_indexed,google_indexed
FROM credits.sites;
SET foreign_key_checks = 1;


SET foreign_key_checks = 0;
TRUNCATE TABLE credits2.pages;
INSERT INTO credits2.pages (id,host,link,title,h1,meta_description,image,anons,main_content,offers_header,calculator_header,banks_header,`type`,tag_id)
SELECT id,host,link,title,h1,meta_description,image,anons,main_content,offers_header,calculator_header,banks_header,`type`,tag_id
FROM credits.pages;
SET foreign_key_checks = 1;



--  
--  2. Офферы
-- 

SET foreign_key_checks = 0;
TRUNCATE TABLE credits2.offers;
INSERT INTO credits2.offers (id,name,active,cpa,epc,epc_system,mct,link,img,bank,`type`,min_rate,max_sum,
	max_period,process_time,description,cpa_name,cpa_offer_id,country,regions,cities,min_age_value,
	max_age_value,min_sum_value,max_sum_value,min_period_value,max_period_value,top,test_links)
SELECT id,name,active,cpa,epc,epc_system,mct,link,img,bank,`type`,min_rate,max_sum,max_period,process_time,
	description,cpa_name,cpa_offer_id,country,regions,cities,min_age_value,max_age_value,min_sum_value,
	max_sum_value,min_period_value,max_period_value,top,test_links
FROM credits.offers;
SET foreign_key_checks = 1;


SET foreign_key_checks = 0;
TRUNCATE TABLE credits2.credit_cards;
INSERT INTO credits2.credit_cards (id,offer_id,name,img,rate,grace_period,`limit`,process_time,description)
SELECT id,offer_id,name,img,rate,grace_period,`limit`,process_time,description
FROM credits.credit_cards;
SET foreign_key_checks = 1;


SET foreign_key_checks = 0;
TRUNCATE TABLE credits2.debit_cards;
INSERT INTO credits2.debit_cards (id,offer_id,name,img,service,cash_out,interest,cashback,description,payment_systems)
SELECT id,offer_id,name,img,service,cash_out,interest,cashback,description,payment_systems
FROM credits.debit_cards;
SET foreign_key_checks = 1;


SET foreign_key_checks = 0;
TRUNCATE TABLE credits2.rko;
INSERT INTO credits2.rko (id,offer_id,bank,tarif,service,payments,cash_in,cash_out,description)
SELECT id,offer_id,bank,tarif,service,payments,cash_in,cash_out,description
FROM credits.rko;
SET foreign_key_checks = 1;



--  
--  3. Теги
-- 

SET foreign_key_checks = 0;
TRUNCATE TABLE credits2.tags;
INSERT INTO credits2.tags (id,offer_type,geo,title,`group`,`order`,rules,parent_id)
SELECT id,offer_type,geo,title,`group`,`order`,rules,parent_id
FROM credits.tags;
SET foreign_key_checks = 1;


SET foreign_key_checks = 0;
TRUNCATE TABLE credits2.offers_tags;
INSERT INTO credits2.offers_tags (offer_id,tag_id)
SELECT offer_id,tag_id
FROM credits.offers_tags;
SET foreign_key_checks = 1;


SET foreign_key_checks = 0;
TRUNCATE TABLE credits2.credit_cards_tags;
INSERT INTO credits2.credit_cards_tags (credit_card_id,tag_id)
SELECT credit_card_id,tag_id
FROM credits.credit_cards_tags;
SET foreign_key_checks = 1;


SET foreign_key_checks = 0;
TRUNCATE TABLE credits2.debit_cards_tags;
INSERT INTO credits2.debit_cards_tags (debit_card_id,tag_id)
SELECT debit_card_id,tag_id
FROM credits.debit_cards_tags;
SET foreign_key_checks = 1;


SET foreign_key_checks = 0;
TRUNCATE TABLE credits2.rko_tags;
INSERT INTO credits2.rko_tags (rko_tarif_id,tag_id)
SELECT rko_tarif_id,tag_id
FROM credits.rko_tags;
SET foreign_key_checks = 1;



--  
--  4. Заявки
-- 

SET foreign_key_checks = 0;
TRUNCATE TABLE credits2.forms;
INSERT INTO credits2.forms (id,lead_time,host,`type`,tag,link,ip,`sum`,period,surname,name,middlename,region,city,
	birthday,email,phone,gender,street,house,housing,flat,reg_region,reg_city,reg_street,reg_house,reg_housing,
	reg_flat,passport_number,passport_date,passport_code,passport_issued_by,birthplace,occupation,earning,
	credit_history,work_experience,last_work_experience,work_name,work_position,work_address,work_phone,work_region,
	work_city,work_street,work_house,prepay,object_type,object_state,price,ak_manufacturer,ak_makes_type,bk_stage,
	bk_company_name,bk_type,bk_pledge,bk_incorporate,inn)
SELECT id,lead_time,host,`type`,tag,link,ip,`sum`,period,surname,name,middlename,region,city,birthday,email,phone,
	gender,street,house,housing,flat,reg_region,reg_city,reg_street,reg_house,reg_housing,reg_flat,passport_number,
	passport_date,passport_code,passport_issued_by,birthplace,occupation,earning,credit_history,work_experience,
	last_work_experience,work_name,work_position,work_address,work_phone,work_region,work_city,work_street,work_house,
	prepay,object_type,object_state,price,ak_manufacturer,ak_makes_type,bk_stage,bk_company_name,bk_type,bk_pledge,bk_incorporate,inn
FROM credits.forms;
SET foreign_key_checks = 1;


SET foreign_key_checks = 0;
TRUNCATE TABLE credits2.form_offers;
INSERT INTO credits2.form_offers (id,name,active,cpa,epl,mct,form_types,cpa_name,cpa_offer_id,fields_set,min_sum,
	max_sum,min_period,max_period,min_age,max_age,regions,cities,regions_native,cities_native,tags,email,dependencies)
SELECT id,name,active,cpa,epl,mct,form_types,cpa_name,cpa_offer_id,fields_set,min_sum,max_sum,min_period,max_period,
	min_age,max_age,regions,cities,regions_native,cities_native,tags,email,dependencies
FROM credits.form_offers;
SET foreign_key_checks = 1;


SET foreign_key_checks = 0;
TRUNCATE TABLE credits2.forms_epf;
INSERT INTO credits2.forms_epf (id,form_type,epf,mct,forms_count,`sum`,update_date)
SELECT id,form_type,epf,mct,forms_count,`sum`,update_date
FROM credits.forms_epf;
SET foreign_key_checks = 1;



--  
--  5. Автомобильный справочник
-- 

SET foreign_key_checks = 0;
TRUNCATE TABLE credits2.cars;
INSERT INTO credits2.cars (id,brand,model,price,image)
SELECT id,brand,model,price,image
FROM credits.cars;
SET foreign_key_checks = 1;



--  
--  6. Гео-справочники
-- 

SET foreign_key_checks = 0;
TRUNCATE TABLE credits2.geo_fias;
INSERT INTO credits2.geo_fias (id,city_name,region_name,region_code,region_iso,unicom_city_code,exbico_city_code,exbico_region_code)
SELECT id,city_name,region_name,region_code,region_iso,unicom_city_code,exbico_city_code,exbico_region_code
FROM credits.geo_fias;
SET foreign_key_checks = 1;


SET foreign_key_checks = 0;
TRUNCATE TABLE credits2.geo_vk;
INSERT INTO credits2.geo_vk (id,city_name,region_iso,region_id)
SELECT id,city_name,region_iso,region_id
FROM credits.geo_vk;
SET foreign_key_checks = 1;




--  
--  7. Новости
-- 

SET foreign_key_checks = 0;
TRUNCATE TABLE credits2.news;
INSERT INTO credits2.news (id,host,title,`date`,category,category_link,rss_url,rss_name,main_content)
SELECT id,host,title,`date`,category,category_link,rss_url,rss_name,main_content
FROM credits.news;
SET foreign_key_checks = 1;


SET foreign_key_checks = 0;
TRUNCATE TABLE credits2.news_host_link;
INSERT INTO credits2.news_host_link (news_id,site_id)
SELECT n.id, s.id
FROM credits.news_host_link nhl 
LEFT JOIN credits.news n ON n.rss_url = nhl.rss_url
LEFT JOIN credits.sites s ON s.host = nhl.host;
SET foreign_key_checks = 1;



--  
--  8. Справочник банков
-- 

SET foreign_key_checks = 0;
TRUNCATE TABLE credits2.banks;
INSERT INTO credits2.banks (id,licence,name,full_name,link,image,phone,email,site,manager,manager_date,address,
	description,actives_sum,actives_rating,profit_sum,profit_rating,update_date,update_link)
SELECT bank_id,licence,name,full_name,link,image,phone,email,site,manager,manager_date,address,description,actives_sum,
	actives_rating,profit_sum,profit_rating,update_date,update_link
FROM credits.banks;
SET foreign_key_checks = 1;


SET foreign_key_checks = 0;
TRUNCATE TABLE credits2.bank_items;
INSERT INTO credits2.bank_items (id,item_id,bank_id,city_id,`type`,name,address,latitude,longitude)
SELECT id,item_id,bank_id,city_id,`type`,name,address,latitude,longitude
FROM credits.bank_items;
SET foreign_key_checks = 1;


SET foreign_key_checks = 0;
TRUNCATE TABLE credits2.bank_cities;
INSERT INTO credits2.bank_cities (id,city_name)
SELECT city_id,city_name
FROM credits.bank_cities;
SET foreign_key_checks = 1;



--  
--  9. Справочник BIN банковских карт
--  

SET foreign_key_checks = 0;
TRUNCATE TABLE credits2.card_bins;
INSERT INTO credits2.card_bins (id,bin,`system`,country,bank,`type`,category)
SELECT id,bin,`system`,country,bank,`type`,category
FROM credits.card_bins;
SET foreign_key_checks = 1;



--  
--  10. Настройки
--  

SET foreign_key_checks = 0;
TRUNCATE TABLE credits2.settings;
INSERT INTO credits2.settings (id,name,value)
SELECT id,name,value
FROM credits.settings;
SET foreign_key_checks = 1;



--  
--  11. Логи
-- 

SET foreign_key_checks = 0;
TRUNCATE TABLE credits2.offers_history;
INSERT INTO credits2.offers_history (id,offer_id,calc_date,epc,mct)
SELECT id,offer_id,calc_date,epc,mct
FROM credits.offers_history;
SET foreign_key_checks = 1;


SET foreign_key_checks = 0;
TRUNCATE TABLE credits2.offers_log;
INSERT INTO credits2.offers_log (id,`date`,offer_id,suboffer_id,suboffer_table,log,comment)
SELECT id,`date`,offer_id,suboffer_id,suboffer_table,log,comment
FROM credits.offers_log;
SET foreign_key_checks = 1;


SET foreign_key_checks = 0;
TRUNCATE TABLE credits2.offer_clicks;
INSERT INTO credits2.offer_clicks (id,ip,region,city,user_agent,offer_id,offer_subid,form_id,`date`,host,tag,cpa,visitors,ya_client_id,link_index)
SELECT id,ip,region,city,user_agent,offer_id,offer_subid,form_id,`date`,host,tag,cpa,visitors,ya_client_id,link_index
FROM credits.offer_clicks;
SET foreign_key_checks = 1;


SET foreign_key_checks = 0;
TRUNCATE TABLE credits2.postback;
INSERT INTO credits2.postback (id,`date`,offer_id,cpa_name,cpa_offer_id,click_id,form_id,lead_id,order_id,status,`sum`,log)
SELECT id,`date`,offer_id,cpa_name,cpa_offer_id,click_id,form_id,lead_id,order_id,status,`sum`,log
FROM credits.postback;
SET foreign_key_checks = 1;


SET foreign_key_checks = 0;
TRUNCATE TABLE credits2.sites_visitors;
INSERT INTO credits2.sites_visitors (id,this_date,visitors,yandex_metrika_id)
SELECT id,this_date,visitors,yandex_metrika_id
FROM credits.sites_visitors;
SET foreign_key_checks = 1;

