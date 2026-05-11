SELECT * FROM sinhvien.session05_order_items;
-- 1. Hiển thị: mã đơn hàng, ngày đặt hàng, tên khách hàng

SELECT
    o.order_id,
    o.order_date,
    c.customer_name
FROM sinhvien.session05_Orders o
JOIN sinhvien.session05_Customers c
ON o.customer_id = c.customer_id;

---- 2. Hiển thị: danh sách sản phẩm trong mỗi đơn hàng

SELECT
    o.order_id,
    oi.product_name,
    oi.quantity,
    oi.price
FROM sinhvien.session05_Orders o
JOIN sinhvien.session05_Order_items oi
ON o.order_id = oi.order_id;

-- 3. Tính: tổng tiền của mỗi đơn hàng

SELECT
    order_id,
    SUM(quantity * price) AS total_amount
FROM sinhvien.session05_Order_items
GROUP BY order_id;

 -- 4. Hiển thị: các đơn hàng có tổng tiền lớn hơn 10.000.000

SELECT
    order_id,
    SUM(quantity * price) AS total_amount
FROM sinhvien.session05_Order_items
GROUP BY order_id
HAVING SUM(quantity * price) > 10000000;
