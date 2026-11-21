
-- SECTION 11: UTILITY OPERATORS, KEYWORDS AND FUNCTIONS
-- Dataset: products.csv

-- 1. GREATEST function
-- Returns the greatest value from the given values
SELECT GREATEST(20, 10, 30);

-- 2. Calculate shipping cost
SELECT
    name,
    weight,
    GREATEST(30, 2 * weight) AS shipping_cost
FROM products;

-- 3. LEAST function
-- Returns the smallest value from the given values
SELECT LEAST(1, 20, 50, 100);

-- 4. Calculate discounted price with a maximum limit
SELECT
    name,
    price,
    LEAST(price * 0.5, 50) AS discount_price
FROM products;

-- 5. CASE statement
-- Categorize products based on their price
SELECT
    name,
    price,
    CASE
        WHEN price > 100 THEN 'high'
        WHEN price > 40 THEN 'medium'
        ELSE 'cheap'
    END AS price_category
FROM products;
