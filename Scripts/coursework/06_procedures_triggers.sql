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


-- 
-- Хранимая функция, вычисляющая EPC от произвольной даты на заданном интервале
-- 
DELIMITER //
DROP FUNCTION  IF EXISTS epc//
CREATE FUNCTION epc (offer_id INT, start_date DATE, interval_value INT) RETURNS INT
BEGIN
	RETURN (
	 	SELECT ROUND(SUM(pb.`sum`)*100/COUNT(cl.id)) epc
		FROM offer_clicks cl
			LEFT JOIN postback pb ON cl.id = pb.click_id
		WHERE 
			cl.offer_id = offer_id
		AND cl.date > DATE_SUB(start_date, INTERVAL interval_value DAY)
	);	
END//
DELIMITER ;


SELECT epc(6, '2020-10-05 00:00:00', 90);
/*
epc(6, '2020-10-05 00:00:00', 90)|
---------------------------------|
                             7817|
*/



-- 
-- Хранимая процедура, заполняющая таблицу с историей изменения EPC и MCT активных офферов
--
DELIMITER //
DROP PROCEDURE IF EXISTS fill_offers_history//
CREATE PROCEDURE fill_offers_history ()
BEGIN
  DECLARE offer_id_value INT;
  DECLARE is_end INT DEFAULT 0;

  DECLARE offers_cursor CURSOR FOR SELECT id FROM offers WHERE active = 1; 
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET is_end = 1;

  OPEN offers_cursor;

  cycle : LOOP
	FETCH offers_cursor INTO offer_id_value;
	IF is_end THEN LEAVE cycle;
	END IF;

	INSERT IGNORE INTO offers_history (epc, mct, calc_date, offer_id)
	VALUES (
		(
			SELECT 
				ROUND(SUM(pb.sum)*100/COUNT(cl.id)) epc
			FROM offer_clicks cl
				LEFT JOIN postback pb ON cl.id = pb.click_id
			WHERE 
				cl.offer_id = offer_id_value
				AND cl.date > DATE_SUB(CURDATE(), INTERVAL 90 DAY)
		),
		(
			SELECT MAX(TO_DAYS(pb.`date`)-TO_DAYS(cl.`date`)) mct
			FROM postback pb
				LEFT JOIN offer_clicks cl ON cl.id = pb.click_id
			WHERE  pb.offer_id = offer_id_value
			    AND pb.status =  'approved'
			    AND cl.`date` > DATE_SUB(CURDATE(), INTERVAL 90 DAY)
		), 
		CURDATE(), 
		offer_id_value
	);
  END LOOP cycle;

  CLOSE offers_cursor;
END//
DELIMITER ;

  

CALL fill_offers_history();
SELECT * FROM offers_history WHERE calc_date = CURDATE() LIMIT 10;
/*
id   |offer_id|calc_date |epc  |mct|
-----|--------|----------|-----|---|
52451|       1|2020-10-06|    0|  0|
52452|       5|2020-10-06|  879|  1|
52453|       6|2020-10-06| 7854| 34|
52454|       8|2020-10-06| 3529|  0|
52455|      10|2020-10-06| 3750|  0|
52456|      11|2020-10-06| 1741|  0|
52457|      12|2020-10-06|  820|  1|
52458|      16|2020-10-06|30247|  0|
52459|      18|2020-10-06|  278|  0|
52460|      21|2020-10-06|    0|  0|
*/


  