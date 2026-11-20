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


'''

ecommerce-# \i session9.sql
           name           | price
--------------------------+-------
 Incredible Granite Mouse |   989
 Practical Rubber Mouse   |   948
 Handmade Rubber Chicken  |   959
 Awesome Fresh Keyboard   |   982
 Incredible Granite Bacon |   982
 Fantastic Fresh Chips    |   966
 Small Fresh Gloves       |   991
(7 rows)

 product_id | count
------------+-------
         55 |     3
         27 |     4
         23 |     7
         56 |     7
         91 |     3
         58 |     5
          8 |     7
         87 |    10
         74 |     4
         29 |     7
         54 |     6
         71 |     3
          4 |     4
         68 |     7
         34 |     8
         51 |     5
         96 |     8
         70 |     6
         52 |    11
         80 |     6
         83 |     2
         67 |     4
         63 |     4
         10 |     4
         90 |     6
         35 |     3
         45 |     3
          6 |    12
         86 |     4
         84 |     5
         39 |     5
         92 |     5
         93 |     3
         89 |     6
         36 |     7
         69 |     5
         31 |     6
         50 |     2
         60 |    10
         14 |     2
         97 |     7
         66 |    10
         22 |     9
         59 |     5
         13 |     7
         65 |     3
          2 |     4
         16 |     7
         62 |     3
         75 |     6
         98 |     6
         73 |     3
         11 |     8
         44 |     7
         42 |     4
         99 |     5
         88 |     8
         82 |     4
         41 |     5
         40 |     4
         46 |     9
         43 |     6
         32 |     4
         53 |     7
          7 |     2
          9 |     4
        100 |     4
         38 |     6
         15 |    11
         79 |     3
         48 |     5
         26 |     3
         12 |     6
         85 |     7
         72 |     5
         95 |    10
         78 |     1
         24 |     7
         57 |     4
         61 |     2
         19 |     3
         81 |     4
         77 |     4
         25 |     6
         94 |     2
         30 |     7
         21 |     5
         49 |     2
         47 |     6
          3 |     5
         17 |     8
         37 |     7
         28 |     8
         20 |     5
         33 |     6
          1 |     7
         76 |     6
          5 |     4
         18 |     9
         64 |     6
(100 rows)

 paid
------
 f
 t
 t
(3 rows)

            name             | price_weight_ratio
-----------------------------+--------------------
 Practical Fresh Shirt       |                292
 Gorgeous Steel Towels       |                 25
 Tasty Wooden Ball           |                 34
 Gorgeous Concrete Towels    |                 29
 Incredible Granite Mouse    |                494
 Gorgeous Rubber Ball        |                200
 Generic Fresh Computer      |                 84
 Fantastic Metal Chair       |                 98
 Ergonomic Metal Pizza       |                 28
 Licensed Steel Car          |                 66
 Tasty Metal Cheese          |                 38
 Handcrafted Rubber Towels   |                157
 Intelligent Metal Mouse     |                 72
 Practical Concrete Sausages |                 45
 Handcrafted Frozen Chair    |                 25
 Generic Cotton Pizza        |                138
 Small Plastic Soap          |                345
 Small Wooden Pizza          |                 43
 Rustic Rubber Soap          |                 63
 Handmade Plastic Gloves     |                 30
 Unbranded Cotton Tuna       |                 63
 Sleek Granite Towels        |                 26
 Practical Rubber Mouse      |                 63
 Handcrafted Concrete Bike   |                 74
 Unbranded Wooden Ball       |                192
 Licensed Frozen Chair       |                 46
 Handmade Rubber Chicken     |                 43
 Awesome Fresh Keyboard      |                 32
 Generic Fresh Hat           |                 31
 Licensed Plastic Keyboard   |                 25
 Fantastic Steel Chicken     |                 27
 Tasty Rubber Soap           |                137
 Refined Wooden Mouse        |                 56
 Gorgeous Steel Cheese       |                 60
 Incredible Granite Bacon    |                109
 Intelligent Fresh Ball      |                 68
 Handcrafted Cotton Bacon    |                 40
 Sleek Rubber Shoes          |                 99
 Practical Wooden Chips      |                176
 Unbranded Granite Shirt     |                 39
 Gorgeous Plastic Sausages   |                278
 Awesome Steel Mouse         |                 35
 Licensed Steel Towels       |                 40
 Licensed Cotton Sausages    |                 27
 Ergonomic Fresh Pants       |                 21
 Handcrafted Frozen Shoes    |                 84
 Small Concrete Pants        |                 25
 Intelligent Plastic Car     |                 48
 Intelligent Cotton Chips    |                 23
 Sleek Soft Computer         |                 88
 Fantastic Fresh Shirt       |                 37
 Generic Fresh Shoes         |                 21
 Sleek Fresh Gloves          |                 61
 Handcrafted Soft Chicken    |                 90
 Fantastic Fresh Chips       |                 69
 Awesome Metal Pants         |                 57
 Handcrafted Frozen Chips    |                 29
 Gorgeous Plastic Gloves     |                 24
 Small Fresh Gloves          |                123
 Small Fresh Bacon           |                 47
 Unbranded Fresh Tuna        |                 73
 Refined Concrete Pants      |                362
 Licensed Plastic Salad      |                166
 Licensed Soft Chicken       |                 32
 Fantastic Granite Soap      |                 22
 Awesome Steel Towels        |                 55
 Ergonomic Wooden Tuna       |                 26
 Refined Metal Tuna          |                 30
 Practical Steel Shoes       |                 67
 Handcrafted Rubber Shoes    |                 45
(70 rows)
