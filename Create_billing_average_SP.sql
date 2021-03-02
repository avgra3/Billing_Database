-- Calling the database
USE billing;

/* This stored procedure will return the average amount billed by the carrier */
-- /*
DROP PROCEDURE IF EXISTS billing_avg;
DELIMITER //
CREATE PROCEDURE billing_avg
(
	IN location_id_param INT, 
    IN carrier_id_param INT,
	OUT bill_avg_param DECIMAL(9,2)
)
BEGIN
/* If no carrier is chosen (NULL) then it will average all bills for a location */
IF carrier_id_param IS NULL THEN
	SET carrier_id_param = 1;
END IF;

IF location_id_param IS NULL THEN
	SET location_id_param = 12;
END IF;

SELECT ROUND(AVG(bill_mrc), 2) AS avg_mrc
FROM billings b JOIN products p
	ON b.product_id = p.product_id
WHERE location_id = location_id_param
	AND carrier_id = carrier_id_param;
END //

