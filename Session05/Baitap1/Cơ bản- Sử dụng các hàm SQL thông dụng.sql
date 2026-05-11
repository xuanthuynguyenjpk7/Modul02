-- -- Tạo bảng session05_student
CREATE TABLE session05_student (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    birth_year INT,
    gender VARCHAR(10),
    score DECIMAL(4,2)
);

SELECT * FROM session05_student;
-- 1. Hiển thị:
-- mã sinh viên
-- họ tên viết hoa toàn bộ
SELECT 
    student_id,
    UPPER(full_name) AS full_name_upper
FROM session05_student;

-- 2. Hiển thị:
-- họ tên
-- số tuổi của sinh viên

SELECT 
full_name,
YEAR (CURDATE()) - birth_year AS age
FROM session05_student;

-- 3. Hiển thị:
-- điểm trung bình được làm tròn 1 chữ số thập phân
SELECT
    full_name,
    ROUND(score, 1) AS rounded_score
FROM session05_student;

-- 4. Hiển thị:
-- tổng số sinh viên
-- điểm cao nhất
-- điểm thấp nhất

SELECT
COUNT(*) AS total_student,
MAX(score) AS Highest_score,
MIN(score) AS Lowest_score
FROM session05_student;


