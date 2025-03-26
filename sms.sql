create database sms;
use sms;

CREATE TABLE Customer(
customer_id INT AUTO_INCREMENT PRIMARY KEY,
customer_name VARCHAR(255) NOT NULL
);
CREATE TABLE Employee(
employee_id INT AUTO_INCREMENT PRIMARY KEY,
product_name VARCHAR(255) NOT NULL,
list_price DECIMAL(10,2) NOT NULL
);
CREATE TABLE Product(
product_id INT AUTO_INCREMENT PRIMARY KEY,
product_name VARCHAR(255) NOT NULL,
list_price DECIMAL(10,2) NOT NULL
);
CREATE TABLE Orders(
order_id INT AUTO_INCREMENT PRIMARY KEY,
order_date DATETIME NOT NULL,
customer_id INT NOT NULL,
employee_id INT NOT NULL,
total DECIMAL(10,2),
FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);
CREATE TABLE LineItem(
order_id INT NOT NULL,
product_id INT NOT NULL,
quantity INT NOT NULL, 
price DECIMAL(10,2),
FOREIGN KEY (order_id) REFERENCES Orders(order_id),
FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- 1
SELECT DISTINCT c.customer_id, c.customer_name FROM Customer c
JOIN Orders o ON o.customer_id = c.customer_id;
-- 2
SELECT o.order_id, o.order_date, o.customer_id, o.employee_id, o.total FROM Orders o
WHERE o.customer_id = 2;
-- 3
SELECT * FROM LineItem l WHERE l.order_id = 32;
-- 4
DELIMITER //
CREATE FUNCTION update_total_orders(o_order_id INT)
RETURNS DECIMAL(10,2) 
READS SQL DATA
BEGIN
	DECLARE total DECIMAL(10,2);
    SELECT SUM(quantity * price) INTO total
    FROM LineItem WHERE order_id = o_order_id;
    
    RETURN total;
END//
DELIMITER ;
-- update the whole table
UPDATE Orders SET total = update_total_orders(order_id);
-- compute the specific order_id
SELECT update_total_orders(3) as order_total;
-- 5
DELIMITER //
CREATE PROCEDURE add_customer (IN customer_name VARCHAR(255))
BEGIN
	INSERT INTO Customer(customer_name) VALUES (customer_name);
END //
DELIMITER ;
CALL add_customer('NGHI NGUYEN');
-- 6
DELIMITER //
CREATE PROCEDURE delete_customer (IN c_customer_id INT)
BEGIN
	DECLARE error_occurred BOOL DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	SET error_occurred = TRUE;
	START TRANSACTION;
    
	DELETE FROM LineItem WHERE order_id IN (
		SELECT order_id FROM Orders WHERE customer_id = c_customer_id
	);
    DELETE FROM Orders WHERE customer_id = c_customer_id;
    DELETE FROM Customer WHERE customer_id = c_customer_id;
    IF error_occurred THEN 
		ROLLBACK;
    ELSE
		COMMIT;
	END IF;
END //
DELIMITER ;
CALL delete_customer(3);
-- 7 
DELIMITER //
CREATE PROCEDURE update_customer (IN c_customer_id INT, IN c_name VARCHAR(255))
BEGIN
	UPDATE Customers SET customer_name = c_name WHERE customer_id = c_customer_id;
END //
DELIMITER ;
CALL update_customer(3, 'HIEN TRAN');
-- 8
INSERT INTO Orders (order_date, customer_id, employee_idd, total) VALUES (NOW(), 3,2,19.99);
-- 9
INSERT INTO LineItem (order_id, product_id, quantity, price) VALUES (1,2,5,14.99);
-- 10 
UPDATE Orders
SET total = update_total_orders(order_id);
