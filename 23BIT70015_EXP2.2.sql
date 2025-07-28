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

/* 6. Retrieve NPV values for given (ID, YEAR) pairs from TBL_QUERIES */
SELECT Q.ID,Q.YEAR,ISNULL(Y.NPV,0) AS[NPV]
FROM TBL_QUERIES AS Q
LEFT OUTER JOIN
TBL_YEAR AS Y
ON 
Q.ID = Y.ID
AND
Y.YEAR = Q.YEAR
