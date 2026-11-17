ALTER TABLE products
ADD CONSTRAINT chk_products_unit_price CHECK (unit_price > 0);

ALTER TABLE products
ADD CONSTRAINT chk_products_discontinued CHECK (discontinued IN (0, 1));

SELECT * INTO discontinued_products
FROM products
WHERE discontinued = 1;

ALTER TABLE order_details
DROP CONSTRAINT fk_order_details_products;

ALTER TABLE order_details
ADD CONSTRAINT fk_order_details_products
FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE;

DELETE FROM products
WHERE discontinued = 1;
