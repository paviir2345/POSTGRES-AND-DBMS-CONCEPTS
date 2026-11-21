


-- 1. Create accounts table
CREATE TABLE s30_accounts (
    id SERIAL PRIMARY KEY,
    account_name VARCHAR(50) NOT NULL,
    balance NUMERIC(10,2) NOT NULL CHECK (balance >= 0)
);

-- 2. Insert sample data
INSERT INTO s30_accounts (account_name, balance)
VALUES
('Arun', 1000),
('Priya', 500);

-- 3. Display initial balances
SELECT * FROM s30_accounts;

-- 4. Start a transaction
BEGIN;

-- Transfer 200 from Arun to Priya
UPDATE s30_accounts
SET balance = balance - 200
WHERE id = 1;

UPDATE s30_accounts
SET balance = balance + 200
WHERE id = 2;

-- Check changes before saving
SELECT * FROM s30_accounts;

-- 5. Save the transaction permanently
COMMIT;

-- Verify updated balances
SELECT * FROM s30_accounts;

-- 6. Demonstrate ROLLBACK
BEGIN;

UPDATE s30_accounts
SET balance = balance - 100
WHERE id = 1;

-- Cancel the transaction
ROLLBACK;

-- Balances return to their previous values
SELECT * FROM s30_accounts;

-- 7. Demonstrate SAVEPOINT
BEGIN;

UPDATE s30_accounts
SET balance = balance - 50
WHERE id = 1;

SAVEPOINT before_second_update;

UPDATE s30_accounts
SET balance = balance + 50
WHERE id = 2;

-- Undo changes made after the savepoint
ROLLBACK TO SAVEPOINT before_second_update;

-- Save the remaining transaction
COMMIT;

SELECT * FROM s30_accounts;

-- 8. Clean up
DROP TABLE s30_accounts;
