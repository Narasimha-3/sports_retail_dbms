DROP TRIGGER IF EXISTS after_delete_order_cascade;

DELIMITER $$

CREATE TRIGGER after_delete_order_cascade
AFTER DELETE ON orders
FOR EACH ROW
BEGIN
    DELETE FROM order_items WHERE order_id = OLD.order_id;
END $$

DELIMITER ;