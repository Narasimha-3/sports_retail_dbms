DROP TRIGGER IF EXISTS before_insert_order_item_stock_check;

DELIMITER $$

CREATE TRIGGER before_insert_order_item_stock_check
BEFORE INSERT ON order_items
FOR EACH ROW
BEGIN
    DECLARE available_stock INT;

    SELECT stock_quantity INTO available_stock
    FROM products
    WHERE product_id = NEW.product_id;

    IF available_stock < NEW.quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient stock for this product!';
    ELSE
        UPDATE products
        SET stock_quantity = stock_quantity - NEW.quantity
        WHERE product_id = NEW.product_id;
    END IF;
END $$

DELIMITER ;
