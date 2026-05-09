SELECT * FROM student.students;

UPDATE students
SET DOB = '2003-07-10'
WHERE StudentId = '1';

UPDATE students
SET DOB = '2005-07-04'
WHERE StudentId = '4';

-- Hiển thị sinh viên có năm sinh từ 2003 đến 2005
SELECT * FROM students
WHERE DOB BETWEEN '2003-01-01' AND '2005-12-31';

-- Hiển thị sinh viên có giới tính là Nam hoặc Nữ
SELECT * FROM students
WHERE Gender = 'Female' OR Gender = 'Male';

-- Hiển thị sinh viên có mã sinh viên thuộc một trong các mã: 1, 4, 5
SELECT * FROM students
WHERE StudentId IN  (1, 4, 5);

-- Chỉ hiển thị:mã sinh viên, họ tên, ngày sinh
SELECT StudentId, FullName, DOB FROM students;