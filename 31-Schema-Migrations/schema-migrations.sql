
-- SECTION 31: SCHEMA MIGRATIONS

-- 1. Initial database structure
CREATE TABLE s31_users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL
);

-- 2. Insert initial data
INSERT INTO s31_users (username)
VALUES ('Arun'), ('Priya');

SELECT * FROM s31_users;

-- 3. MIGRATION 001
-- Add an email column to the users table

ALTER TABLE s31_users
ADD COLUMN email VARCHAR(100);

-- Update existing records
UPDATE s31_users
SET email = 'arun@example.com'
WHERE username = 'Arun';

UPDATE s31_users
SET email = 'priya@example.com'
WHERE username = 'Priya';

SELECT * FROM s31_users;

-- 4. MIGRATION 002
-- Add an account creation timestamp

ALTER TABLE s31_users
ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

SELECT * FROM s31_users;

-- 5. REVERT MIGRATION 002
-- Remove the created_at column

ALTER TABLE s31_users
DROP COLUMN created_at;

SELECT * FROM s31_users;

-- 6. REVERT MIGRATION 001
-- Remove the email column

ALTER TABLE s31_users
DROP COLUMN email;

SELECT * FROM s31_users;

-- 7. Clean up
DROP TABLE s31_users;
