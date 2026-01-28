

CREATE DATABASE SchoolDB;
USE SchoolDB;

CREATE TABLE Students(
Id INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Age INT CHECK (Age BETWEEN 6 AND 20),
    Email NVARCHAR(100) UNIQUE,
    Score INT DEFAULT 0 CHECK (Score BETWEEN 0 AND 100)
);

INSERT INTO Students (FullName, Age, Email, Score)
VALUES
('Sebine Isgenderova', 31, 'sebine@mail.com', 94),
('Solmaz Ceferquliyeva', 30, 'soli@mail.com', 95),
('Firengiz Xudaverdiyeva', 31, 'fira@mail.com', 94),
('Sevinay Rzayeva', 30, 'seva@mail.com', 95),
('Fidan Rzayeva', 29, 'fidush@mail.com', 97);

ALTER TABLE Students
ADD CreatedTime DATETIME DEFAULT GETDATE();

UPDATE Students
SET Email = 'sql@gmail.com'
WHERE Score > 90;

DELETE FROM Students
WHERE AGE < 10;

ALTER TABLE Students
DROP CONSTRAINT CK_Students_Score;

SELECT name
FROM sys.check_constraints
WHERE parent_object_id = OBJECT_ID('Students');

ALTER TABLE Students
ADD CONSTRAINT CK_Studen_Score_5
CHECK (Score % 5 = 0 AND Score BETWEEN 0 AND 100);


CREATE TABLE TopStudents(
Id INT,
FullName NVARCHAR(100),
Score INT
);

INSERT INTO TopStudents(Id,FullName,Score)
SELECT Id, FullName, Score
FROM Students
WHERE Score > 90;