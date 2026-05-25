SELECT * FROM session11_tsu0202.accounts;

-- Tạo Stored Procedure withdraw_money
DELIMITER $$

CREATE PROCEDURE withdraw_money(
    IN p_account_id INT,
    IN p_amount DECIMAL(15,2)
)

BEGIN

    DECLARE current_balance DECIMAL(15,2);

    START TRANSACTION;

    -- Trừ tiền trước
    UPDATE session11_tsu0202.accounts
    SET balance = balance - p_amount
    WHERE account_id = p_account_id;

    -- Lấy số dư sau khi trừ
    SELECT balance
    INTO current_balance
    FROM session11_tsu0202.accounts
    WHERE account_id = p_account_id;

    -- Kiểm tra
    IF current_balance < 0 THEN

        ROLLBACK;

        SELECT 'Số dư không đủ' AS message;

    ELSE

        COMMIT;

        SELECT 'Rút tiền thành công' AS message;

    END IF;

END $$

DELIMITER ;

-- Kiểm tra số dư trước khi test
SELECT * FROM accounts WHERE account_id = 2;

-- Trường hợp 1: Thất bại
-- Rút 1000000 từ tài khoản chỉ có 700000
CALL withdraw_money(2, 10000000);

-- Kiểm tra lại số dư
SELECT * FROM accounts WHERE account_id = 2;

-- Trường hợp 2: Rút Thành công
CALL withdraw_money(2, 3000000);
-- Kiểm tra lại số dư
SELECT * FROM accounts WHERE account_id = 2;
