CREATE TABLE session3_teachers (
    teacher_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    price DECIMAL(10,2) NOT NULL,
    teacher_id INT NOT NULL,

    FOREIGN KEY (teacher_id)
    REFERENCES session3_teachers(teacher_id)
);

CREATE TABLE session3_students (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE session3_enrollments (
    student_id INT,
    course_id INT,

    PRIMARY KEY (student_id, course_id),

    FOREIGN KEY (student_id)
    REFERENCES session3_students(student_id),

    FOREIGN KEY (course_id)
    REFERENCES session3_courses(course_id)
);

ALTER TABLE courses
ADD CONSTRAINT chk_price
CHECK (price > 0);

DROP TABLE session3_enrollments;