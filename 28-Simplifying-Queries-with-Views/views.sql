
-- ==========================================
-- SECTION 28: SIMPLIFYING QUERIES WITH VIEWS
-- ==========================================

-- 1. CREATE USERS TABLE

CREATE TABLE s28_users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL
);

-- 2. CREATE POSTS TABLE

CREATE TABLE s28_posts (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES s28_users(id),
    title VARCHAR(100) NOT NULL
);

-- 3. INSERT SAMPLE DATA

INSERT INTO s28_users (username)
VALUES ('Arun'), ('Priya'), ('Kavin');

INSERT INTO s28_posts (user_id, title)
VALUES
(1, 'Learning SQL'),
(1, 'PostgreSQL Basics'),
(2, 'Database Design');

-- 4. MERGE DATA FROM TWO TABLES USING JOIN

SELECT
    s28_users.username,
    s28_posts.title
FROM s28_users
JOIN s28_posts
ON s28_users.id = s28_posts.user_id;

-- 5. CREATE A VIEW

CREATE VIEW s28_user_posts AS
SELECT
    s28_users.username,
    s28_posts.title
FROM s28_users
JOIN s28_posts
ON s28_users.id = s28_posts.user_id;

-- 6. RETRIEVE DATA FROM THE VIEW

SELECT * FROM s28_user_posts;

-- 7. FILTER DATA USING A VIEW

SELECT *
FROM s28_user_posts
WHERE username = 'Arun';

-- 8. CHANGE AN EXISTING VIEW

CREATE OR REPLACE VIEW s28_user_posts AS
SELECT
    s28_users.username,
    s28_posts.title,
    s28_posts.id AS post_id
FROM s28_users
JOIN s28_posts
ON s28_users.id = s28_posts.user_id;

-- 9. VIEW THE UPDATED VIEW

SELECT * FROM s28_user_posts;

-- 10. DELETE A VIEW

DROP VIEW s28_user_posts;
