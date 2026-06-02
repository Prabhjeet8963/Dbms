
CREATE DATABASE Db_8;
USE Db_8;

CREATE TABLE Student 
(
  sid VARCHAR(8) PRIMARY KEY,
  sname VARCHAR(15) NOT NULL,
  age INT CHECK (age > 0)
);

CREATE TABLE Matches 
(
  mid VARCHAR(8) PRIMARY KEY,
  mname VARCHAR(50) NOT NULL,
  venue VARCHAR(50) NOT NULL
);

CREATE TABLE Play 
(
  sid VARCHAR(10) NOT NULL,
  mid VARCHAR(10) NOT NULL,
  day DATE NOT NULL,
  PRIMARY KEY (sid, mid, day),
  CONSTRAINT fk_play_student FOREIGN KEY (sid) REFERENCES Student(sid),
  CONSTRAINT fk_play_match   FOREIGN KEY (mid) REFERENCES Matches(mid)
);


INSERT INTO Student VALUES
('S1', 'Ram', 20),
('S2', 'Shyam', 21),
('S3', 'Aman', 22),
('S4', 'Amit', 23),
('S5', 'Karan', 20);

INSERT INTO Matches VALUES 
('B10', 'Cricket', 'Delhi'),
('B11', 'Football', 'Mumbai'),
('B12', 'F1', 'Assam'),
('B13', 'Badminton', 'Delhi');

INSERT INTO Play VALUES 
('S1', 'B10', '2024-03-12'),
('S1', 'B11', '2024-03-12'),
('S2', 'B11', '2024-03-12'),
('S3', 'B12', '2024-03-14'),
('S4', 'B13', '2024-03-16'),
('S2', 'B10', '2024-03-18');

SELECT S.*
FROM Student S
JOIN Play P ON S.sid = P.sid
WHERE P.mid = 'B10';

SELECT mname FROM Matches
WHERE mid IN (
  SELECT mid FROM Play
  WHERE sid = (
    SELECT sid FROM Student
    WHERE sname = 'Amit'));

SELECT sname FROM Student
WHERE sid IN (
  SELECT sid FROM Play
  WHERE mid IN (
    SELECT mid FROM Matches
    WHERE venue = 'Delhi'
  )
);


SELECT DISTINCT S.sname
FROM Student AS S
JOIN Play AS P ON S.sid = P.sid;


SELECT sid, sname
FROM Student
WHERE sid IN (
  SELECT sid
  FROM Play
  GROUP BY sid, day
  HAVING COUNT(DISTINCT mid) >= 2
);


SELECT DISTINCT S.sid
FROM Student AS S
JOIN Play AS P ON S.sid = P.sid
JOIN Matches AS M ON P.mid = M.mid
WHERE M.venue IN ('Delhi', 'Mumbai');


SELECT AVG(age) AS avg_age
FROM Student;


