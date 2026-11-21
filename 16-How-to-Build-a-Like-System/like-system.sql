
-- ==========================================
-- SECTION 16: HOW TO BUILD A LIKE SYSTEM
-- ==========================================


-- 1. REQUIREMENTS OF A LIKE SYSTEM
-- A user can like a post.
-- A user should not like the same post twice.
-- We should be able to find who liked a post.


-- 2. CREATE USERS AND POSTS TABLES

CREATE TABLE s16_users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE s16_posts (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES s16_users(id),
    title VARCHAR(100) NOT NULL,
    content TEXT
);


-- 3. AVOID STORING MULTIPLE USER IDs IN ONE COLUMN
-- Bad design example:
-- post_id | liked_user_ids
-- 1       | '1,2,3,4'
--
-- This makes searching, updating and validating
-- individual likes difficult.


-- 4. DESIGNING A LIKE SYSTEM
-- One row represents one user's like on one post.

CREATE TABLE s16_post_likes (
    user_id INTEGER REFERENCES s16_users(id),
    post_id INTEGER REFERENCES s16_posts(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (user_id, post_id)
);


-- 5. INSERT SAMPLE USERS

INSERT INTO s16_users (username)
VALUES
('arun'),
('priya'),
('kavin');


-- 6. INSERT SAMPLE POSTS

INSERT INTO s16_posts (user_id, title, content)
VALUES
(1, 'Learning SQL', 'SQL is useful for databases'),
(2, 'Learning PostgreSQL', 'PostgreSQL is a relational database');


-- 7. ADD LIKES

INSERT INTO s16_post_likes (user_id, post_id)
VALUES
(1, 2),
(2, 1),
(3, 1);


-- 8. DISPLAY ALL LIKES

SELECT * FROM s16_post_likes;


-- 9. FIND THE USERS WHO LIKED A POST

SELECT
    s16_users.username,
    s16_posts.title
FROM s16_post_likes
JOIN s16_users
ON s16_post_likes.user_id = s16_users.id
JOIN s16_posts
ON s16_post_likes.post_id = s16_posts.id;


-- 10. COUNT LIKES FOR EACH POST

SELECT
    s16_posts.id,
    s16_posts.title,
    COUNT(s16_post_likes.user_id) AS total_likes
FROM s16_posts
LEFT JOIN s16_post_likes
ON s16_posts.id = s16_post_likes.post_id
GROUP BY s16_posts.id, s16_posts.title;


-- 11. MAKING A REACTION SYSTEM INSTEAD
-- A reaction system supports different reactions
-- such as Like, Love and Haha.

CREATE TABLE s16_reactions (
    user_id INTEGER REFERENCES s16_users(id),
    post_id INTEGER REFERENCES s16_posts(id),
    reaction_type VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (user_id, post_id),

    CHECK (
        reaction_type IN ('Like', 'Love', 'Haha', 'Wow')
    )
);

INSERT INTO s16_reactions
(user_id, post_id, reaction_type)
VALUES
(1, 1, 'Love'),
(2, 2, 'Like'),
(3, 1, 'Haha');


-- 12. COUNT EACH TYPE OF REACTION

SELECT
    reaction_type,
    COUNT(*) AS total_reactions
FROM s16_reactions
GROUP BY reaction_type;


-- 13. POLYMORPHIC ASSOCIATION
-- A polymorphic design can point to different
-- types of records using a type and an ID.
--
-- Note: target_id cannot have a normal foreign key
-- to both posts and comments.

CREATE TABLE s16_polymorphic_likes (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES s16_users(id),
    target_type VARCHAR(20) NOT NULL,
    target_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    UNIQUE (user_id, target_type, target_id),

    CHECK (target_type IN ('post', 'comment'))
);


-- Example polymorphic likes
INSERT INTO s16_polymorphic_likes
(user_id, target_type, target_id)
VALUES
(1, 'post', 1),
(2, 'comment', 5);


-- 14. ALTERNATIVE: SEPARATE TABLES FOR EACH TARGET

CREATE TABLE s16_comments (
    id SERIAL PRIMARY KEY,
    post_id INTEGER REFERENCES s16_posts(id),
    user_id INTEGER REFERENCES s16_users(id),
    comment_text TEXT NOT NULL
);

CREATE TABLE s16_comment_likes (
    user_id INTEGER REFERENCES s16_users(id),
    comment_id INTEGER REFERENCES s16_comments(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (user_id, comment_id)
);


-- 15. SIMPLE ALTERNATIVE:
-- ONE TABLE WITH TWO OPTIONAL TARGET COLUMNS.
-- Exactly one target must be provided.

CREATE TABLE s16_content_likes (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES s16_users(id),
    post_id INTEGER REFERENCES s16_posts(id),
    comment_id INTEGER REFERENCES s16_comments(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CHECK (
        (post_id IS NOT NULL AND comment_id IS NULL)
        OR
        (post_id IS NULL AND comment_id IS NOT NULL)
    ),

    UNIQUE (user_id, post_id),
    UNIQUE (user_id, comment_id)
);


-- 16. WHICH APPROACH?
-- The separate post_likes and comment_likes tables
-- provide clear foreign keys and simple validation.
-- Choose based on the requirements of the application.
