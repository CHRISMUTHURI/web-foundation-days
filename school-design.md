
 School Database Design

 1. Introduction

The School Database System is designed to manage students, courses and student enrolments. It stores student information, course details and the grades students achieve in their respective courses.

The database uses SQLite and follows relational database principles to maintain data accuracy, consistency and integrity.

 2. Database Tables

 2.1 Students Table

The students table stores information about students registered in the school system.

It contains the following fields:

- student_id: Primary key that uniquely identifies each student.
- full_name: Stores the student's full name.
- email: Stores the student's email address. It must be unique to prevent duplicate student accounts.

 2.2 Courses Table

The courses table stores information about courses offered by the institution.

It contains the following fields:

- course_id: Primary key that uniquely identifies each course.
- course_name: Stores the name of the course.
- course_code: Stores a unique identification code for each course.

 2.3 Enrolments Table

The enrolments table records the courses students have registered for and the grades they receive.

It contains the following fields:

- enrolment_id: Primary key that uniquely identifies each enrolment.
- student_id: Foreign key referencing the students table.
- course_id: Foreign key referencing the courses table.
- grade: Stores the grade achieved by a student in a particular course.

The table also uses a UNIQUE constraint on student_id and course_id to prevent a student from enrolling in the same course more than once.

 3. Database Relationships

3.1 One-to-Many Relationship

There is a one-to-many relationship between the students table and the enrolments table.

One student can have multiple enrolment records because a student can register for several courses. However, each enrolment record belongs to only one student.

There is also a one-to-many relationship between the courses table and the enrolments table.

One course can have multiple enrolment records because several students can register for the same course. However, each enrolment record refers to only one course.

3.2 Many-to-Many Relationship

There is a many-to-many relationship between students and courses.

One student can enrol in several courses, while one course can have several students enrolled in it.

A direct many-to-many relationship cannot be represented efficiently using only the two tables. Therefore, the enrolments table is used as a junction table to connect students and courses.

The junction table also stores additional information, such as the grade achieved by each student in a particular course.

 4. Database Indexing

An index should be created on the student_id column in the enrolments table.

The index improves database performance by making it faster to retrieve enrolment records belonging to a particular student.

This is useful when searching for all courses registered by a student or retrieving a student's academic records.

The index is created using the following SQL statement:

CREATE INDEX idx_enrolments_student_id
ON enrolments(student_id);

 5. SQL or NoSQL Database Selection

For this School Database System, I would choose a relational SQL database such as SQLite instead of a NoSQL database.

This system contains structured information involving students, courses and enrolments. These entities have clearly defined relationships that can be represented using primary keys, foreign keys and a junction table.

SQL supports relational operations such as JOIN, GROUP BY and LEFT JOIN, which make it easier to retrieve student enrolment information, calculate the number of students per course and identify students who have not enrolled in any course.

SQL also provides constraints such as UNIQUE and NOT NULL to maintain data integrity and prevent duplicate records.

Therefore, SQLite is suitable for this system because it is lightweight, supports relational database operations and does not require a separate database server.
