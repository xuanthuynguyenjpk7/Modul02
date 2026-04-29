CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL
);

INSERT INTO products (product_name, price, stock_quantity)
VALUES 
('Áo thun nam', 150000.00, 50),
('Quần jean nữ', 350000.00, 30),
('Giày thể thao', 800000.00, 20),
('Túi xách', 500000.00, 15),
('Mũ lưỡi trai', 120000.00, 40);
