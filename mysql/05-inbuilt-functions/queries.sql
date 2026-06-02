-- ==========================================================
-- ANALYTICAL QUERIES: HR EMPLOYEE ANALYTICS
-- ==========================================================

USE HR_ANALYTICS_DB;

-- ----------------------------------------------------------
-- 1. DESCRIPTIVE STATISTICS & METRICS
-- ----------------------------------------------------------

-- A. Calculate the average salary of all employees
SELECT AVG(SAL) AS Average_Salary
FROM EMP;

-- B. Find the total count of registered employees
SELECT COUNT(*) AS Total_Employees
FROM EMP;

-- C. Find the count of unique employee names (handling potential duplicates)
SELECT COUNT(DISTINCT ENAME) AS Unique_Names_Count
FROM EMP;

-- D. Calculate total salary expenditures grouped by job profile
SELECT JOB, SUM(SAL) AS Total_Salary_Expenditure
FROM EMP
-- Groups individuals into profile blocks
GROUP BY JOB;

-- ----------------------------------------------------------
-- 2. DYNAMIC MAXIMUMS & SUBQUERIES
-- ----------------------------------------------------------

-- A. Retrieve details of employees earning the highest overall salary
-- Demonstrates nested aggregate filters
SELECT *
FROM EMP
WHERE SAL = (
    SELECT MAX(SAL) 
    FROM EMP
);

-- B. Find details of the highest paid employee specifically in Department 10
SELECT *
FROM EMP
WHERE DEPTNO = 10
  AND SAL = (
      SELECT MAX(SAL) 
      FROM EMP 
      WHERE DEPTNO = 10
  );

-- C. Find employees whose salary matches exactly the midpoint between the minimum and maximum salary
SELECT *
FROM EMP
WHERE SAL = (
    SELECT (MAX(SAL) + MIN(SAL)) / 2 
    FROM EMP
);

-- ----------------------------------------------------------
-- 3. SELF-JOIN COORDINATIONS
-- ----------------------------------------------------------

-- A. Retrieve pairs of employees hired on the EXACT SAME hiredate
-- Utilizes an inner self-join while ensuring distinct primary keys
SELECT E1.ENAME AS Employee_1, E2.ENAME AS Employee_2, E1.HIREDATE
FROM EMP E1
JOIN EMP E2 ON E1.HIREDATE = E2.HIREDATE AND E1.EMPNO < E2.EMPNO
ORDER BY E1.HIREDATE;

-- ----------------------------------------------------------
-- 4. SCALAR SCALING & DATE ARITHMETIC
-- ----------------------------------------------------------

-- A. Perform case-folding operations on employee names
SELECT ENAME,
       UPPER(ENAME) AS Upper_Case,
       LOWER(ENAME) AS Lower_Case
FROM EMP;

-- B. Perform date operations: calculate the day exactly 3 days after each employee's hire date
SELECT ENAME, HIREDATE,
       DATE_ADD(HIREDATE, INTERVAL 3 DAY) AS Date_After_3_Days
FROM EMP;
