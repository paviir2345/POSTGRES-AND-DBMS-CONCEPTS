
-- SECTION 35: SQL INJECTION

-- 1. Create users table
CREATE TABLE s35_users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);

-- 2. Insert users
INSERT INTO s35_users (username, email)
VALUES
('Arun', 'arun@example.com'),
('Priya', 'priya@example.com');

-- 3. Normal user search
SELECT *
FROM s35_users
WHERE username = 'Arun';

-- 4. Safe search example
-- In an application, use a prepared statement:
-- SELECT * FROM s35_users WHERE username = $1;
-- Pass the username as a separate parameter.

-- 5. Insert a new user
INSERT INTO s35_users (username, email)
VALUES ('Rahul', 'rahul@example.com');

-- 6. Update a user
UPDATE s35_users
SET email = 'newarun@example.com'
WHERE id = 1;

-- 7. Delete a user
DELETE FROM s35_users
WHERE id = 3;

-- 8. View remaining users
SELECT * FROM s35_users;

-- 9. Clean up
DROP TABLE s35_users;
