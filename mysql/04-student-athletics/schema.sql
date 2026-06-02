-- ==========================================================
-- DATABASE SCHEMA: STUDENT ATHLETICS SYSTEM
-- ==========================================================

CREATE DATABASE IF NOT EXISTS ATHLETICS_DB;
USE ATHLETICS_DB;

-- 1. Student Table
CREATE TABLE Student (
    sid VARCHAR(8) PRIMARY KEY,
    sname VARCHAR(15) NOT NULL,
    age INT NOT NULL,
    CONSTRAINT chk_student_age CHECK (age > 0)
);

-- 2. Matches Table
CREATE TABLE Matches (
    mid VARCHAR(8) PRIMARY KEY,
    mname VARCHAR(50) NOT NULL,
    venue VARCHAR(50) NOT NULL
);

-- 3. Play Table (Ternary Junction: Student, Match, Day)
CREATE TABLE Play (
    sid VARCHAR(8) NOT NULL,
    mid VARCHAR(8) NOT NULL,
    day DATE NOT NULL,
    PRIMARY KEY (sid, mid, day),
    FOREIGN KEY (sid) REFERENCES Student(sid) ON DELETE CASCADE,
    FOREIGN KEY (mid) REFERENCES Matches(mid) ON DELETE CASCADE
);

-- ==========================================================
-- DATA POPULATION
-- ==========================================================

-- Populate Student
INSERT INTO Student (sid, sname, age) VALUES
('S1', 'Ram', 20),
('S2', 'Shyam', 21),
('S3', 'Aman', 22),
('S4', 'Amit', 23),
('S5', 'Karan', 20);

-- Populate Matches
INSERT INTO Matches (mid, mname, venue) VALUES
('B10', 'Cricket', 'Delhi'),
('B11', 'Football', 'Mumbai'),
('B12', 'F1', 'Assam'),
('B13', 'Badminton', 'Delhi');

-- Populate Play Assignments
INSERT INTO Play (sid, mid, day) VALUES
('S1', 'B10', '2024-03-12'),
('S1', 'B11', '2024-03-12'),
('S2', 'B11', '2024-03-12'),
('S3', 'B12', '2024-03-14'),
('S4', 'B13', '2024-03-16'),
('S2', 'B10', '2024-03-18');
