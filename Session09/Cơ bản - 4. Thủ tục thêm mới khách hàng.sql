SELECT * FROM session09_tsu0202.customers;

-- Tạo Stored Procedure thêm khách hàng
DELIMITER $$

CREATE PROCEDURE insert_customer(
    IN in_customer_name VARCHAR(50),
    IN in_email VARCHAR(100),
    IN in_phone VARCHAR(15),
    IN in_address VARCHAR(255)
)
BEGIN

    INSERT INTO customers(
        customer_name,
        email,
        phone,
        address
    )
    VALUES(
        in_customer_name,
        in_email,
        in_phone,
        in_address
    );

    SELECT 'Thêm mới khách hàng thành công' AS message;

END $$

DELIMITER ;

-- Gọi procedure để thêm dữ liệu
CALL insert_customer(
    'Nguyen Van A',
    'nguyenvana@gmail.com',
    '0901234567',
    'Ha Noi'
);

-- Kiểm tra dữ liệu
SELECT * FROM customers;