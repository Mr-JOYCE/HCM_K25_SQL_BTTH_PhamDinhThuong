-- ======================================================
-- HỆ THỐNG QUẢN LÝ KHÓA HỌC TRUNG TÂM ĐÀO TẠO
-- Bao gồm:
-- CREATE TABLE
-- INSERT DATA
-- SQL Solutions (21 Questions)
-- ======================================================

-- 1. CREATE TABLES

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    gender VARCHAR(10),
    age INT
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    tuition_fee DECIMAL(10,2)
);

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enroll_date DATE,
    score DECIMAL(5,2),

    FOREIGN KEY(student_id)
        REFERENCES students(student_id),

    FOREIGN KEY(course_id)
        REFERENCES courses(course_id)
);

-- 2. INSERT DATA

INSERT INTO students VALUES
(1,'Nguyen Van An','Male',20),
(2,'Tran Thi Binh','Female',21),
(3,'Le Van Cuong','Male',22),
(4,'Pham Thi Dung','Female',20),
(5,'Hoang Van Em','Male',23),
(6,'Nguyen Thi Giang','Female',21),
(7,'Do Van Hung','Male',22),
(8,'Le Thi Hoa','Female',20),
(9,'Tran Van Khoa','Male',24),
(10,'Pham Thi Lan','Female',19);

INSERT INTO courses VALUES
(1,'Java',5000000),
(2,'Python',4500000),
(3,'MySQL',3500000),
(4,'ReactJS',6000000),
(5,'Testing',3000000);

INSERT INTO enrollments VALUES
(1,1,1,'2025-01-10',8.5),
(2,1,2,'2025-01-12',9.0),
(3,2,1,'2025-01-15',7.5),
(4,3,3,'2025-01-18',8.0),
(5,4,2,'2025-01-20',9.2),
(6,5,4,'2025-01-22',6.8),
(7,6,5,'2025-01-25',8.7),
(8,7,1,'2025-01-27',7.0),
(9,8,4,'2025-02-01',9.5),
(10,9,2,'2025-02-05',8.9),
(11,10,3,'2025-02-08',7.8),
(12,2,5,'2025-02-10',8.4),
(13,3,2,'2025-02-12',9.1),
(14,4,4,'2025-02-15',8.3),
(15,5,1,'2025-02-18',7.6);

-- =========================
-- QUESTION 1
-- =========================
SELECT * FROM students;

-- QUESTION 2
SELECT
    full_name AS student_name,
    age AS student_age
FROM students;

-- QUESTION 3
UPDATE students
SET age = 25
WHERE student_id = 1;

-- QUESTION 4
DELETE FROM enrollments
WHERE enrollment_id = 15;

-- QUESTION 5
SELECT COUNT(*) AS total_student
FROM students;

-- QUESTION 6
SELECT
    MAX(score) AS highest_score,
    MIN(score) AS lowest_score,
    AVG(score) AS average_score
FROM enrollments;

-- QUESTION 7
SELECT SUM(tuition_fee) AS total_tuition
FROM courses;

-- QUESTION 8
SELECT
    c.course_name,
    COUNT(e.student_id) AS total_student
FROM courses c
JOIN enrollments e
ON c.course_id = e.course_id
GROUP BY c.course_name;

-- QUESTION 9
SELECT
    c.course_name,
    AVG(e.score) AS average_score
FROM courses c
JOIN enrollments e
ON c.course_id = e.course_id
GROUP BY c.course_name;

-- QUESTION 10
SELECT
    c.course_name,
    COUNT(*) AS total_student
FROM courses c
JOIN enrollments e
ON c.course_id = e.course_id
GROUP BY c.course_name
HAVING COUNT(*) > 2;

-- QUESTION 11
SELECT
    s.full_name,
    e.score
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
WHERE e.score = (
    SELECT MAX(score)
    FROM enrollments
);

-- QUESTION 12
SELECT
    s.full_name,
    e.score
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
WHERE e.score = (
    SELECT MIN(score)
    FROM enrollments
);

-- QUESTION 13
SELECT
    s.full_name,
    e.score
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
WHERE e.score > (
    SELECT AVG(score)
    FROM enrollments
);

-- QUESTION 14
SELECT *
FROM courses
WHERE tuition_fee = (
    SELECT MAX(tuition_fee)
    FROM courses
);

-- QUESTION 15
SELECT
    s.full_name,
    c.course_name,
    e.score
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
JOIN courses c
ON c.course_id = e.course_id;

-- QUESTION 16
SELECT
    s.full_name,
    c.course_name,
    e.enroll_date
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
JOIN courses c
ON c.course_id = e.course_id;

-- QUESTION 17
SELECT
    c.course_name,
    COUNT(*) AS total_student
FROM courses c
JOIN enrollments e
ON c.course_id = e.course_id
GROUP BY c.course_name;

-- QUESTION 18
SELECT
    c.course_name,
    AVG(e.score) AS average_score
FROM courses c
JOIN enrollments e
ON c.course_id = e.course_id
GROUP BY c.course_name;

-- QUESTION 19
SELECT
    c.course_name,
    COUNT(*) AS total_student
FROM courses c
JOIN enrollments e
ON c.course_id = e.course_id
GROUP BY c.course_name
HAVING COUNT(*) = (
    SELECT MAX(total_student)
    FROM (
        SELECT COUNT(*) AS total_student
        FROM enrollments
        GROUP BY course_id
    ) t
);

-- QUESTION 20
SELECT
    s.full_name,
    COUNT(*) AS total_course
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
GROUP BY s.student_id, s.full_name
HAVING COUNT(*) = (
    SELECT MAX(total_course)
    FROM (
        SELECT COUNT(*) AS total_course
        FROM enrollments
        GROUP BY student_id
    ) t
);

-- QUESTION 21
SELECT
    s.full_name,
    c.course_name,
    e.score
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
JOIN courses c
ON c.course_id = e.course_id
WHERE e.score >
(
    SELECT AVG(score)
    FROM enrollments e2
    WHERE e2.course_id = e.course_id
);