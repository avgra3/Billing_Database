-- Calling the database
USE billing;
                        
/* Creating the view for viewing all bills not paid yet*/
/* Checks to make sure the bill has not been paid and gives a warning if the bill is past due. */

CREATE OR REPLACE VIEW bills_pending_pay AS
SELECT bs.billing_id AS 'billing_id', CONCAT('$',bill_mrc + bill_nrc + bill_taxes) AS totalDue, 
	DATE_FORMAT(bill_due_date, '%m-%d-%Y') AS due_date, IF(bill_due_date < NOW(), '', 'Bill Past Due!') AS past_due
FROM billings bs JOIN customerbill cb
	ON bs.billing_id = cb.billing_id
WHERE MONTH(bill_due_date) <= MONTH(NOW())
	AND bill_paid <> 'PAID'
ORDER BY bill_due_date;
      
    
/* Select statement to view the view  */
SELECT * FROM bills_pending_pay;
