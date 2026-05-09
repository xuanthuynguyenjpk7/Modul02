SELECT * FROM student.students;

-- Hiển thị sinh viên chưa có email
SELECT * FROM students
WHERE Email IS NULL;

-- Hiển thị sinh viên đã có email
SELECT * FROM students
WHERE Email IS NOT NULL;

-- Hiển thị sinh viên có họ tên bắt đầu bằng chữ “Ng”
SELECT * FROM students
WHERE FullName LIKE 'Ng%';

-- Hiển thị sinh viên không phải giới tính Nam
SELECT * FROM students
WHERE NOT Gender = 'Male';


