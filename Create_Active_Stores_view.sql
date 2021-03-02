-- Calling the database
USE billing;

/* Creating the view for viewing all active stores and what their products are*/

CREATE OR REPLACE VIEW active_locations AS
SELECT location_name, carrier_name, product_type
FROM locations l JOIN products p
	ON l.location_id = p.location_id
    JOIN carriers c
    ON p.carrier_id = c.carrier_id
WHERE p.product_id IN (SELECT product_id
					FROM products
                    WHERE location_active = 'ACTIVE');
      

/* Select statement to view the view  */
SELECT * FROM active_locations;