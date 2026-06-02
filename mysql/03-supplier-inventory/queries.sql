-- ==========================================================
-- ANALYTICAL QUERIES: SUPPLIER INVENTORY SYSTEM
-- ==========================================================

USE SUPPLIER_DB;

-- ----------------------------------------------------------
-- 1. SELECTION FILTERS & COUNTING
-- ----------------------------------------------------------

-- A. Retrieve all suppliers located in 'Bombay' with a turnover of 50
SELECT scode, sname, scity, turnover
FROM Supplier
WHERE scity = 'Bombay' AND turnover = 50.00;

-- B. Find suppliers who have an unrecorded (NULL) turnover
SELECT scode, sname, scity
FROM Supplier
WHERE turnover IS NULL;

-- C. Count the total number of registered suppliers
SELECT COUNT(*) AS Total_Suppliers
FROM Supplier;

-- ----------------------------------------------------------
-- 2. RANGE MATCHING & SETS
-- ----------------------------------------------------------

-- A. Retrieve parts whose weight falls between 25 and 35
SELECT pcode, weigh, color
FROM Part
WHERE weigh BETWEEN 25 AND 35;

-- B. Find parts whose cost matches exactly 20, 30, or 40
SELECT pcode, color, cost
FROM Part
WHERE cost IN (20.00, 30.00, 40.00);

-- ----------------------------------------------------------
-- 3. AGGREGATIONS & ORDERING
-- ----------------------------------------------------------

-- A. Calculate the total quantity supplied for part 'P2'
SELECT SUM(qty) AS Total_P2_Quantity
FROM Supplier_Part
WHERE pcode = 'P2';

-- B. Retrieve supplier codes and turnovers sorted in descending order of turnover
SELECT scode, turnover
FROM Supplier
ORDER BY turnover DESC;

-- ----------------------------------------------------------
-- 4. INTERMEDIATE NESTED SUBQUERIES
-- ----------------------------------------------------------

-- A. Retrieve the names of suppliers who supply part 'P2'
-- Uses a subquery to map matching supplier codes
SELECT sname
FROM Supplier
WHERE scode IN (
    SELECT scode
    FROM Supplier_Part
    WHERE pcode = 'P2'
);

-- B. Find parts whose cost is strictly greater than the average cost of all parts
-- Demonstrates nested scalar subquery evaluation
SELECT pcode, weigh, color, cost
FROM Part
WHERE cost > (
    SELECT AVG(cost)
    FROM Part
);
