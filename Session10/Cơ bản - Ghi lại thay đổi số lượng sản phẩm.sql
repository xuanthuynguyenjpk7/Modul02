CREATE DATABASE InventoryManagement;
USE InventoryManagement;

CREATE TABLE Products (
    productID INT AUTO_INCREMENT PRIMARY KEY,
    productName VARCHAR(100) NOT NULL,
    quantity INT NOT NULL
);

CREATE TABLE InventoryChanges (
    changeID INT AUTO_INCREMENT PRIMARY KEY,
    productID INT,
    oldQuantity INT,
    newQuantity INT,
    changeDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER AfterProductUpdate
AFTER UPDATE ON Products
FOR EACH ROW
BEGIN
    IF OLD.quantity <> NEW.quantity THEN
        INSERT INTO InventoryChanges (
            productID,
            oldQuantity,
            newQuantity
        )
        VALUES (
            OLD.productID,
            OLD.quantity,
            NEW.quantity
        );
    END IF;
END$$

DELIMITER ;

-- Thêm dữ liệu test
INSERT INTO Products(productName, quantity)
VALUES
('Laptop', 10),
('Mouse', 50);

UPDATE Products
SET quantity = 15
WHERE productID = 1;

SELECT * FROM InventoryChanges;