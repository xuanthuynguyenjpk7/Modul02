SELECT * FROM sinhvien.session05_products;

CREATE INDEX idx_category_price
ON sinhvien.session05_products(category, price);