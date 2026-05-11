SELECT * FROM sinhvien.session05_products;

-- 1. Hiển thị các sản phẩm có:
-- giá cao hơn giá trung bình của tất cả sản phẩm
SELECT *
FROM sinhvien.session05_products
WHERE price > (
    SELECT AVG(price)
    FROM sinhvien.session05_products
);

-- 2. Hiển thị sản phẩm có:
-- giá cao nhất trong từng loại sản phẩm
SELECT * FROM sinhvien.session05_products p1
WHERE price = (
SELECT MAX(price)
FROM sinhvien.session05_products p2
WHERE p1.category = p2.category
);

-- 3. Hiển thị các sản phẩm thuộc loại:
-- có ít nhất một sản phẩm giá trên 20.000.000
SELECT * FROM sinhvien.session05_products
WHERE category IN (
SELECT category	
FROM sinhvien.session05_products
WHERE price > 20000000
);


