USE session10_tsu0202;
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary DECIMAL(10,2),
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15)
);

-- Tạo bảng salary_log
CREATE TABLE salary_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (employee_id) REFERENCES employees(id)
);

-- Insert 10 bản ghi vào bảng employees
INSERT INTO employees(first_name, last_name, salary, email, phone_number)
VALUES
('Nguyen', 'An', 1200.00, 'an@gmail.com', '0901111111'),
('Tran', 'Binh', 1500.00, 'binh@gmail.com', '0902222222'),
('Le', 'Cuong', 1800.00, 'cuong@gmail.com', '0903333333'),
('Pham', 'Dung', 2000.00, 'dung@gmail.com', '0904444444'),
('Hoang', 'Giang', 1700.00, 'giang@gmail.com', '0905555555'),
('Vo', 'Hai', 2100.00, 'hai@gmail.com', '0906666666'),
('Do', 'Khanh', 1900.00, 'khanh@gmail.com', '0907777777'),
('Bui', 'Lam', 2200.00, 'lam@gmail.com', '0908888888'),
('Dang', 'Minh', 2500.00, 'minh@gmail.com', '0909999999'),
('Phan', 'Nam', 1600.00, 'nam@gmail.com', '0901234567');

-- TẠo trigger
DELIMITER $$

CREATE TRIGGER trg_after_update_salary
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN 
     IF OLD.salary <> NEW.salary THEN
	     INSERT INTO salary_log(employee_id, old_salary, new_salary)
         VALUES (
         OLD.id,
         OLD.salary,
         NEW.salary
         );
	END IF;
END $$

DELIMITER ;

-- TEST UPDATE lương
UPDATE session10_tsu0202.employees
SET salary = 3500.00
WHERE id = 1;
