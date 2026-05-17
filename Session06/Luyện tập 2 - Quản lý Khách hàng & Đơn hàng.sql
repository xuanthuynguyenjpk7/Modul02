CREATE DATABASE ss06_luyentap2;
USE ss06_luyentap2;
-- Tạo bảng categories
CREATE TABLE categories (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);

-- Tạo bảng products
CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    price DOUBLE,
    category_id INT,
    
    FOREIGN KEY (category_id)
    REFERENCES categories(id)
);

-- Tạo bảng customers
CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255)
);

-- Tạo bảng orders
-- =========================
CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    
    FOREIGN KEY (customer_id)
    REFERENCES customers(id)
);

-- Tạo bảng order_details
-- =========================
CREATE TABLE order_details (
    order_id INT,
    product_id INT,
    quantity INT,
    price DOUBLE,

    PRIMARY KEY (order_id, product_id),

    FOREIGN KEY (order_id)
    REFERENCES orders(id),

    FOREIGN KEY (product_id)
    REFERENCES products(id)
);

-- Thêm dữ liệu categories
INSERT INTO categories VALUES
(1, 'Điện thoại'),
(2, 'Laptop');

-- Thêm dữ liệu products
INSERT INTO products VALUES
(1, 'iPhone 15', 1200, 1),
(2, 'Samsung S24', 1000, 1),
(3, 'Dell XPS', 1500, 2);

-- Thêm dữ liệu customers
INSERT INTO customers VALUES
(1, 'Nguyen Van A', 'a@gmail.com'),
(2, 'Tran Thi B', 'b@gmail.com');

-- Thêm dữ liệu orders
INSERT INTO orders VALUES
(1, 1, '2026-05-18'),
(2, 2, '2026-05-19');

-- Thêm dữ liệu order_details
INSERT INTO order_details VALUES
(1, 1, 2, 1200),
(1, 2, 1, 1000),
(2, 3, 1, 1500);

-- Liệt kê những khách hàng đã có ít nhất một đơn hàng
SELECT customers.name
FROM customers
INNER JOIN orders
ON customers.id = orders.customer_id;

-- Tìm khách hàng chưa từng đặt đơn hàng nào
SELECT customers.name
FROM customers
LEFT JOIN orders
ON customers.id = orders.customer_id
WHERE orders.id IS NULL;

-- Tính tổng doanh thu mỗi khách hàng mang lại
SELECT
customers.name,
SUM(order_details.quantity * order_details.price) AS total_revenue
FROM customers
INNER JOIN orders
ON customers.id = orders.customer_id
INNER JOIN order_details
ON orders.id = order_details.order_id
GROUP BY customers.name;

-- Xác định khách hàng đã mua sản phẩm có giá cao nhất
SELECT customers.name, products.name, products.price
FROM customers
INNER JOIN orders
ON customers.id = orders.customer_id
INNER JOIN order_details
ON orders.id = order_details.order_id
INNER JOIN products
ON order_details.product_id = products.id
WHERE products.price = (
    SELECT MAX(price)
    FROM products
);