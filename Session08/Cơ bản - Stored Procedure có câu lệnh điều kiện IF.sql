SELECT 
    *
FROM
    sinhvien.orders;

DELIMITER $$
CREATE PROCEDURE sp_check_order_value(
IN p_order_total DECIMAL(10,2)
)
BEGIN 
IF p_order_total >= 5000000 THEN 
SELECT 'Đơn hàng giá trị cao' AS message;
ELSE 
SELECT 'Đơn hàng bình thường' AS message;
END IF;
END $$

DELIMITER ;

CALL sp_check_order_value(6000000);

CALL sp_check_order_value(3000000);
