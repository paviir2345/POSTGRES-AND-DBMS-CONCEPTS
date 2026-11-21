
-- SECTION 22: UNDERSTANDING POSTGRESQL INTERNALS

-- 1. Create a sample table
CREATE TABLE s22_students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INTEGER,
    marks NUMERIC(5,2)
);

-- 2. Insert sample records
INSERT INTO s22_students (name, age, marks)
VALUES
('Arun', 20, 85.50),
('Priya', 21, 92.00),
('Kavin', 19, 78.50);

-- 3. Retrieve records
SELECT * FROM s22_students;

-- 4. Check the size of the table
SELECT pg_size_pretty(
    pg_relation_size('s22_students')
) AS table_size;

-- 5. Check total size including indexes
SELECT pg_size_pretty(
    pg_total_relation_size('s22_students')
) AS total_size;

-- 6. View PostgreSQL table metadata
SELECT
    relname,
    relkind,
    relpages,
    reltuples
FROM pg_class
WHERE relname = 's22_students';

-- 7. Check the database size
SELECT pg_size_pretty(
    pg_database_size(current_database())
) AS database_size;

-- 8. View the current database
SELECT current_database();
