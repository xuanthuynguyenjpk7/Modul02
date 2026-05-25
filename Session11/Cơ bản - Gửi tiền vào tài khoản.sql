CREATE DATABASE session11_tsu0202;
USE session11_tsu0202;

-- Tạo bảng accounts
CREATE TABLE accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    account_name VARCHAR(100) NOT NULL,
    balance DECIMAL(15,2) NOT NULL
);

-- Thêm 10 tài khoản mẫu
INSERT INTO accounts (account_name, balance)
VALUES
('Nguyen Van A', 5000000),
('Tran Thi B', 7000000),
('Le Van C', 3000000),
('Pham Thi D', 9000000),
('Hoang Van E', 4500000),
('Do Thi F', 8000000),
('Vu Van G', 6000000),
('Bui Thi H', 7500000),
('Dang Van I', 10000000),
('Ngo Thi K', 5500000);

-- Kiểm tra số dư trước giao dịch
SELECT * FROM accounts 
WHERE account_id = 1;

-- Bắt đầu transaction
START TRANSACTION ;

-- Cộng thêm 1.000.000 VNĐ vào tài khoản account_id = 1
UPDATE accounts
SET balance = balance + 1000000
WHERE account_id = 1; 

-- Lưu thay đổi nếu ko có lỗi
COMMIT ;

-- Kiểm tra số dư sau giao dịch
SELECT * FROM accounts 
WHERE account_id = 1;

