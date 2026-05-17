SELECT * FROM session05_customers;
SELECT * FROM session05_orders;

CREATE VIEW v_order_info AS
SELECT 
session05_orders.order_id,
session05_orders.order_date,
session05_customers.customer_name
FROM session05_orders
INNER JOIN session05_customers
ON session05_orders.customer_id = session05_customers.customer_id;
