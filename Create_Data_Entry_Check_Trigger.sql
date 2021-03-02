USE billing;

/* Create a test table so we don't ruin any current data */
DROP TABLE IF EXISTS carriers_copy;
CREATE TABLE carriers_copy
SELECT * FROM carriers;

/* When we update the carriers table, check that the data entered is correct */
DROP TRIGGER IF EXISTS carriers_before_update
DELIMITER //
CREATE TRIGGER carriers_before_update
 BEFORE UPDATE ON carriers_copy
 FOR EACH ROW
 BEGIN
	SET NEW.carrier_name = UPPER(NEW.carrier_name);
    SET NEW.contract_active = UPPER(NEW.contract_active);
        
    IF NEW.residual_rate < 0 THEN
		SIGNAL SQLSTATE 'HY000'
        SET MESSAGE_TEXT = 'Residual rates cannot be less than 0';
    END IF;
    
    IF NEW.contract_active NOT IN('Y','N') THEN
		SIGNAL SQLSTATE 'HY000'
        SET MESSAGE_TEXT = 'Please enter contract active as Y for active or N for inactive';
    END IF;
    
 END //