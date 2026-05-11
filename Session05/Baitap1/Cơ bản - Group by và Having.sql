SELECT * FROM student.employees2;

-- 1. Thống kê:
-- mỗi phòng ban có bao nhiêu nhân viên
SELECT
    department,
    COUNT(*) AS total_employees
FROM student.employees2
GROUP BY department;

-- 2. Tính:
-- mức lương trung bình của từng phòng ban
SELECT 
department,
AVG(salary) AS Average_salary
FROM student.employees2
GROUP BY department;

-- 3. Chỉ hiển thị:
-- các phòng ban có trên 3 nhân viên

SELECT
    department,
    COUNT(*) AS total_employees
FROM student.employees2
GROUP BY department
HAVING COUNT(*) > 3;

-- 4. Chỉ hiển thị:
-- các phòng ban có lương trung bình lớn hơn 12.000.000
SELECT 
department,
AVG(salary) AS Average_salary
FROM student.employees2
GROUP BY department
HAVING AVG(salary) > 12000000;