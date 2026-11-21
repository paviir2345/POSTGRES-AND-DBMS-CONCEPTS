

CREATE TABLE s24_products (
    id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price NUMERIC(10,2)
);

-- 2. INSERT SAMPLE DATA

INSERT INTO s24_products (product_name, category, price)
VALUES
('Laptop', 'Electronics', 55000),
('Phone', 'Electronics', 25000),
('Keyboard', 'Accessories', 1500),
('Mouse', 'Accessories', 800),
('Monitor', 'Electronics', 12000),
('Chair', 'Furniture', 5000);

-- 3. BASIC QUERY

SELECT *
FROM s24_products
WHERE category = 'Electronics';

-- 4. EXPLAIN
-- Shows the query execution plan without
-- actually executing the query.

EXPLAIN
SELECT *
FROM s24_products
WHERE category = 'Electronics';

-- 5. EXPLAIN ANALYZE
-- Executes the query and shows actual
-- execution time and plan details.

EXPLAIN ANALYZE
SELECT *
FROM s24_products
WHERE category = 'Electronics';

-- 6. CREATE AN INDEX

CREATE INDEX idx_s24_products_category
ON s24_products(category);

-- 7. CHECK THE QUERY PLAN AFTER INDEXING

EXPLAIN
SELECT *
FROM s24_products
WHERE category = 'Electronics';

-- 8. CHECK ACTUAL QUERY PERFORMANCE

EXPLAIN ANALYZE
SELECT *
FROM s24_products
WHERE category = 'Electronics';

-- 9. QUERY USING A DIFFERENT CONDITION

EXPLAIN ANALYZE
SELECT *
FROM s24_products
WHERE price > 10000;

-- 10. SORTING QUERY

EXPLAIN ANALYZE
SELECT *
FROM s24_products
ORDER BY price DESC;
