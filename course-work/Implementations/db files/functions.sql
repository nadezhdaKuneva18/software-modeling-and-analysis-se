--функция

--Връща 1, ако е записан, иначе 0.
GO
CREATE FUNCTION fn_IsUserEnrolled(@UserId INT, @CourseId INT)
RETURNS BIT
AS
BEGIN
    DECLARE @Result BIT = 0;

    IF EXISTS (SELECT 1 FROM UserCourse WHERE User_Id = @UserId AND Course_Id = @CourseId)
        SET @Result = 1;

    RETURN @Result;
END;
GO

SELECT dbo.fn_IsUserEnrolled(2, 1) AS IsEnrolled;  -- 1 = записан, 0 = не е




--Изчислява средна оценка на курс
--Взема всички числови стойности от Grade.Graded за даден курс и връща средно аритметично.
GO
CREATE FUNCTION fn_AvgGradeByCourse(@CourseId INT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @avg FLOAT;

    SELECT @avg = AVG(CAST(Graded AS FLOAT))
    FROM Grade g
    JOIN Assignment a ON g.Assignment_Id = a.AssignmentId
    WHERE a.Course_Id = @CourseId AND ISNUMERIC(g.Graded) = 1;

    RETURN @avg;
END;
GO

SELECT dbo.fn_AvgGradeByCourse(1) AS AverageGrade;

