SELECT c.company_name, CONCAT(e.first_name, ' ', e.last_name) AS employee_name
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN employees e ON o.employee_id = e.employee_id
JOIN shippers s ON o.ship_via = s.shipper_id
WHERE c.city = 'London' 
  AND e.city = 'London' 
  AND s.company_name = 'United Package';

SELECT p.product_name, p.units_in_stock, s.company_name, s.phone
FROM products p
JOIN suppliers s ON p.supplier_id = s.supplier_id
JOIN categories c ON p.category_id = c.category_id
WHERE p.discontinued <> 1 
  AND p.units_in_stock < 25 
  AND c.category_name IN ('Beverages', 'Seafood')
ORDER BY p.units_in_stock;

SELECT company_name
FROM customers
WHERE customer_id NOT IN (SELECT customer_id FROM orders);

SELECT product_name
FROM products
WHERE product_id IN (
    SELECT product_id 
    FROM order_details 
    WHERE quantity = 10
);
