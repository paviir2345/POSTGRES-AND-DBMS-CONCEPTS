
-- ==========================================
-- SECTION 15: DATABASE STRUCTURE DESIGN PATTERNS
-- ==========================================

-- 1. Create users table

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE
);


-- 2. Create categories table

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE
);


-- 3. Create posts table

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    category_id INTEGER,
    title VARCHAR(150) NOT NULL,
    body TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);


-- 4. Create comments table

CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    post_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    comment_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (post_id) REFERENCES posts(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);


-- 5. Insert sample users

INSERT INTO users (username, email)
VALUES
('arun', 'arun@example.com'),
('priya', 'priya@example.com');


-- 6. Insert categories

INSERT INTO categories (category_name)
VALUES
('Technology'),
('Education');


-- 7. Insert posts

INSERT INTO posts (user_id, category_id, title, body)
VALUES
(1, 1, 'Learning PostgreSQL', 'Introduction to databases'),
(2, 2, 'Database Design', 'Understanding table relationships');


-- 8. Insert comments

INSERT INTO comments (post_id, user_id, comment_text)
VALUES
(1, 2, 'Very useful post'),
(2, 1, 'Good explanation');


-- 9. Retrieve the posts with their authors

SELECT
    posts.title,
    users.username
FROM posts
JOIN users
ON posts.user_id = users.id;


-- 10. Retrieve comments with usernames

SELECT
    comments.comment_text,
    users.username
FROM comments
JOIN users
ON comments.user_id = users.id;
