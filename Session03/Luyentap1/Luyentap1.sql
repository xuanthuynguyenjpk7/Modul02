CREATE TABLE session03_classes (
    class_id INT PRIMARY KEY,
    class_name VARCHAR(100) NOT NULL,
    major VARCHAR(100) NOT NULL
);

CREATE TABLE session03_students (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    birth_year INT NOT NULL,
    gender VARCHAR(10) NOT NULL,
    class_id INT NOT NULL,
    FOREIGN KEY (class_id)
    REFERENCES session03_classes(class_id)
);