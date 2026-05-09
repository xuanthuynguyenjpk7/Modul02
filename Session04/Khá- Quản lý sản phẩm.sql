-- Thêm dữ liệu (INSERT)
-- Thêm ít nhất 5 sản phẩm vào bảng products
-- Trong đó:
-- Có ít nhất 2 sản phẩm thuộc loại Laptop
-- Có ít nhất 1 sản phẩm thuộc loại Phone

SELECT * FROM student.products;
INSERT INTO student.products (product_id, product_name, price, stock_quantity)
VALUES 
('10', 'Iphone', '25000000.00', '13'),
('7', 'Iphone', '27000000.00', '18'),
('8', 'Laptop', '58000000.00', '11'),
('9', 'Laptop', '62000000.00', '8');
SELECT * FROM student.products;

-- Truy vấn dữ liệu (SELECT)
-- Hiển thị sản phẩm có giá từ 800.000 đến 65.000.000

SELECT * FROM student.products
WHERE price BETWEEN 800000.00 AND 65000000.00;
SELECT * FROM student.products;

-- Hiển thị sản phẩm thuộc loại Laptop hoặc Tablet
SELECT * FROM student.products
WHERE product_name = 'Laptop' OR product_name = 'Tablet';
SELECT * FROM student.products;

-- Hiển thị sản phẩm có tên bắt đầu bằng “Sam”
SELECT * FROM student.products
WHERE product_name LIKE '%Sam%';

-- Hiển thị sản phẩm không thuộc loại Phone
SELECT * FROM student.products
WHERE NOT product_name LIKE '%Phone%';

-- Cập nhật & xóa dữ liệu (UPDATE – DELETE)
-- Giảm giá 5% cho các sản phẩm thuộc loại Laptop
SELECT * FROM student.products;
UPDATE student.products
SET price = price * 0.5
WHERE product_name LIKE '%Laptop%';

SELECT * FROM student.products
WHERE product_name LIKE '%Laptop%';
ROLLBACK;

-- Xóa các sản phẩm có số lượng tồn kho bằng 0
SELECT * FROM student.products;
DELETE FROM student.products
WHERE stock_quantity = 0;
SELECT * FROM student.products;