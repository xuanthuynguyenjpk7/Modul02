USE ss06_luyentap2;


-- Thêm một đơn hàng mới
SELECT * FROM orders;
INSERT INTO orders (id, customer_id, order_date)
VALUES (3, 1, '2026-05-18');

-- Thêm chi tiết đơn hàng vào order_details
SELECT * FROM order_details;
INSERT INTO order_details (order_id, product_id, quantity, price)
VALUES
(3, 1, 2, 1200),
(3, 3, 1, 1500);

-- Tính tổng doanh thu toàn bộ cửa hàng
SELECT 
SUM(quantity * price) AS total_revenue
FROM order_details;

-- Tính doanh thu trung bình mỗi đơn hàng
SELECT 	
AVG(order_total) AS average_total_revenue -- Tính trung bình từ tổng từng đơn
FROM ( -- Tính tổng tiền từng đơn hàng
SELECT 
order_id,
SUM(quantity * price) AS order_total
FROM order_details
GROUP BY order_id
) AS temp;

-- Tìm đơn hàng có doanh thu cao nhất
SELECT 
order_id
SUM(quantity*price) AS total
FROM order_details
GROUP BY order_id -- tính tổng cho từng đơn
ORDER BY total DESC  -- sxep lớn đến nhỏ
LIMIT 1; -- Chỉ lấy 1 dòng đầu tiên, → tức là đơn hàng doanh thu cao nhất.

-- Top 3 sản phẩm bán chạy nhất
SELECT
products.name,
SUM(order_details.quantity) AS total_sold -- Tính tổng số lượng đã bán.
FROM order_details
INNER JOIN products
ON order_details.product_id = products.id -- → để lấy tên sản phẩm
GROUP BY products.name -- Gom theo từng sản phẩm.
ORDER BY total_sold DESC  -- Sắp xếp bán nhiều nhất lên đầu.
LIMIT 3; -- Lấy top 3 sản phẩm trên cùng