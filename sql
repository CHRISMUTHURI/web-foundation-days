
-- =====================================================
-- DAY 6 ASSIGNMENT: SCHOOL DATABASE
-- Database: SQLite
-- =====================================================

-- Enable foreign key enforcement
PRAGMA foreign_keys = ON;

-- =====================================================
-- 1. CREATE TABLES
-- =====================================================

-- Students table
CREATE TABLE students (
    student_id INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE
);

-- Courses table
CREATE TABLE courses (
    course_id INTEGER PRIMARY KEY AUTOINCREMENT,
    course_name TEXT NOT NULL,
    course_code TEXT NOT NULL UNIQUE
);

-- Enrolments table (junction table)
CREATE TABLE enrolments (
    enrolment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    grade TEXT,

    FOREIGN KEY (student_id)
        REFERENCES students(student_id),

    FOREIGN KEY (course_id)
        REFERENCES courses(course_id),

    UNIQUE (student_id, course_id)
);

-- =====================================================
-- 2. INSERT SAMPLE STUDENTS
-- =====================================================

INSERT INTO students (full_name, email) VALUES
('Chris Mwenda', 'chris@example.com'),
('John Kamau', 'john@example.com'),
('Mary Wanjiku', 'mary@example.com'),
('Peter Otieno', 'peter@example.com');

-- =====================================================
-- 3. INSERT SAMPLE COURSES
-- =====================================================

INSERT INTO courses (course_name, course_code) VALUES
('Database Management Systems', 'DBMS101'),
('Web Development', 'WEB102'),
('Computer Networking', 'NET103');

-- =====================================================
-- 4. INSERT SAMPLE ENROLMENTS
-- =====================================================

INSERT INTO enrolments (student_id, course_id, grade) VALUES
(1, 1, 'A'),
(1, 2, 'B'),
(2, 1, 'B'),
(2, 3, 'A'),
(3, 2, 'A'),
(3, 3, 'B');

-- =====================================================
-- 5. QUERY ONE:
-- All courses for one student (by name)
-- =====================================================

SELECT
    students.full_name,
    courses.course_name,
    courses.course_code,
    enrolments.grade
FROM enrolments
JOIN students
    ON enrolments.student_id = students.student_id
JOIN courses
    ON enrolments.course_id = courses.course_id
WHERE students.full_name = 'Chris Mwenda';

-- =====================================================
-- 6. QUERY TWO:
-- All students enrolled on one course
-- =====================================================

SELECT
    students.full_name,
    students.email,
    courses.course_name
FROM enrolments
JOIN students
    ON enrolments.student_id = students.student_id
JOIN courses
    ON enrolments.course_id = courses.course_id
WHERE courses.course_name = 'Web Development';

-- =====================================================
-- 7. QUERY THREE:
-- Number of students per course
-- Includes courses with zero students
-- =====================================================

SELECT
    courses.course_name,
    COUNT(enrolments.student_id) AS total_students
FROM courses
LEFT JOIN enrolments
    ON courses.course_id = enrolments.course_id
GROUP BY
    courses.course_id,
    courses.course_name;

-- =====================================================
-- 8. QUERY FOUR:
-- Students who have no enrolments
-- =====================================================

SELECT
    students.student_id,
    students.full_name,
    students.email
FROM students
LEFT JOIN enrolments
    ON students.student_id = enrolments.student_id
WHERE enrolments.enrolment_id IS NULL;

-- =====================================================
-- 9. QUERY FIVE:
-- Update one enrolment's grade
-- =====================================================

UPDATE enrolments
SET grade = 'A'
WHERE student_id = 2
AND course_id = 1;

-- Verify the grade update
SELECT
    students.full_name,
    courses.course_name,
    enrolments.grade
FROM enrolments
JOIN students
    ON enrolments.student_id = students.student_id
JOIN courses
    ON enrolments.course_id = courses.course_id
WHERE student_id = 2
AND course_id = 1;

-- =====================================================
-- 10. CREATE AN INDEX
-- =====================================================

CREATE INDEX idx_enrolments_student_id
ON enrolments(student_id);
