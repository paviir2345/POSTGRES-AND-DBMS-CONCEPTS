
-- SECTION 20: IMPLEMENTING DATABASE DESIGN PATTERNS

-- 1. USERS TABLE
CREATE TABLE s20_users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL
);

-- 2. POSTS TABLE
CREATE TABLE s20_posts (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES s20_users(id),
    title VARCHAR(100) NOT NULL,
    body TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. COMMENTS TABLE
CREATE TABLE s20_comments (
    id SERIAL PRIMARY KEY,
    post_id INTEGER NOT NULL REFERENCES s20_posts(id),
    user_id INTEGER NOT NULL REFERENCES s20_users(id),
    comment_text TEXT NOT NULL
);

-- 4. LIKES TABLE
CREATE TABLE s20_likes (
    user_id INTEGER REFERENCES s20_users(id),
    post_id INTEGER REFERENCES s20_posts(id),
    PRIMARY KEY (user_id, post_id)
);

-- 5. PHOTO TAGS AND CAPTION TAGS
CREATE TABLE s20_tags (
    id SERIAL PRIMARY KEY,
    post_id INTEGER REFERENCES s20_posts(id),
    tagged_user_id INTEGER REFERENCES s20_users(id),
    tag_type VARCHAR(20) NOT NULL,

    CHECK (tag_type IN ('photo', 'caption'))
);

-- 6. HASHTAGS TABLE
CREATE TABLE s20_hashtags (
    id SERIAL PRIMARY KEY,
    tag_name VARCHAR(50) UNIQUE NOT NULL
);

-- 7. HASHTAG POSTS TABLE
CREATE TABLE s20_hashtag_posts (
    post_id INTEGER REFERENCES s20_posts(id),
    hashtag_id INTEGER REFERENCES s20_hashtags(id),

    PRIMARY KEY (post_id, hashtag_id)
);

-- 8. FOLLOWERS TABLE
CREATE TABLE s20_followers (
    follower_id INTEGER REFERENCES s20_users(id),
    following_id INTEGER REFERENCES s20_users(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (follower_id, following_id),
    CHECK (follower_id <> following_id)
);

-- 9. INSERT SAMPLE USERS
INSERT INTO s20_users (username)
VALUES ('arun'), ('priya'), ('kavin');

-- 10. INSERT SAMPLE POSTS
INSERT INTO s20_posts (user_id, title, body)
VALUES
(1, 'Learning SQL', 'Practising PostgreSQL'),
(2, 'Database Design', 'Understanding relationships');

-- 11. INSERT COMMENTS
INSERT INTO s20_comments (post_id, user_id, comment_text)
VALUES
(1, 2, 'Nice post'),
(2, 1, 'Very useful');

-- 12. INSERT LIKES
INSERT INTO s20_likes (user_id, post_id)
VALUES (1, 2), (2, 1), (3, 1);

-- 13. INSERT PHOTO AND CAPTION TAGS
INSERT INTO s20_tags (post_id, tagged_user_id, tag_type)
VALUES
(1, 2, 'photo'),
(2, 3, 'caption');

-- 14. INSERT HASHTAGS
INSERT INTO s20_hashtags (tag_name)
VALUES ('postgresql'), ('database'), ('learning');

-- 15. CONNECT HASHTAGS TO POSTS
INSERT INTO s20_hashtag_posts (post_id, hashtag_id)
VALUES (1, 1), (1, 3), (2, 2);

-- 16. INSERT FOLLOWERS
INSERT INTO s20_followers (follower_id, following_id)
VALUES (1, 2), (2, 3), (3, 1);

-- 17. VIEW POSTS WITH THEIR AUTHORS
SELECT
    s20_posts.title,
    s20_users.username
FROM s20_posts
JOIN s20_users
ON s20_posts.user_id = s20_users.id;

-- 18. COUNT LIKES FOR EACH POST
SELECT
    post_id,
    COUNT(*) AS total_likes
FROM s20_likes
GROUP BY post_id;

-- 19. VIEW POSTS WITH HASHTAGS
SELECT
    s20_posts.title,
    s20_hashtags.tag_name
FROM s20_hashtag_posts
JOIN s20_posts
ON s20_hashtag_posts.post_id = s20_posts.id
JOIN s20_hashtags
ON s20_hashtag_posts.hashtag_id = s20_hashtags.id;

-- 20. VIEW FOLLOWERS
SELECT
    follower.username AS follower,
    following.username AS following
FROM s20_followers
JOIN s20_users AS follower
ON s20_followers.follower_id = follower.id
JOIN s20_users AS following
ON s20_followers.following_id = following.id;
