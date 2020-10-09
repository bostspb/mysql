/**
 * Представления
 */

-- 
-- Перенесем несклько характерных выборок в представления
--

-- Доходность по офферам за последние 90 дней
CREATE VIEW offers_statistics_d90 (id,name,`type`,clicks,leads,actions,earnings,cpa,epc,epl,ar) AS 	
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


-- Рассчет максимального времени конверсии в днях для активных офферов
CREATE VIEW mct_d90 (id, name, `type`, mct) AS
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