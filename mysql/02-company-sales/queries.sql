-- ==========================================================
-- OPERATIONS & DDL/DML EXERCISES: COMPANY SALES DATABASE
-- ==========================================================

USE SALES_DB;

-- ----------------------------------------------------------
-- 1. DATA RETRIEVAL (DQL) EXERCISES
-- ----------------------------------------------------------

-- A. Retrieve the names of all clients
SELECT NAME FROM CLIENT_MASTER;

-- B. Find clients residing in 'Bombay' with balance due greater than 0
SELECT NAME, CITY, BALDUE
FROM CLIENT_MASTER
WHERE CITY = 'Bombay' AND BALDUE > 0.00;

-- C. Calculate profit margin for each product
-- Displays description, sell price, cost price, and absolute profit margin
SELECT DESCRIPTION, SELLPRICE, COSTPRICE, 
       (SELLPRICE - COSTPRICE) AS Absolute_Profit,
       PROFIT_PERCENT AS Profit_Percentage
FROM PRODUCT_MASTER;

-- D. Retrieve products that have a high cost and need reordering soon
-- Cost price > 100 and stock on hand is less than reorder level
SELECT PRODUCTNO, DESCRIPTION, QTYONHAND, REORDERLVL, COSTPRICE
FROM PRODUCT_MASTER
WHERE COSTPRICE > 100.00 AND QTYONHAND <= REORDERLVL;

-- ----------------------------------------------------------
-- 2. DATA MANIPULATION (DML) - UPDATE & DELETE
-- ----------------------------------------------------------

-- A. Update the city of client 'Hansel Colaco' to 'Pune'
UPDATE CLIENT_MASTER
SET CITY = 'Pune'
WHERE NAME = 'Hansel Colaco';

-- Verify the update
SELECT CLIENTNO, NAME, CITY FROM CLIENT_MASTER WHERE NAME = 'Hansel Colaco';

-- B. Adjust product cost and sell prices
-- Increase the cost price of 'T-Shirts' by 10% and sell price by 8%
UPDATE PRODUCT_MASTER
SET COSTPRICE = COSTPRICE * 1.10,
    SELLPRICE = SELLPRICE * 1.08
WHERE DESCRIPTION = 'T-Shirts';

-- C. Conditionally remove clients with zero outstanding balances
-- First, let's select them
SELECT CLIENTNO, NAME, BALDUE FROM CLIENT_MASTER WHERE BALDUE = 0.00;

-- Now delete clients where balance due is zero
-- (Commented out by default to preserve sample data, but fully executable)
-- DELETE FROM CLIENT_MASTER WHERE BALDUE = 0.00;

-- ----------------------------------------------------------
-- 3. SCHEMA DYNAMIC EVOLUTION (DDL ALTERATIONS)
-- ----------------------------------------------------------

-- A. Add a new column 'Telephone' to the CLIENT_MASTER table
ALTER TABLE CLIENT_MASTER
ADD COLUMN Telephone VARCHAR(10) NULL;

-- Verify structural change
DESCRIBE CLIENT_MASTER;

-- B. Modify the size of an existing column
-- Increase length of Client Name to accommodate up to 30 characters
ALTER TABLE CLIENT_MASTER
MODIFY COLUMN NAME VARCHAR(30) NOT NULL;

-- Verify structural adjustment
DESCRIBE CLIENT_MASTER;
