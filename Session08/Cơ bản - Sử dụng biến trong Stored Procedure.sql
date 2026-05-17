SELECT * FROM student.employees;

DELIMITER $$
CREATE PROCEDURE sp_get_avg_salary()
BEGIN 
 -- Khai báo biến lưu lương trung bình
 DECLARE avg_salary DECIMAL(10,2);
 -- Gán giá trị cho biến
 SELECT AVG(salary)
 INTO avg_salary
 FROM student.employees;
 
 -- Hiển thị kết quả
 SELECT avg_salary AS average_salary;
 
 END $$
 
 DELIMITER ;
 
CALL sp_get_avg_salary();