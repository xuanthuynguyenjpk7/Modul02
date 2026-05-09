SELECT * FROM student.students;

UPDATE students
SET Email = 'nguyenvana@gmail.com'
WHERE StudentId = '1';
SELECT * FROM student.students;

UPDATE students
SET Gender = 'Male'
WHERE StudentId ='5';
SELECT * FROM student.students;

DELETE FROM students WHERE StudentId = '3';
SELECT * FROM student.students;