PRAGMA foreign_keys = ON;

CREATE TABLE Students (
    student_number INTEGER PRIMARY KEY,
    student_name TEXT NOT NULL,
    exam_score INTEGER NOT NULL CHECK (exam_score BETWEEN 0 AND 100),
    support TEXT NOT NULL CHECK (support IN ('Yes','No')),
    date_of_birth TEXT NOT NULL
);

CREATE TABLE Courses (
    course_id TEXT PRIMARY KEY,
    course_name TEXT NOT NULL UNIQUE,
    teacher_name TEXT NOT NULL
);

CREATE TABLE StudentCourses (
    student_number INTEGER NOT NULL,
    course_id TEXT NOT NULL,
    exam_board TEXT NOT NULL,
    PRIMARY KEY (student_number, course_id),
    FOREIGN KEY (student_number) REFERENCES Students(student_number),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

INSERT INTO Students VALUES (1001, 'Bob Baker', 78, 'No', '2001-08-25');
INSERT INTO Students VALUES (1002, 'Sally Davies', 55, 'Yes', '1999-10-02');
INSERT INTO Students VALUES (1003, 'Mark Hamnill', 90, 'No', '1995-06-05');
INSERT INTO Students VALUES (1004, 'Anas Ali', 70, 'No', '1980-08-03');
INSERT INTO Students VALUES (1005, 'Cheuk Yin', 45, 'Yes', '2002-05-01');

INSERT INTO Courses VALUES ('C01', 'Computer Science', 'Mr Jones');
INSERT INTO Courses VALUES ('C02', 'Maths', 'Ms Parker');
INSERT INTO Courses VALUES ('C03', 'Physics', 'Mr Peters');
INSERT INTO Courses VALUES ('C04', 'Biology', 'Mrs Patel');
INSERT INTO Courses VALUES ('C05', 'Music', 'Ms Daniels');

INSERT INTO StudentCourses VALUES (1001, 'C01', 'BCS');
INSERT INTO StudentCourses VALUES (1001, 'C02', 'EdExcel');
INSERT INTO StudentCourses VALUES (1001, 'C03', 'OCR');
INSERT INTO StudentCourses VALUES (1002, 'C02', 'AQA');
INSERT INTO StudentCourses VALUES (1002, 'C04', 'WJEC');
INSERT INTO StudentCourses VALUES (1002, 'C05', 'AQA');
INSERT INTO StudentCourses VALUES (1003, 'C01', 'BCS');
INSERT INTO StudentCourses VALUES (1003, 'C02', 'EdExcel');
INSERT INTO StudentCourses VALUES (1003, 'C03', 'OCR');
INSERT INTO StudentCourses VALUES (1004, 'C02', 'AQA');
INSERT INTO StudentCourses VALUES (1004, 'C03', 'OCR');
INSERT INTO StudentCourses VALUES (1004, 'C04', 'WJEC');
INSERT INTO StudentCourses VALUES (1005, 'C01', 'BCS');
INSERT INTO StudentCourses VALUES (1005, 'C02', 'EdExcel');
INSERT INTO StudentCourses VALUES (1005, 'C05', 'AQA');

-- Verification queries (run separately in DB Browser if desired)
SELECT 'Students' AS table_name, COUNT(*) AS records FROM Students
UNION ALL SELECT 'Courses', COUNT(*) FROM Courses
UNION ALL SELECT 'StudentCourses', COUNT(*) FROM StudentCourses;

PRAGMA foreign_key_check;

SELECT s.student_number, s.student_name, c.course_name,
       sc.exam_board, c.teacher_name
FROM StudentCourses sc
JOIN Students s ON s.student_number = sc.student_number
JOIN Courses c ON c.course_id = sc.course_id
ORDER BY s.student_number, c.course_id;
