
-- SECTION 10: SELECTING DISTINCT RECORDS

-- Display unique phone manufacturers
SELECT DISTINCT manufacturer
FROM phones;

-- Count unique phone manufacturers
SELECT COUNT(*)
FROM (
    SELECT DISTINCT manufacturer
    FROM phones
) AS unique_manufacturers;

