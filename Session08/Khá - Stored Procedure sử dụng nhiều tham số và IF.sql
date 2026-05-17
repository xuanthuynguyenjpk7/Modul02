SELECT * FROM student.employees;

DELIMITER $$

CREATE PROCEDURE sp_check_employee_income(
    IN emp_name VARCHAR(100),
    IN emp_salary DECIMAL(10,2)
)
BEGIN
    IF emp_salary >= 15000000 THEN
        SELECT 
            emp_name AS employee_name,
            'Thu nhập cao' AS income_level;

    ELSEIF emp_salary >= 8000000 THEN
        SELECT 
            emp_name AS employee_name,
            'Thu nhập trung bình' AS income_level;

    ELSE
        SELECT 
            emp_name AS employee_name,
            'Thu nhập thấp' AS income_level;
    END IF;

END $$

DELIMITER ;

CALL sp_check_employee_income('Nguyen Van A', 12000000);

CALL sp_check_employee_income('Lê Thị Hiền', 22627000);

