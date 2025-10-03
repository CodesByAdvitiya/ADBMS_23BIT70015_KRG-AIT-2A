--------------------------------------------EXPERIMENT 05 (MEDIUM LEVEL)------------------------------
/*Create a large dataset:  

Create a table names transaction_data (id , value) with 1 million records. 

take id 1 and 2, and for each id, generate 1 million records in value column 

Use Generate_series () and random() to populate the data. 

Create a normal view and materialized view to for sales_summary, which includes total_quantity_sold, total_sales, and total_orders with aggregation. 

Compare the performance and execution time of both. 
*/
-- Create base table
CREATE TABLE transaction_data (
    id INT,
    value INT
);
-- For id = 1
INSERT INTO transaction_data (id, value)
SELECT 1, random() * 1000
FROM generate_series(1, 1000000);
-- For id = 2
INSERT INTO transaction_data (id, value)
SELECT 2, random() * 1000
FROM generate_series(1, 1000000);
-- View data
SELECT * FROM transaction_data;
-- WITH NORMAL VIEW
CREATE OR REPLACE VIEW sales_summary_view AS
SELECT
    id,
    COUNT(*) AS total_orders,
    SUM(value) AS total_sales,
    AVG(value) AS avg_transaction
FROM transaction_data
GROUP BY id;
-- Analyze performance of normal view
EXPLAIN ANALYZE
SELECT * FROM sales_summary_view;
-- WITH MATERIALIZED VIEW
CREATE MATERIALIZED VIEW sales_summary_mv AS
SELECT
    id,
    COUNT(*) AS total_orders,
    SUM(value) AS total_sales,
    AVG(value) AS avg_transaction
FROM transaction_data
GROUP BY id;
-- Analyze performance of materialized view
EXPLAIN ANALYZE
SELECT * FROM sales_summary_mv;
-- Create another table
CREATE TABLE random_tabl (id INT, val DECIMAL);
-- Insert random data
INSERT INTO random_tabl 
SELECT 1, random() FROM generate_series(1, 1000000);
INSERT INTO random_tabl 
SELECT 2, random() FROM generate_series(1, 1000000);
-- Normal execution
SELECT id, AVG(val), COUNT(*)
FROM random_tabl
GROUP BY id;
-- Create materialized view
CREATE MATERIALIZED VIEW mv_random_tabl AS
SELECT id, AVG(val), COUNT(*)
FROM random_tabl
GROUP BY id;
-- Query materialized view
SELECT * FROM mv_random_tabl;
-- Refresh materialized view after data change
REFRESH MATERIALIZED VIEW mv_random_tabl;





--------------------------------------------EXPERIMENT 05 (HARD LEVEL)------------------------------
/*The company TechMart Solutions stores all sales transactions in a central database. A new reporting team has been formed to analyze sales but they should not have direct access to the base tables for security reasons. 

The database administrator has decided to: 

Create restricted views to display only summarized, non-sensitive data. 

Assign access to these views to specific users using DCL commands (GRANT, REVOKE). */
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