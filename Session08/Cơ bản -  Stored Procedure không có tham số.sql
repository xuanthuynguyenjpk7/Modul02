SELECT * FROM sinhvien.session03_students;
-- Tạo một Stored Procedure có tên sp_get_all_students
DELIMITER $$
CREATE PROCEDURE sp_get_all_students()
BEGIN
SELECT * FROM sinhvien.session03_students;
END $$
DELIMITER ;

-- Gọi Stored Procedure
CALL sp_get_all_students();