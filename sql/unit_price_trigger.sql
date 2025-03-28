DROP TRIGGER IF EXISTS before_insert_order_items_unit_price;

DELIMITER //

CREATE TRIGGER before_insert_order_items_unit_price
BEFORE INSERT ON order_items
FOR EACH ROW
BEGIN
    DECLARE actual_price DECIMAL(10,2);

    SELECT price INTO actual_price
    FROM products
    WHERE product_id = NEW.product_id;

    SET NEW.unit_price = actual_price;
END;
//

DELIMITER ;