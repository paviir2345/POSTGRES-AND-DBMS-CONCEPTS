
-- ==========================================
-- SECTION 23: A LOOK AT INDEXES FOR PERFORMANCE
-- ==========================================

-- 1. CREATE A SAMPLE TABLE

CREATE TABLE s23_users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    age INTEGER,
    created_at TIMESTAMP
);

-- 2. INSERT SAMPLE DATA

INSERT INTO s23_users (username, email, age, created_at)
SELECT
    'user' || n,
    'user' || n || '@example.com',
    18 + (n % 40),
    TIMESTAMP '2024-01-01' + n * INTERVAL '1 minute'
FROM generate_series(1, 100000) AS n;

-- 3. FULL TABLE SCAN

EXPLAIN ANALYZE
SELECT *
FROM s23_users
WHERE age = 25;

-- 4. CREATE AN INDEX

CREATE INDEX idx_s23_users_age
ON s23_users(age);

-- 5. CHECK QUERY PERFORMANCE AFTER INDEXING

EXPLAIN ANALYZE
SELECT *
FROM s23_users
WHERE age = 25;

-- 6. INDEX ON USERNAME

CREATE INDEX idx_s23_users_username
ON s23_users(username);

-- Search using username

EXPLAIN ANALYZE
SELECT *
FROM s23_users
WHERE username = 'user500';

-- 7. COMPOSITE INDEX

CREATE INDEX idx_s23_users_age_username
ON s23_users(age, username);

-- Query using both indexed columns

EXPLAIN ANALYZE
SELECT *
FROM s23_users
WHERE age = 25
AND username = 'user500';

-- 8. INDEX TYPES

-- B-TREE INDEX (default index type)
CREATE INDEX idx_s23_btree
ON s23_users USING BTREE(age);

-- HASH INDEX
CREATE INDEX idx_s23_hash
ON s23_users USING HASH(username);

-- BRIN INDEX
CREATE INDEX idx_s23_brin
ON s23_users USING BRIN(created_at);

-- 9. AUTOMATICALLY GENERATED INDEXES

-- PRIMARY KEY and UNIQUE constraints
-- automatically create unique indexes.

SELECT indexname, indexdef
FROM pg_indexes
WHERE tablename = 's23_users';

-- 10. VIEW INDEX INFORMATION

SELECT
    indexrelname,
    idx_scan,
    idx_tup_read,
    idx_tup_fetch
FROM pg_stat_user_indexes
WHERE relname = 's23_users';

-- 11. DOWNSIDES OF INDEXES

-- Indexes require storage space and
-- can slow down INSERT, UPDATE and DELETE.

-- Remove an index when it is no longer needed.

DROP INDEX idx_s23_users_age_username;
