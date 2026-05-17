SELECT * FROM student.employees;
ALTER TABLE student.employees
ADD id_number VARCHAR(200);

CREATE VIEW v_employee_public AS
SELECT 
emp_id,
full_name,
department
FROM student.employees;