--IDENTITY/CHECKIDENT

--Schema Window
CREATE TABLE [Attendance] ([Date] DATETIME, [StudentId] INT)
CREATE TABLE [Students] ([FirstName] NVARCHAR(MAX), [LastName] NVARCHAR(MAX), [StudentId] INT IDENTITY(1,1))

INSERT INTO [Students] ([FirstName], [LastName])
VALUES
('Frodo', 'Baggins'),
('Samwise', 'Gamgee'),
('Meriadoc', 'Brandybuck'),
('Peregrin', 'Took');

--SQL Window
SELECT * 
FROM [Students]

--New Tab
--https://docs.microsoft.com/en-us/sql/t-sql/database-console-commands/dbcc-checkident-transact-sql?view=sql-server-2017

--Cross Apply
--SchemaWindow
INSERT INTO [Attendance] ([Date], [StudentId])
VALUES (GETDATE(), 1),
       (GETDATE(), 2),
       (GETDATE(), 4),
       ('2018-04-19', 1),
       ('2018-04-19', 2),
       ('2018-04-19', 3),
       ('2018-04-19', 4)
;
--Sql Window 
SELECT S.[FirstName]
     , S.[LastName]
     , D.[DaysPresent]
FROM [Students] S
CROSS APPLY ( SELECT COUNT([DATE]) AS [DaysPresent] FROM [Attendance] A WHERE A.[StudentId] = S.[StudentId]) D

--https://www.mssqltips.com/sqlservertip/1958/sql-server-cross-apply-and-outer-apply/


--HELPTEXT
CREATE PROCEDURE [sp_GetAttendanceForStudent] 
( 
    @studentId INT
) 			
AS
BEGIN
  SELECT COUNT([DATE]) AS DaysPresent
  FROM [Attendance]
  WHERE [StudentId] = @studentId
END

--SqlWindow (Run SQL to PlainText)
SP_HELPTEXT 'sp_GetAttendanceForStudent'

EXEC sp_GetAttendanceForStudent 1																																																																				
