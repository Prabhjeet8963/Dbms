create database ex5;

use ex5;

create table SUPPLIER (
scode varchar(20) primary key,
sname varchar(50),
scity varchar(30),
turnover decimal(10,2)
);

create table PART (
pcode varchar(10) primary key,
weigh int,
color varchar(20),
cost decimal(10,2),
sellingprice decimal (10,2)
);

CREATE TABLE Supplier_Part (
    scode VARCHAR(10),
    pcode VARCHAR(10),
    qty INT,
    FOREIGN KEY (scode) REFERENCES Supplier(scode),
    FOREIGN KEY (pcode) REFERENCES Part(pcode)
);

INSERT INTO Supplier VALUES
('S1', 'SupplierA', 'Bombay', 50),
('S2', 'SupplierB', 'Delhi', 75),
('S3', 'SupplierC', 'Bangalore', 100),
('S4', 'SupplierD', 'Mumbai', NULL),
('S5', 'SupplierE', 'Bombay', 50);

INSERT INTO Part VALUES
('P1', 25, 'Red', 20.00, 30.00),
('P2', 30, 'Blue', 40.00, 60.00),
('P3', 35, 'Green', 30.00, 45.00),
('P4', 40, 'Yellow', 50.00, 75.00),
('P5', 32, 'Red', 45.00, 65.00);

INSERT INTO Supplier_Part VALUES
('S1', 'P1', 100),
('S1', 'P2', 200),
('S2', 'P2', 150),
('S3', 'P3', 50),
('S4', 'P4', 250),
('S5', 'P1', 75),
('S5', 'P5', 120);

Select scode , pcode 
FROM Supplier_Part 
ORDER BY scodde ASC;

SELECT * 
FROM Supplier 
WHERE scity = 'Bombay' AND turnover = 50;

SELECT COUNT(*) 
FROM Supplier;

SELECT pcode 
FROM Part 
WHERE weigh BETWEEN 25 AND 35;

SELECT scode 
FROM Supplier 
WHERE turnover IS NULL;

SELECT pcode 
FROM Part
WHERE cost IN (20, 30, 40);

SELECT SUM(qty) 
FROM Supplier_Part
WHERE pcode = 'P2';

SELECT sname 
FROM Supplier 
WHERE scode 
IN (SELECT scode FROM Supplier_Part WHERE pcode = 'P2');

SELECT pcode 
FROM Part 
WHERE cost > (SELECT AVG(cost) FROM Part);

SELECT scode, turnover 
FROM Supplier 
ORDER BY turnover DESC;