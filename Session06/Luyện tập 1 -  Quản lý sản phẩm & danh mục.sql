CREATE DATABASE ss06_tsu0202;
USE ss06_tsu0202;

CREATE TABLE categories (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR (255)
);

CREATE TABLE products (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(255),
price DOUBLE,
category_id INT,

FOREIGN KEY (category_id)
REFERENCES categories(id)
);

INSERT INTO categories (name)
VALUES
('Điện thoại'),
('Laptop'),
('Phụ kiện');

INSERT INTO products (name, price, category_id)
VALUES
('iphone 15', 25000000, 1),
('Macbook Air M2', 32000000, 2),
('Tai nghe Bluetooth', 15000000, 3);

SELECT * FROM products;
-- Cập nhật giá của 1 sản phẩm đã có
UPDATE products
SET price = 37000000
WHERE id = 2;

-- Xóa 1 sản phẩm
DELETE FROM products
WHERE id = 1;

-- Hiển thị tất cả sản phẩm, sắp xếp theo giá tăng dần
SELECT * FROM products
ORDER BY price ASC;

-- sắp xếp theo giá giảm dần
SELECT * FROM products
ORDER BY price DESC;

-- Thống kê số lượng sản phẩm cho từng danh mục
SELECT
categories.name AS category_name,
COUNT(products.id) AS total_products
FROM categories
LEFT JOIN products
ON categories.id = products.category_id
GROUP BY categories.name;