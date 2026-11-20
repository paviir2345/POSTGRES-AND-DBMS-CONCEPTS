--SECTION 3: Working with Table

-- 1. Create users table with SERIAL primary key 
CREATE TABLE users (
    id       SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL
);

-- 2. Insert users 
INSERT INTO users (username)
VALUES ('Monahan93'),
       ('Pfeffer_Old'),
       ('Ernestine_Psi'),
       ('Zedrick99');

SELECT * FROM users;

-- 3. Create photos table with foreign key
CREATE TABLE photos (
    id      SERIAL PRIMARY KEY,
    url     VARCHAR(200),
    user_id INTEGER REFERENCES users(id)
);

-- 4. Insert photos (FK to users) 
INSERT INTO photos (url, user_id)
VALUES ('http://one.jpg',    4),
       ('http://two.jpg',    4),
       ('http://three.jpg',  1),
       ('http://four.jpg',   2),
       ('http://five.jpg',   1),
       ('http://six.jpg',    3),
       ('http://seven.jpg',  4);


SELECT * FROM photos;

-- 5. Query photos by specific user 
SELECT * FROM photos
WHERE user_id = 4;

-- 6. Create comments table referencing both users and photos
CREATE TABLE comments (
    id       SERIAL PRIMARY KEY,
    contents VARCHAR(240),
    user_id  INTEGER REFERENCES users(id),
    photo_id INTEGER REFERENCES photos(id)
);

--  7. Insert comments 
INSERT INTO comments (contents, user_id, photo_id)
VALUES ('Awesome photo!',       1, 1),
       ('Love this pic',        2, 1),
       ('Great shot',           3, 2),
       ('So beautiful',         4, 3),
       ('Nice composition',     1, 4),
       ('Incredible!',          2, 5),
       ('Who took this?',       3, 6),
       ('Stunning colors',      4, 7),
       ('Where is this?',       1, 2),
       ('I was there!',         2, 3);


SELECT * FROM comments;

-- Drop and recreate photos with ON DELETE CASCADE
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS photos;

CREATE TABLE photos (
    id      SERIAL PRIMARY KEY,
    url     VARCHAR(200),
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE
);

INSERT INTO photos (url, user_id)
VALUES ('http://one.jpg',    4),
       ('http://two.jpg',    4),
       ('http://three.jpg',  1),
       ('http://four.jpg',   2),
       ('http://five.jpg',   1),
       ('http://six.jpg',    3),
       ('http://seven.jpg',  4);

-- Now delete a user — their photos cascade-delete too
DELETE FROM users WHERE id = 4;

SELECT * FROM photos; 

-- Re-insert user 4 and photos 
INSERT INTO users (username) VALUES ('Zedrick99');   

-- ON DELETE SET NULL demonstration
DROP TABLE IF EXISTS photos;

CREATE TABLE photos (
    id      SERIAL PRIMARY KEY,
    url     VARCHAR(200),
    user_id INTEGER REFERENCES users(id) ON DELETE SET NULL
);

INSERT INTO photos (url, user_id)
VALUES ('http://one.jpg',  1),
       ('http://two.jpg',  2),
       ('http://three.jpg',3);

DELETE FROM users WHERE id = 1;

SELECT * FROM photos;

-- Restore clean state 
DROP TABLE IF EXISTS photos;

CREATE TABLE photos (
    id      SERIAL PRIMARY KEY,
    url     VARCHAR(200),
    user_id INTEGER REFERENCES users(id)
);

INSERT INTO photos (url, user_id)
VALUES ('http://one.jpg',    2),
       ('http://two.jpg',    2),
       ('http://three.jpg',  3),
       ('http://four.jpg',   2),
       ('http://five.jpg',   3);

CREATE TABLE comments (
    id       SERIAL PRIMARY KEY,
    contents VARCHAR(240),
    user_id  INTEGER REFERENCES users(id),
    photo_id INTEGER REFERENCES photos(id)
);

INSERT INTO comments (contents, user_id, photo_id)
VALUES ('Awesome photo!',   2, 1),
       ('Love this pic',    3, 1),
       ('Great shot',       2, 2),
       ('So beautiful',     3, 3),
       ('Nice composition', 2, 4),
       ('Incredible!',      3, 5);
