
-- SECTION 33: FAST MIGRATION AND CONNECTION POOLS

-- 1. Create users table
CREATE TABLE s33_users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL
);

-- 2. Insert sample users
INSERT INTO s33_users (username)
VALUES ('Arun'), ('Priya');

-- 3. Connect and query data
SELECT * FROM s33_users;

-- 4. Query a particular user
SELECT *
FROM s33_users
WHERE username = 'Arun';

-- 5. Update a user
UPDATE s33_users
SET username = 'Arun Kumar'
WHERE id = 1;

SELECT * FROM s33_users;

-- 6. Clean up
DROP TABLE s33_users;
