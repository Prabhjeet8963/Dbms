-- ==========================================================
-- ANALYTICAL QUERIES: STUDENT ATHLETICS SYSTEM
-- ==========================================================

USE ATHLETICS_DB;

-- ----------------------------------------------------------
-- 1. BASIC JOINS & RETRIEVALS
-- ----------------------------------------------------------

-- A. Retrieve all student details who played in match 'B10'
SELECT S.*
FROM Student S
JOIN Play P ON S.sid = P.sid
WHERE P.mid = 'B10';

-- B. Find match names played by student 'Amit'
-- Demonstrates nested subqueries mapping name to student ID
SELECT mname 
FROM Matches
WHERE mid IN (
  SELECT mid 
  FROM Play
  WHERE sid = (
    SELECT sid 
    FROM Student
    WHERE sname = 'Amit'
  )
);

-- C. Retrieve names of students who played in matches hosted in 'Delhi'
SELECT DISTINCT S.sname
FROM Student S
WHERE S.sid IN (
  SELECT P.sid 
  FROM Play P
  WHERE P.mid IN (
    SELECT M.mid 
    FROM Matches M
    WHERE M.venue = 'Delhi'
  )
);

-- D. Retrieve a list of distinct students who have participated in at least one match
SELECT DISTINCT S.sname
FROM Student S
JOIN Play P ON S.sid = P.sid;

-- ----------------------------------------------------------
-- 2. GROUPING & CONDITIONAL FILTERING (HAVING)
-- ----------------------------------------------------------

-- A. Find student IDs and names of athletes who played at least two matches on the SAME day
-- Highlights the combination of GROUP BY and HAVING counts
SELECT sid, sname
FROM Student
WHERE sid IN (
  SELECT sid
  FROM Play
  GROUP BY sid, day
  HAVING COUNT(DISTINCT mid) >= 2
);

-- ----------------------------------------------------------
-- 3. SET OPERATIONS & STATISTICAL METRICS
-- ----------------------------------------------------------

-- A. Find distinct student IDs of athletes who played in 'Delhi' or 'Mumbai' venues
SELECT DISTINCT S.sid
FROM Student S
JOIN Play P ON S.sid = P.sid
JOIN Matches M ON P.mid = M.mid
WHERE M.venue IN ('Delhi', 'Mumbai');

-- B. Calculate the average age of all registered students
SELECT AVG(age) AS Average_Student_Age
FROM Student;
