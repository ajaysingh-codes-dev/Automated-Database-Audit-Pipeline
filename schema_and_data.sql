CREATE DATABASE IF NOT EXISTS ecommerce_audit;
USE ecommerce_audit;

CREATE TABLE customer_orders(
order_id INT AUTO_INCREMENT PRIMARY KEY,
customer_name VARCHAR(100) NOT NULL,
product VARCHAR(100) NOT NULL,
quantity INT NOT NULL DEFAULT 1,
amount DECIMAL (10, 2) NOT NULL DEFAULT 0.00,
status VARCHAR(100) NOT NULL DEFAULT 'Pending',
region  VARCHAR(100),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

SELECT * FROM customer_orders;

INSERT INTO customer_orders
(customer_name, product, quantity, amount, status, region)
VALUES
    ('Rimuru Tempest', 'Sword', 1, 2500.00, 'Completed', 'Tempest'),
    ('Benimaru', 'Katana', 1, 1800.00, 'Pending', 'Tempest'),
    ('Shion', 'Great Sword', 2, 3200.00, 'Completed', 'Tempest'),
    ('Souei', 'Kunai', 5, 500.00, 'Pending', 'Tempest'),
    ('Milim Nava', 'Battle Axe', 1, 4500.00, 'Completed', 'Dragon Kingdom'),
    ('Shuna', 'Magic Staff', 1, 2200.00, 'Pending', 'Tempest'),
    ('Hakuro', 'Training Katana', 2, 1200.00, 'Completed', 'Tempest'),
    ('Gobta', 'Iron Spear', 1, 650.00, 'Cancelled', 'Tempest'),
    ('Diablo', 'Demon Sword', 1, 5500.00, 'Completed', 'Tempest'),
    ('Veldora', 'Dragon Gauntlets', 2, 6000.00, 'Pending', 'Cave'),
    ('Hinata Sakaguchi', 'Holy Sword', 1, 4800.00, 'Completed', 'Western Nations'),
    ('Carrion', 'War Axe', 1, 3500.00, 'Pending', 'Eurazania'),
    ('Frey', 'Wing Blades', 2, 2800.00, 'Completed', 'Thalion'),
    ('Gabiru', 'Trident', 1, 1400.00, 'Cancelled', 'Tempest'),
    ('Ranga', 'Magic Claws', 2, 1900.00, 'Pending', 'Tempest');

SELECT * FROM customer_orders;