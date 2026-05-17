SELECT * FROM ss06_tsu0202.products;

-- Tìm sản phẩm có giá nằm trong một khoảng cụ thể
-- Ex:  Tìm sản phẩm giá từ 500 đến 1500
SELECT *
FROM products
WHERE price BETWEEN 500 AND 1500;

-- Tìm sản phẩm có tên chứa chuỗi ký tự nhất định
-- (Tìm sản phẩm có chữ "Phone")
SELECT * FROM products
WHERE name LIKE '%phone%';

-- Tính giá trung bình sản phẩm cho mỗi danh mục
SELECT
category_id,
AVG(price) AS average_price
FROM products
GROUP BY category_id;

-- Tìm sản phẩm có giá cao hơn mức trung bình của toàn bộ sản phẩm
SELECT * FROM products
WHERE price > (
SELECT AVG(price)
FROM products
);

-- Tìm sản phẩm có giá thấp nhất cho từng danh mục
SELECT * FROM products p
WHERE price = (
SELECT MIN(price)
FROM products
WHERE category_id = p.category_id
);
