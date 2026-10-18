USE ecommerce_audit;

SELECT * FROM customer_orders;

CREATE TABLE trigger_report(
    id INT AUTO_INCREMENT PRIMARY KEY,
    record_id INT NOT NULL,
    table_name VARCHAR(100) NOT NULL,
    customer_name VARCHAR(100),
    action_type ENUM('INSERT', 'DELETE', 'UPDATE') NOT NULL,
    old_data JSON,
    new_data JSON,
    change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TRIGGER IF EXISTS customer_order_on_delete;
CREATE Trigger customer_order_on_delete
AFTER DELETE ON customer_orders FOR EACH ROW
INSERT INTO trigger_report (record_id, table_name, customer_name, action_type, old_data, new_data)
VALUES(OLD.order_id, 'customer_order', OLD.customer_name, 'DELETE', JSON_OBJECT('order_id', OLD.order_id, 'customer_name', OLD.customer_name, 'product', OLD.product, 'status', OLD.status),
NULL
);

DROP TRIGGER IF EXISTS customer_order_on_insert;
CREATE TRIGGER customer_order_on_insert
AFTER INSERT ON customer_orders FOR EACH ROW
INSERT INTO trigger_report (record_id, table_name, customer_name, action_type, old_data, new_data)
VALUES(NEW.order_id, 'customer_order', NEW.customer_name, 'INSERT', NULL,
JSON_OBJECT('order_id', NEW.order_id, 'customer_name', NEW.customer_name, 'product', NEW.product,  'status', NEW.status)
);

DROP TRIGGER IF EXISTS customer_order_on_update;
CREATE TRIGGER customer_order_on_update
AFTER UPDATE ON customer_orders FOR EACH ROW
INSERT INTO trigger_report (record_id, table_name, customer_name, action_type, old_data, new_data)
VALUES(NEW.order_id, 'customer_order', NEW.customer_name, 'UPDATE', JSON_OBJECT('order_id', OLD.order_id, 'customer_name', OLD.customer_name, 'product', OLD.product, 'status', OLD.status),
JSON_OBJECT('order_id', NEW.order_id, 'customer_name', NEW.customer_name, 'product', NEW.product,  'status', NEW.status)
);

SELECT * FROM customer_orders;

UPDATE customer_orders
SET status = 'completed'
WHERE customer_name = 'Benimaru';

SELECT * FROM trigger_report;