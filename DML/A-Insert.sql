-- Insert Examples
USE [A01-School]
GO -- Execute the code up to this point as a single batch

/*  Notes:
    The syntax for the INSERT statement is

    INSERT INTO TableName(Comma, Separated, ListOf, ColumnNames)
    VALUES ('A', 'Value', 'Per', 'Column')

    The line above will insert a single row of data. Typically, this
    syntax is used for hard-coded values.
    To insert multiple rows of hard-coded values, follow this pattern:

    INSERT INTO TableName(Comma, Separated, ListOf, ColumnNames)
    VALUES ('A', 'Value', 'Per', 'Column'),
           ('Another', 'Row', 'Of', 'Values')
    
    Another syntax for the INSERT statement is to use a SELECT clause in place
    of the VALUES clause. This is used for zero-to-many possible rows to insert.

    INSERT INTO TableName(Comma, Separated, ListOf, ColumnNames)
    SELECT First, Second, Third, LastColumn
    FROM   SomeTable
*/

-- Insert Examples
-- 1. Let's add a new course called "Expert SQL". It will be a 90 hour course with a cost of $450.00
INSERT INTO Course(CourseId, CourseName, CourseHours, CourseCost)
VALUES ('DMIT777', 'Expert SQL', 90, 450.00)

-- 2. Let's add a new staff member, someone who's really good at SQL
-- SELECT * FROM STAFF
INSERT INTO Staff(FirstName, LastName, DateHired, PositionID)
SELECT 'Dan', 'Gilleland', GETDATE(), PositionID
       --, PositionDescription
FROM   Position
WHERE  PositionDescription = 'Instructor'
-- 2b. Let's get another instructor
INSERT INTO Staff(FirstName, LastName, DateHired, PositionID)
VALUES ('Shane', 'Bell', GETDATE(), 
        (SELECT PositionID
        FROM   Position
        WHERE  PositionDescription = 'Instructor'))
		-- 2.c. We have an open position in the staff.
SELECT	PositionDescription
FROM	Position
WHERE	PositionID NOT IN (SELECT PositionID FROM Staff)
--		Add Sheldon Murray as the new Assistant Dean. (He has friends at NAIT)
INSERT INTO Staff(FirstName, LastName, DateHired, PositionID)
VALUES		('Sheldon','Murray',GETDATE(),
			(SELECT PositionID
			FROM	Position
			WHERE	PositionDescription = 'Assistant Dean'))

-- 3. There are three additional clubs being started at the school:
--      - START - Small Tech And Research Teams
--      - CALM - Coping And Lifestyle Management
--      - RACE - Rapid Acronym Creation Experts
--    SELECT * FROM Club
INSERT INTO Club(ClubId, ClubName)
VALUES ('START', 'Small Tech And Research Teams'),
       ('CALM', 'Coping And Lifestyle Management'),
       ('RACE', 'Rapid Acronym Creation Experts')

-- ======= Practice ========
-- 4. In your web browser, use https://randomuser.me/ to get information on three
--    people to add as new students. Write separate insert statement for each new student.
-- TODO: Student Answer Here....
-- Select * FROM Student
INSERT INTO Student(FirstName, LastName, Gender, StreetAddress, Birthdate)
VALUES	('Lois', 'Palmer', 'F', '8677 Ash Dr', '1949-02-03 00:00:00'),
		('Cory', 'Allen', 'M', '2551 Rolling Green Rd', '1981-06-11 00:00:00'),
		('Gloria', 'Black', 'F', '480 Bruce St', '1970-02-10 00:00:00')


-- 5. Enroll each of the students you've added into the DMIT104 course.
--    Use 'Dan Gilleland' as the instructor. At this point, their marks should be NULL.
