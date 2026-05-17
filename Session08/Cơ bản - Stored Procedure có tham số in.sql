SELECT * FROM sinhvien.session05_products;

-- Stored Procedure có tham số IN
DELIMITER $$
CREATE PROCEDURE sp_get_products_by_category(
IN p_category VARCHAR(200)
)
BEGIN 
SELECT * FROM sinhvien.session05_products
WHERE category = p_category;
END $$

DELIMITER ;

CALL sp_get_products_by_category('Phone');
