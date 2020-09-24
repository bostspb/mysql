/**
 * Наиболее популярные запросы при работе с БД
 */

-- Список банков в зависимости от города
SELECT b.* 
FROM banks b 
LEFT JOIN bank_items bi ON b.bank_id = bi.bank_id
WHERE bi.city_id = ?i
GROUP BY b.id 
ORDER BY b.name;


-- Получение списка офферов с возможностью фильтрации по нескольким параметрам
SELECT DISTINCT ". Offer::getDBFieldNames('o.')." FROM offers o
LEFT JOIN offers_tags ot ON o.id = ot.offer_id 
LEFT JOIN tags t ON t.id = ot.tag_id
WHERE o.active = 1 AND o.bank != '' AND country = ?s 
AND o.min_sum_value <= ?i AND o.max_sum_value >= ?i
AND o.min_period_value <= ?i AND o.max_period_value >= ?i
AND t.title IN (?a)
AND t.offer_type = ?s
GROUP BY o.id HAVING COUNT(*) = ?i 
ORDER BY o.epc DESC, o.epc_system DESC, o.cpa DESC



-- Статистика по различным срезам
SELECT ".$start_select_fields.", COUNT(cl.id) clicks, COUNT(pb.id) leads, COUNT(pb.id) actions, SUM(pb.sum) earnings, o.cpa cpa
FROM offer_clicks cl
LEFT JOIN postback pb ON cl.id = pb.click_id
LEFT JOIN offers o ON cl.offer_id = o.id
WHERE cl.date >= ?s AND cl.date <= ?s
        AND o.id IS NOT NULL
        ?p
        ?p
        
        
-- Список конверсий
SELECT c.date          action_date, 
                            p.click_id      id, 
                            p.date          postback_date, 
                            p.id            postback_id,
                            TO_DAYS(p.date)-TO_DAYS(c.date) period,
                            p.cpa_offer_id  cpa_offer_id,                
                            o.name          offer_name,
                            p.sum           sum, 
                            p.cpa_name      cpa_name, 
                            p.status        status, 
                            o.type          type,
                            p.lead_id       lead_id,
                            p.order_id      order_id
                    FROM  postback p
                    LEFT JOIN offer_clicks c ON p.click_id = c.id 
                    LEFT JOIN offers o ON o.id = c.offer_id
                    WHERE p.cpa_name = ?s
                        AND p.click_id > 0
                        AND p.status = ?s
                        AND c.date >= ?s
                        AND c.date <= ?s

-- Сводка по конверсиям по типам кредитов
SELECT o.type, COUNT(*) count, SUM(p.sum) sum
                        FROM  postback p
                        LEFT JOIN offer_clicks c ON p.click_id = c.id 
                        LEFT JOIN offers o ON o.id = c.offer_id
                        WHERE p.click_id > 0
                            AND p.status = 'approved'
                            AND c.date >= ?s
                            AND c.date <= ?s
                        GROUP BY o.TYPE
                        
-- Сумма и количество конверсий по дням                     
SELECT DATE(date) date, SUM(sum) sum, COUNT(id) count
  FROM postback
  WHERE status = 'approved' AND date >= ?s AND date <= ?s AND cpa_name = ?s
  GROUP BY DATE(date)

-- Рассчет максимального времени конверсии в днях для активных офферов


  SELECT o.id offer_id, MAX(TO_DAYS(pb.date)-TO_DAYS(cl.date)) mct
                    FROM postback pb
                        LEFT JOIN offer_clicks cl ON cl.id = pb.click_id
                        LEFT JOIN offers o ON cl.offer_id = o.id
                    WHERE  pb.form_id = 0
                        AND pb.status =  'approved'
                        AND cl.date > '2018-01-01 00:00:00'
                        AND cl.date > DATE_SUB(CURDATE(), Interval 3 MONTH)
                        AND o.active > 0
                    GROUP BY o.id