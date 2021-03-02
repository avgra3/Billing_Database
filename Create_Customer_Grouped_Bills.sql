-- Calling the database
USE billing;

/* Creating the view for viewing customer bill - billing grouped by location */
/* Grouped by the location_name, then the carrier, finally the product */

CREATE OR REPLACE VIEW customer_bill_grouped AS
SELECT location_name, carrier_name, product_type, SUM(bill_mrc) AS monthly_rate, SUM(bill_nrc) AS one_time, SUM(bill_taxes) AS taxes, SUM(customer_billed) AS billed_out
FROM customerbill cb JOIN billings b
	ON cb.billing_id = b.billing_id
    JOIN products p
    ON p.product_id = b.product_id
    JOIN carriers c
    ON p.carrier_id = c.carrier_id
    JOIN locations l
    ON l.location_id = p.location_id
GROUP BY location_name, product_type, carrier_name WITH ROLLUP;    

/* Select statement to view the view  */
SELECT * FROM customer_bill_grouped;