

-- 1. CREATE A SAMPLE TABLE

CREATE TABLE s25_orders (
    id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    category VARCHAR(50),
    amount NUMERIC(10,2)
);

-- 2. INSERT SAMPLE DATA

INSERT INTO s25_orders (customer_name, category, amount)
VALUES
('Arun', 'Electronics', 50000),
('Priya', 'Furniture', 12000),
('Kavin', 'Electronics', 30000),
('Divya', 'Clothing', 5000),
('Rahul', 'Furniture', 15000),
('Meena', 'Clothing', 8000);

-- 3. DEVELOPING AN UNDERSTANDING OF COST

EXPLAIN
SELECT *
FROM s25_orders
WHERE category = 'Electronics';

-- 4. CALCULATING COST BY HAND
-- PostgreSQL estimates query costs using
-- page reads and CPU-related operations.
-- Cost values are planner estimates, not milliseconds.

EXPLAIN
SELECT *
FROM s25_orders
WHERE amount > 10000;

-- 5. A TOUCH MORE ON COSTS

EXPLAIN
SELECT *
FROM s25_orders
WHERE category = 'Furniture'
AND amount > 10000;

-- 6. STARTUP COST VS TOTAL COST

EXPLAIN
SELECT *
FROM s25_orders
ORDER BY amount DESC;

-- 7. COSTS FLOW UP
-- Examine the costs of a query involving a filter
-- and sorting operation.

EXPLAIN
SELECT *
FROM s25_orders
WHERE amount > 5000
ORDER BY amount DESC;

-- 8. CREATE AN INDEX

CREATE INDEX idx_s25_orders_category
ON s25_orders(category);

-- 9. USE MY INDEX!

EXPLAIN
SELECT *
FROM s25_orders
WHERE category = 'Electronics';

-- 10. COMPARE WITH ANALYZE

EXPLAIN ANALYZE
SELECT *
FROM s25_orders
WHERE category = 'Electronics';

-- 11. CREATE ANOTHER INDEX

CREATE INDEX idx_s25_orders_amount
ON s25_orders(amount);

-- 12. CHECK THE QUERY PLAN

EXPLAIN ANALYZE
SELECT *
FROM s25_orders
WHERE amount > 10000;
