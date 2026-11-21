
-- ==========================================
-- SECTION 29: MATERIALIZED VIEWS
-- ==========================================

-- 1. CREATE USERS TABLE

CREATE TABLE s29_users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL
);

-- 2. CREATE ORDERS TABLE

CREATE TABLE s29_orders (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES s29_users(id),
    amount NUMERIC(10,2),
    order_date TIMESTAMP
);

-- 3. INSERT SAMPLE USERS

INSERT INTO s29_users (username)
VALUES
('Arun'),
('Priya'),
('Kavin'),
('Divya');

-- 4. INSERT SAMPLE ORDERS

INSERT INTO s29_orders (user_id, amount, order_date)
VALUES
(1, 5000, '2026-01-05'),
(1, 3000, '2026-01-08'),
(2, 7000, '2026-01-12'),
(2, 2000, '2026-01-15'),
(3, 4000, '2026-01-20'),
(1, 6000, '2026-01-26');

-- 5. GROUP ORDERS BY WEEK

SELECT
    DATE_TRUNC('week', order_date) AS week,
    SUM(amount) AS total_sales
FROM s29_orders
GROUP BY DATE_TRUNC('week', order_date)
ORDER BY week;

-- 6. REMINDER: USING LEFT JOIN

-- Displays all users, including users
-- who have not placed any orders.

SELECT
    s29_users.username,
    s29_orders.amount
FROM s29_users
LEFT JOIN s29_orders
ON s29_users.id = s29_orders.user_id;

-- 7. COUNT ORDERS FOR EACH USER

SELECT
    s29_users.username,
    COUNT(s29_orders.id) AS total_orders
FROM s29_users
LEFT JOIN s29_orders
ON s29_users.id = s29_orders.user_id
GROUP BY s29_users.id, s29_users.username;

-- 8. EXAMPLE OF A CORRELATED SUBQUERY
-- This repeats a subquery for each user.
-- It can be inefficient on large datasets.

SELECT
    username,
    (
        SELECT SUM(amount)
        FROM s29_orders
        WHERE s29_orders.user_id = s29_users.id
    ) AS total_spent
FROM s29_users;

-- 9. ALTERNATIVE USING LEFT JOIN

SELECT
    s29_users.username,
    COALESCE(SUM(s29_orders.amount), 0) AS total_spent
FROM s29_users
LEFT JOIN s29_orders
ON s29_users.id = s29_orders.user_id
GROUP BY s29_users.id, s29_users.username;

-- 10. CREATE A MATERIALIZED VIEW

CREATE MATERIALIZED VIEW s29_weekly_sales AS
SELECT
    DATE_TRUNC('week', order_date) AS week,
    SUM(amount) AS total_sales
FROM s29_orders
GROUP BY DATE_TRUNC('week', order_date);

-- 11. VIEW MATERIALIZED VIEW DATA

SELECT *
FROM s29_weekly_sales
ORDER BY week;

-- 12. INSERT A NEW ORDER

INSERT INTO s29_orders (user_id, amount, order_date)
VALUES (2, 9000, '2026-02-02');

-- 13. VIEW BEFORE REFRESHING

-- The materialized view still contains
-- the previously stored results.

SELECT *
FROM s29_weekly_sales;

-- 14. REFRESH MATERIALIZED VIEW

REFRESH MATERIALIZED VIEW s29_weekly_sales;

-- 15. VIEW UPDATED RESULTS

SELECT *
FROM s29_weekly_sales
ORDER BY week;

-- 16. DELETE MATERIALIZED VIEW

DROP MATERIALIZED VIEW s29_weekly_sales;
