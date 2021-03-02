-- Create the database and tables
CREATE DATABASE IF NOT EXISTS billing;

-- Create the tables
CREATE TABLE IF NOT EXISTS billing.carriers
	(
	carrier_id INT NOT NULL AUTO_INCREMENT,
	carrier_name VARCHAR(40) NOT NULL,
	contract_start DATE,
	contract_active CHAR(1) NOT NULL,
	residual_rate DECIMAL(4,2),
	CONSTRAINT carriers_carrier_id PRIMARY KEY(carrier_id)
	);
	
CREATE TABLE IF NOT EXISTS billing.locations
	(
	location_id INT NOT NULL AUTO_INCREMENT,
	location_name VARCHAR(40) NOT NULL,
	location_address1 VARCHAR(40) NOT NULL,
	location_address2 VARCHAR(20),
	location_city VARCHAR(20),
	location_state VARCHAR(2) NOT NULL,
	location_zip VARCHAR(14) NOT NULL,
	location_active VARCHAR(6) NOT NULL,
	CONSTRAINT locations_location_id PRIMARY KEY(location_id)
	);
	
CREATE TABLE IF NOT EXISTS billing.products
	(
	product_id INT NOT NULL AUTO_INCREMENT,
	carrier_id INT,
	location_id INT,
	product_type VARCHAR(10) NOT NULL,
	bill_type VARCHAR(6) NOT NULL,
	product_upcharge_rate DECIMAL(4,2) NOT NULL,
	product_install_date DATE NOT NULL,
	product_disco_date DATE,
	CONSTRAINT products_product_id PRIMARY KEY(product_id),
	CONSTRAINT products_carrier_id FOREIGN KEY(carrier_id)
		REFERENCES carriers(carrier_id),
	CONSTRAINT products_location_id FOREIGN KEY(location_id)
		REFERENCES locations(location_id)
	);
	
CREATE TABLE IF NOT EXISTS billing.billings
	(
	billing_id INT NOT NULL AUTO_INCREMENT,
	product_id INT,
	bill_mrc DECIMAL(9,2) NOT NULL,
	bill_nrc DECIMAL(9,2) NOT NULL,
	bill_taxes DECIMAL(9,2) NOT NULL,
	bill_invoice_date DATE NOT NULL,
	bill_period_start DATE NOT NULL,
	bill_period_end DATE NOT NULL,
	bill_due_date DATE NOT NULL,
	bill_paid VARCHAR(4),
	CONSTRAINT billings_billing_id PRIMARY KEY(billing_id),
	CONSTRAINT billings_product_id FOREIGN KEY(product_id)
		REFERENCES products(product_id)
	);
	

CREATE TABLE IF NOT EXISTS billing.customerbill
	(
	line_item_id INT NOT NULL AUTO_INCREMENT,
	billing_id INT,
	customer_billed DECIMAL(9,2) NOT NULL,
	month_billed_for INT NOT NULL,
	CONSTRAINT customerbill_line_item_id PRIMARY KEY(line_item_id),
	CONSTRAINT customerbill_billing_id FOREIGN KEY(billing_id)
		REFERENCES billings(billing_id)
	);