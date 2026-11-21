
-- SECTION 18: HASHTAG SYSTEM

-- 1. Create users
CREATE TABLE s18_users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL
);

-- 2. Create posts
CREATE TABLE s18_posts (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES s18_users(id),
    content TEXT NOT NULL
);

-- 3. Create hashtags
CREATE TABLE s18_hashtags (
    id SERIAL PRIMARY KEY,
    tag_name VARCHAR(50) UNIQUE NOT NULL
);

-- 4. Connect posts and hashtags
CREATE TABLE s18_post_hashtags (
    post_id INTEGER REFERENCES s18_posts(id),
    hashtag_id INTEGER REFERENCES s18_hashtags(id),
    PRIMARY KEY (post_id, hashtag_id)
);

-- 5. Insert sample data
INSERT INTO s18_users (username)
VALUES ('arun'), ('priya');

INSERT INTO s18_posts (user_id, content)
VALUES
(1, 'Learning PostgreSQL'),
(2, 'Practising database design');

INSERT INTO s18_hashtags (tag_name)
VALUES ('postgresql'), ('database'), ('learning');

-- 6. Add hashtags to posts
INSERT INTO s18_post_hashtags
VALUES
(1, 1),
(1, 3),
(2, 2);

-- 7. Display posts with their hashtags
SELECT
    s18_posts.content,
    s18_hashtags.tag_name
FROM s18_post_hashtags
JOIN s18_posts
ON s18_post_hashtags.post_id = s18_posts.id
JOIN s18_hashtags
ON s18_post_hashtags.hashtag_id = s18_hashtags.id;

-- 8. Find posts containing a particular hashtag
SELECT s18_posts.content
FROM s18_posts
JOIN s18_post_hashtags
ON s18_posts.id = s18_post_hashtags.post_id
JOIN s18_hashtags
ON s18_post_hashtags.hashtag_id = s18_hashtags.id
WHERE s18_hashtags.tag_name = 'postgresql';
