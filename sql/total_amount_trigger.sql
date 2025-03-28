DROP TRIGGER IF EXISTS after_insert_order_items_total_sum;

DELIMITER $$

CREATE TRIGGER after_insert_order_items_total_sum
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    DECLARE discount DECIMAL(5,2);
    DECLARE order_total DECIMAL(10,2);

    DECLARE order_date TIMESTAMP;
    SELECT order_date INTO order_date FROM orders WHERE order_id = NEW.order_id;

    SELECT COALESCE(MAX(md.max_discount), 0) INTO discount
    FROM max_discounts md
    WHERE md.product_id = NEW.product_id;

    SET order_total = NEW.quantity * NEW.unit_price * (1 - discount / 100);

    UPDATE orders 
    SET total_amount = (
        SELECT SUM(oi.quantity * oi.unit_price * (1 - COALESCE(md.max_discount, 0) / 100))
        FROM order_items oi
        LEFT JOIN max_discounts md ON oi.product_id = md.product_id
        WHERE oi.order_id = NEW.order_id
    )
    WHERE order_id = NEW.order_id;
END $$

DELIMITER ;
