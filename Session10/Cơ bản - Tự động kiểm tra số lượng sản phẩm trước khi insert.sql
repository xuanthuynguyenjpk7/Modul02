SELECT * FROM inventorymanagement.products;
DELIMITER $$

CREATE TRIGGER BeforeInsertProduct
BEFORE INSERT ON products
FOR EACH ROW
BEGIN 
     IF NEW.quantity < 0 THEN 
     SIGNAL SQLSTATE '45000'
     SET message_text = 'So luong san pham khong duoc nho hon 0';
     END IF;
END $$

DELIMITER ;

SELECT * FROM inventorymanagement.products;

-- insert thử
INSERT INTO products(productName, quantity)
VALUES ('Monitor', -5);

INSERT INTO products(productName, quantity)
VALUES ('TAblet', 5);