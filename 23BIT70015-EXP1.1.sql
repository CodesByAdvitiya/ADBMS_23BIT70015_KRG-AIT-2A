/* Problem Title: Author-Book Relationship Using Joins and Basic SQL Operations */
/* 1. Create the database */
CREATE DATABASE BookCafe;
USE BookCafe;

/*2. Create the Authors table */
CREATE TABLE Authors(
    author_id INT PRIMARY KEY,
    author_name VARCHAR(150),
    nationality VARCHAR(60)
);

/* 3. Create the Books table with FK to Authors */
CREATE TABLE Books(
    book_code INT PRIMARY KEY,
    book_title VARCHAR(120),
    author_id INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

/* 4. Insert authors (from 5 different countries) */
INSERT INTO Authors (author_id, author_name, nationality)
VALUES
    (101, 'J.K. Rowling', 'United Kingdom'),
    (102, 'Dr. Seuss', 'United States'),
    (103, 'Tove Jansson', 'Finland'),
    (104, 'R.K. Narayan', 'India'),
    (105, 'Hayao Miyazaki', 'Japan');

/* 5. Insert books */
INSERT INTO Books (book_code, book_title, author_id)
VALUES
    (101, 'The Enchanted Feather', 101),          
    (102, 'The Whimsical Whistle Tree', 102),      
    (103, 'Moomin and the Sky Garden', 103),       
    (104, 'Swami and the Talking Tiger', 104),     
    (105, 'Kiki’s Little Lantern Adventure', 105); 

/* 6. Final SELECT query to display result */
SELECT
    B.book_title AS Title,
    A.author_name AS Author,
    A.nationality AS Country
FROM
    Books B
    JOIN Authors A ON B.author_id = A.author_id;
