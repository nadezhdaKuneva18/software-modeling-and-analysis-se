--тригери

--При добавяне на нов студент към курс — автоматично увеличава броя участници
GO
CREATE TRIGGER trg_UpdateParticipantCount
ON UserCourse
AFTER INSERT
AS
BEGIN
    UPDATE Course
    SET CountOfParticipants = CountOfParticipants + 1
    WHERE CourseId IN (SELECT Course_Id FROM inserted);
END;
GO



--При изтриване на задание — изтрива всички оценки към него
GO
CREATE TRIGGER trg_DeleteGradesWithAssignment
ON Assignment
AFTER DELETE
AS
BEGIN
    DELETE FROM Grade
    WHERE Assignment_Id IN (SELECT AssignmentId FROM deleted);
END;
GO
