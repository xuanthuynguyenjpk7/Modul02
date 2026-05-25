USE session09_tsu0202;
-- Tạo bảng products
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    price DOUBLE NOT NULL CHECK (price > 0),
    stock INT NOT NULL CHECK (stock > 0)
);

-- Thêm 20 bản ghi
INSERT INTO products(product_name, price, stock)
VALUES
('Laptop Dell', 18000000, 10),
('Laptop HP', 16500000, 8),
('Chuột Logitech', 450000, 50),
('Bàn phím cơ', 1200000, 20),
('Màn hình Samsung', 3500000, 15),
('Tai nghe Sony', 2200000, 25),
('USB 64GB', 250000, 40),
('Ổ cứng SSD 1TB', 2100000, 18),
('Điện thoại iPhone', 25000000, 5),
('Điện thoại Samsung', 19000000, 7),
('Máy in Canon', 3200000, 6),
('Webcam Logitech', 950000, 14),
('Loa Bluetooth', 1500000, 30),
('Smartwatch', 4200000, 12),
('Router Wifi', 890000, 16),
('Máy tính bảng', 11000000, 9),
('Camera an ninh', 2700000, 11),
('Sạc dự phòng', 650000, 22),
('Máy chiếu', 12500000, 4),
('Micro thu âm', 1750000, 13);

-- Tạo Stored Procedure
DELIMITER $$

CREATE PROCEDURE get_high_value_products()
BEGIN
    SELECT *
    FROM products
    WHERE price > 1000000;
END $$

DELIMITER ;

-- Gọi procedure để kiểm tra kết quả
CALL get_high_value_products();