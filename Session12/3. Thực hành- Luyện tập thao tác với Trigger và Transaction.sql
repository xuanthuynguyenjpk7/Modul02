USE ecommerce;
CREATE TABLE order_logs
(
    log_id     INT PRIMARY KEY AUTO_INCREMENT,
    order_id   INT NOT NULL,
    old_status ENUM ('Pending', 'Completed', 'Cancelled'),
    new_status ENUM ('Pending', 'Completed', 'Cancelled'),
    log_date   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders (order_id) ON DELETE CASCADE
);

# Tạo bảng và Trigger BEFORE INSERT:
# Tạo một Trigger có tên before_insert_check_payment.
# Trigger này sẽ được kích hoạt trước khi chèn dữ liệu vào bảng payments.
# Nó sẽ kiểm tra xem số tiền thanh toán (amount) có khớp với tổng tiền đơn hàng (total_amount) hay không.
# Nếu không khớp, Trigger sẽ báo lỗi SQLSTATE '45000'.
DELIMITER $$
CREATE TRIGGER trg_before_insert_check_payment
    BEFORE INSERT
    ON payments
    FOR EACH ROW
BEGIN
    DECLARE v_total_amount DECIMAL(10, 2);
    SELECT total_amount
    INTO v_total_amount
    FROM orders
    WHERE order_id = NEW.order_id;
    IF NEW.amount <> v_total_amount THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Số tiền thanh toán không khớp với tổng tiền đơn hàng!';
    END IF;
END$$

DROP TRIGGER trg_before_insert_check_payment;


# Tạo Trigger AFTER UPDATE:
# Tạo một Trigger có tên after_update_order_status.
#     Trigger này sẽ được kích hoạt sau khi cập nhật trạng thái của đơn hàng trong bảng orders.
#     Nếu trạng thái có sự thay đổi (OLD.status khác NEW.status),
#     Trigger sẽ tự động ghi log vào bảng order_logs.

DELIMITER $$
CREATE TRIGGER trigger_after_update_order_status
    AFTER UPDATE
    ON orders
    FOR EACH ROW
BEGIN
    IF OLD.status <> NEW.status THEN
        INSERT INTO order_logs(order_id, old_status, new_status)
        VALUES (OLD.order_id, OLD.status, NEW.status);
    END IF;
END$$
DELIMITER ;

# Viết Stored Procedure:
#
# Tạo một Stored Procedure có tên sp_update_order_status_with_payment.
# Thủ tục này sẽ nhận các tham số đầu vào cần thiết
# (ví dụ: order_id, new_status, payment_amount, payment_method).
# Bên trong thủ tục, sử dụng Transaction để quản lý:
# Bắt đầu giao dịch bằng lệnh BEGIN.
# Sử dụng một khối BEGIN...END và DECLARE EXIT HANDLER FOR SQLEXCEPTION
# để xử lý lỗi một cách hiệu quả.
# Kiểm tra trạng thái đơn hàng. Nếu trạng thái đã giống với new_status, ROLLBACK và thông báo lỗi.
# Nếu new_status là 'Completed', thực hiện:
# Thêm bản ghi thanh toán vào bảng payments.
# (Trigger before_insert_check_payment sẽ tự động kiểm tra số tiền).
# Cập nhật trạng thái đơn hàng trong bảng orders.
# (Trigger after_update_order_status sẽ tự động ghi log).
# Nếu tất cả các bước thành công, COMMIT giao dịch.
# Nếu có lỗi, khối EXIT HANDLER sẽ bắt lỗi và ROLLBACK để đảm bảo dữ liệu không bị sai lệch.