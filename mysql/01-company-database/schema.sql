-- ==========================================
-- DATABASE SCHEMA: COMPANY DATABASE
-- ==========================================

CREATE DATABASE IF NOT EXISTS COMPANY_DB;
USE COMPANY_DB;

-- 1. DEPARTMENT Table (Self-contained structure)
CREATE TABLE DEPARTMENT (
    Dname VARCHAR(25) NOT NULL UNIQUE,
    Dnumber INT PRIMARY KEY,
    Mgr_ssn CHAR(9) NULL,
    Mgr_start_date DATE NULL
);

-- 2. EMPLOYEE Table (Integrates foreign keys)
CREATE TABLE EMPLOYEE (
    Fname VARCHAR(15) NOT NULL,
    Minit CHAR(1) NULL,
    Lname VARCHAR(15) NOT NULL,
    Ssn CHAR(9) PRIMARY KEY,
    Bdate DATE NULL,
    Address VARCHAR(50) NULL,
    Sex CHAR(1) NULL,
    Salary DECIMAL(10, 2) NULL,
    Super_ssn CHAR(9) NULL,
    Dno INT NOT NULL,
    FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE(Ssn),
    FOREIGN KEY (Dno) REFERENCES DEPARTMENT(Dnumber)
);

-- Add manager foreign key constraint to DEPARTMENT after EMPLOYEE exists
ALTER TABLE DEPARTMENT ADD CONSTRAINT fk_dept_mgr 
FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn);

-- 3. DEPT_LOCATIONS Table (Associative Multi-valued Attribute)
CREATE TABLE DEPT_LOCATIONS (
    Dnumber INT NOT NULL,
    Dlocation VARCHAR(15) NOT NULL,
    PRIMARY KEY (Dnumber, Dlocation),
    FOREIGN KEY (Dnumber) REFERENCES DEPARTMENT(Dnumber)
);

-- 4. PROJECT Table
CREATE TABLE PROJECT (
    Pname VARCHAR(25) NOT NULL UNIQUE,
    Pnumber INT PRIMARY KEY,
    Plocation VARCHAR(15) NULL,
    Dnum INT NOT NULL,
    FOREIGN KEY (Dnum) REFERENCES DEPARTMENT(Dnumber)
);

-- 5. WORKS_ON Table (Many-to-Many Relationship Entity)
CREATE TABLE WORKS_ON (
    Essn CHAR(9) NOT NULL,
    Pno INT NOT NULL,
    Hours DECIMAL(3, 1) NOT NULL,
    PRIMARY KEY (Essn, Pno),
    FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn),
    FOREIGN KEY (Pno) REFERENCES PROJECT(Pnumber)
);

-- 6. DEPENDENT Table (Weak Entity Type)
CREATE TABLE DEPENDENT (
    Essn CHAR(9) NOT NULL,
    Dependent_name VARCHAR(15) NOT NULL,
    Sex CHAR(1) NULL,
    Bdate DATE NULL,
    Relationship VARCHAR(15) NULL,
    PRIMARY KEY (Essn, Dependent_name),
    FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn) ON DELETE CASCADE
);

-- ==========================================
-- DATA POPULATION
-- ==========================================

-- Populate Department first (without Manager FK to avoid circular insert lock)
INSERT INTO DEPARTMENT (Dname, Dnumber, Mgr_ssn, Mgr_start_date) VALUES
('Research', 5, NULL, '1988-05-22'),
('Administration', 4, NULL, '1995-01-01'),
('Headquarters', 1, NULL, '1981-06-19');

-- Populate Employees
INSERT INTO EMPLOYEE (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES
('James',    'E', 'Borg',    '888665555', '1937-11-10', '450 Stone, Houston, TX',   'M', 55000.00, NULL,        1),
('Franklin', 'T', 'Wong',    '333445555', '1965-12-08', '638 Voss, Houston, TX',    'M', 40000.00, '888665555', 5),
('John',     'B', 'Smith',   '123456789', '1965-01-09', '731 Fondren, Houston, TX', 'M', 30000.00, '333445555', 5),
('Jennifer', 'S', 'Wallace', '987654321', '1941-06-20', '291 Berry, Bellaire, TX',  'F', 43000.00, '888665555', 4),
('Alicia',   'J', 'Zelaya',  '999887777', '1968-01-19', '3321 Castle, Spring, TX',  'F', 25000.00, '987654321', 4),
('Ramesh',   'K', 'Narayan', '666884444', '1962-09-15', '975 Fire Oak, Humble, TX', 'M', 38000.00, '333445555', 5),
('Joyce',    'A', 'English', '453453453', '1972-07-31', '5631 Rice, Houston, TX',   'F', 25000.00, '333445555', 5),
('Ahmad',    'V', 'Jabbar',  '987987987', '1969-03-29', '980 Dallas, Houston, TX',  'M', 25000.00, '987654321', 4);

-- Resolve Manager relations in DEPARTMENT
UPDATE DEPARTMENT SET Mgr_ssn = '333445555' WHERE Dnumber = 5;
UPDATE DEPARTMENT SET Mgr_ssn = '987654321' WHERE Dnumber = 4;
UPDATE DEPARTMENT SET Mgr_ssn = '888665555' WHERE Dnumber = 1;

-- Populate Department Locations
INSERT INTO DEPT_LOCATIONS (Dnumber, Dlocation) VALUES
(1, 'Houston'),
(4, 'Stafford'),
(5, 'Bellaire'),
(5, 'Sugarland'),
(5, 'Houston');

-- Populate Projects
INSERT INTO PROJECT (Pname, Pnumber, Plocation, Dnum) VALUES
('ProductX', 1, 'Bellaire', 5),
('ProductY', 2, 'Sugarland', 5),
('ProductZ', 3, 'Houston', 5),
('Computerization', 10, 'Stafford', 4),
('Reorganization', 20, 'Houston', 1),
('Newbenefits', 30, 'Stafford', 4);

-- Populate Works_On Table
INSERT INTO WORKS_ON (Essn, Pno, Hours) VALUES
('123456789', 1, 32.5),
('123456789', 2, 7.5),
('666884444', 3, 40.0),
('453453453', 1, 20.0),
('453453453', 2, 20.0),
('333445555', 2, 10.0),
('333445555', 3, 10.0),
('333445555', 10, 10.0),
('999887777', 30, 30.0),
('999887777', 10, 10.0),
('987987987', 10, 35.0),
('987987987', 30, 5.0);

-- Populate Dependents (Weak entity instances)
INSERT INTO DEPENDENT (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES
('333445555', 'Alice',   'F', '1966-04-05', 'Spouse'),
('333445555', 'Theodore','M', '1983-10-25', 'Son'),
('333445555', 'Joy',     'F', '1986-05-03', 'Daughter'),
('987654321', 'Abner',   'M', '1942-02-28', 'Spouse'),
('123456789', 'Michael', 'M', '1988-01-04', 'Son'),
('123456789', 'Alice',   'F', '1988-12-30', 'Daughter'),
('123456789', 'Elizabeth','F','1967-05-05', 'Spouse');
