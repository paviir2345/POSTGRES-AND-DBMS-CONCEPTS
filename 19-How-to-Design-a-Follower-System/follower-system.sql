
-- SECTION 19: FOLLOWER SYSTEM

-- 1. Create users table
CREATE TABLE s19_users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL
);

-- 2. Create followers table
-- follower_id = user who follows
-- following_id = user being followed

CREATE TABLE s19_followers (
    follower_id INTEGER REFERENCES s19_users(id),
    following_id INTEGER REFERENCES s19_users(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (follower_id, following_id),

    CHECK (follower_id <> following_id)
);

-- 3. Insert sample users
INSERT INTO s19_users (username)
VALUES
('arun'),
('priya'),
('kavin');

-- 4. Add followers
INSERT INTO s19_followers (follower_id, following_id)
VALUES
(1, 2),
(2, 1),
(3, 1),
(1, 3);

-- 5. Display all followers and followed users
SELECT
    follower.username AS follower,
    following.username AS following
FROM s19_followers
JOIN s19_users AS follower
    ON s19_followers.follower_id = follower.id
JOIN s19_users AS following
    ON s19_followers.following_id = following.id;

-- 6. Find followers of a particular user
SELECT follower.username
FROM s19_followers
JOIN s19_users AS follower
    ON s19_followers.follower_id = follower.id
WHERE s19_followers.following_id = 1;

-- 7. Find users followed by a particular user
SELECT following.username
FROM s19_followers
JOIN s19_users AS following
    ON s19_followers.following_id = following.id
WHERE s19_followers.follower_id = 1;

-- 8. Unfollow a user
DELETE FROM s19_followers
WHERE follower_id = 1
AND following_id = 2;
