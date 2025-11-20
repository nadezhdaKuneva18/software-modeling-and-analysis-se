--съхранена процедура
--1. Добавяне на ново задание към курс
--Автоматично ще създава нов запис в Assignment и ще връща ID-то на добавеното задание.
GO
CREATE PROCEDURE AddAssignment
    @Topic NVARCHAR(100),
    @Desc NVARCHAR(255),
    @StartDate DATE,
    @FinalDate DATE,
    @Status NVARCHAR(50),
    @Grade NVARCHAR(10),
    @Course_Id INT
AS
BEGIN
    INSERT INTO Assignment (Topic, [Desc], StartDate, FinalDate, [Status], Grade, Course_Id)
    VALUES (@Topic, @Desc, @StartDate, @FinalDate, @Status, @Grade, @Course_Id);

    SELECT SCOPE_IDENTITY() AS NewAssignmentId;
END;
GO



EXEC AddAssignment 
    @Topic = N'Тест 2',
    @Desc = N'Линейни уравнения',
    @StartDate = '2025-11-20',
    @FinalDate = '2025-11-25',
    @Status = N'assigned',
    @Grade = NULL,
    @Course_Id = 1;





--2. Извеждане на всички задания за даден курс
--Връща списък с всички задания + броя им.
	GO
CREATE PROCEDURE GetAssignmentsByCourse
    @CourseId INT
AS
BEGIN
    SELECT 
        a.AssignmentId,
        a.Topic,
        a.[Desc],
        a.StartDate,
        a.FinalDate,
        a.[Status],
        a.Grade
    FROM Assignment a
    WHERE a.Course_Id = @CourseId;

    SELECT COUNT(*) AS TotalAssignments 
    FROM Assignment 
    WHERE Course_Id = @CourseId;
END;
GO

EXEC GetAssignmentsByCourse @CourseId = 1;
