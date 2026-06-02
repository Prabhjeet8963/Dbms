-- ==========================================================
-- DATABASE SCHEMA: SUPPLIER INVENTORY SYSTEM
-- ==========================================================

CREATE DATABASE IF NOT EXISTS SUPPLIER_DB;
USE SUPPLIER_DB;

-- 1. SUPPLIER Table
CREATE TABLE Supplier (
    scode VARCHAR(10) PRIMARY KEY,
    sname VARCHAR(50) NOT NULL,
    scity VARCHAR(30) NOT NULL,
    turnover DECIMAL(10, 2) NULL
);

-- 2. PART Table
CREATE TABLE Part (
    pcode VARCHAR(10) PRIMARY KEY,
    weigh INT NOT NULL,
    color VARCHAR(20) NOT NULL,
    cost DECIMAL(10, 2) NOT NULL,
    sellingprice DECIMAL(10, 2) NOT NULL,
    CONSTRAINT chk_weigh CHECK (weigh > 0)
);

-- 3. SUPPLIER_PART Table (Many-to-Many Associative Entity)
CREATE TABLE Supplier_Part (
    scode VARCHAR(10),
    pcode VARCHAR(10),
    qty INT NOT NULL,
    PRIMARY KEY (scode, pcode),
    FOREIGN KEY (scode) REFERENCES Supplier(scode) ON DELETE CASCADE,
    FOREIGN KEY (pcode) REFERENCES Part(pcode) ON DELETE CASCADE,
    CONSTRAINT chk_qty CHECK (qty >= 0)
);

-- ==========================================================
-- DATA POPULATION
-- ==========================================================

-- Populate Supplier
INSERT INTO Supplier (scode, sname, scity, turnover) VALUES
('S1', 'SupplierA', 'Bombay', 50.00),
('S2', 'SupplierB', 'Delhi', 75.00),
('S3', 'SupplierC', 'Bangalore', 100.00),
('S4', 'SupplierD', 'Mumbai', NULL),
('S5', 'SupplierE', 'Bombay', 50.00);

-- Populate Part
INSERT INTO Part (pcode, weigh, color, cost, sellingprice) VALUES
('P1', 25, 'Red', 20.00, 30.00),
('P2', 30, 'Blue', 40.00, 60.00),
('P3', 35, 'Green', 30.00, 45.00),
('P4', 40, 'Yellow', 50.00, 75.00),
('P5', 32, 'Red', 45.00, 65.00);

-- Populate Supplier_Part Join Table
INSERT INTO Supplier_Part (scode, pcode, qty) VALUES
('S1', 'P1', 100),
('S1', 'P2', 200),
('S2', 'P2', 150),
('S3', 'P3', 50),
('S4', 'P4', 250),
('S5', 'P1', 75),
('S5', 'P5', 120);
