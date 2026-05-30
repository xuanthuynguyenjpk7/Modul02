USE ecommerce;

-- Stored Procedure sp_create_order:
# Tạo một Stored Procedure có tên sp_create_order.
# Thủ tục này sẽ nhận các tham số đầu vào: customer_id, product_id, quantity, và price.
# Bên trong thủ tục, sử dụng Transaction để quản lý:
# Bắt đầu giao dịch bằng lệnh BEGIN.
# Kiểm tra số lượng tồn kho. Nếu không đủ, ROLLBACK và thông báo lỗi.
# Nếu đủ, thực hiện các thao tác sau:
# Thêm một đơn hàng mới vào bảng orders.
# Lấy order_id vừa tạo bằng LAST_INSERT_ID().
# Thêm sản phẩm vào bảng order_items.
# Cập nhật (giảm) số lượng tồn kho trong bảng inventory.
# COMMIT giao dịch.
DELIMITER $$
CREATE PROCEDURE sp_create_order (
    IN p_customer_id INT,
    IN p_product_id INT,
    IN p_quantity INT,
    IN p_price DECIMAL(10,2)
)
BEGIN

     DECLARE current_stock INT;
    DECLARE new_order_id INT;
    START TRANSACTION;
    SELECT inventory.stock_quantity INTO current_stock
    FROM inventory
    WHERE product_id = p_product_id;
IF current_stock < p_quantity THEN
      ROLLBACK ;
    SIGNAL  SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Số lượng tồn kho không đủ!';

    ELSE
    INSERT INTO orders (customer_id, order_date, total_amount, status)
        VALUES(p_customer_id,'2023-03-12 03:23:50', 23000, 'Pending');
    SET new_order_id = LAST_INSERT_ID();
 -- cách 2: SELECT MAX(id) into new_order_id FROM orders;

    INSERT INTO order_items(order_id, product_id, quantity, price)
        VALUES(new_order_id, p_product_id, p_quantity, p_price);
UPDATE inventory
    SET stock_quantity = stock_quantity - p_quantity
    WHERE product_id = p_product_id;
    COMMIT ;
END if;
END $$


# Stored Procedure sp_pay_order:
#
# Tạo một Stored Procedure có tên sp_pay_order.
# Thủ tục này sẽ nhận hai tham số: order_id và payment_method.
# Sử dụng Transaction để quản lý:
# Bắt đầu giao dịch.
# Kiểm tra trạng thái đơn hàng. Nếu không phải 'Pending', ROLLBACK và thông báo lỗi.
# Nếu là 'Pending', thực hiện các thao tác:
# Thêm bản ghi thanh toán vào bảng payments.
# Cập nhật trạng thái đơn hàng trong bảng orders thành 'Completed'.
# COMMIT giao dịch.

DELIMITER $$
CREATE PROCEDURE sp_pay_order(
    IN p_order_id INT,
    IN p_payment_method VARCHAR(20)
)
BEGIN
    DECLARE order_status VARCHAR(30);
    START TRANSACTION ;
    SELECT orders.status
    INTO order_status
    FROM orders
    WHERE order_id = p_order_id;
    IF order_status <> 'pending' THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Đơn hàng có trạng thái khác pending!';
    ELSE
        INSERT INTO payments(order_id, payment_method, status)
        VALUES (p_order_id, p_payment_method);
        UPDATE orders
        SET status = 'Completed'
        WHERE order_id = p_order_id;
        COMMIT;
    END IF;
END$$

# Stored Procedure sp_cancel_order:
#
# Tạo một Stored Procedure có tên sp_cancel_order.
# Thủ tục này sẽ nhận tham số order_id.
# Sử dụng Transaction để quản lý:
# Bắt đầu giao dịch.
# Kiểm tra trạng thái đơn hàng. Nếu không phải 'Pending', ROLLBACK và thông báo lỗi.
# Nếu là 'Pending', thực hiện các thao tác:
# Hoàn trả số lượng hàng vào kho bằng cách cập nhật bảng inventory.
# Xóa các sản phẩm liên quan khỏi bảng order_items.
# Cập nhật trạng thái đơn hàng trong bảng orders thành 'Cancelled'.
# COMMIT giao dịch.

DELIMITER $$
CREATE PROCEDURE sp_cancel_order(
    IN sp_order_id INT
)
BEGIN
    DECLARE v_status VARCHAR(20);
    START TRANSACTION ;
    SELECT status
    INTO v_status
    FROM orders
    WHERE order_id = sp_order_id;
    IF v_status <> 'pending' THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Đơn hàng không phải trạng thái pending!';
    ELSE
        UPDATE inventory i JOIN order_items oi ON i.product_id = oi.product_id
        SET stock_quantity = stock_quantity + oi.quantity
        WHERE i.product_id = oi.product_id;

        DELETE
        FROM order_items
        WHERE order_id = sp_order_id;

        UPDATE orders
        SET status = 'Cancelled'
        WHERE order_id = sp_order_id;
        COMMIT;
    END IF;
END$$


DROP PROCEDURE sp_create_order;
DROP PROCEDURE sp_pay_order;
DROP PROCEDURE sp_cancel_order;