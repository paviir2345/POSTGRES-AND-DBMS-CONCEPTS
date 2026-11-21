
-- SECTION 32: SCHEMA VS DATA MIGRATIONS

-- 1. Create the initial posts table
CREATE TABLE s32_posts (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL
);

-- 2. Insert sample posts
INSERT INTO s32_posts (title)
VALUES
('Learning PostgreSQL'),
('Understanding Migrations'),
('Database Design');

SELECT * FROM s32_posts;

-- 3. SCHEMA MIGRATION
-- Add a new column to the table

ALTER TABLE s32_posts
ADD COLUMN description TEXT;

SELECT * FROM s32_posts;

-- 4. DATA MIGRATION
-- Add values to the new column

UPDATE s32_posts
SET description = 'A post about databases'
WHERE id = 1;

UPDATE s32_posts
SET description = 'A post about database changes'
WHERE id = 2;

UPDATE s32_posts
SET description = 'A post about designing databases'
WHERE id = 3;

SELECT * FROM s32_posts;

-- 5. Add another column
ALTER TABLE s32_posts
ADD COLUMN status VARCHAR(20) DEFAULT 'draft';

-- 6. Update existing values
UPDATE s32_posts
SET status = 'published'
WHERE id = 1;

UPDATE s32_posts
SET status = 'published'
WHERE id = 2;

SELECT * FROM s32_posts;

-- 7. Demonstrate transaction for data updates
BEGIN;

UPDATE s32_posts
SET status = 'draft'
WHERE id = 1;

SELECT * FROM s32_posts;

-- Save the changes
COMMIT;

-- 8. Drop the old column after migration
ALTER TABLE s32_posts
DROP COLUMN title;

SELECT * FROM s32_posts;

-- 9. Clean up
DROP TABLE s32_posts;
