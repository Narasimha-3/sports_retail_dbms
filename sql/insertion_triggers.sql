DROP TRIGGER IF EXISTS before_insert_discount;
DROP TRIGGER IF EXISTS before_insert_category;
DROP TRIGGER IF EXISTS before_insert_product;
DROP TRIGGER IF EXISTS before_insert_supplier;
DROP TRIGGER IF EXISTS before_insert_user;
DROP TRIGGER IF EXISTS before_insert_order;
DROP TRIGGER IF EXISTS before_insert_customer;
DROP TRIGGER IF EXISTS before_insert_order_item;
DROP TRIGGER IF EXISTS before_insert_review;

DELIMITER $$

CREATE TRIGGER before_insert_customer
BEFORE INSERT ON customers
FOR EACH ROW
BEGIN
    DECLARE next_id INT;
    SELECT IFNULL(MAX(customer_id), 0) + 1 INTO next_id FROM customers;
    SET NEW.customer_id = next_id;
END $$


CREATE TRIGGER before_insert_order_item
BEFORE INSERT ON order_items
FOR EACH ROW
BEGIN
    DECLARE next_id INT;
    SELECT IFNULL(MAX(order_item_id), 0) + 1 INTO next_id FROM order_items;
    SET NEW.order_item_id = next_id;
END $$


CREATE TRIGGER before_insert_review
BEFORE INSERT ON reviews
FOR EACH ROW
BEGIN
    DECLARE next_id INT;
    SELECT IFNULL(MAX(review_id), 0) + 1 INTO next_id FROM reviews;
    SET NEW.review_id = next_id;
END $$


CREATE TRIGGER before_insert_category
BEFORE INSERT ON categories
FOR EACH ROW
BEGIN
    DECLARE next_id INT;
    SELECT IFNULL(MAX(category_id), 0) + 1 INTO next_id FROM categories;
    SET NEW.category_id = next_id;
END $$


CREATE TRIGGER before_insert_order
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    DECLARE next_id INT;
    SELECT IFNULL(MAX(order_id), 0) + 1 INTO next_id FROM orders;
    SET NEW.order_id = next_id;
END $$


CREATE TRIGGER before_insert_product
BEFORE INSERT ON products
FOR EACH ROW
BEGIN
    DECLARE next_id INT;
    SELECT IFNULL(MAX(product_id), 0) + 1 INTO next_id FROM products;
    SET NEW.product_id = next_id;
END $$


CREATE TRIGGER before_insert_supplier
BEFORE INSERT ON suppliers
FOR EACH ROW
BEGIN
    DECLARE next_id INT;
    SELECT IFNULL(MAX(supplier_id), 0) + 1 INTO next_id FROM suppliers;
    SET NEW.supplier_id = next_id;
END $$


CREATE TRIGGER before_insert_user
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
    DECLARE next_id INT;
    SELECT IFNULL(MAX(user_id), 0) + 1 INTO next_id FROM users;
    SET NEW.user_id = next_id;
END $$


CREATE TRIGGER before_insert_discount
BEFORE INSERT ON discounts
FOR EACH ROW
BEGIN
    DECLARE next_id INT;
    SELECT IFNULL(MAX(discount_id), 0) + 1 INTO next_id FROM discounts;
    SET NEW.discount_id = next_id;
END $$

DELIMITER ;