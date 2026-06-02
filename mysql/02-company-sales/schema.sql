-- ==========================================================
-- DATABASE SCHEMA: COMPANY SALES DATABASE
-- ==========================================================

CREATE DATABASE IF NOT EXISTS SALES_DB;
USE SALES_DB;

-- 1. CLIENT_MASTER Table
CREATE TABLE CLIENT_MASTER (
    CLIENTNO VARCHAR(6) PRIMARY KEY,
    NAME VARCHAR(20) NOT NULL,
    ADDRESS1 VARCHAR(30) NULL,
    ADDRESS2 VARCHAR(30) NULL,
    CITY VARCHAR(15) NULL,
    PINCODE INT NULL,
    STATE VARCHAR(15) NULL,
    BALDUE DECIMAL(10, 2) DEFAULT 0.00
);

-- 2. PRODUCT_MASTER Table
CREATE TABLE PRODUCT_MASTER (
    PRODUCTNO VARCHAR(6) PRIMARY KEY,
    DESCRIPTION VARCHAR(25) NOT NULL,
    PROFIT_PERCENT DECIMAL(5, 2) NOT NULL,
    UNIT_MEASURE VARCHAR(10) NOT NULL,
    QTYONHAND INT NOT NULL,
    REORDERLVL INT NOT NULL,
    SELLPRICE DECIMAL(10, 2) NOT NULL,
    COSTPRICE DECIMAL(10, 2) NOT NULL,
    CONSTRAINT chk_sell_price CHECK (SELLPRICE > 0),
    CONSTRAINT chk_cost_price CHECK (COSTPRICE > 0)
);

-- 3. SALESMAN_MASTER Table
CREATE TABLE SALESMAN_MASTER (
    SALESMANNO VARCHAR(6) PRIMARY KEY,
    SALESMANNAME VARCHAR(20) NOT NULL,
    ADDRESS1 VARCHAR(30) NOT NULL,
    ADDRESS2 VARCHAR(30) NULL,
    CITY VARCHAR(20) NULL,
    PINCODE INT NULL,
    STATE VARCHAR(20) NULL,
    SALAMT DECIMAL(10, 2) NOT NULL,
    TGTTOGET DECIMAL(10, 2) NOT NULL,
    YTDQTY DECIMAL(10, 2) DEFAULT 0.00,
    REMARKS VARCHAR(60) NULL,
    CONSTRAINT chk_sal_amt CHECK (SALAMT > 0),
    CONSTRAINT chk_tgt_get CHECK (TGTTOGET > 0)
);

-- ==========================================================
-- DATA POPULATION
-- ==========================================================

-- Populate Client Master
INSERT INTO CLIENT_MASTER (CLIENTNO, NAME, ADDRESS1, CITY, PINCODE, STATE, BALDUE) VALUES
('C00001', 'Ivan Bayross', 'A/14, Juhu', 'Bombay', 400049, 'Maharashtra', 15000.00),
('C00002', 'Mamta Muzumdar', 'B/22, Bandra', 'Bombay', 400050, 'Maharashtra', 0.00),
('C00003', 'Chhaya Bankeshwar', 'C/109, Nariman Point', 'Bombay', 400021, 'Maharashtra', 5000.00),
('C00004', 'Ashwini Joshi', 'F/201, Shivajinagar', 'Pune', 411005, 'Maharashtra', 0.00),
('C00005', 'Hansel Colaco', 'G/15, Colaba', 'Bombay', 400005, 'Maharashtra', 2000.00),
('C00006', 'Deepak Sharma', 'H/22, Karol Bagh', 'Delhi', 110005, 'Delhi', 8000.00);

-- Populate Product Master
INSERT INTO PRODUCT_MASTER (PRODUCTNO, DESCRIPTION, PROFIT_PERCENT, UNIT_MEASURE, QTYONHAND, REORDERLVL, SELLPRICE, COSTPRICE) VALUES
('P00001', 'T-Shirts', 10.50, 'Piece', 200, 50, 350.00, 250.00),
('P00002', 'Shirts', 12.00, 'Piece', 150, 40, 500.00, 380.00),
('P00003', 'Jeans', 15.00, 'Piece', 100, 30, 850.00, 600.00),
('P00004', 'Socks', 8.00, 'Pair', 500, 100, 80.00, 50.00),
('P00005', 'Jackets', 18.00, 'Piece', 50, 15, 2200.00, 1500.00);

-- Populate Salesman Master
INSERT INTO SALESMAN_MASTER (SALESMANNO, SALESMANNAME, ADDRESS1, ADDRESS2, CITY, PINCODE, STATE, SALAMT, TGTTOGET, YTDQTY, REMARKS) VALUES
('S00001', 'Aman Sharma', '12/A, Park Street', NULL, 'Calcutta', 700016, 'West Bengal', 3000.00, 100.00, 50.00, 'Excellent performance'),
('S00002', 'Kiran Patel', '45, MG Road', NULL, 'Bombay', 400001, 'Maharashtra', 3500.00, 120.00, 40.00, 'Consistent'),
('S00003', 'Rohan Mehta', '89, Residency Road', NULL, 'Bangalore', 560025, 'Karnataka', 3200.00, 110.00, 60.00, 'Good record'),
('S00004', 'Rajesh Sen', '101, Karol Bagh', NULL, 'Delhi', 110005, 'Delhi', 3100.00, 95.00, 30.00, 'Scope of improvement');
