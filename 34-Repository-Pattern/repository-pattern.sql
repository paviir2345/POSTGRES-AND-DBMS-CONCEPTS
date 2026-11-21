
-- SECTION 34: REPOSITORY PATTERN

-- 1. Create users table
CREATE TABLE s34_users (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);

-- 2. Insert sample users
INSERT INTO s34_users (first_name, last_name, email)
VALUES
('Arun', 'Kumar', 'arun@example.com'),
('Priya', 'Sharma', 'priya@example.com'),
('Rahul', 'Das', 'rahul@example.com');

-- 3. Access all users (repository: find all)
SELECT * FROM s34_users;

-- 4. Find a particular user using ID
SELECT *
FROM s34_users
WHERE id = 2;

-- 5. Find a user using email
SELECT *
FROM s34_users
WHERE email = 'arun@example.com';

-- 6. Fix casing in a search
SELECT *
FROM s34_users
WHERE LOWER(first_name) = LOWER('ARUN');

-- 7. Clean up
DROP TABLE s34_users;
