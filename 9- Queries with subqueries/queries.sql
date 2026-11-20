SELECT name,price
FROM products
WHERE price>(
    SELECT MAX(price)
    FROM products
    WHERE department='Toys'
);

SELECT product_id,COUNT(*)
FROM orders
GROUP BY product_id;

SELECT paid 
FROM orders
WHERE id IN (3,4,5);

SELECT name,price_weight_ratio
FROM(
SELECT name,price/weight AS price_weight_ratio
FROM products) AS p
WHERE price_weight_ratio>20;

SELECT AVG(order_count)
FROM(
    SELECT user_id,COUNT(*) AS order_count
    FROM orders
    GROUP BY user_id
)AS P;

SELECT first_name
FROM users
JOIN(
    SELECT user_id
    FROM orders
    WHERE product_id=3
)AS o
ON o.user_id=users.id;

SELECT id
FROM orders
WHERE product_id IN(
    SELECT id 
    FROM products 
    WHERE price/weight>50
    );

SELECT name
FROM products
WHERE price>(
    SELECT AVG(price)
    FROM products
);

SELECT name,department
FROM products
WHERE department NOT IN(
    SELECT department 
    FROM products
    WHERE price<100
);

SELECT name,department,price
FROM products
WHERE price>ALL(
    SELECT price
    FROM products
    WHERE department='Industrial'
);

SELECT name,department,price
FROM products
WHERE price > SOME(
    SELECT price
    FROM products
    WHERE department='Industrial'
);

SELECT name,department,price
FROM products AS p1
WHERE p1.price=(
    SELECT MAX(price)
    FROM products AS p2
    WHERE p2.department=p1.department
);

SELECT p1.name,(
    SELECT COUNT(*)
    FROM orders AS o1
    WHERE o1.product_id=p1.id
) AS num_orders
FROM products AS p1;

SELECT (
    SELECT MAX(price)FROM products
),(SELECT MIN(price)FROM products);
