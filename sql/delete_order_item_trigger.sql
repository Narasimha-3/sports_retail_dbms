DROP TRIGGER IF EXISTS after_delete_order_items_total_sum;

DELIMITER $$

CREATE TRIGGER after_delete_order_items_total_sum
AFTER DELETE ON order_items
FOR EACH ROW
BEGIN
    DECLARE discount DECIMAL(5,2);
    DECLARE item_total DECIMAL(10,2);

    DECLARE order_date TIMESTAMP;
    SELECT order_date INTO order_date FROM orders WHERE order_id = OLD.order_id;

    SELECT COALESCE(MAX(md.max_discount), 0) INTO discount
    FROM max_discounts md
    WHERE md.product_id = OLD.product_id;

    SET item_total = OLD.quantity * OLD.unit_price * (1 - discount / 100);

    UPDATE orders 
    SET total_amount = total_amount - item_total
    WHERE order_id = OLD.order_id;
END $$

DELIMITER ;
