USE ss06_luyentap2;

-- Liệt kê sản phẩm cùng tên danh mục tương ứng
SELECT
products.name AS product_name,
categories.name AS category_name
FROM products
INNER JOIN categories
ON products.category_id = categories.id; -- → nối sản phẩm với danh mục của nó.

-- Đếm số đơn hàng của từng khách hàng
	SELECT 
	customers.name,
	COUNT(orders.id) AS total_orders
	FROM customers
	LEFT JOIN orders
	ON customers.id = orders.customer_id
	GROUP BY customers.name;
    
    -- Tìm 5 khách hàng chi tiêu nhiều nhất
    SELECT 
    customers.name,
    SUM(order_details.quantity * order_details.price) AS total_spent
    FROM customers
    INNER JOIN orders
    ON customers.id = orders.customer_id
    INNER JOIN order_details
    ON orders.id = order_details.order_id
    GROUP BY customers.name
    ORDER BY total_spent DESC
    LIMIT 5;
    
    -- Tìm sản phẩm chưa từng xuất hiện trong đơn hàng nào
    SELECT 
    products.name
    FROM products
    LEFT JOIN order_details
    ON products.id = order_details.product_id
    WHERE order_details.product_id IS NULL;
    
    -- Tìm khách hàng đã mua sản phẩm thuộc danh mục có nhiều sản phẩm nhất
    SELECT DISTINCT customers.name
FROM customers
INNER JOIN orders
ON customers.id = orders.customer_id
INNER JOIN order_details
ON orders.id = order_details.order_id
INNER JOIN products
ON order_details.product_id = products.id
WHERE products.category_id = (
    SELECT category_id
    FROM products
    GROUP BY category_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);