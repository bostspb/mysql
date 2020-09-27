/**
 * Скрипты характерных выборок
 */


-- Список всех банков, которые имеют филиалы или банкоматы в заданном городе
SELECT b.* 
FROM banks b 
	LEFT JOIN bank_items bi ON b.id = bi.bank_id
WHERE bi.city_id = 114 -- Санкт-Петербург
GROUP BY b.id 
ORDER BY b.name;



-- Получение списка офферов с возможностью фильтрации по нескольким параметрам
SELECT DISTINCT o.* FROM offers o
	LEFT JOIN offers_tags ot ON o.id = ot.offer_id 
	LEFT JOIN tags t ON t.id = ot.tag_id
WHERE 
	o.active = 1 												-- активные офферы
	AND o.bank != ''											-- указана организация 
	AND country = 'RU' 											-- страна Россия
	AND o.min_sum_value <= 25000 AND o.max_sum_value >= 25000 	-- посетителю нужна сумма 25 000 руб.
	AND o.min_period_value <= 14 AND o.max_period_value >= 14	-- посетителю нужн кредит сроком на 2 недели
	AND t.title IN ('Экспресс', 'На карту', 'Без отказа')		-- посетитель ищет быстрый займ на карту с высоким процентом одобрения
	AND t.offer_type = 'Микрозайм'								-- уточняем, что это именно микрозайм, а не потребительский кредит
GROUP BY o.id HAVING COUNT(*) = 3 
ORDER BY o.epc DESC, o.epc_system DESC, o.cpa DESC;



-- Доходность по офферам за последние 90 дней
SELECT o.id, o.name, o.`type`, 
	COUNT(cl.id) clicks, 
	COUNT(pb.id) leads, 
	SUM(case when pb.status = 'approved' then 1 else 0 end) actions, 
	SUM(pb.sum) earnings, 
	o.cpa cpa, 								 -- Cost Per Action	
	FORMAT(SUM(pb.sum)/COUNT(cl.id), 2) epc, -- Earnings Per Click
	FORMAT(SUM(pb.sum)/COUNT(pb.id), 2) epl, -- Earnings Per Lead
	FORMAT(SUM(case when pb.status = 'approved' then 1 else 0 end)*100/COUNT(pb.id), 2) ar	 -- Approve Rate
FROM offer_clicks cl
	LEFT JOIN postback pb ON cl.id = pb.click_id
	LEFT JOIN offers o ON cl.offer_id = o.id
WHERE cl.date > DATE_SUB(CURDATE(), INTERVAL 90 DAY)
	AND o.id IS NOT NULL
GROUP BY o.id
ORDER BY SUM(pb.sum)/COUNT(cl.id) DESC;
  

        
-- Сводка по конверсиям за последние 90 дней в разрезе типов кредита
SELECT o.`type`, COUNT(*) `count`, SUM(p.`sum`) `sum`
FROM  postback p
	LEFT JOIN offer_clicks c ON p.click_id = c.id 
	LEFT JOIN offers o ON o.id = c.offer_id
WHERE p.click_id > 0
    AND p.status = 'approved'
    AND p.`date` > DATE_SUB(CURDATE(), INTERVAL 90 DAY)
GROUP BY o.TYPE;
    

                        
-- Сумма и количество конверсий по дням за последние 90 дней в разрезе одной партнерской сети              
SELECT DATE(`date`) date, SUM(`sum`) `sum`, COUNT(id) `count`
FROM postback
WHERE status = 'approved' 
	AND `date` > DATE_SUB(CURDATE(), INTERVAL 90 DAY)
	AND cpa_name = 'leadgid.ru'
GROUP BY DATE(`date`);


  
-- Рассчет максимального времени конверсии в днях для активных офферов
SELECT o.id, o.name, o.`type`, MAX(TO_DAYS(pb.`date`)-TO_DAYS(cl.`date`)) mct
FROM postback pb
	LEFT JOIN offer_clicks cl ON cl.id = pb.click_id
	LEFT JOIN offers o ON cl.offer_id = o.id
WHERE  pb.form_id = 0
    AND pb.status =  'approved'
    AND cl.`date` > DATE_SUB(CURDATE(), INTERVAL 90 DAY)
    AND o.active = 1
GROUP BY o.id
ORDER BY o.`type`, o.name;

