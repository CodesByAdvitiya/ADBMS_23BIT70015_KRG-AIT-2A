/* You are a Database Engineer at TalentTree Inc., an enterprise HR analytics platform that stores 
employee data, including their reporting relationships.The company maintains a centralized Employee
relation that holds:Each employee’s ID, name, department, and manager ID (who is also an employee 
in the same table).Your task is to generate a report that maps employees to their respective managers,
showing:
The employee’s name and department
Their manager’s name and department (if applicable)
This will help the HR department visualize the internal reporting hierarchy. */

/* 1. Create the database */  
CREATE DATABASE EmployeeDB; 

USE EmployeeDB; 
/*2. Create the Authors table */  
CREATE TABLE TBL_Employee ( 
    	EmpID INT PRIMARY KEY, 
    	EmpName VARCHAR(50) NOT NULL, 
    	Department VARCHAR(50) NOT NULL, 
    	ManagerID INT NULL   
); 
ALTER TABLE TBL_Employee ADD CONSTRAINT FK_Manager FOREIGN KEY (ManagerID) REFERENCES TBL_Employee(EmpID); 

/* 3. Insert authors (from 5 different countries) */  
INSERT INTO TBL_Employee (EmpID, EmpName, Department, ManagerID) VALUES 
(1, 'Alice', 'HR', NULL), (2, 'Bob', 'Finance', 1), (3, 'Charlie', 'IT', 1), 
(4, 'David', 'Finance', 2), (5, 'Eve', 'IT', 3), (6, 'Frank', 'HR', 1); 

/* 4. Self Join */  
SELECT E1.EmpName AS [EMPLOYEE_NAME], 
E1.Department AS [EMPLOYEE_DEPARTMENT],  
E2.EmpName AS [MANAGER_NAME],  
E2.Department AS [MANAGER_DEPARTMENT]  
FROM TBL_Employee AS E1  
Left outer JOIN  
TBL_Employee AS E2  
ON E1.ManagerID = E2.EmpID; 

/* Write a SQL query to retrieve the ID, YEAR, and the corresponding NPV for each record in the QUERIES_TABLE:
		If an (ID, YEAR) pair exists in the YEAR_TABLE, return its NPV.
		If it does not exist, return NPV as 0. */


/* 1. Create the database */
CREATE DATABASE NPVDb;
USE NPVDb;

/* 2. Create the TBL_YEAR table */
CREATE TABLE TBL_YEAR(
	ID INT,
	YEAR INT,
	NPV INT
);

/* 3. Insert TBL_YEAR Data */ 
INSERT INTO TBL_YEAR(ID,YEAR,NPV)
VALUES
(1,2018,100),
(7,2020,30),
(13,2019,40),
(1,2019,13),
(2,2008,121),
(3,2009,12),
(11,2020,99),
(7,2019,0);

/* 4. Create the TBL_QUERIES table */
CREATE TABLE TBL_QUERIES(
	ID INT,
	YEAR INT
);

/* 5. Insert TBL_QUERIES Data */ 
INSERT INTO TBL_QUERIES( ID,YEAR)
VALUES
(1,2019),
(2,2008),
(3,2009),
(7,2018),
(7,2019),
(7,2020),
(13,2019);

/* 5. Retrieve NPV values for given (ID, YEAR) pairs from TBL_QUERIES */
SELECT Q.ID,Q.YEAR,ISNULL(Y.NPV,0) AS[NPV]
FROM TBL_QUERIES AS Q
LEFT OUTER JOIN
TBL_YEAR AS Y
ON 
Q.ID = Y.ID
AND
Y.YEAR = Q.YEAR