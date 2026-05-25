CREATE DATABASE session09_tsu0202;
USE session09_tsu0202;

-- Tạo bảng customers
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    address VARCHAR(255) NOT NULL
);
-- xem trước khi tạo index
EXPLAIN
SELECT *
FROM session09_tsu0202.customers
WHERE email = 'abc@gmail.com';

-- Tạo Unique Index cho email
CREATE UNIQUE INDEX idx_customers_email
ON customers(email);
-- xem sau khi tạo index
EXPLAIN
SELECT *
FROM session09_tsu0202.customers
WHERE email = 'abc@gmail.com';

-- Tạo Index thường cho phone
CREATE INDEX idx_customers_phone
ON customers(phone);

SHOW INDEX FROM customers;

SET profiling = 1;

SELECT *
FROM customers
WHERE email = 'abc@gmail.com';

SHOW PROFILES;