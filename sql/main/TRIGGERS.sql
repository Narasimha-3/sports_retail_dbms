CREATE DEFINER=`root`@`localhost` TRIGGER `before_insert_category` BEFORE INSERT ON `categories` FOR EACH ROW BEGIN
    DECLARE next_id INT;
    SELECT IFNULL(MAX(category_id), 0) + 1 INTO next_id FROM categories;
    SET NEW.category_id = next_id;
END

CREATE DEFINER=`root`@`localhost` TRIGGER `before_delete_category` BEFORE DELETE ON `categories` FOR EACH ROW BEGIN
    DELETE FROM products WHERE category_id = OLD.category_id;
END

CREATE DEFINER=`root`@`localhost` TRIGGER `before_insert_customer` BEFORE INSERT ON `customers` FOR EACH ROW BEGIN
    DECLARE next_id INT;
    SELECT IFNULL(MAX(customer_id), 0) + 1 INTO next_id FROM customers;
    SET NEW.customer_id = next_id;
END

CREATE DEFINER=`root`@`localhost` TRIGGER `before_insert_discount` BEFORE INSERT ON `discounts` FOR EACH ROW BEGIN
    DECLARE next_id INT;
    SELECT IFNULL(MAX(discount_id), 0) + 1 INTO next_id FROM discounts;
    SET NEW.discount_id = next_id;
END

CREATE DEFINER=`root`@`localhost` TRIGGER `before_insert_order_item` BEFORE INSERT ON `order_items` FOR EACH ROW BEGIN
    DECLARE next_id INT;
    SELECT IFNULL(MAX(order_item_id), 0) + 1 INTO next_id FROM order_items;
    SET NEW.order_item_id = next_id;
END

CREATE DEFINER=`root`@`localhost` TRIGGER `before_insert_order_item_stock_check` BEFORE INSERT ON `order_items` FOR EACH ROW BEGIN
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
END

CREATE DEFINER=`root`@`localhost` TRIGGER `before_insert_order_items_unit_price` BEFORE INSERT ON `order_items` FOR EACH ROW BEGIN
    DECLARE actual_price DECIMAL(10,2);

    SELECT price INTO actual_price
    FROM products
    WHERE product_id = NEW.product_id;

    SET NEW.unit_price = actual_price;
END

CREATE DEFINER=`root`@`localhost` TRIGGER `after_insert_order_items_total_sum` AFTER INSERT ON `order_items` FOR EACH ROW BEGIN
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
END

CREATE DEFINER=`root`@`localhost` TRIGGER `after_delete_order_items_total_sum` AFTER DELETE ON `order_items` FOR EACH ROW BEGIN
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
END

CREATE DEFINER=`root`@`localhost` TRIGGER `before_insert_order` BEFORE INSERT ON `orders` FOR EACH ROW BEGIN
    DECLARE next_id INT;
    SELECT IFNULL(MAX(order_id), 0) + 1 INTO next_id FROM orders;
    SET NEW.order_id = next_id;
END

CREATE DEFINER=`root`@`localhost` TRIGGER `after_delete_order_cascade` AFTER DELETE ON `orders` FOR EACH ROW BEGIN
    DELETE FROM order_items WHERE order_id = OLD.order_id;
END

CREATE DEFINER=`root`@`localhost` TRIGGER `before_insert_product` BEFORE INSERT ON `products` FOR EACH ROW BEGIN
    DECLARE next_id INT;
    SELECT IFNULL(MAX(product_id), 0) + 1 INTO next_id FROM products;
    SET NEW.product_id = next_id;
END

CREATE DEFINER=`root`@`localhost` TRIGGER `before_delete_product_reviews` BEFORE DELETE ON `products` FOR EACH ROW BEGIN
    DELETE FROM reviews WHERE product_id = OLD.product_id;
END

CREATE DEFINER=`root`@`localhost` TRIGGER `before_delete_product_order_items` BEFORE DELETE ON `products` FOR EACH ROW BEGIN
    DELETE FROM order_items WHERE product_id = OLD.product_id;
END

CREATE DEFINER=`root`@`localhost` TRIGGER `after_delete_product_discounts` AFTER DELETE ON `products` FOR EACH ROW BEGIN
    DELETE FROM discounts WHERE product_id = OLD.product_id;
END

CREATE DEFINER=`root`@`localhost` TRIGGER `before_insert_review` BEFORE INSERT ON `reviews` FOR EACH ROW BEGIN
    DECLARE order_count INT;

    SELECT COUNT(*) INTO order_count
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.customer_id = NEW.customer_id
      AND oi.product_id = NEW.product_id;

    IF order_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Customer has not purchased this product, so they cannot review it.';
    END IF;
END

CREATE DEFINER=`root`@`localhost` TRIGGER `update_product_rating` AFTER INSERT ON `reviews` FOR EACH ROW BEGIN
    UPDATE Products
    SET rating = (SELECT AVG(rating) FROM Reviews WHERE product_id = NEW.product_id)
    WHERE product_id = NEW.product_id;
END

CREATE DEFINER=`root`@`localhost` TRIGGER `before_insert_supplier` BEFORE INSERT ON `suppliers` FOR EACH ROW BEGIN
    DECLARE next_id INT;
    SELECT IFNULL(MAX(supplier_id), 0) + 1 INTO next_id FROM suppliers;
    SET NEW.supplier_id = next_id;
END

CREATE DEFINER=`root`@`localhost` TRIGGER `before_delete_supplier` BEFORE DELETE ON `suppliers` FOR EACH ROW BEGIN
    DELETE FROM products WHERE supplier_id = OLD.supplier_id;
END

CREATE DEFINER=`root`@`localhost` TRIGGER `before_insert_user` BEFORE INSERT ON `users` FOR EACH ROW BEGIN
    DECLARE next_id INT;
    SELECT IFNULL(MAX(user_id), 0) + 1 INTO next_id FROM users;
    SET NEW.user_id = next_id;
END