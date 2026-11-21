
-- SECTION 17: MENTION SYSTEM

-- 1. Users
CREATE TABLE s17_users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL
);

-- 2. Posts with captions and locations
CREATE TABLE s17_posts (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES s17_users(id),
    caption TEXT,
    location VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Comments
CREATE TABLE s17_comments (
    id SERIAL PRIMARY KEY,
    post_id INTEGER REFERENCES s17_posts(id),
    user_id INTEGER REFERENCES s17_users(id),
    comment_text TEXT NOT NULL
);

-- 4. Photo mentions and caption mentions
CREATE TABLE s17_mentions (
    id SERIAL PRIMARY KEY,
    post_id INTEGER REFERENCES s17_posts(id),
    mentioned_user_id INTEGER REFERENCES s17_users(id),
    mention_type VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CHECK (mention_type IN ('photo', 'caption'))
);

-- 5. Insert sample users
INSERT INTO s17_users (username)
VALUES
('arun'),
('priya'),
('kavin');

-- 6. Insert a post with caption and location
INSERT INTO s17_posts (user_id, caption, location)
VALUES
(1, 'Enjoying the day with friends', 'Chennai');

-- 7. Add photo and caption mentions
INSERT INTO s17_mentions
(post_id, mentioned_user_id, mention_type)
VALUES
(1, 2, 'photo'),
(1, 3, 'caption');

-- 8. Display mentions
SELECT
    s17_posts.caption,
    s17_users.username,
    s17_mentions.mention_type
FROM s17_mentions
JOIN s17_users
ON s17_mentions.mentioned_user_id = s17_users.id
JOIN s17_posts
ON s17_mentions.post_id = s17_posts.id;

-- 9. Update a mention
UPDATE s17_mentions
SET mention_type = 'photo'
WHERE id = 2;

-- 10. Delete a mention
DELETE FROM s17_mentions
WHERE id = 2;
