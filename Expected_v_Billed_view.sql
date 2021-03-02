/* Selecting the database */
USE billing;

/* Creates a view that compares what is expected versus what was billed */
/* Uses 3 tables 
	2 Where conditions: for only bills paid AND total mrc >= 0
    IF function in one of the columns when credit/adjustment amount is less than zero, set to zero*/

CREATE OR REPLACE VIEW monthly_billing AS
SELECT carrier_name, product_type, customer_billed AS revenue, IF(bill_mrc + bill_nrc + bill_taxes < 0, 0, bill_mrc + bill_nrc + bill_taxes) AS cost, 
	(customer_billed - (bill_mrc + bill_nrc + bill_taxes)) AS profit, 
	ROUND(((customer_billed - (bill_mrc + bill_nrc + bill_taxes))/customer_billed)*100,2) AS percent_profit
FROM  customerbill cb JOIN billings b
	ON cb.billing_id = b.billing_id
    JOIN products p ON p.product_id = b.product_id
    JOIN carriers c ON c.carrier_id = p.carrier_id
    WHERE bill_paid IS NOT NULL
		AND bill_mrc >= 0
GROUP BY product_type, carrier_name WITH ROLLUP
ORDER BY product_type;
     
    
/* Select statement to view the view with a specific carrier  */
SELECT * FROM monthly_billing
WHERE carrier_name = 'Comcast';