import requests
import json

def get_all_products():
    return requests.get("http://127.0.0.1:8000/get_all_products").json()

def get_all_categories():
    return requests.get("http://127.0.0.1:8000/get_all_categories").json()

def get_whole_category(category_id):
    return requests.get(f"http://127.0.0.1:8000/get_whole_category/{category_id}").json()

def edit_category(category_id, category_name, description):
    requests.put(f"http://127.0.0.1:8000/edit_category/{category_id}", params={
    "category_name": category_name,
    "description": description
    })

def get_product_details(product_id):
    return requests.get(f"http://127.0.0.1:8000/get_product_details/{product_id}").json()

def get_whole_product(product_id):
    return requests.get(f"http://127.0.0.1:8000/get_whole_product/{product_id}").json()

def edit_product(product_id, name, price, stock_quantity, category_id, supplier_id):
    requests.put(f"http://127.0.0.1:8000/edit_product/{product_id}", params={
    "name": name,
    "price": price,
    "stock_quantity": stock_quantity,
    "category_id": category_id,
    "supplier_id": supplier_id
    })

def add_stock(product_id, amount):
    requests.put(f"http://127.0.0.1:8000/add_stock/{product_id}", params={
        "amount": amount
    })

def get_all_discounts():
    return requests.get("http://127.0.0.1:8000/get_all_discounts").json() 

def delete_discount(discount_id):
    requests.put(f"http://127.0.0.1:8000/delete_discount/{discount_id}")

def add_discount(product_id, discount_percentage, start_date, end_date):
    requests.put(f"http://127.0.0.1:8000/delete_discount/{product_id}", params={
        "discount_percentage": discount_percentage,
        "start_date": start_date,
        "end_date": end_date
    })

def get_all_suppliers():
    return requests.get("http://127.0.0.1:8000/get_all_suppliers").json()

def get_whole_supplier(supplier_id):
    return requests.get("http://127.0.0.1:8000/get_whole_supplier/{supplier_id}").json()

def edit_supplier(supplier_id, name, contact_email, phone, address):
    requests.put(f"http://127.0.0.1:8000/edit_supplier/{supplier_id}", params={
    "name": name,
    "contact_email": contact_email,
    "phone": phone,
    "address": address
    })

def add_supplier(name, contact_email, phone, address):
    requests.put(f"http://127.0.0.1:8000/add_supplier", params={
    "name": name,
    "contact_email": contact_email,
    "phone": phone,
    "address": address
    })

def delete_supplier(supplier_id):
    requests.put(f"http://127.0.0.1:8000/delete_supplier/{supplier_id}")

def add_category(category_name, description=""):
    requests.put(f"http://127.0.0.1:8000/add_category", params={
    "category_name": category_name,
    "description": description
    })

def delete_category(category_id):
    requests.put(f"http://127.0.0.1:8000/delete_category/{category_id}")

def add_user(name, email, password_hash, role):
    requests.put(f"http://127.0.0.1:8000/add_user", params={
    "name": name,
    "email": email,
    "password_hash": password_hash,
    "role": role
    })

def get_all_users():
    return requests.get("http://127.0.0.1:8000/get_all_users").json()

def get_whole_user(user_id):
    return requests.put(f"http://127.0.0.1:8000/get_whole_user/{user_id}").json()

def edit_user(user_id, name, email, password_hash, role):
    requests.put(f"http://127.0.0.1:8000/edit_user/{user_id}", params={
    "name": name,
    "email": email,
    "password_hash": password_hash,
    "role": role
    })

def delete_user(user_id):
    requests.put(f"http://127.0.0.1:8000/delete_user/{user_id}")


def add_product(name, price, stock_quantity, category_id, supplier_id):
    requests.put(f"http://127.0.0.1:8000/add_product", params={
    "name": name,
    "price": price,
    "stock_quantity": stock_quantity,
    "category_id": category_id,
    "supplier_id": supplier_id
    })

def delete_product(product_id):
    requests.put(f"http://127.0.0.1:8000/delete_product/{product_id}")

def delete_order_item(order_item_id):
    requests.put(f"http://127.0.0.1:8000/delete_order_item/{order_item_id}")

def add_order(customer_id, order_date=None):
    return requests.put(f"http://127.0.0.1:8000/add_order/{customer_id}", params={
    "order_date": order_date
    }).json()

def add_order_items(order_id, items):
    requests.put(f"http://127.0.0.1:8000/add_order_items/{order_id}", params={
    "items": items
    })

def get_all_orders(): 
    return requests.get("http://127.0.0.1:8000/get_all_orders").json()

def get_all_reviews():
    return requests.get("http://127.0.0.1:8000/get_all_reviews").json()
   
def add_review(customer_id, product_id, rating, review_text=""):
    requests.put(f"http://127.0.0.1:8000/add_review", params={
    "customer_id": customer_id,
    "product_id": product_id,
    "rating": rating,
    "review_text": review_text
    })

def delete_review(review_id):
    requests.put(f"http://127.0.0.1:8000/delete_review/{review_id}")

def delete_order(order_id):
    requests.put(f"http://127.0.0.1:8000/delete_order/{order_id}")

def get_all_orders():
    return requests.get("http://127.0.0.1:8000/get_all_orders").json()

def get_all_customers():
    return requests.get("http://127.0.0.1:8000/get_all_customers").json()

def get_whole_customer(customer_id):
    return requests.put(f"http://127.0.0.1:8000/get_whole_customer/{customer_id}").json() 

def edit_customer(customer_id, name, email, phone):
    requests.put(f"http://127.0.0.1:8000/edit_customer/{customer_id}", params={
    "name": name,
    "email": email,
    "phone": phone
    })

def add_customer( name, email, phone):
    requests.put(f"http://127.0.0.1:8000/add_customer", params={
    "name": name,
    "email": email,
    "phone": phone
    })

def get_all_order_items():
    return requests.get("http://127.0.0.1:8000/get_all_order_items").json()

def get_all_product_sales():
    return requests.get("http://127.0.0.1:8000/get_all_product_sales").json()

def get_monthly_sales():
    return requests.get("http://127.0.0.1:8000/get_monthly_sales").json()

def get_discounted_products(high_stock=None, low_rating=None, clearance=None, seasonal=None):
    return requests.get("http://127.0.0.1:8000/get_discounted_products", params=
                        {
                            "high_stock": high_stock,
                            "low_rating": low_rating,
                            "clearance": clearance,
                            "seasonal": seasonal
                        }).json()

def fetch_review_insights(procedure_name, *params):
    return requests.get("http://127.0.0.1:8000/fetch_review_insights", params={
        "procedure_name": procedure_name,
        "params": ",".join(map(str, params))
    }).json()

def fetch_reviews(product_id):
    return requests.get("http://127.0.0.1:8000/fetch_reviews/{product_id}").json()

def fetch_stock_alerts(procedure_name, *params):
    return requests.get("http://127.0.0.1:8000/fetch_stock_alerts", params={
        "procedure_name": procedure_name,
        "params": ",".join(map(str, params))
    }).json()

def get_complaints():
    return requests.get("http://127.0.0.1:8000/get_complaints").json()
