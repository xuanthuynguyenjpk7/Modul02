CREATE DATABASE TSU_PTON_260202_NGUYENTHIXUANTHUY;
USE TSU_PTON_260202_NGUYENTHIXUANTHUY;

CREATE TABLE passenger (
passenger_id VARCHAR(5) PRIMARY KEY,
passenger_full_name VARCHAR(100) NOT NULL,
passenger_email VARCHAR(100) NOT NULL,
passenger_phone VARCHAR(15) NOT NULL,
passenger_cccd VARCHAR(20) NOT NULL
)

CREATE TABLE trains (
train_id VARCHAR(5) PRIMARY KEY,
train_name VARCHAR(100) NOT NULL,
train_type VARCHAR(10) NOT NULL,
total_seats INT NOT NULL
)

CREATE TABLE tickets (
ticket_id VARCHAR(5) PRIMARY KEY,
passenger_id VARCHAR(5) NOT NULL,
train_id VARCHAR(5) NOT NULL,
departure_date DATE NOT NULL,
seat_number VARCHAR(10) NOT NULL,
ticket_price DECIMAL(10,2) NOT NULL,
FOREIGN KEY (passenger_id) REFERENCES passenger (passenger_id),
FOREIGN KEY (train_id) REFERENCES trains (train_id)
)

CREATE TABLE paymenttransactions (
transaction_id VARCHAR(5) PRIMARY KEY,
ticket_id VARCHAR(5) NOT NULL,
payment_method VARCHAR(50) NOT NULL,
transaction_date DATE NOT NULL,
amount DECIMAL(10,2) NOT NULL,
FOREIGN KEY (ticket_id) REFERENCES tickets (ticket_id)
)

INSERT INTO passenger (passenger_id, passenger_full_name, passenger_email, passenger_phone, passenger_cccd)
VALUES 
('P001', 'Nguyen Van An', 'an.nguyen@example.com', '0912345678', '001234567890'),
('P002', 'Tran Thi Binh', 'binh.tran@example.com', '0923456789', '002345678901'),
('P003', 'Le Minh Chau', 'chau.le@example.com', '0934567890', '003456789012'),
('P004', 'Pham Quoc Dat', 'dat.pham@example.com', '0945678901', '004567890123'),
('P005', 'Nguyen Van An', 'em.vo@example.com', '0956789012', '005678901234')

INSERT INTO trains (train_id, train_name, train_type, total_seats)
VALUES 
('T001', 'Tau Thong Nhat 1', 'SE', 500),
('T002', 'Tau Thong Nhat 2', 'TN', 450),
('T003', 'Tau Sai Gon - Hue', 'SE', 400),
('T004', 'Tau Ha Noi - Lao Cai', 'TN', 350),
('T005', 'Tau Da Nang Express', 'SE', 300)

INSERT INTO tickets (ticket_id, passenger_id, train_id, departure_date, seat_number, ticket_price)
VALUES 
('TK001', 'P001', 'T001', '2025-06-10', 'A01', 850000),
('TK002', 'P002', 'T002', '2025-06-11', 'B05', 650000),
('TK003', 'P003', 'T003', '2025-06-12', 'C10', 720000),
('TK004', 'P004', 'T004', '2025-06-13', 'D12', 500000),
('TK005', 'P005', 'T005', '2025-06-10', 'E08', 900000)

INSERT INTO paymenttransactions (transaction_id, ticket_id, payment_method, transaction_date, amount)
VALUES 
('TR001', 'TK001', 'Credit Card', '2025-06-01', 850000),
('TR002', 'TK002', 'Cash', '2025-06-02', 650000),
('TR003', 'TK003', 'Bank Transfer', '2025-06-03', 720000),
('TR004', 'TK004', 'E-Wallet', '2025-06-04', 500000),
('TR005', 'TK005', 'Credit Card', '2025-06-05', 900000)


-- 3. Cập nhật dữ liệu (6 điểm) Viết câu lệnh UPDATE giảm giá vé 15% 
-- (price = price * 0.85) cho các vé tàu có ngày khởi hành trước ngày 2025-05-01.
SET SQL_SAFE_UPDATES = 0;
UPDATE tickets 
SET ticket_price = ticket_price * 0.85
WHERE departure_date > '2025-05-01';

-- 4. 4. Xóa dữ liệu (6 điểm) Viết câu lệnh DELETE 
-- xóa các giao dịch có phương thức là "E-Wallet" 
-- và số tiền nhỏ hơn 200.000 VNĐ.
DELETE FROM paymenttransactions
WHERE payment_method = "E-Wallet" 
AND amount < 200000;

-- PHẦN 2: Truy vấn dữ liệu
-- 5. (3 điểm) Lấy thông tin hành khách gồm: 
-- mã HK, họ tên, email, SĐT sắp xếp theo họ tên giảm dần.
SELECT passenger_id, passenger_full_name, passenger_email, passenger_phone
FROM passenger
ORDER BY passenger_full_name DESC;

-- 6. (3 điểm) Lấy danh sách đoàn tàu gồm: 
-- mã tàu, tên tàu, tổng số ghế, sắp xếp theo số ghế tăng dần.
SELECT train_id, train_name, total_seats
FROM trains
ORDER BY total_seats ASC;

-- 7. (3 điểm) Lấy thông tin vé đã đặt gồm: 
-- Họ tên hành khách, Tên tàu, Ngày khởi hành, Số ghế.
SELECT passenger_full_name, train_name, departure_date, seat_number
FROM passenger p
JOIN  tickets tk ON p.passenger_id = tk.passenger_id 
JOIN trains tr ON tk.train_id = tr.train_id;

-- 8. (3 điểm) Lấy danh sách hành khách và tổng tiền đã thanh toán: 
-- mã HK, họ tên, phương thức thanh toán, số tiền thanh toán, 
-- sắp xếp theo số tiền tăng dần.
SELECT p.passenger_id, 
	 p.passenger_full_name,
	pm.payment_method, 
	SUM(pm.amount) AS total_amount
FROM passenger p
JOIN tickets tk ON p.passenger_id = tk.passenger_id
JOIN paymenttransactions pm ON tk.ticket_id = pm.ticket_id
GROUP BY p.passenger_id, 
		p.passenger_full_name,
        pm.payment_method
ORDER BY total_amount ASC;

-- 9. (3 điểm) Lấy thông tin hành khách từ vị trí thứ 3 đến thứ 5 
-- trong bảng Passengers sắp xếp theo tên (Z-A).
select * FROM passenger
ORDER BY passenger_full_name DESC
LIMIT 3 OFFSET 2;

-- 10. (5 điểm) Liệt kê các hành khách đã đặt ít nhất 3 vé tàu.
SELECT  p.passenger_id,
		p.passenger_full_name,
        COUNT(tk.ticket_id) AS total_tickets
FROM passenger p
JOIN tickets tk ON p.passenger_id = tk.passenger_id
GROUP BY p.passenger_id,
		p.passenger_full_name
HAVING COUNT(tk.ticket_id) >= 3;

-- 11. (5 điểm) Liệt kê các đoàn tàu đã có hơn 10 lượt khách đặt vé.
SELECT tr.train_id,
		tr.train_name,
        tr.train_type,
        COUNT(tk.ticket_id) AS total_tickets
FROM trains tr
JOIN tickets tk ON tr.train_id = tk.train_id
GROUP BY 
	tr.train_id,
    tr.train_name
HAVING total_tickets > 10;

-- 12. (5 điểm) Lấy danh sách hành khách có tổng tiền giao dịch > 2.000.000 VNĐ, 
-- gồm: mã HK, họ tên, mã tàu, tổng tiền.
SELECT p.passenger_id,
		p.passenger_full_name,
       tr.train_id,
       SUM(pm.amount) AS total_amount
FROM passenger p
JOIN tickets tk ON p.passenger_id = tk.passenger_id
JOIN paymenttransactions pm ON tk.ticket_id = pm.ticket_id
JOIN trains tr ON tk.train_id = tr.train_id 
GROUP BY 
	p.passenger_id,
	p.passenger_full_name,
	tr.train_id
HAVING total_amount > 2000000;

-- 13. (6 điểm) Lấy danh sách hành khách có tên chứa chữ "Hoàng" 
-- hoặc địa chỉ email thuộc miền "@gmail.com". Sắp xếp theo tên tăng dần.
SELECT passenger_id,
		passenger_full_name,
        passenger_email
FROM passenger
WHERE passenger_full_name LIKE '%Hoàng%'
OR  passenger_email LIKE '%gmail.com'
ORDER BY passenger_full_name ASC;

-- 14. (4 điểm)  Lấy danh sách đoàn tàu (trang thứ 2, mỗi trang 5 bản ghi) 
-- sắp xếp theo số ghế giảm dần.
SELECT *
FROM trains
ORDER BY total_seats DESC
LIMIT 5 OFFSET 5;

-- PHẦN 3: Tạo View
-- 15. (5 điểm) Tạo view vw_UpcomingTrips hiển thị thông tin tàu và 
-- hành khách đã đặt vé với ngày khởi hành sau ngày 2025-06-01, 
-- gồm: Họ tên, Tên tàu, Số ghế, Giá vé, Ngày khởi hành.
CREATE VIEW vw_UpcomingTrips AS
SELECT p.passenger_full_name,
		tr.train_name,
        tk.seat_number,
        tk.ticket_price,
        tk.departure_date
FROM passenger p
JOIN tickets tk ON p.passenger_id = tk.passenger_id
JOIN trains tr ON tk.train_id = tr.train_id
WHERE tk.departure_date < '2025-06-01'
GROUP BY p.passenger_id, tk.train_id;

-- 16. (5 điểm) Tạo view vw_HighValueTickets hiển thị khách 
-- hàng đặt vé có giá trị trên 500.000 VNĐ, gồm: Họ tên, Tên tàu, Số ghế, Giá vé.

CREATE VIEW vw_HighValueTickets AS
SELECT p.passenger_full_name,
		tr.train_name,
        tk.seat_number,
        tk.ticket_price
FROM passenger p
JOIN tickets tk ON p.passenger_id = tk.passenger_id
JOIN trains tr ON tk.train_id = tr.train_id
WHERE tk.ticket_price > 500000
GROUP BY p.passenger_id, tk.train_id;

-- PHẦN 4: Tạo Trigger
-- 17. (5 điểm) Tạo trigger tg_check_ticket_date kiểm tra khi chèn vào bảng Tickets. 
-- Nếu ngày khởi hành nhỏ hơn ngày hiện tại thì báo lỗi 
-- "Ngày khởi hành không hợp lệ" và hủy thao tác.

DELIMITER $$
CREATE TRIGGER tg_check_ticket_date 
BEFORE INSERT ON tickets
FOR EACH ROW
BEGIN
	IF  NEW.departure_date < CURDATE() THEN 
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Ngày khởi hành không hợp lệ';
    END IF;
END $$
DELIMITER ;

-- 18. (5 điểm) Tạo trigger tg_update_seats tự động giảm total_seats của 
-- bảng Trains đi 1 khi có một bản ghi mới được thêm vào bảng Tickets.

DELIMITER $$
CREATE TRIGGER tg_update_seats
AFTER INSERT ON tickets
FOR EACH ROW
BEGIN
	UPDATE trains 
    SET total_seats = total_seats - 1
    WHERE train_id = NEW.train_id;
END $$
DELIMITER ;

-- PHẦN 5: Tạo Store Procedure
-- 19. (5 điểm) Viết Procedure sp_add_passenger để thêm mới một hành khách.
DELIMITER $$
CREATE Procedure sp_add_passenger (
		IN p_passenger_id INT,
        IN p_passenger_full_name VARCHAR(100),
        IN p_passenger_email VARCHAR(100),
        IN p_passenger_phone VARCHAR(15),
        IN p_passenger_cccd VARCHAR(20)
)
BEGIN 
	INSERT INTO passenger (
        passenger_id,
        passenger_full_name,
        passenger_email,
		passenger_phone,
        passenger_cccd
    )
    VALUES (
        p_passenger_id,
        p_passenger_full_name,
        p_passenger_email,
		p_passenger_phone,
        p_passenger_cccd
    );
END $$
DELIMITER ;


-- 20. (5 điểm) Viết Procedure sp_cancel_ticket nhận vào p_ticket_id, 
-- thực hiện xóa vé trong bảng Tickets và 
-- các giao dịch liên quan trong bảng PaymentTransactions.

DELIMITER $$
CREATE PROCEDURE sp_cancel_ticket (
IN p_ticket_id INT
)
BEGIN 
DELETE FROM paymenttransactions
WHERE ticket_id = p.ticket_id;

DELETE FROM tickets
WHERE ticket_id = p_ticket_id;
END $$
DELIMITER ;