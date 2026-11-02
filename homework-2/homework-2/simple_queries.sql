SELECT contact_name, city 
FROM customers;

SELECT order_id, shipped_date - order_date AS days_to_ship
FROM orders;

SELECT DISTINCT city 
FROM customers;

SELECT COUNT(*) 
FROM orders;

SELECT COUNT(DISTINCT ship_country) 
FROM orders;
