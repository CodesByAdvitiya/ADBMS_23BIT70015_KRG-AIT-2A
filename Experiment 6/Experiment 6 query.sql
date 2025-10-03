-- ======================================
--Create Tables
CREATE TABLE customer_master (
    customer_id INT IDENTITY PRIMARY KEY,
    full_name NVARCHAR(100) NOT NULL
);
CREATE TABLE product_catalog (
    product_id INT IDENTITY PRIMARY KEY,
    product_name NVARCHAR(100) NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL
);
CREATE TABLE sales_orders (
    order_id INT IDENTITY PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id INT FOREIGN KEY REFERENCES customer_master(customer_id),
    product_id INT FOREIGN KEY REFERENCES product_catalog(product_id),
    quantity INT NOT NULL,
    discount_percent DECIMAL(5,2) DEFAULT 0
);
-- Insert Sample Data
-- Customers
INSERT INTO customer_master (full_name)
VALUES ('Alice Smith'), ('Bob Johnson'), ('Charlie Rose');
-- Products
INSERT INTO product_catalog (product_name, unit_price)
VALUES ('Laptop', 1000.00), ('Phone', 600.00), ('Tablet', 300.00);
-- Orders
INSERT INTO sales_orders (order_date, customer_id, product_id, quantity, discount_percent)
VALUES
('2023-09-01', 1, 1, 2, 10),
('2023-09-02', 2, 2, 1, 5),
('2023-09-03', 3, 3, 3, 0);
-- Create View vW_ORDER_SUMMARY
CREATE VIEW vW_ORDER_SUMMARY AS
SELECT 
    O.order_id,
    O.order_date,
    P.product_name,
    C.full_name,
    (P.unit_price * O.quantity) - ((P.unit_price * O.quantity) * O.discount_percent / 100) AS final_cost
FROM customer_master AS C
JOIN sales_orders AS O ON O.customer_id = C.customer_id
JOIN product_catalog AS P ON P.product_id = O.product_id;
-- Test the view
SELECT * FROM vW_ORDER_SUMMARY;
-- Create Login and User
-- Create Login at Server Level (run as sysadmin)
CREATE LOGIN jin WITH PASSWORD = 'StrongPassword123!';
-- Create Database User for the login
USE [Academic];
CREATE USER ALAK FOR LOGIN jin;
-- Grant SELECT permission on the view only
GRANT SELECT ON vW_ORDER_SUMMARY TO ALAk;
-- Create Employee Table
CREATE TABLE EMPL (
    empId INT PRIMARY KEY,
    name NVARCHAR(50) NOT NULL,
    dept NVARCHAR(50) NOT NULL
);
-- Insert Data
INSERT INTO EMPL VALUES 
(1, 'Clark', 'Sales'),
(2, 'Dave', 'Accounting'),
(3, 'Ava', 'Sales');
-- Create View With CHECK OPTION
CREATE VIEW vW_STORE_SALES_DATA
AS
SELECT empId, name, dept
FROM EMPL
WHERE dept = 'Sales'
WITH CHECK OPTION;
-- View Content
SELECT * FROM vW_STORE_SALES_DATA;
-- This works
INSERT INTO vW_STORE_SALES_DATA (empId, name, dept)
VALUES (4, 'Riya', 'Sales');
-- This fails - violates CHECK OPTION
INSERT INTO vW_STORE_SALES_DATA (empId, name, dept)

VALUES (5, 'Aman', 'Admin');

