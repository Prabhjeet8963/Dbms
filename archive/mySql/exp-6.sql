CREATE DATABASE COMPANY6;
USE COMPANY6;

CREATE TABLE DEPARTMENT (
    Dname VARCHAR(15),
    Dnumber INT PRIMARY KEY,
    Mgr_ssn CHAR(9),
    Mgr_start_date DATE
);

CREATE TABLE EMPLOYEE (
    Fname VARCHAR(15),
    Minit CHAR(1),
    Lname VARCHAR(15),
    Ssn CHAR(9) PRIMARY KEY,
    Bdate DATE,
    Address VARCHAR(30),
    Sex CHAR(1),
    Salary DECIMAL(10, 2),
    Super_ssn CHAR(9),
    Dno INT,
    FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE(Ssn),
    FOREIGN KEY (Dno) REFERENCES DEPARTMENT(Dnumber)
);

ALTER TABLE DEPARTMENT ADD FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn);

CREATE TABLE DEPT_LOCATIONS (
    Dnumber INT,
    Dlocation VARCHAR(15),
    PRIMARY KEY (Dnumber, Dlocation),
    FOREIGN KEY (Dnumber) REFERENCES DEPARTMENT(Dnumber)
);

CREATE TABLE PROJECT (
    Pname VARCHAR(15),
    Pnumber INT PRIMARY KEY,
    Plocation VARCHAR(15),
    Dnum INT,
    FOREIGN KEY (Dnum) REFERENCES DEPARTMENT(Dnumber)
);

CREATE TABLE WORKS_ON (
    Essn CHAR(9),
    Pno INT,
    Hours DECIMAL(3, 1),
    PRIMARY KEY (Essn, Pno),
    FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn),
    FOREIGN KEY (Pno) REFERENCES PROJECT(Pnumber)
);

CREATE TABLE DEPENDENT (
    Essn CHAR(9),
    Dependent_name VARCHAR(15),
    Sex CHAR(1),
    Bdate DATE,
    Relationship VARCHAR(8),
    PRIMARY KEY (Essn, Dependent_name),
    FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn)
);

SELECT *
FROM EMPLOYEE
WHERE Dno = 5;

SELECT *
FROM PROJECT
WHERE Pname = 'ProductX';

SELECT *
FROM WORKS_ON
WHERE Hours > 10;

SELECT T.Essn, T.Pno, T.Hours
FROM WORKS_ON T
JOIN PROJECT S ON T.Pno = S.Pnumber
WHERE S.Pname = 'ProductX';

SELECT E.Fname, E.Minit, E.Lname
FROM EMPLOYEE E
JOIN WORKS_ON W ON E.Ssn = W.Essn
JOIN PROJECT P ON W.Pno = P.Pnumber
WHERE E.Dno = 5
  AND W.Hours > 10
  AND P.Pname = 'ProductX';


 -- Question2
 
SELECT *
FROM EMPLOYEE E
JOIN DEPENDENT D ON E.Ssn = D.Essn;

SELECT *
FROM EMPLOYEE E
JOIN DEPENDENT D ON E.Ssn = D.Essn
WHERE E.Fname = D.Dependent_name;

SELECT DISTINCT E.Fname, E.Minit, E.Lname
FROM EMPLOYEE E
JOIN DEPENDENT D ON E.Ssn = D.Essn
WHERE E.Fname = D.Dependent_name;

 -- Question3
 
 SELECT Ssn
FROM EMPLOYEE
WHERE Fname = 'Franklin' AND Lname = 'Wong';

 SELECT *
FROM EMPLOYEE
WHERE Super_ssn = (
    SELECT Ssn
    FROM EMPLOYEE
    WHERE Fname = 'Franklin' AND Lname = 'Wong'
);

SELECT Fname, Minit, Lname
FROM EMPLOYEE
WHERE Super_ssn = (
    SELECT Ssn
    FROM EMPLOYEE
    WHERE Fname = 'Franklin' AND Lname = 'Wong'
);

 -- Question4

SELECT Essn, Pno
FROM WORKS_ON;

SELECT Pnumber
FROM PROJECT;

SELECT E.Ssn
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

SELECT E.Fname, E.Minit, E.Lname
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

 -- Question5
 SELECT DISTINCT Essn
FROM WORKS_ON;

SELECT Fname, Minit, Lname, Ssn
FROM EMPLOYEE;

SELECT Fname, Minit, Lname
FROM EMPLOYEE
WHERE Ssn NOT IN (
    SELECT Essn
    FROM WORKS_ON
);

 -- Question6
 
SELECT E.Ssn, E.Fname, E.Minit, E.Lname, E.Address, E.Dno
FROM EMPLOYEE E
JOIN WORKS_ON W ON E.Ssn = W.Essn
JOIN PROJECT P ON W.Pno = P.Pnumber
WHERE P.Plocation = 'Houston';

SELECT Dnumber
FROM DEPT_LOCATIONS
WHERE Dlocation = 'Houston';
 show tables;

SELECT DISTINCT E.Fname, E.Minit, E.Lname, E.Address
FROM EMPLOYEE E
JOIN WORKS_ON W ON E.Ssn = W.Essn
JOIN PROJECT P ON W.Pno = P.Pnumber
WHERE P.Plocation = 'Houston'
  AND E.Dno NOT IN (
      SELECT Dnumber
      FROM DEPT_LOCATIONS
      WHERE Dlocation = 'Houston'
  );

-- Question7
SELECT Mgr_ssn
FROM DEPARTMENT;

SELECT DISTINCT Essn
FROM DEPENDENT;

SELECT E.Lname
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.Ssn = D.Mgr_ssn
WHERE E.Ssn NOT IN (
    SELECT Essn
    FROM DEPENDENT
);






