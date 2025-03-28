CREATE DEFINER=`root`@`localhost` PROCEDURE `AddStock`(
    IN prod_id INT,
    IN stock_amount INT
)
BEGIN
    UPDATE Products 
    SET stock_quantity = stock_quantity + stock_amount
    WHERE product_id = prod_id;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `AnalyzeReviewImpact`()
BEGIN
    SELECT 
        p.product_id, 
        p.name, 
        COALESCE(r.avg_rating, 0) AS avg_rating,
        COALESCE(s.total_sales, 0) AS total_sales
    FROM products p
    LEFT JOIN (
        SELECT product_id, AVG(rating) AS avg_rating
        FROM reviews
        GROUP BY product_id
    ) r ON p.product_id = r.product_id
    LEFT JOIN (
        SELECT oi.product_id, SUM(oi.quantity) AS total_sales
        FROM order_items oi
        JOIN orders o ON oi.order_id = o.order_id
        WHERE YEAR(o.order_date) = 2025
        GROUP BY oi.product_id
    ) s ON p.product_id = s.product_id
    ORDER BY avg_rating DESC;
END


CREATE DEFINER=`root`@`localhost` PROCEDURE `ApplyDiscounts`(
    IN high_stock_discount DECIMAL(5,2), 
    IN low_rating_discount DECIMAL(5,2), 
    IN clearance_discount DECIMAL(5,2), 
    IN seasonal_discount DECIMAL(5,2)
)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE pid INT;
    DECLARE pstock INT;
    DECLARE psales INT;
    DECLARE avg_rating DECIMAL(3,2);
    DECLARE product_age INT;
    DECLARE current_price DECIMAL(10,2);
    DECLARE discount_percent DECIMAL(5,2);
    DECLARE discounted_price DECIMAL(10,2);

    DECLARE cur CURSOR FOR 
        SELECT p.product_id, p.stock_quantity, p.price, 
               COALESCE(SUM(oi.quantity), 0) AS total_sales, 
               COALESCE(AVG(r.rating), 3.0) AS avg_rating,
               DATEDIFF(NOW(), p.created_at) AS product_age
        FROM products p
        LEFT JOIN order_items oi ON p.product_id = oi.product_id
        LEFT JOIN reviews r ON p.product_id = r.product_id
        GROUP BY p.product_id, p.stock_quantity, p.price, p.created_at;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO pid, pstock, current_price, psales, avg_rating, product_age;
        IF done THEN 
            LEAVE read_loop;
        END IF;

        SET discount_percent = GREATEST(
            CASE WHEN pstock > 200 AND psales < 20 THEN high_stock_discount ELSE 0 END,
            CASE WHEN avg_rating < 3.0 THEN low_rating_discount ELSE 0 END,
            CASE WHEN product_age > 365 THEN clearance_discount ELSE 0 END,
            seasonal_discount
        );


        SET discounted_price = current_price * (1 - discount_percent / 100);


        SELECT pid AS product_id, discounted_price AS new_price, discount_percent AS applied_discount;
    
    END LOOP;

    CLOSE cur;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `ApplyDynamicPricing`(
    IN demand_factor DECIMAL(5,2)
)
BEGIN
    UPDATE products p
    JOIN (
        SELECT oi.product_id, COUNT(oi.order_id) AS total_orders
        FROM order_items oi
        GROUP BY oi.product_id
    ) AS order_stats
    ON p.product_id = order_stats.product_id
    SET p.price = p.price * (1 + (order_stats.total_orders / 100) * demand_factor);
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `CheckStockDemandMismatch`()
BEGIN
    SELECT 
        p.product_id, 
        p.name, 
        p.stock_quantity, 
        COALESCE(SUM(oi.quantity), 0) AS total_sold,
        CASE 
            WHEN p.stock_quantity > (SUM(oi.quantity) * 2) THEN 'Overstocked'
            WHEN p.stock_quantity < (SUM(oi.quantity) * 0.5) THEN 'Understocked'
            ELSE 'Balanced'
        END AS stock_status
    FROM products p
    LEFT JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY p.product_id, p.name, p.stock_quantity
    HAVING stock_status != 'Balanced';
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `EditCategory`(
    IN cat_id INT, 
    IN cat_name VARCHAR(100), 
    IN cat_desc TEXT
)
BEGIN
    UPDATE Categories 
    SET category_name = cat_name, 
        description = cat_desc 
    WHERE category_id = cat_id;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `EditProduct`(
    IN prod_id INT,
    IN prod_name VARCHAR(100),
    IN prod_price DECIMAL(10,2),
    IN prod_stock INT,
    IN prod_category INT,
    IN prod_supplier INT
)
BEGIN
    UPDATE Products 
    SET name = prod_name, 
        price = prod_price, 
        stock_quantity = prod_stock, 
        category_id = prod_category, 
        supplier_id = prod_supplier 
    WHERE product_id = prod_id;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllCategories`()
BEGIN
    SELECT category_id, category_name FROM Categories;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllDiscounts`()
BEGIN
    SELECT d.discount_id, d.product_id, d.discount_percentage, d.start_date, d.end_date, p.name AS product_name
    FROM discounts d
    JOIN Products p ON d.product_id = p.product_id;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllProducts`()
BEGIN
    SELECT product_id, name FROM Products;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetLowStockProducts`(IN min_stock INT)
BEGIN
    SELECT 
        product_id, 
        name, 
        stock_quantity 
    FROM products
    WHERE stock_quantity < min_stock;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetOverstockedSlowMovers`(IN min_sales INT, IN max_stock INT)
BEGIN
    SELECT 
        p.product_id, 
        p.name, 
        p.stock_quantity, 
        COALESCE(SUM(oi.quantity), 0) AS total_sold
    FROM products p
    LEFT JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY p.product_id, p.name, p.stock_quantity
    HAVING total_sold < min_sales AND stock_quantity > max_stock;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPricingTrends`()
BEGIN
    SELECT p.product_id, p.name, p.price, AVG(oi.unit_price) AS avg_selling_price,
           COUNT(oi.order_id) AS total_orders
    FROM products p
    LEFT JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY p.product_id, p.name, p.price
    ORDER BY total_orders DESC;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetProductDetails`(IN prod_id INT)
BEGIN
    SELECT 
        p.product_id, 
        p.name AS product_name, 
        p.price, 
        p.stock_quantity, 
        c.category_name, 
        s.name AS supplier_name, 
        s.contact_email, 
        s.phone 
    FROM Products p
    JOIN Categories c ON p.category_id = c.category_id
    JOIN Suppliers s ON p.supplier_id = s.supplier_id
    WHERE p.product_id = prod_id;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetProductReviews`(
    IN product_id_param INT,
    IN sort_order_param VARCHAR(4)
)
BEGIN
    IF sort_order_param NOT IN ('ASC', 'DESC') THEN
        SET sort_order_param = 'DESC';
    END IF;

    SELECT review_id, product_id, customer_id, 
           COALESCE(rating, 0) AS rating, 
           review_text, created_at
    FROM reviews
    WHERE product_id = product_id_param
    ORDER BY rating IS NULL, rating * 1  
    COLLATE utf8mb4_general_ci, rating * (CASE WHEN sort_order_param = 'ASC' THEN 1 ELSE -1 END);
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTopSellingProducts`()
BEGIN
    SELECT p.product_id, p.name, SUM(oi.quantity) AS total_sold
    FROM Order_Items oi
    JOIN Products p ON oi.product_id = p.product_id
    GROUP BY p.product_id, p.name
    ORDER BY total_sold DESC
    LIMIT 10;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetWholeCategory`(IN cat_id INT)
BEGIN
    SELECT * FROM Categories WHERE category_id = cat_id;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetWholeProduct`(IN prod_id INT)
BEGIN
    SELECT * FROM Products WHERE product_id = prod_id;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `OptimizeDiscounts`(
    IN base_discount DECIMAL(5,2), 
    IN bulk_discount DECIMAL(5,2),
    IN low_demand_discount DECIMAL(5,2)
)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE pid INT;
    DECLARE pstock INT;
    DECLARE psales INT;
    DECLARE current_price DECIMAL(10,2);
    DECLARE discount_percent DECIMAL(5,2);
    DECLARE discounted_price DECIMAL(10,2);
    
    DECLARE cur CURSOR FOR 
        SELECT p.product_id, p.stock_quantity, p.price, 
               COALESCE(SUM(oi.quantity), 0) AS total_sales
        FROM products p
        LEFT JOIN order_items oi ON p.product_id = oi.product_id
        GROUP BY p.product_id, p.stock_quantity, p.price;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO pid, pstock, current_price, psales;
        IF done THEN LEAVE read_loop; END IF;

        SET discount_percent = GREATEST(
            CASE WHEN pstock > 100 THEN bulk_discount ELSE 0 END,
            CASE WHEN psales < 10 THEN low_demand_discount ELSE 0 END,
            base_discount
        );
        SET discounted_price = current_price * (1 - discount_percent / 100);
        UPDATE products SET price = discounted_price WHERE product_id = pid;
    END LOOP;
    CLOSE cur;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `RecommendReviewCollection`(IN min_reviews INT, IN min_sales INT)
BEGIN
    WITH SalesSummary AS (
        SELECT 
            oi.product_id, 
            SUM(oi.quantity) AS total_sales
        FROM order_items oi
        JOIN orders o ON oi.order_id = o.order_id
        WHERE YEAR(o.order_date) = 2025
        GROUP BY oi.product_id
    ),
    ReviewSummary AS (
        SELECT 
            r.product_id, 
            COUNT(r.review_id) AS total_reviews
        FROM reviews r
        GROUP BY r.product_id
    )
    SELECT 
        p.product_id, 
        p.name, 
        COALESCE(rs.total_reviews, 0) AS total_reviews, 
        COALESCE(ss.total_sales, 0) AS total_sales
    FROM products p
    LEFT JOIN SalesSummary ss ON p.product_id = ss.product_id
    LEFT JOIN ReviewSummary rs ON p.product_id = rs.product_id
    WHERE COALESCE(rs.total_reviews, 0) < min_reviews 
      AND COALESCE(ss.total_sales, 0) > min_sales
    ORDER BY total_sales DESC;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `ReviewBasedSalesTrends`(IN min_high_reviews INT)
BEGIN

    IF min_high_reviews IS NULL THEN
        SET min_high_reviews = 35;
    END IF;

    WITH ProductReviewCounts AS (
        SELECT 
            p.product_id,
            COUNT(r.review_id) AS review_count
        FROM products p
        LEFT JOIN reviews r ON p.product_id = r.product_id
        GROUP BY p.product_id
    )

    SELECT 
        CASE 
            WHEN pr.review_count >= min_high_reviews THEN 'High Reviews' 
            ELSE 'Low Reviews' 
        END AS review_category,
        COUNT(DISTINCT oi.product_id) AS total_products,
        SUM(oi.quantity) AS total_sales,
        ROUND(SUM(oi.quantity) / COUNT(DISTINCT oi.product_id), 2) AS avg_sales_per_product
    FROM ProductReviewCounts pr
    LEFT JOIN order_items oi ON pr.product_id = oi.product_id
    GROUP BY review_category;
    
END