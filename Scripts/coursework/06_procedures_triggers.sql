/**
 * Процедуры, функции и триггеры
 */
 
-- 
-- Триггер, вычисляющий и обновляющий EPC и MCT для оффера, по которому пришел постбек
-- 
DELIMITER //
DROP TRIGGER IF EXISTS calc_epc_mct_on_postback//
CREATE TRIGGER calc_epc_mct_on_postback AFTER INSERT ON postback
FOR EACH ROW
BEGIN	
	IF NEW.status = 'approved' THEN 		
		UPDATE offers 
		SET epc = (
			SELECT 
				ROUND(SUM(pb.sum)*100/COUNT(cl.id)) epc
			FROM offer_clicks cl
				LEFT JOIN postback pb ON cl.id = pb.click_id
			WHERE 
				cl.offer_id = NEW.offer_id
				AND cl.date > DATE_SUB(CURDATE(), INTERVAL 90 DAY)
		),
		mct = (
			SELECT MAX(TO_DAYS(pb.`date`)-TO_DAYS(cl.`date`)) mct
			FROM postback pb
				LEFT JOIN offer_clicks cl ON cl.id = pb.click_id
			WHERE  pb.offer_id = NEW.offer_id
			    AND pb.status =  'approved'
			    AND cl.`date` > DATE_SUB(CURDATE(), INTERVAL 90 DAY)
		)
		WHERE id = NEW.offer_id;
	END IF;
END//
DELIMITER ;
