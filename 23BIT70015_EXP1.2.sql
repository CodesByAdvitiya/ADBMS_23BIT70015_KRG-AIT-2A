/* Problem Title: Department-Course Subquery and Access Control */
/* 1. Create the database */
CREATE DATABASE AcademicDB;
USE AcademicDB;

/* 2. Create the Departments table */
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_title VARCHAR(80)
);

/* 3. Create the Subjects table with foreign key reference */
CREATE TABLE Subjects (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(120),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

/* 4. Insert department data */
INSERT INTO Departments (dept_id, dept_title)
VALUES
    (10, 'Information Technology'),
    (20, 'Chemical Engineering'),
    (30, 'Electronics'),
    (40, 'Architecture'),
    (50, 'Statistics');

/* 5. Insert subject data */
INSERT INTO Subjects (subject_id, subject_name, dept_id)
VALUES
    (1001, 'Algorithms', 10),
    (1002, 'Computer Networks', 10),
    (1003, 'Database Systems', 10),
    (1004, 'Heat Transfer', 20),
    (1005, 'Chemical Kinetics', 20),
    (1006, 'Digital Circuits', 30),
    (1007, 'Control Systems', 30),
    (1008, 'Building Design', 40),
    (1009, 'Probability', 50),
    (1010, 'Statistical Methods', 50);

/* 6. Final SELECT: Departments with at least 3 subjects */
SELECT dept_title
FROM Departments
WHERE dept_id IN (
    SELECT dept_id
    FROM Subjects
    GROUP BY dept_id
    HAVING COUNT(subject_id) >= 3
);

/* 7. Granting SELECT-Only Access to a User on the Subjects Table in SQL Server */
CREATE LOGIN Adi WITH PASSWORD = 'Test@123';
CREATE USER Miku FOR LOGIN Adi;
GRANT SELECT ON Subjects TO Miku;

EXECUTE AS USER = 'Miku';
SELECT * FROM Subjects;
REVERT;
