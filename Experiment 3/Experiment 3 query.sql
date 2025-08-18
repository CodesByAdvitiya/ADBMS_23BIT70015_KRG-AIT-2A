--------------------------EASY----------------------- 
/* YOU ARE GIVEN WITH EMPLOYEE TABLE WITH ONLY ONE ATTRIBUTE THAT IS EMP_ID WHICH CONTAINS VALUES AS:
	EMPLOYEE (EMP_ID)           
            2                   
            4
            4
            6
            6
            7
            8
            8
            8
  TASK: FIND THE MAXIMUM VALUE FOR EMP_ID, BUT EXCLUDING THE DUPLICATE EMPLOYEE ID'S. (ONLY WITH SUB-QUERIES)
  OUTPUT: 7
  EXPLAINATION: IF WE EXCLUDE DUPLICATES SUCH AS, 4, 6, AND 8, & FROM THE REST I.E., 2,7 THE MAXIMUM IS 7.*/

/* 1. Create the database */  
CREATE DATABASE DUPLI; 
USE DUPLI; 

/*2. Create the Tables */  
CREATE TABLE Employee ( 
EMP_ID INT 
); 

/* 3. Insert data  into Tables*/ 
INSERT INTO Employee (EMP_ID) VALUES 
(2), (4), (4), (6), (6), (7), (8), (8), (8); 

/* 4. Query to find maximum EMP_ID excluding duplicates */  
SELECT MAX(EMP_ID) AS MaxEmpID 
FROM Employee 
WHERE EMP_ID NOT IN ( 
    SELECT EMP_ID 
    FROM Employee 
    GROUP BY EMP_ID 
    HAVING COUNT(*) > 1 
); 

---------------------------MEDIUM-------------------------- 
/*Department Salary Champions:
    In a bustling corporate organization, each department strives to retain the most talented
    (and well-compensated) employees. You have access to two key records: one lists every
    employee along with their salary and department, while the other details the names of
    each department. Your task is to identify the top earners in every department.
    If multiple employees share the same highest salary within a department, all of them should
    be celebrated equally. The final result should present the department name, employee
    name, and salary of these top-tier professionals arranged by department.*/
/* 1. Create the database */  
CREATE DATABASE EMPLOYEE; 
USE EMPLOYEE; 

/*2. Create the Tables */  
CREATE TABLE EMP_TBL( 
ID INT PRIMARY KEY, 
NAME VARCHAR(60), 
SALARY INT, 
DEPT_ID INT 
); 
CREATE TABLE DEPT_TBL( 
ID INT PRIMARY KEY, 
DEPT_NAME VARCHAR(100) 
); 
 
/* 3. Insert data into Tables*/ 
INSERT INTO EMP_TBL(ID,NAME,SALARY,DEPT_ID) VALUES  
(1,'JOE',70000,1),  (2,'JIM',90000,1),  (3,'HENRY',80000,2),  
(4,'SAM',60000,2),  (5,'MAX',90000,1); 
 
INSERT INTO DEPT_TBL(ID,DEPT_NAME) VALUES  
(1,'IT'), (2,'SALES'); 
 
/* 4. CO-RELATED SUB-QUERIES */  
SELECT D.DEPT_NAME AS [DEPARTMENT NAME], 
E.NAME AS [EMPLOYEE NAME], E.SALARY  
FROM EMP_TBL AS E  
INNER JOIN DEPT_TBL AS D  
ON E.DEPT_ID = D.ID  
WHERE E.SALARY IN( 
SELECT MAX(SALARY)  
FROM EMP_TBL WHERE DEPT_ID=E.DEPT_ID)  
ORDER BY D.ID; 
 
--------------------------HARD-------------------------- 
/*Merging Employee Histories: Who Earned Least?:
    Two legacy HR systems (A and B) have separate records of employee salaries. These records may overlap.
    Management wants to merge these datasets and identify each unique employee (by EmpID) along with their
    lowest recorded salary across both systems.
    Objective
    1. Combine two tables A and B.
    2. Return each EmpID with their lowest salary, and the corresponding Ename.*/

/* 1. Create the database */  
CREATE DATABASE MERGEEMP; 
USE MERGEEMP; 

/*2. Create the Tables */  
CREATE TABLE TBL_A( 
EmpID INT PRIMARY KEY, 
Ename VARCHAR(100),
Salary INT 
); 
CREATE TABLE TBL_B( 
EmpID INT PRIMARY KEY, 
Ename VARCHAR(100), 
Salary INT 
); 
 
/* 3. Insert data into Tables*/ 
INSERT INTO TBL_A(EmpID,Ename,Salary) VALUES 
(1,'AA',1000), 
(2,'BB',300); 
INSERT INTO TL_B(EmpID,Ename,Salary) VALUES 
(2,'BB',400), 
(3,'CC',100); 

/* 4. SUB-QUERIES */  
SELECT EmpID,MIN(Ename) AS Ename,MIN(Salary) AS [Salary] 
FROM (
    SELECT EmpID,Ename,Salary FROM TBL_A 
	UNION ALL 
	SELECT EmpID,Ename,Salary FROM TBL_B 
) AS MERGEDDATA 
GROUP BY EmpID;