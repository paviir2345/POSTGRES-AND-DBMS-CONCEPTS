(
    SELECT * FROM products
    ORDER BY price DESC
    LIMIT 4
)
UNION
(
    SELECT * FROM products
    ORDER BY price / weight DESC
    LIMIT 4
);

-- Union All keeps duplicate rows between sets
(
    SELECT * FROM products
    ORDER BY price DESC
    LIMIT 4
)
UNION ALL
(
    SELECT * FROM products
    ORDER BY price / weight DESC
    LIMIT 4
);

-- Intersect returns only rows common to both query results
(
    SELECT * FROM products
    ORDER BY price DESC
    LIMIT 4
)
INTERSECT
(
    SELECT * FROM products
    ORDER BY price / weight DESC
    LIMIT 4
);

-- Intersect All keeps duplicate pairs 
(
    SELECT * FROM products
    ORDER BY price DESC
    LIMIT 4
)
INTERSECT ALL
(
    SELECT * FROM products
    ORDER BY price / weight DESC
    LIMIT 4
);

