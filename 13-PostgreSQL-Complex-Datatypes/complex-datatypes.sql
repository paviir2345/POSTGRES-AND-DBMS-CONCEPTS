
-- ==========================================
-- SECTION 13: POSTGRESQL COMPLEX DATATYPES
-- ==========================================

-- 1. DATA TYPES
-- PostgreSQL supports different types of data.

SELECT
    100::INTEGER AS integer_value,
    25.50::NUMERIC(6,2) AS numeric_value,
    'Hello PostgreSQL'::TEXT AS text_value;


-- 2. FAST RULES ON NUMERIC DATA TYPES

-- INTEGER: Whole numbers
-- SMALLINT: Smaller range of whole numbers
-- BIGINT: Larger range of whole numbers
-- NUMERIC: Exact decimal values
-- REAL and DOUBLE PRECISION: Approximate decimal values

SELECT
    100::SMALLINT AS small_number,
    25000::INTEGER AS normal_number,
    9000000000::BIGINT AS large_number,
    123.45::NUMERIC(6,2) AS exact_decimal,
    12.5::REAL AS real_number,
    12.5::DOUBLE PRECISION AS double_number;


-- 3. MORE ON NUMBER DATA TYPES

-- NUMERIC stores exact decimal values.

SELECT
    10.25::NUMERIC + 5.50::NUMERIC AS total;

-- Division with numeric values
SELECT
    10::NUMERIC / 3::NUMERIC AS division_result;

-- Rounding a numeric value
SELECT
    ROUND(15.678::NUMERIC, 2) AS rounded_value;


-- 4. REMINDER ON CHARACTER TYPES

SELECT
    'PostgreSQL'::CHAR(15) AS fixed_length_text,
    'PostgreSQL'::VARCHAR(20) AS variable_length_text,
    'PostgreSQL'::TEXT AS text_value;


-- 5. BOOLEAN DATA TYPES

SELECT
    TRUE AS true_value,
    FALSE AS false_value,
    NULL::BOOLEAN AS unknown_value;

-- Boolean comparison
SELECT
    10 > 5 AS comparison_result;


-- 6. TIMES, DATES, AND TIMESTAMPS

SELECT
    CURRENT_DATE AS today,
    CURRENT_TIME AS current_time,
    CURRENT_TIMESTAMP AS current_timestamp;

-- Creating date and time values
SELECT
    DATE '2026-11-21' AS sample_date,
    TIME '10:30:00' AS sample_time,
    TIMESTAMP '2026-11-21 10:30:00' AS sample_timestamp;

-- Adding days to a date
SELECT
    DATE '2026-11-21' + 7 AS date_after_seven_days;


-- 7. REALLY AWESOME INTERVALS

-- INTERVAL represents a duration of time.

SELECT
    INTERVAL '2 days' AS two_days,
    INTERVAL '3 hours' AS three_hours,
    INTERVAL '2 months' AS two_months;

-- Adding an interval to a date
SELECT
    DATE '2026-11-21' + INTERVAL '5 days' AS future_date;

-- Adding an interval to a timestamp
SELECT
    TIMESTAMP '2026-11-21 10:00:00'
    + INTERVAL '2 hours' AS future_timestamp;

-- Combining different interval units
SELECT
    INTERVAL '2 days 3 hours 30 minutes' AS combined_interval;


-- 8. PRACTICE TABLE USING DIFFERENT DATA TYPES

CREATE TABLE datatype_practice (
    id INTEGER,
    student_name VARCHAR(50),
    marks NUMERIC(5,2),
    is_passed BOOLEAN,
    joining_date DATE,
    joining_time TIME,
    created_at TIMESTAMP,
    course_duration INTERVAL
);

-- Insert sample records
INSERT INTO datatype_practice
VALUES (
    1,
    'Arun',
    89.50,
    TRUE,
    DATE '2026-11-21',
    TIME '09:30:00',
    TIMESTAMP '2026-11-21 09:30:00',
    INTERVAL '6 months'
);

-- Retrieve the records
SELECT * FROM datatype_practice;
