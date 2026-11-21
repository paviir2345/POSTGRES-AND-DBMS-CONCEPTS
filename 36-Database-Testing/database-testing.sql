
-- SECTION 36: DATABASE TESTING

-- 1. Create a separate schema for testing
CREATE SCHEMA s36_test;

-- 2. Create users table inside the schema
CREATE TABLE s36_test.users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL
);

-- 3. Insert test data
INSERT INTO s36_test.users (username)
VALUES ('Arun'), ('Priya');

-- 4. Check the number of users
SELECT COUNT(*) AS user_count
FROM s36_test.users;

-- 5. Test whether a particular user exists
SELECT *
FROM s36_test.users
WHERE username = 'Arun';

-- 6. Test data isolation
CREATE SCHEMA s36_test_second;

CREATE TABLE s36_test_second.users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL
);

INSERT INTO s36_test_second.users (username)
VALUES ('Rahul');

-- The two schemas have separate users tables
SELECT * FROM s36_test.users;

SELECT * FROM s36_test_second.users;

-- 7. Clean up test schemas
DROP SCHEMA s36_test CASCADE;

DROP SCHEMA s36_test_second CASCADE;
