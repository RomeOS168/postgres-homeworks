SELECT * 
FROM orders 
WHERE ship_country IN ('France', 'Germany', 'Spain');

SELECT DISTINCT ship_country, ship_city 
FROM orders 
ORDER BY ship_country, ship_city;

SELECT AVG(shipped_date - order_date) 
FROM orders 
WHERE ship_country = 'Germany';

SELECT MIN(unit_price), MAX(unit_price) 
FROM products 
WHERE discontinued <> 1;

SELECT MIN(unit_price), MAX(unit_price) 
FROM products 
WHERE discontinued <> 1 AND units_in_stock >= 20;

