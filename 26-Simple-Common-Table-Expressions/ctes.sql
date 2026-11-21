

CREATE TABLE s26_orders (
    id SERIAL PRIMARY KEY,
    customer_name VARCHAR(50),
    amount NUMERIC(10,2)
);

-- 2. INSERT SAMPLE DATA

INSERT INTO s26_orders (customer_name, amount)
VALUES
('Arun', 5000),
('Priya', 8000),
('Kavin', 3000),
('Divya', 10000),
('Rahul', 2000);

-- 3. RETRIEVE ALL ORDERS

SELECT *
FROM s26_orders;

-- 4. BASIC CTE
-- A CTE is a temporary named result
-- that can be used within a query.

WITH high_value_orders AS (
    SELECT *
    FROM s26_orders
    WHERE amount > 5000
)
SELECT *
FROM high_value_orders;

-- 5. CTE WITH SELECTED COLUMNS

WITH customer_orders AS (
    SELECT customer_name, amount
    FROM s26_orders
)
SELECT *
FROM customer_orders;

-- 6. CTE WITH AGGREGATE FUNCTION

WITH total_orders AS (
    SELECT SUM(amount) AS total_amount
    FROM s26_orders
)
SELECT *
FROM total_orders;

-- 7. CTE WITH GROUP BY

WITH customer_totals AS (
    SELECT
        customer_name,
        SUM(amount) AS total_amount
    FROM s26_orders
    GROUP BY customer_name
)
SELECT *
FROM customer_totals
WHERE total_amount > 4000;

-- 8. USING MORE THAN ONE CTE

WITH high_orders AS (
    SELECT *
    FROM s26_orders
    WHERE amount > 4000
),
large_orders AS (
    SELECT *
    FROM high_orders
    WHERE amount > 7000
)
SELECT *
FROM large_orders;
