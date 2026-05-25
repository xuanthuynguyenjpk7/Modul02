SELECT * FROM inventorymanagement.products;
DELIMITER $$

CREATE TRIGGER BeforeProductDelete
BEFORE DELETE ON products
FOR EACH ROW 
BEGIN 
     IF OLD.quantity > 10 THEN
     SIGNAL SQLSTATE '45000'
     SET MESSAGE_TEXT = 'Không thể xóa sản phẩm có số lượng lớn hơn 10';
     END IF;
END $$

DELIMITER ;

SELECT * FROM products;

-- Thử xóa spham
DELETE FROM products
WHERE productID = 1;

DELETE FROM products
WHERE productID = 3;
