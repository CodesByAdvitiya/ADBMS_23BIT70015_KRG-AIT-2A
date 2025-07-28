/* You are a Database Engineer at TalentTree Inc., an enterprise HR analytics platform that stores employee data, including their reporting relationships.The company maintains a centralized Employee 
relation that holds:Each employee’s ID, name, department, and manager ID (who is also an employee in the same table).Your task is to generate a report that maps employees to their respective managers, 
showing:
The employee’s name and department
Their manager’s name and department (if applicable)
This will help the HR department visualize the internal reporting hierarchy. */

/* 1. Create the database */
CREATE DATABASE EmployeeDB;
USE EmployeeDB;

/* 2. Create the TBL_Employee table */
CREATE TABLE TBL_Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    ManagerID INT NULL  
);

/* 3. Add a self-referencing foreign key constraint on ManagerID */
ALTER TABLE TBL_Employee
ADD CONSTRAINT FK_Manager FOREIGN KEY (ManagerID) REFERENCES TBL_Employee(EmpID);

/* 4. Insert TBL_Employee data */
INSERT INTO TBL_Employee (EmpID, EmpName, Department, ManagerID)
VALUES
(1, 'Alice', 'HR', NULL),       
(2, 'Bob', 'Finance', 1),
(3, 'Charlie', 'IT', 1),
(4, 'David', 'Finance', 2),
(5, 'Eve', 'IT', 3),
(6, 'Frank', 'HR', 1);

/* 5. Generate a report mapping employees to their respective managers */
SELECT E1.EmpName AS [EMPLOYEE_NAME],E1.Department AS [EMPLOYEE_DEPARTMENT], E2.EmpName AS [MANAGER_NAME],
E2.Department AS [MANAGER_DEPARTMENT]
FROM
TBL_Employee AS E1
LEFT OUTER JOIN
TBL_Employee AS E2
ON 
E1.ManagerID = E2.EmpID;
