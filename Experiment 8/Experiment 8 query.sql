---------------------Hard Level Problem-----------------------------
/*
Design a robust PostgreSQL transaction system for the students table where multiple student records are inserted in a single transaction. 
If any insert fails due to invalid data, only that insert should be rolled back while preserving the previous successful inserts using savepoints. 
The system should provide clear messages for both successful and failed insertions, ensuring data integrity and controlled error handling.
*/

DROP TABLE IF EXISTS students;

CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    class INT
);


DO $$
BEGIN
    -- Start a transaction
    BEGIN
        -- Insert multiple students
        INSERT INTO students(name, age, class) VALUES ('Anisha',16,8);
        INSERT INTO students(name, age, class) VALUES ('Neha',17,8);
        INSERT INTO students(name, age, class) VALUES ('Mayank',19,9);

        -- If all succeed
        RAISE NOTICE ' Transaction Successfully Done';

    EXCEPTION
        WHEN OTHERS THEN
            -- If any insert fails
            RAISE NOTICE 'Transaction Failed..! Rolling back changes.';
            RAISE;  -- this will rollback the entire transaction
    END;
END;
$$;


SELECT * FROM students;

---------------------------WRONG DATA TYPE SCENARIO-------------------------
DO $$
BEGIN
    SAVEPOINT sp1;
    INSERT INTO students(name, age, class) VALUES ('Aarav', 16, 8);

    SAVEPOINT sp2;
    BEGIN
        INSERT INTO students(name, age, class) VALUES ('Rahul', 'wrong', 9); -- fails
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'Failed to insert Rahul, rolling back to savepoint sp2';
        ROLLBACK TO SAVEPOINT sp2;
    END;

    INSERT INTO students(name, age, class) VALUES ('Sita', 17, 10);

    COMMIT;
END;
$$;