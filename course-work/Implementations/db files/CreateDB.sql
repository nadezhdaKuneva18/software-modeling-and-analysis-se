CREATE DATABASE DBClassroom;
GO

USE DBClassroom;
GO

-- Таблица: Потребители
CREATE TABLE [User] (
    UserId INT IDENTITY PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    [Password] NVARCHAR(100) NOT NULL,
    FacNum NVARCHAR(50),
    PhoneNum NVARCHAR(20)
);

-- Таблица: Класна стая
CREATE TABLE Classroom (
    ClassroomId INT IDENTITY PRIMARY KEY,
    CourseName NVARCHAR(100),
    [Type] NVARCHAR(50),  --лекция, час или упражнение
    Capacity INT
);

-- Таблица: Курсове
CREATE TABLE Course (
    CourseId INT IDENTITY PRIMARY KEY,
    CourseName NVARCHAR(100) NOT NULL,
    CountOfParticipants INT DEFAULT 0,
    Classroom_Id INT FOREIGN KEY REFERENCES Classroom(ClassroomId)
);

-- Таблица: Връзка потребител-курс
CREATE TABLE UserCourse (
    UserCourseId INT IDENTITY PRIMARY KEY,
    Role NVARCHAR(50),
    Course_Id INT FOREIGN KEY REFERENCES Course(CourseId),
    User_Id INT FOREIGN KEY REFERENCES [User](UserId)
);

-- Таблица: Инфо канал
CREATE TABLE InfoChannel (
    InfoId INT IDENTITY PRIMARY KEY,
    [Message] NVARCHAR(255),
    Comment NVARCHAR(255),
    Course_Id INT FOREIGN KEY REFERENCES Course(CourseId)
);

-- Таблица: Задания
CREATE TABLE Assignment (
    AssignmentId INT IDENTITY PRIMARY KEY,
    Topic NVARCHAR(100),
    [Desc] NVARCHAR(255),
    StartDate DATE,
    FinalDate DATE,
    [Status] NVARCHAR(50),   -- assigned, completed, missing
    Grade NVARCHAR(10),
    Course_Id INT FOREIGN KEY REFERENCES Course(CourseId)
);

-- Таблица: Срещи
CREATE TABLE Meeting (
    MeetingId INT IDENTITY PRIMARY KEY,
    StartTime DATETIME,
    EndTime DATETIME,
    Participating NVARCHAR(255),
    Course_Id INT FOREIGN KEY REFERENCES Course(CourseId)
);

-- Таблица: Оценки
CREATE TABLE Grade (
    GradeId INT IDENTITY PRIMARY KEY,
    Graded NVARCHAR(10),
    Ungraded NVARCHAR(10),
    Comment NVARCHAR(255),
    Assignment_Id INT FOREIGN KEY REFERENCES Assignment(AssignmentId),
    UserCourse_Id INT FOREIGN KEY REFERENCES UserCourse(UserCourseId)
);

