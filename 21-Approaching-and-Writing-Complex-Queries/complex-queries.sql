
-- ==========================================
-- SECTION 21: APPROACHING AND WRITING
-- COMPLEX QUERIES
-- ==========================================

-- 1. CREATE TABLES

CREATE TABLE s21_users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL
);

CREATE TABLE s21_posts (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES s21_users(id),
    title VARCHAR(100) NOT NULL
);

CREATE TABLE s21_likes (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES s21_users(id),
    post_id INTEGER REFERENCES s21_posts(id)
);


-- 2. ADDING SOME DATA

INSERT INTO s21_users (username)
VALUES
('arun'),
('priya'),
('kavin'),
('divya');

INSERT INTO s21_posts (user_id, title)
VALUES
(1, 'Learning SQL'),
(1, 'PostgreSQL Basics'),
(2, 'Database Design'),
(3, 'Learning Joins'),
(2, 'SQL Practice');

INSERT INTO s21_likes (user_id, post_id)
VALUES
(1, 3),
(2, 1),
(2, 2),
(3, 1),
(4, 1),
(1, 5);


-- 3. HIGHEST USER ID

SELECT MAX(id)
FROM s21_users;

-- Display the user with the highest ID
SELECT *
FROM s21_users
WHERE id = (
    SELECT MAX(id)
    FROM s21_users
);


-- 4. POSTS BY A PARTICULAR USER

SELECT *
FROM s21_posts
WHERE user_id = 1;


-- 5. SOLVING FOR POSTS BY USER
-- Display posts along with their authors

SELECT
    s21_users.username,
    s21_posts.title
FROM s21_users
JOIN s21_posts
ON s21_users.id = s21_posts.user_id;


-- Find posts written by a particular username

SELECT
    s21_users.username,
    s21_posts.title
FROM s21_users
JOIN s21_posts
ON s21_users.id = s21_posts.user_id
WHERE s21_users.username = 'arun';


-- 6. LIKES PER USER
-- Count the number of likes received by each user
-- on their posts

SELECT
    s21_users.id,
    s21_users.username,
    COUNT(s21_likes.id) AS total_likes
FROM s21_users
LEFT JOIN s21_posts
ON s21_users.id = s21_posts.user_id
LEFT JOIN s21_likes
ON s21_posts.id = s21_likes.post_id
GROUP BY s21_users.id, s21_users.username
ORDER BY total_likes DESC;


-- 7. LIKES PER USER USING A SUBQUERY

SELECT
    username,
    (
        SELECT COUNT(*)
        FROM s21_posts
        JOIN s21_likes
        ON s21_posts.id = s21_likes.post_id
        WHERE s21_posts.user_id = s21_users.id
    ) AS total_likes
FROM s21_users;
