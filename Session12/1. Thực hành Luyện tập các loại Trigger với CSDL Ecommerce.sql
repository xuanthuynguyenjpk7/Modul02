USE ecommerce;
-- 1. Bảng customers (Khách hàng)
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Bảng orders (Đơn hàng)
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) DEFAULT 0,
    status ENUM('Pending', 'Completed', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

-- 3. Bảng products (Sản phẩm)
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Bảng order_items (Chi tiết đơn hàng)
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 5. Bảng inventory (Kho hàng)
CREATE TABLE inventory (
    product_id INT PRIMARY KEY,
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- 6. Bảng payments (Thanh toán)
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM('Credit Card', 'PayPal', 'Bank Transfer', 'Cash') NOT NULL,
    status ENUM('Pending', 'Completed', 'Failed') DEFAULT 'Pending',
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);

-- Trigger BEFORE INSERT:
-- Tạo Trigger kiểm tra số lượng tồn kho trước khi thêm sản phẩm
-- vào order_items. Nếu không đủ, báo lỗi SQLSTATE '45000'.

CREATE TRIGGER trgbeforeinsertorder
    BEFORE INSERT ON order_items
    FOR EACH ROW
    BEGIN
        DECLARE current_stock INT;
          -- Lấy số lượng tồn kho hiện tại
        SELECT stock_quantity
        INTO current_stock
        FROM inventory
        WHERE product_id = NEW.product_id;
        -- Kiểm tra tồn kho
    IF current_stock < NEW.quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Không đủ số lượng tồn kho';
    END IF;

    END;

DROP TRIGGER trgbeforeinsertorder;
INSERT INTO customers(name, email, phone, address)
VALUES
('Nguyen Van A', 'a@gmail.com', '0901234567', 'Ha Noi');

INSERT INTO orders(customer_id, total_amount, status)
VALUES
(1, 0, 'Pending');

INSERT INTO products(name, price, description)
VALUES
('Laptop', 1500, 'Laptop gaming'),
('Mouse', 25, 'Wireless mouse');

INSERT INTO inventory(product_id, stock_quantity)
VALUES
(1, 10),
(2, 5);

-- Test thử
INSERT INTO order_items(order_id, product_id, quantity, price)
VALUES
(1, 2, 20, 25);

INSERT INTO order_items(order_id, product_id, quantity, price)
VALUES
(1, 1, 2, 1500);
-- Trigger AFTER INSERT:
-- Tạo Trigger cập nhật total_amount trong bảng orders
-- sau khi thêm một sản phẩm mới vào order_items.
CREATE TRIGGER trgafterinsertorder
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
UPDATE orders
SET total_amount = total_amount + (NEW.quantity * NEW.price)
WHERE order_id = NEW.order_id;
END;

SELECT * FROM orders;
INSERT INTO order_items(order_id, product_id, quantity, price)
VALUES (1, 1, 3, 3000);

-- Trigger BEFORE UPDATE:
-- Tạo Trigger kiểm tra số lượng tồn kho trước khi cập nhật
-- số lượng sản phẩm trong order_items.
-- Nếu không đủ, báo lỗi SQLSTATE '45000'.
CREATE TRIGGER trgbeforeupdateorder
    BEFORE UPDATE ON order_items
    FOR EACH ROW
    BEGIN
        DECLARE current_stock INT;
        SELECT stock_quantity
        INTO current_stock
            FROM inventory
        WHERE product_id = NEW.product_id;
        IF current_stock < NEW.quantity THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Không đủ số lượng tồn kho';
        end if;
    end;

-- TEST
UPDATE order_items
SET quantity = 100
WHERE order_item_id = 1;

UPDATE order_items
SET quantity = 9
WHERE order_item_id = 1;

-- Trigger AFTER UPDATE:
-- Tạo Trigger cập nhật lại total_amount trong bảng orders khi
-- số lượng hoặc giá của một sản phẩm trong order_items thay đổi.
CREATE TRIGGER trgafterupdateorder
    AFTER UPDATE ON order_items
    FOR EACH ROW
    BEGIN
        UPDATE orders
            SET total_amount = total_amount + (NEW.quantity * NEW.price)
                                            - (OLD.quantity * OLD.price)
        WHERE order_id = NEW.order_id;
    END;

UPDATE order_items
SET quantity = 5,
    price = 2000
WHERE order_item_id = 1;

UPDATE order_items
SET quantity = 4,
    price = 1000
WHERE order_item_id = 2;

-- Trigger BEFORE DELETE:
-- Tạo Trigger ngăn chặn việc xóa một đơn hàng có trạng thái
-- Completed trong bảng orders. Nếu cố gắng xóa, báo lỗi SQLSTATE '45000'.
CREATE TRIGGER trgbeforedelete
    BEFORE DELETE ON  orders
    FOR EACH ROW
    BEGIN
IF OLD.status = 'Completed' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Không thể xóa đơn hàng với trạng thái Completed';
END IF;
END;

DROP TRIGGER trgbeforedelete;

-- TEST
INSERT INTO orders(customer_id, order_date, status)
VALUES
    (1, '2024-08-09 06:07:49', 'pending'),
   (1, '2026-02-12 12:45:12', 'completed');

DELETE FROM orders
WHERE order_id = 1;

DELETE FROM orders
WHERE order_id = 9;

-- Trigger AFTER DELETE:
-- Tạo Trigger hoàn trả số lượng sản phẩm vào kho (inventory)
-- sau khi một sản phẩm trong order_items bị xóa.
USE ecommerce;
CREATE TRIGGER trgafterdelete
    AFTER DELETE ON order_items
    FOR EACH ROW
    BEGIN
        UPDATE inventory JOIN products p on inventory.product_id = p.product_id
        SET   stock_quantity =  stock_quantity + OLD.quantity
        WHERE p.product_id = OLD.product_id;
    END;

DELETE FROM order_items
WHERE product_id = 1;