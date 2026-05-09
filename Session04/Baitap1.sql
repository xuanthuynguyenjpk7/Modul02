SELECT * FROM student.students;

INSERT INTO students (StudentId, FullName, DOB, Gender)
VALUES ( '001', 'Nguyễn Văn A', '1992-07-10', 'Male');

INSERT INTO students (StudentId, FullName, DOB, Gender, Email, MarriedStatus)
VALUES ( '002', 'Nguyễn Thị C', '1990-3-2', 'Female', 'thic@gmail.com', 'Married');

SELECT * FROM student.students;
SELECT StudentId, FullName, Email FROM students;