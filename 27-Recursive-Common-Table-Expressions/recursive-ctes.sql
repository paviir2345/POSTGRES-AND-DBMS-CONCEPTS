
-- ==========================================
-- SECTION 27: RECURSIVE COMMON TABLE EXPRESSIONS
-- ==========================================

-- 1. CREATE EMPLOYEES TABLE

CREATE TABLE s27_employees (
    id SERIAL PRIMARY KEY,
    employee_name VARCHAR(50) NOT NULL,
    manager_id INTEGER REFERENCES s27_employees(id)
);

-- 2. INSERT SAMPLE DATA

INSERT INTO s27_employees (employee_name, manager_id)
VALUES
('Arun', NULL),
('Priya', 1),
('Kavin', 1),
('Divya', 2),
('Rahul', 2);

-- 3. VIEW ALL EMPLOYEES

SELECT *
FROM s27_employees;

-- 4. BASIC RECURSIVE CTE
-- Display numbers from 1 to 10.

WITH RECURSIVE number_series AS (
    SELECT 1 AS number

    UNION ALL

    SELECT number + 1
    FROM number_series
    WHERE number < 10
)
SELECT *
FROM number_series;

-- 5. RECURSIVE CTE FOR EMPLOYEE HIERARCHY
-- Start with the top-level employee
-- and find their employees recursively.

WITH RECURSIVE employee_hierarchy AS (
    -- Anchor query
    SELECT
        id,
        employee_name,
        manager_id,
        1 AS level
    FROM s27_employees
    WHERE manager_id IS NULL

    UNION ALL

    -- Recursive query
    SELECT
        e.id,
        e.employee_name,
        e.manager_id,
        eh.level + 1
    FROM s27_employees e
    JOIN employee_hierarchy eh
        ON e.manager_id = eh.id
)
SELECT *
FROM employee_hierarchy
ORDER BY level, id;

-- 6. DISPLAY EMPLOYEE HIERARCHY WITH INDENTATION

WITH RECURSIVE employee_hierarchy AS (
    SELECT
        id,
        employee_name,
        manager_id,
        1 AS level
    FROM s27_employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT
        e.id,
        e.employee_name,
        e.manager_id,
        eh.level + 1
    FROM s27_employees e
    JOIN employee_hierarchy eh
        ON e.manager_id = eh.id
)
SELECT
    repeat('  ', level - 1) || employee_name AS hierarchy,
    level
FROM employee_hierarchy
ORDER BY level, id;
