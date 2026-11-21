
-- ==========================================
-- SECTION 14: DATABASE-SIDE VALIDATION
-- AND CONSTRAINTS
-- ==========================================


-- 1. THINKING ABOUT VALIDATION
-- Validation makes sure that stored data follows rules.


-- 2. CREATING AND VIEWING TABLES
CREATE TABLE students (
    student_id INTEGER,
    student_name VARCHAR(50),
    age INTEGER
);

-- View table structure using:
-- In pgAdmin, expand Schemas > public > Tables.


-- 3. APPLYING A NOT NULL CONSTRAINT
CREATE TABLE student_details (
    student_id INTEGER NOT NULL,
    student_name VARCHAR(50) NOT NULL,
    email VARCHAR(100)
);

-- Valid insertion
INSERT INTO student_details
VALUES (1, 'Arun', 'arun@example.com');

-- This will fail because student_name is NULL:
-- INSERT INTO student_details
-- VALUES (2, NULL, 'test@example.com');


-- 4. SOLVING A GOTCHA WITH NULL CONSTRAINTS
-- NULL means a value is missing or unknown.
-- NOT NULL prevents missing values in a column.

INSERT INTO student_details
VALUES (3, 'Priya', NULL);

SELECT * FROM student_details;


-- 5. DEFAULT COLUMN VALUES
CREATE TABLE courses (
    course_id INTEGER,
    course_name VARCHAR(50) NOT NULL,
    status VARCHAR(20) DEFAULT 'Active'
);

INSERT INTO courses (course_id, course_name)
VALUES (1, 'PostgreSQL');

SELECT * FROM courses;


-- 6. APPLYING A UNIQUE CONSTRAINT TO ONE COLUMN
CREATE TABLE users (
    user_id INTEGER,
    username VARCHAR(50) UNIQUE,
    email VARCHAR(100)
);

INSERT INTO users
VALUES (1, 'pavi', 'pavi@example.com');

-- This will fail because username already exists:
-- INSERT INTO users
-- VALUES (2, 'pavi', 'another@example.com');


-- 7. MULTI-COLUMN UNIQUENESS
CREATE TABLE course_enrollments (
    enrollment_id INTEGER,
    student_id INTEGER,
    course_id INTEGER,
    UNIQUE (student_id, course_id)
);

INSERT INTO course_enrollments
VALUES (1, 101, 10);

INSERT INTO course_enrollments
VALUES (2, 101, 20);

-- This will fail because the student-course
-- combination already exists:
-- INSERT INTO course_enrollments
-- VALUES (3, 101, 10);


-- 8. ADDING A VALIDATION CHECK
CREATE TABLE products (
    product_id INTEGER,
    product_name VARCHAR(50),
    price NUMERIC(10,2) CHECK (price > 0)
);

INSERT INTO products
VALUES (1, 'Keyboard', 1200.00);

-- This will fail because price must be positive:
-- INSERT INTO products
-- VALUES (2, 'Mouse', -100);


-- 9. CHECKS OVER MULTIPLE COLUMNS
CREATE TABLE discounts (
    discount_id INTEGER,
    original_price NUMERIC(10,2),
    discount_price NUMERIC(10,2),
    CHECK (
        original_price > 0
        AND discount_price >= 0
        AND discount_price <= original_price
    )
);

INSERT INTO discounts
VALUES (1, 1000, 800);

-- This will fail because discount_price
-- is greater than original_price:
-- INSERT INTO discounts
-- VALUES (2, 1000, 1200);


-- 10. WHERE ARE WE APPLYING VALIDATION?
-- Constraints are applied directly to table columns
-- or to the table as a whole.

SELECT * FROM students;
SELECT * FROM student_details;
SELECT * FROM courses;
SELECT * FROM users;
SELECT * FROM course_enrollments;
SELECT * FROM products;
SELECT * FROM discounts;
