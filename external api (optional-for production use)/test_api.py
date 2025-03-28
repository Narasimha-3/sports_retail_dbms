import os
from fastapi import FastAPI
import mysql.connector
import json
import pandas as pd

app = FastAPI()

@app.get("/get_all_products")
def get_all_products():
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()
    cursor.callproc("GetAllProducts")

    for result in cursor.stored_results():
        products_list = result.fetchall()

    products = [f"{pname}  (id:-{pid}-)" for pid, pname in products_list]
    print(products)

    with open("log.txt", "a") as log_file:
        log_file.write(json.dumps(products_list))

    cursor.close()
    db.close()
    return products

@app.get("/get_all_categories")
def get_all_categories():
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    cursor.callproc("GetAllCategories")

    for result in cursor.stored_results():
        categories_list = result.fetchall()

    categories = [f"{cname}  (id-{cid}-)" for cid, cname in categories_list]

    cursor.close()
    db.close()
    return categories

@app.get("/get_whole_category/{category_id}")
def get_whole_category(category_id):
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    cursor.callproc("GetWholeCategory", (category_id,))

    for result in cursor.stored_results():
        category = result.fetchone()  

    cursor.close()
    db.close()
    return category

@app.put("/edit_category/{category_id}")
def edit_category(category_id: int, category_name: str, description: str):

    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    cursor.callproc("EditCategory", (category_id, category_name, description))

    db.commit()
    print(f"Category updated! Category ID {category_id}")
    with open("log.txt", "a") as log_file:
        log_file.write(f"Category updated! Category ID {category_id}")

    cursor.close()
    db.close()

@app.get("/get_product_details/{product_id}")
def get_product_details(product_id):
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor(dictionary=True)

    cursor.callproc("GetProductDetails", (product_id,))
    
    for result in cursor.stored_results():
        product_details = result.fetchone()

    cursor.close()
    db.close()
    return product_details

@app.get("/get_whole_product/{product_id}")
def get_whole_product(product_id):
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    cursor.callproc("GetWholeProduct", (product_id,))
    
    for result in cursor.stored_results():
        product = result.fetchone()

    cursor.close()
    db.close()
    return product

@app.put("/edit_product/{product_id}")
def edit_product(product_id, name, price, stock_quantity, category_id, supplier_id):
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    cursor.callproc("EditProduct", (product_id, name, price, stock_quantity, category_id, supplier_id))
    db.commit()

    print(f"Product updated! Product ID {product_id}")
    with open("log.txt", "a") as log_file:
        log_file.write(f"Product updated! Product ID {product_id}")

    cursor.close()
    db.close()

@app.put("/add_stock/{product_id}")
def add_stock(product_id, amount):
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    cursor.callproc("AddStock", (product_id, amount))
    db.commit()

    print(f"Stock updated! Added {amount} units to Product ID {product_id}")
    with open("log.txt", "a") as log_file:
        log_file.write(f"Stock updated! Added {amount} units to Product ID {product_id}")

    cursor.close()
    db.close()

@app.get("/get_all_discounts")
def get_all_discounts():
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    cursor.callproc("GetAllDiscounts")
    
    for result in cursor.stored_results():
        discounts_list = result.fetchall()

    discounts = [
        f"{discount[5]}: {discount[2]}% from {discount[3]} to {discount[4]},  (id:-{discount[0]}-)"
        for discount in discounts_list
    ]

    cursor.close()
    db.close()
    return discounts

@app.put("/delete_discount/{discount_id}")
def delete_discount(discount_id: int):
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    query = "DELETE FROM discounts WHERE discount_id = %s"
    values = (discount_id,)
    cursor.execute(query, values)
    db.commit()

    print(f"Discount deleted! Discount ID {discount_id}")
    with open("log.txt", "a") as log_file:
        log_file.write(f"Discount deleted! Discount ID {discount_id}")

    cursor.close()
    db.close()

@app.put("/add_discount/{product_id}")
def add_discount(product_id, discount_percentage, start_date, end_date):
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    query = "INSERT INTO discounts (product_id, discount_percentage, start_date, end_date) VALUES (%s, %s, %s, %s)"
    values = (product_id, discount_percentage, start_date, end_date)

    cursor.execute(query, values)
    db.commit()

    print(f"Discount added for product ID {product_id}: {discount_percentage}%")
    with open("log.txt", "a") as log_file:
        log_file.write(f"Discount added for product ID {product_id}: {discount_percentage}%")


    cursor.close()
    db.close()

@app.get("/get_all_suppliers")
def get_all_suppliers():

    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    cursor.execute("SELECT supplier_id, name FROM suppliers;")
    suppliers_list = cursor.fetchall()
    suppliers = [f"{sname}  (id:-{sid}-)" for sid, sname in suppliers_list]

    cursor.close()
    db.close()
    return suppliers

@app.get("/get_whole_supplier/{supplier_id}")
def get_whole_supplier(supplier_id):

    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    query = "SELECT * FROM suppliers WHERE supplier_id = %s;"
    cursor.execute(query, (supplier_id,))
    supplier = cursor.fetchone()

    cursor.close()
    db.close()
    return supplier

@app.put("/edit_supplier/{supplier_id}")
def edit_supplier(supplier_id, name, contact_email, phone, address):

    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    query = "UPDATE suppliers SET name = %s, contact_email = %s, phone = %s, address = %s WHERE supplier_id = %s;"
    values = (name, contact_email, phone, address, supplier_id)

    cursor.execute(query, values)
    db.commit()

    print(f"Supplier updated! Supplier ID {supplier_id}")
    with open("log.txt", "a") as log_file:
        log_file.write(f"Supplier updated! Supplier ID {supplier_id}")

    cursor.close()
    db.close()

@app.put("/add_supplier")
def add_supplier(name, contact_email, phone, address):
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    query = "INSERT INTO suppliers (name, contact_email, phone, address) VALUES (%s, %s, %s, %s)"
    values = (name, contact_email, phone, address)

    cursor.execute(query, values)
    db.commit()

    print(f"Supplier added: {name}")

    with open("log.txt", "a") as log_file:
        log_file.write(f"Supplier added: {name}")


    cursor.close()
    db.close()

@app.put("/delete_supplier/{supplier_id}")
def delete_supplier(supplier_id: int):
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()
    query = "DELETE FROM suppliers WHERE supplier_id = %s"
    values = (supplier_id,)
    cursor.execute(query, values)
    db.commit()
    print(f"Supplier deleted! Supplier ID {supplier_id}")
    with open("log.txt", "a") as log_file:
        log_file.write(f"Supplier deleted! Supplier ID {supplier_id}")

    cursor.close()
    db.close()

@app.put("/add_category")
def add_category(category_name, description=""):
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    query = "INSERT INTO categories (category_name, description) VALUES (%s, %s)"
    values = (category_name, description)

    cursor.execute(query, values)
    db.commit()

    print(f"Category added: {category_name}")
    with open("log.txt", "a") as log_file:
        log_file.write(f"Category added: {category_name}")


    cursor.close()
    db.close()

@app.put("/delete_category/{category_id}")
def delete_category(category_id):
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    query = "DELETE FROM Categories WHERE category_id = %s"
    values = (category_id,)
    cursor.execute(query, values)
    db.commit()

    print(f"Category deleted! Category ID {category_id}")
    with open("log.txt", "a") as log_file:
        log_file.write(f"Category deleted! Category ID {category_id}")


    cursor.close()
    db.close()

@app.put("/add_user")
def add_user(name, email, password_hash, role):
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    query = "INSERT INTO users (name, email, password_hash, role) VALUES (%s, %s, %s, %s)"
    values = (name, email, password_hash, role)

    cursor.execute(query, values)
    db.commit()

    print(f"User added: {name} with role {role}")
    with open("log.txt", "a") as log_file:
        log_file.write(f"User added: {name} with role {role}")

    cursor.close()
    db.close()

@app.get("/get_all_users")
def get_all_users():

    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    cursor.execute("SELECT user_id, name FROM users;")
    users_list = cursor.fetchall()
    users = [f"{uname}  (id:-{uid}-)" for uid, uname in users_list]

    cursor.close()
    db.close()
    return users

@app.get("/get_whole_user/{user_id}")
def get_whole_user(user_id):

    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    query = "SELECT * FROM users WHERE user_id = %s;"
    cursor.execute(query, (user_id,))
    user = cursor.fetchone()

    cursor.close()
    db.close()
    return user

@app.put("/edit_user/{user_id}")
def edit_user(user_id, name, email, password_hash, role):

    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    query = "UPDATE users SET name = %s, email = %s, password_hash = %s, role = %s WHERE user_id = %s;"
    values = (name, email, password_hash, role, user_id)

    cursor.execute(query, values)
    db.commit()

    print(f"User updated! User ID {user_id}")
    with open("log.txt", "a") as log_file:
        log_file.write(f"User updated! User ID {user_id}")

    cursor.close()
    db.close()

@app.put("/delete_user/{user_id}")
def delete_user(user_id):
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    query = "DELETE FROM users WHERE user_id = %s"
    values = (user_id,)

    cursor.execute(query, values)
    db.commit()

    print(f"User with ID {user_id} deleted.")

    with open("log.txt", "a") as log_file:
        log_file.write(f"User deleted! User ID {user_id}")

    cursor.close()
    db.close()

@app.put("/add_product")
def add_product(name, price, stock_quantity, category_id, supplier_id):
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    query = "INSERT INTO Products (name, price, stock_quantity, category_id, supplier_id) VALUES (%s, %s, %s, %s, %s)"
    values = (name, price, stock_quantity, category_id, supplier_id)

    cursor.execute(query, values)
    db.commit()

    print(f"Product added! {name}")
    with open("log.txt", "a") as log_file:
        log_file.write(f"Product added! {name}")

    cursor.close()
    db.close()

@app.put("/delete_product/{product_id}")
def delete_product(product_id):
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    query = "DELETE FROM Products WHERE product_id = %s"
    values = (product_id,)
    cursor.execute(query, values)
    db.commit()

    print(f"Product deleted! Product ID {product_id}")
    with open("log.txt", "a") as log_file:
        log_file.write(f"Product deleted! Product ID {product_id}")

    cursor.close()
    db.close()

@app.put("/delete_order_item/{order_item_id}")
def delete_order_item(order_item_id):
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    query = "DELETE FROM order_items WHERE order_item_id = %s"
    values = (order_item_id, )

    cursor.execute(query, values)
    db.commit()

    print(f"Order item deleted! Order item ID: {order_item_id}")
    with open("log.txt", "a") as log_file:
        log_file.write(f"Order item deleted! Order item ID: {order_item_id}")

    cursor.close()
    db.close()

@app.put("/add_order/{customer_id}")
def add_order(customer_id, order_date=None):
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    if order_date is None:
        cursor.execute("SELECT CURRENT_DATE()")
        order_date = cursor.fetchone()[0]

    query = "INSERT INTO orders (customer_id, order_date, total_amount) VALUES (%s, %s, 0)"
    cursor.execute(query, (customer_id, order_date))
    order_id = cursor.lastrowid
    db.commit()
    cursor.close()
    db.close()

    print(f"Order {order_id} created successfully on {order_date}")
    with open("log.txt", "a") as log_file:
        log_file.write(f"Order {order_id} created successfully on {order_date}")

    return order_id

@app.put("/add_order_item/{order_id}")
def add_order_items(order_id, items):
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    for item in items:
        product_id, quantity = item

        cursor.execute("SELECT price FROM products WHERE product_id = %s", (product_id,))
        product = cursor.fetchone()
        if not product:
            print(f"Product ID {product_id} not found!")
            with open("log.txt", "a") as log_file:
                log_file.write(f"Product ID {product_id} not found!")

            continue
        unit_price = product[0]

        order_item_query = "INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES (%s, %s, %s, %s)"
        cursor.execute(order_item_query, (order_id, product_id, quantity, unit_price))

    db.commit()
    cursor.close()
    db.close()
    print(f"Order items added for Order {order_id}")
    with open("log.txt", "a") as log_file:
        log_file.write(f"Order items added for Order {order_id}")

@app.get("/get_all_orders")
def get_all_customers():

    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    cursor.execute("SELECT customer_id, name FROM customers;")
    customers_list = cursor.fetchall()
    customers = [f"{cname}  (id:-{cid}-)" for cid, cname in customers_list]

    cursor.close()
    db.close()
    return customers

@app.get("/get_all_reviews")
def get_all_reviews():

    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    products = get_all_products()
    list_of_products = {}

    for product in products:
        list_of_products[product.split("-")[1]] = product.split(" (id")[0]

    customers = get_all_customers()
    list_of_customers = {}

    for customer in customers:
        list_of_customers[customer.split("-")[1]] = customer.split(" (id")[0]

    cursor.execute("SELECT review_id, customer_id, product_id, rating, review_text FROM reviews;")
    reviews_list = cursor.fetchall()
    reviews = []

    for review in reviews_list:
        product_id = review[2]
        product_name = list_of_products[str(product_id)]
        customer_id = review[1]
        customer_name = list_of_customers[str(customer_id)]
        rating = review[3]
        review_text = review[4]
        reviews.append(f"{customer_name} reviewed {product_name} with rating {rating}: {review_text},  (id:-{review[0]}-)")

    cursor.close()
    db.close()
    return reviews

@app.put("/add_review")
def add_review(customer_id, product_id, rating, review_text=""):
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    query = """
    INSERT INTO reviews (customer_id, product_id, rating, review_text) 
    VALUES (%s, %s, %s, %s)
    """
    values = (customer_id, product_id, rating, review_text)

    cursor.execute(query, values)
    db.commit()

    print(f"Review added! Customer {customer_id} reviewed Product {product_id} with rating {rating}")
    with open("log.txt", "a") as log_file:
        log_file.write(f"Review added! Customer {customer_id} reviewed Product {product_id} with rating {rating}")
    
    cursor.close()
    db.close()

@app.put("/delete_review/{review_id}")
def delete_review(review_id):
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    query = "DELETE FROM reviews WHERE review_id = %s"
    values = (review_id,)

    cursor.execute(query, values)
    db.commit()

    print(f"Review deleted! Review ID: {review_id}")
    with open("log.txt", "a") as log_file:
        log_file.write(f"Review deleted! Review ID: {review_id}")

    cursor.close()
    db.close()

@app.put("/delete_order/{order_id}")
def delete_order(order_id):

    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    query = "DELETE FROM orders WHERE order_id = %s"
    values = (order_id,)

    cursor.execute(query, values)
    db.commit()

    print(f"Order deleted! Order ID: {order_id}")
    with open("log.txt", "a") as log_file:
        log_file.write(f"Order deleted! Order ID: {order_id}")

    cursor.close()
    db.close()

@app.get("/get_all_orders")
def get_all_orders():

    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    cursor.execute("SELECT order_id, customer_id, order_date, total_amount FROM orders;")
    orders_list = cursor.fetchall()
    orders = []

    customers = get_all_customers()
    list_of_customers = {}

    for customer in customers:
        list_of_customers[customer.split("-")[1]] = customer.split(" (id")[0]
    

    for order in orders_list:
        customer_id = order[1]
        customer_name = list_of_customers[str(customer_id)]
        order_id = order[0]
        order_date = order[2]
        total_amount = order[3]
        orders.append(f"{customer_name}📅{order_date}💵{total_amount},  (id:-{order_id}:-)")
    
    cursor.close()
    db.close()
    return orders

@app.put("/get_all_customers")
def get_all_customers():

    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    cursor.execute("SELECT customer_id, name FROM customers;")
    customers_list = cursor.fetchall()
    customers = [f"{cname}  (id:-{cid}-)" for cid, cname in customers_list]

    cursor.close()
    db.close()
    return customers

@app.get("/get_whole_customer/{customer_id}")
def get_whole_customer(customer_id):

    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    query = "SELECT * FROM customers WHERE customer_id = %s;"
    cursor.execute(query, (customer_id,))
    customer = cursor.fetchone()

    cursor.close()
    db.close()
    return customer

@app.put("/edit_customer/{customer_id}")
def edit_customer(customer_id, name, email, phone):

    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    query = "UPDATE customers SET name = %s, email = %s, phone = %s WHERE customer_id = %s;"
    values = (name, email, phone, customer_id)

    cursor.execute(query, values)
    db.commit()

    print(f"Customer updated! Customer ID {customer_id}")
    with open("log.txt", "a") as log_file:
        log_file.write(f"Customer updated! Customer ID {customer_id}")

    cursor.close()
    db.close()

@app.put("/add_customer")
def add_customer(name, email, phone):

    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    query = "INSERT INTO customers (name, email, phone) VALUES (%s, %s, %s)"
    values = (name, email, phone)

    cursor.execute(query, values)
    db.commit()

    print(f"Customer added! {name}")
    with open("log.txt", "a") as log_file:
        log_file.write(f"Customer added! {name}")

    cursor.close()
    db.close()


@app.put("/get_all_order_items")
def get_all_order_items():
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    cursor.execute("SELECT order_item_id, order_id, product_id, quantity, unit_price FROM order_items;")
    order_items_list = cursor.fetchall()
    order_items = []

    products = get_all_products()
    list_of_products = {}

    for product in products:
        list_of_products[product.split("-")[1]] = product.split(" (id")[0]

    orders = get_all_orders()
    list_of_orders = {}

    for order in orders:
        list_of_orders[order.split(":-")[1]] = order.split("📅")[1].split("💵")[0]

    for order_item in order_items_list:
        product_id = order_item[2]
        product_name = list_of_products[str(product_id)]
        order_id = order_item[1]
        order_date = list_of_orders[str(order_id)]
        quantity = order_item[3]
        unit_price = order_item[4]
        order_items.append(f"{product_name}📅{order_date}💵{unit_price}📦{quantity},  (id:-{order_item[0]}:-)")

    cursor.close()
    db.close()
    return order_items

@app.get("/get_all_product_sales")
def get_all_product_sales():
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor(dictionary=True)

    query = """
    SELECT 
        p.name AS product_name,
        SUM(oi.quantity) AS total_sold,
        SUM(oi.quantity * oi.unit_price) AS total_revenue
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY p.product_id
    ORDER BY total_revenue DESC;
    """
    
    cursor.execute(query)
    product_details = cursor.fetchall() 
    cursor.close()
    db.close()

    return product_details

@app.get("/get_monthly_sales")
def get_monthly_sales():
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor(dictionary=True)

    query = """
    SELECT 
        MONTH(o.order_date) AS month,
        p.name AS product_name,
        SUM(oi.quantity) AS total_sold
    FROM Order_Items oi
    JOIN Orders o ON oi.order_id = o.order_id
    JOIN Products p ON oi.product_id = p.product_id
    GROUP BY month, p.product_id
    ORDER BY month, total_sold DESC;
    """

    cursor.execute(query)
    seasonal_data = cursor.fetchall()
    cursor.close()
    db.close()

    return seasonal_data

@app.get("/get_discounted_products")
def get_discounted_products(high_stock=None, low_rating=None, clearance=None, seasonal=None):
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    query = "CALL ApplyDiscounts(%s, %s, %s, %s);"
    values = (
        high_stock if high_stock is not None else 10,   
        low_rating if low_rating is not None else 15,   
        clearance if clearance is not None else 20,     
        seasonal if seasonal is not None else 5         
    )
    
    cursor.execute(query, values)
    data = cursor.fetchall()
    
    cursor.close()
    db.close()

    return data

@app.get("/fetch_review_insights")
def fetch_review_insights(procedure_name: str, params: str = ""):
    try:
        db = mysql.connector.connect(
            host="localhost",
            user="root",
            password=os.environ["DB_PASSWORD"],
            database="sports_retail"
        )
        cursor = db.cursor()

        param_list = tuple(params.split(",")) if params else ()

        cursor.callproc(procedure_name, param_list)

        for result in cursor.stored_results():
            data = result.fetchall()

        columns = [desc[0] for desc in result.description]
        df = pd.DataFrame(data, columns=columns)

        cursor.close()
        db.close()

        return df.to_dict(orient="records")

    except Exception as e:
        error_msg = f"Error fetching data: {e}"
        print(error_msg)
        with open("log.txt", "a") as log_file:
            log_file.write(error_msg + "\n")
        return {"error": error_msg}

@app.get("/fetch_reviews/{product_id}")
def fetch_reviews(product_id, sort_order="DESC"):
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor(dictionary=True)

    query = "CALL GetProductReviews(%s, %s)"
    cursor.execute(query, (product_id, sort_order))
    reviews = cursor.fetchall()

    cursor.close()
    db.close()

    return pd.DataFrame(reviews) if reviews else None

@app.get("/fetch_stock_alerts")
def fetch_stock_alerts(procedure_name: str, params: str = ""):
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    param_list = tuple(params.split(",")) if params else ()
    placeholders = ", ".join(["%s"] * len(param_list)) if param_list else ""
    
    query = f"CALL {procedure_name}({placeholders})"
    cursor.execute(query, param_list)

    result = cursor.fetchall()
    columns = [desc[0] for desc in cursor.description]

    df = pd.DataFrame(result, columns=columns)

    cursor.close()
    db.close()
    return df.to_dict(orient="records")


@app.get("/get_complaints")
def get_complaints():
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password=os.environ["DB_PASSWORD"],
        database="sports_retail"
    )
    cursor = db.cursor()

    query = """
    SELECT p.name, c.complaint
    FROM complaints c
    JOIN products p ON c.product_id = p.product_id
    """
    
    cursor.execute(query)
    results = cursor.fetchall()
    
    complaint_list = [f"{product}: {complaint}" for product, complaint in results]

    cursor.close()
    db.close()
    
    return complaint_list
