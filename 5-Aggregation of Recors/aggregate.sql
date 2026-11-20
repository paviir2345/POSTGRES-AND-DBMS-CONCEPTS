-- 1. GROUP BY
SELECT photo_id
FROM comments
GROUP BY photo_id;

-- 2. COUNT(*)
SELECT photo_id, COUNT(*) AS num_comments
FROM comments
GROUP BY photo_id;

-- 3. Aggregate functions 
SELECT
    COUNT(*)           AS total_comments,
    MIN(photo_id)      AS min_photo_id,
    MAX(photo_id)      AS max_photo_id,
    AVG(photo_id)      AS avg_photo_id
FROM comments;

-- ─── 4. COUNT with GROUP BY: comments per photo ──────────────
SELECT photo_id, COUNT(*) AS comment_count
FROM comments
GROUP BY photo_id;

-- 5. COUNT corner case: COUNT(*) vs COUNT(column) 
SELECT COUNT(*) AS all_rows, COUNT(user_id) AS non_null_user_ids
FROM comments;

-- 6. GROUP BY user_id
SELECT user_id, COUNT(*) AS num_comments_created
FROM comments
GROUP BY user_id;

-- 7. Exercise: 
SELECT author_id, COUNT(*) AS num_books
FROM books
GROUP BY author_id;

-- 8. JOIN + GROUP BY
SELECT authors.name, COUNT(*) AS num_books
FROM books
JOIN authors ON authors.id = books.author_id
GROUP BY authors.name;

-- 9. HAVING: filter groups 
SELECT photo_id, COUNT(*) AS comment_count
FROM comments
WHERE photo_id < 3
GROUP BY photo_id
HAVING COUNT(*) > 2;

-- 10. HAVING users who commented on the first 2 photos 
SELECT user_id, COUNT(*) AS comment_count
FROM comments
WHERE photo_id <= 2
GROUP BY user_id
HAVING COUNT(*) >= 2;

-- 11. More on HAVING
SELECT user_id, COUNT(*) AS comment_count
FROM comments
WHERE photo_id IN (3, 4)
GROUP BY user_id
HAVING COUNT(*) > 1;

-- 12. Exercise: phones with manufacturer that sold > 50000 
SELECT manufacturer, SUM(units_sold) AS total_units
FROM phones
GROUP BY manufacturer
HAVING SUM(units_sold) > 50000;

-- 13. Exercise solution: manufacturer and total revenue 
SELECT manufacturer, SUM(price * units_sold) AS total_revenue
FROM phones
GROUP BY manufacturer;

-- 14. MIN and MAX by manufacturer 
SELECT manufacturer,
       MIN(price) AS cheapest,
       MAX(price) AS most_expensive,
       AVG(price) AS avg_price
FROM phones
GROUP BY manufacturer;
