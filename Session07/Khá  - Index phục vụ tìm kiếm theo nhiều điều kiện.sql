SELECT * FROM sinhvien.orders;

ALTER TABLE sinhvien.orders
ADD order_total DECIMAL(10,2);

CREATE INDEX index_search_status_orderdate
ON sinhvien.orders (status, order_date);