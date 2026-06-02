-- ==========================================================
-- ANALYTICAL QUERIES: COMPANY DATABASE
-- ==========================================================

USE COMPANY_DB;

-- ----------------------------------------------------------
-- 1. SIMPLE FILTERS & JOIN PREVIEWS
-- ----------------------------------------------------------

-- A. Retrieve all employees working in Department 5
SELECT Fname, Lname, Ssn, Dno
FROM EMPLOYEE
WHERE Dno = 5;

-- B. Find structural details of the project named 'ProductX'
SELECT *
FROM PROJECT
WHERE Pname = 'ProductX';

-- C. Retrieve assignments in WORKS_ON where hours are greater than 10
SELECT Essn, Pno, Hours
FROM WORKS_ON
WHERE Hours > 10.0;

-- ----------------------------------------------------------
-- 2. MULTI-TABLE JOINS (INNER JOIN)
-- ----------------------------------------------------------

-- Find the names of employees in Department 5 who work more than 10 hours
-- on the project 'ProductX' (requires combining 3 tables: EMPLOYEE, WORKS_ON, PROJECT)
SELECT E.Fname, E.Minit, E.Lname
FROM EMPLOYEE E
JOIN WORKS_ON W ON E.Ssn = W.Essn
JOIN PROJECT P ON W.Pno = P.Pnumber
WHERE E.Dno = 5
  AND W.Hours > 10.0
  AND P.Pname = 'ProductX';

-- ----------------------------------------------------------
-- 3. IDENTITY MATCHES (EMPLOYEES & DEPENDENTS)
-- ----------------------------------------------------------

-- Find employees who have a dependent with the same first name as themselves
SELECT DISTINCT E.Fname, E.Lname, E.Ssn
FROM EMPLOYEE E
JOIN DEPENDENT D ON E.Ssn = D.Essn
WHERE E.Fname = D.Dependent_name;

-- ----------------------------------------------------------
-- 4. RECURSIVE RELATIONSHIPS (SELF-JOIN / SUBQUERIES)
-- ----------------------------------------------------------

-- Retrieve the names of employees supervised directly by 'Franklin Wong'
SELECT Fname, Minit, Lname
FROM EMPLOYEE
WHERE Super_ssn = (
    SELECT Ssn
    FROM EMPLOYEE
    WHERE Fname = 'Franklin' AND Lname = 'Wong'
);

-- ----------------------------------------------------------
-- 5. RELATIONAL DIVISION (UNIVERSAL QUANTIFICATION - "ALL")
-- ----------------------------------------------------------

-- Find the employees who work on EVERY project in the company
-- Solved using double-nested NOT EXISTS (Relational Division)
-- "Find an employee such that there does NOT exist a project in the company
--  which is NOT worked on by this employee."
SELECT E.Fname, E.Lname, E.Ssn
FROM EMPLOYEE E
WHERE NOT EXISTS (
    SELECT P.Pnumber
    FROM PROJECT P
    WHERE NOT EXISTS (
        SELECT 1
        FROM WORKS_ON W
        WHERE W.Essn = E.Ssn
          AND W.Pno = P.Pnumber
    )
);

-- ----------------------------------------------------------
-- 6. SET EXCLUSION (OUTER JOINS / NOT IN)
-- ----------------------------------------------------------

-- Find the names of employees who do NOT work on any project
SELECT Fname, Minit, Lname
FROM EMPLOYEE
WHERE Ssn NOT IN (
    SELECT DISTINCT Essn
    FROM WORKS_ON
);

-- ----------------------------------------------------------
-- 7. LOCATION CONSTRAINTS (SET CORRELATION & SUBQUERIES)
-- ----------------------------------------------------------

-- Find the names of employees who work on at least one project located in 'Houston',
-- but whose department is NOT located in 'Houston'
SELECT DISTINCT E.Fname, E.Lname, E.Address
FROM EMPLOYEE E
JOIN WORKS_ON W ON E.Ssn = W.Essn
JOIN PROJECT P ON W.Pno = P.Pnumber
WHERE P.Plocation = 'Houston'
  AND E.Dno NOT IN (
      SELECT Dnumber
      FROM DEPT_LOCATIONS
      WHERE Dlocation = 'Houston'
  );

-- ----------------------------------------------------------
-- 8. INTEGRITY VERIFICATIONS
-- ----------------------------------------------------------

-- Find the last names of all department managers who have NO dependents
SELECT E.Lname
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.Ssn = D.Mgr_ssn
WHERE E.Ssn NOT IN (
    SELECT DISTINCT Essn
    FROM DEPENDENT
);
