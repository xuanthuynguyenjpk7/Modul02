SELECT * FROM session09_tsu0202.customers;

-- Tạo VIEW
CREATE VIEW view_customer_contact AS
SELECT 
    customer_id,
    customer_name,
    email,
    phone
FROM session09_tsu0202.customers;

-- Xem dữ liệu trong VIEW
SELECT * 
FROM view_customer_contact;