SELECT * FROM student.employees;

-- Truy vấn dữ liệu (SELECT)
-- Hiển thị danh sách nhân viên có mức lương từ 10.000.000 đến 20.000.000
SELECT * FROM student.employees
WHERE salary BETWEEN 10000000.00 AND 20000000.00;

SELECT * FROM student.employees;
UPDATE student.employees
SET department = 'ACC'
WHERE emp_id = '2';

UPDATE student.employees
SET department = 'SALES'
WHERE emp_id = '6';
SELECT * FROM student.employees;

UPDATE student.employees
SET department = 'CS'
WHERE emp_id = '10';
SELECT * FROM student.employees;

-- Hiển thị nhân viên thuộc phòng ban IT hoặc HR
SELECT * FROM student.employees
WHERE department IN ('IT', 'HR');

-- Hiển thị nhân viên có họ tên chứa chữ “Anh”
SELECT * FROM student.employees
WHERE full_name LIKE '% Anh%';

-- Hiển thị nhân viên chưa có số điện thoại
SELECT * FROM student.employees
WHERE phone IS NULL;

-- Cập nhật & xóa dữ liệu (UPDATE – DELETE)
-- Cập nhật lương tăng thêm 10% cho nhân viên phòng IT
SET SQL_SAFE_UPDATES = 0;
SELECT * FROM student.employees;
UPDATE student.employees
SET salary = salary * 1.10
WHERE department = 'IT';
-- Sau khi update, kiểm tra lại:
SELECT *
FROM student.employees
WHERE department = 'IT';

-- Cập nhật số điện thoại cho nhân viên chưa có số điện thoại
SELECT * FROM student.employees
WHERE phone IS NULL;

UPDATE student.employees
SET phone = '070124566'
WHERE emp_id = '6';

UPDATE student.employees
SET phone = '090765243'
WHERE emp_id = '8';

UPDATE student.employees
SET phone = '0908367249'
WHERE emp_id = '10';
SELECT *FROM student.employees;

-- Xóa nhân viên có mức lương thấp hơn 5.000.000
SELECT *FROM student.employees
WHERE salary < 5000000; 

START TRANSACTION;
DELETE FROM student.employees
WHERE salary <= '5000000.00';
SELECT * FROM student.employees;
ROLLBACK;
