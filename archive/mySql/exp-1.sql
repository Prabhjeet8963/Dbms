
SHOW DATABASES;

CREATE DATABASE dbmsb53;
USE dbmsb53;

CREATE TABLE emp ( 
  emp_id INT PRIMARY KEY,
  emp_name VARCHAR(25)
);

INSERT INTO emp (emp_id, emp_name) VALUES
(123,'hello'),
(456,'Aarav');

SHOW TABLES;
SELECT * FROM emp;

CREATE DATABASE company01;
USE company01;

CREATE TABLE DEPARTMENT (
  Dname VARCHAR(15) NOT NULL,
  Dnumber INT NOT NULL,
  Mgr_ssn CHAR(9) NULL,
  Mgr_start_date DATE,
  PRIMARY KEY (Dnumber),
  UNIQUE (Dname)
);

CREATE TABLE EMPLOYEE (
  Fname VARCHAR(15) NOT NULL,
  Minit CHAR,
  Lname VARCHAR(15) NOT NULL,
  Ssn CHAR(9) NOT NULL,
  Bdate DATE,
  Address VARCHAR(30),
  Sex CHAR,
  Salary DECIMAL(10,2),
  Super_Ssn CHAR(9),
  Dno INT NOT NULL,
  PRIMARY KEY (Ssn),
  FOREIGN KEY (Super_Ssn) REFERENCES EMPLOYEE(Ssn),
  FOREIGN KEY (Dno) REFERENCES DEPARTMENT(Dnumber)
);

CREATE TABLE DEPT_LOCATION (
  Dnumber INT NOT NULL,
  Dlocation VARCHAR(15) NOT NULL,
  PRIMARY KEY(Dnumber, Dlocation),
  FOREIGN KEY(Dnumber) REFERENCES DEPARTMENT(Dnumber)
);

CREATE TABLE PROJECT(
  Pname VARCHAR(15) NOT NULL,
  Pnumber INT NOT NULL,
  Plocation VARCHAR(15),
  Dnum INT NOT NULL,
  PRIMARY KEY (Pnumber),
  UNIQUE (Pname),
  FOREIGN KEY (Dnum) REFERENCES DEPARTMENT(Dnumber)
);

CREATE TABLE WORKS_ON(
  Emp_ssn CHAR(9) NOT NULL,
  Pno INT NOT NULL,
  Hours DECIMAL(3,1) NOT NULL,
  PRIMARY KEY (Emp_ssn, Pno),
  FOREIGN KEY (Emp_ssn) REFERENCES EMPLOYEE(Ssn),
  FOREIGN KEY (Pno) REFERENCES PROJECT(Pnumber)
);

CREATE TABLE DEPENDENT(
  Emp_ssn CHAR(9) NOT NULL,
  Dependent_name VARCHAR(15) NOT NULL,
  Sex CHAR,
  Bdate DATE,
  Relationship VARCHAR(15),
  PRIMARY KEY (Emp_ssn, Dependent_name),
  FOREIGN KEY (Emp_ssn) REFERENCES EMPLOYEE(Ssn)
);

SELECT * FROM DEPENDENT;

INSERT INTO DEPARTMENT VALUES
('Research', 5, NULL, '1988-05-22'),
('Administration', 4, NULL, '1995-01-01'),
('Headquarters', 1, NULL, '1981-06-19');

SELECT * FROM DEPARTMENT;

INSERT INTO EMPLOYEE VALUES
('James',    'E', 'Borg',    '888665555', '1937-11-10', '450 Stone, Houston TX',   'M', 55000.00, NULL,        1),
('Franklin', 'T', 'Wong',    '333445555', '1965-12-08', '638 Voss, Houston TX',    'M', 40000.00, '888665555', 5),
('John',     'B', 'Smith',   '123456789', '1965-01-09', '731 Fondren, Houston TX', 'M', 30000.00, '333445555', 5),
('Jennifer', 'S', 'Wallace', '987654321', '1941-06-20', '291 Berry, Bellaire TX',  'F', 43000.00, '888665555', 4),
('Alicia',   'J', 'Zelaya',  '999887777', '1968-01-19', '3321 Castle, Spring TX',  'F', 25000.00, '987654321', 4),
('Ramesh',   'K', 'Narayan', '666884444', '1962-09-15', '975 Fire Oak, Humble TX', 'M', 38000.00, '333445555', 5),
('Joyce',    'A', 'English', '453453453', '1972-07-31', '5631 Rice, Houston TX',   'F', 25000.00, '333445555', 5),
('Ahmad',    'V', 'Jabbar',  '987987987', '1969-03-29', '980 Dallas, Houston TX',  'M', 25000.00, '987654321', 4);

SELECT * FROM EMPLOYEE;

-- Update Works one At A TIme!
UPDATE DEPARTMENT SET Mgr_ssn = '333445555' WHERE Dnumber = 5;

UPDATE DEPARTMENT SET Mgr_ssn = '987654321' WHERE Dnumber = 4;

UPDATE DEPARTMENT SET Mgr_ssn = '888665555' WHERE Dnumber = 1;

SELECT * FROM DEPARTMENT;

ALTER TABLE DEPARTMENT
ADD CONSTRAINT fk_department_manager 
FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn);

SELECT * FROM DEPARTMENT;

INSERT INTO PROJECT VALUES
('ProductX', 1, 'Bellaire', 5),
('ProductY', 2, 'Sugarland', 5),
('ProductZ', 3, 'Houston', 5),
('Computerization', 10, 'Stafford', 4),
('Reorganization', 20, 'Houston', 1),
('Newbenefits', 30, 'Stafford', 4);

SELECT * FROM PROJECT;

INSERT INTO WORKS_ON VALUES
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

-- STEP 10: Insert Dependents
INSERT INTO DEPENDENT VALUES
('333445555', 'Alice',   'F', '1966-04-05', 'Spouse'),
('333445555', 'Theodore','M', '1983-10-25', 'Son'),
('333445555', 'Joy',     'F', '1986-05-03', 'Daughter'),
('987654321', 'Abner',   'M', '1942-02-28', 'Spouse'),
('123456789', 'Michael', 'M', '1988-01-04', 'Son'),
('123456789', 'Alice',   'F', '1988-12-30', 'Daughter'),
('123456789', 'Elizabeth','F','1967-05-05', 'Spouse');

SHOW DATABASES;