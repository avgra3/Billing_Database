USE billing;

/* Return product ID for a given billing ID */
DROP FUNCTION IF EXISTS get_carrier_id;

DELIMITER //
CREATE FUNCTION get_carrier_id
(
	billing_id_param INT
)
RETURNS INT
DETERMINISTIC READS SQL DATA
BEGIN
	DECLARE carrier_id_var INT;
    
    SELECT c.carrier_id
    INTO carrier_id_var
    FROM carriers c JOIN products p 
		ON c.carrier_id = p.carrier_id
        JOIN billings b
			ON b.product_id = p.product_id
	WHERE billing_id = billing_id_param;
    
    RETURN(carrier_id_var);  
    
END//


