import streamlit as st
import random
import datetime
import sql_api as sq
import pandas as pd
import plotly.express as px

if "ballon" not in st.session_state:
    st.session_state.ballon = False

def set_page_container_style(
        max_width: int = 1100, max_width_100_percent: bool = False,
        padding_top: int = 100, padding_right: int = 10, padding_left: int = 1, padding_bottom: int = 10,
        color: str = "blue", background_color: str = "black",
    ):
        if max_width_100_percent:
            max_width_str = f'max-width: 100%;'
        else:
            max_width_str = f'max-width: {max_width}px;'

        st.markdown(
            f'''
            <style>
                .reportview-container .sidebar-content {{
                    padding-top: {padding_top}rem;
                }}
                .reportview-container .main .block-container {{
                    {max_width_str}
                    padding-top: 0rem;
                    padding-right: {padding_right}rem;
                    padding-left: {padding_left}rem;
                    padding-bottom: {padding_bottom}rem;
                }}
                .reportview-container .main {{
                    color: {color};
                    background-color: {background_color};
                }}
            </style>
            ''',
            unsafe_allow_html=True,
        )

@st.dialog("Complaints")
def display_complaints():
    st.title(":red-background[Customer Complaints Dashboard]")

    complaints = sq.get_complaints()

    if not complaints:
        st.warning("No complaints found!")
        return

    random.shuffle(complaints)

    for complaint in complaints:
        with st.container(border=True):
            col1, col2 = st.columns([3, 6])
            
            with col1:
                st.markdown("📦 **Product**")
                st.markdown(f"🟠 *{complaint.split(":")[0]}*")

            with col2:
                st.markdown("✍ **Complaint**")
                st.markdown(f"💬 {complaint.split(":")[1]}")

            st.divider()

@st.dialog("Add a new category")
def categories_add():
    name = st.text_input("Category name")
    description = st.text_input("Description")
    if st.button("Submit"):
        sq.add_category(name, description)
        st.session_state.ballon = True
        st.rerun()

@st.dialog("Select the category to delete")
def categories_delete():
    option = st.selectbox(
    "",
    sq.get_all_categories(),
    index=None,
    placeholder="select category",
    )
    if st.button("Delete"):
        sq.delete_category(option.split("-")[1])
        st.session_state.ballon = True
        st.rerun()

@st.dialog("Edit Category")
def categories_edit():
    option = st.selectbox(
    "",
    sq.get_all_categories(),
    index=None,
    placeholder="select category",
    )
    if option != None:
        # st.write(option)
        id = option.split("-")[1]
        cat = sq.get_whole_category(id)
        name = st.text_input("Category name", value=cat[1])
        description = st.text_input("Description", value=cat[2])
        if st.button("Submit"):
            sq.edit_category(option.split("-")[1], name, description)
            st.session_state.ballon = True
            st.rerun()

@st.dialog("Add a new supplier")
def suppliers_add():
    name = st.text_input("Supplier name")
    email = st.text_input("Email")
    phone = st.text_input("Phone")
    address = st.text_input("Address")
    if st.button("Submit"):
        sq.add_supplier(name, email, phone, address)
        st.session_state.ballon = True
        st.rerun()

@st.dialog("Select the supplier to delete")
def suppliers_delete():
    option = st.selectbox(
    "",
    sq.get_all_suppliers(),
    index=None,
    placeholder="select supplier",
    )
    if st.button("Delete"):
        sq.delete_supplier(option.split("-")[1])
        st.session_state.ballon = True
        st.rerun()

@st.dialog("Edit Supplier")
def suppliers_edit():
    option = st.selectbox(
    "",
    sq.get_all_suppliers(),
    index=None,
    placeholder="select supplier",
    )
    if option != None:
        # st.write(option)
        id = option.split("-")[1]
        sup = sq.get_whole_supplier(id)
        name = st.text_input("Supplier name", value=sup[1])
        email = st.text_input("Email", value=sup[2])
        phone = st.text_input("Phone", value=sup[3])
        address = st.text_input("Address", value=sup[4])
        if st.button("Submit"):
            sq.edit_supplier(option.split("-")[1], name, email, phone, address)
            st.session_state.ballon = True
            st.rerun()


@st.dialog("Add a new product")
def products_add():
    name = st.text_input("Product name")
    category = st.selectbox(
    "Category",
    sq.get_all_categories(),
    index=None,
    placeholder="select category",
    )
    supplier = st.selectbox(
    "Supplier",
    sq.get_all_suppliers(),
    index=None,
    placeholder="select supplier",
    )
    price = st.number_input("Price", value=0)
    stock_quantity = st.number_input("Stock Quantity", value=0)
    if st.button("Submit"):
        sq.add_product(name, price, stock_quantity, category.split("-")[1], supplier.split("-")[1])
        st.session_state.ballon = True
        st.rerun()

@st.dialog("Select the product to delete")
def products_delete():
    st.write("it's a complex operation")
    option = st.selectbox(
    "",
    sq.get_all_products(),
    index=None,
    placeholder="select product",
    )
    if st.button("Delete"):
        sq.delete_product(option.split("-")[1])
        st.session_state.ballon = True
        st.rerun()

@st.dialog("Edit Product")
def products_edit():
    option = st.selectbox(
    "",
    sq.get_all_products(),
    index=None,
    placeholder="select product",
    )
    if option != None:
        # st.write(option)
        id = option.split("-")[1]
        prod = sq.get_whole_product(id)
        name = st.text_input("Product name", value=prod[1])
        price = st.number_input("Price", value= float(prod[4]))
        stock_quantity = st.number_input("Stock Quantity", value=prod[5])
        category = prod[2]
        supplier = prod[3]
        rating = prod[6]
        st.write(f"Rating: {rating}")
        categories = sq.get_all_categories()
        suppliers = sq.get_all_suppliers()
        category_dict = {cat.split("-")[1]: i  for i,cat in enumerate(categories)}
        supplier_dict = {sup.split("-")[1]: i for i,sup in enumerate(suppliers)}
        category2 = st.selectbox("Category", categories, index=category_dict[str(category)])
        supplier2 = st.selectbox("Supplier", suppliers, index=supplier_dict[str(supplier)])
        if st.button("Submit"):
            sq.edit_product(option.split("-")[1], name, price, stock_quantity, category2.split("-")[1], supplier2.split("-")[1])
            st.session_state.ballon = True
            st.rerun()


@st.dialog("Add a new user")
def users_add():
    name = st.text_input("User name")
    email = st.text_input("Email")
    password = st.text_input("Password")
    role = st.selectbox("Role", ['admin', 'marketing_analyst', 'sales_manager', 'customer_support'])
    if st.button("Submit"):
        rolei = 3
        if role == 'admin':
            rolei = 1
        elif role == 'marketing_analyst':
            rolei = 2
        elif rolei == 'sales_manager':
            rolei = 3
        elif role == 'customer_support':
            rolei = 4
        sq.add_user(name, email, password, rolei)
        st.session_state.ballon = True
        st.rerun()

@st.dialog("Select the user to delete")
def users_delete():
    option = st.selectbox(
    "",
    sq.get_all_users(),
    index=None,
    placeholder="select user",
    )
    if st.button("Delete"):
        sq.delete_user(option.split("-")[1])
        st.session_state.ballon = True
        st.rerun()

@st.dialog("Edit User")
def users_edit():
    option = st.selectbox(
    "",
    sq.get_all_users(),
    index=None,
    placeholder="select user",
    )
    if option != None:
        st.write(option)
        id = option.split("-")[1]
        user = sq.get_whole_user(id)
        name = st.text_input("User name", value=user[1])
        email = st.text_input("Email", value=user[2])
        password = st.text_input("Password", value=user[3])
        role = user[4]
        rolei = 3
        if role == 'admin':
            rolei = 1
        elif role == 'marketing_analyst':
            rolei = 2
        elif rolei == 'sales_manager':
            rolei = 3
        elif role == 'customer_support':
            rolei = 4
        role2 = st.selectbox("Role", ['admin', 'marketing_analyst', 'sales_manager', 'customer_support'], index=rolei-1)
        if st.button("Submit"):
            rolei = 3
            if role2 == 'admin':
                rolei = 1
            elif role2 == 'marketing_analyst':
                rolei = 2
            elif role2 == 'sales_manager':
                rolei = 3
            elif role2 == 'customer_support':
                rolei = 4
            sq.edit_user(option.split("-")[1], name, email, password, rolei)
            st.session_state.ballon = True
            st.rerun()

@st.dialog("Add a new discount")
def discounts_add():
    product = st.selectbox(
    "Product",
    sq.get_all_products(),
    index=None,
    placeholder="select product",
    )
    discount = st.number_input("Discount", value=0)
    start_date = st.date_input("Start Date", datetime.datetime.now())
    end_date = st.date_input("End Date", datetime.datetime.now())
    if st.button("Submit"):
        sq.add_discount(product.split("-")[1], discount, start_date, end_date)
        st.session_state.ballon = True
        st.rerun()

@st.dialog("Select the discount to delete")
def discounts_delete():
    option = st.selectbox(
    "",
    sq.get_all_discounts(),
    index=None,
    placeholder="select discount",
    )
    if st.button("Delete"):
        sq.delete_discount(option.split("(id:-")[1].split("-")[0])
        st.session_state.ballon = True
        st.rerun()

@st.dialog("Add a new review")
def reviews_add():
    customers = sq.get_all_customers()
    products = sq.get_all_products()
    customer = st.selectbox(
        "Customer",
        customers,
        index=None,
        placeholder="select customer",
    )
    product = st.selectbox(
        "Product",
        products,
        index=None,
        placeholder="select product",
    )

    sentiment_mapping = ["one", "two", "three", "four", "five"]
    selected = st.feedback("stars")
    if selected is not None:
        rating = int(selected)+1
    # rating = st.number_input("Rating", value=0)
    review = st.text_input("Review")
    if st.button("Submit"):
        sq.add_review(customer.split("-")[1], product.split("-")[1], rating, review)
        st.session_state.ballon = True
        st.rerun()

@st.dialog("Select the review to delete")
def reviews_delete():
    option = st.selectbox(
    "",
    sq.get_all_reviews(),
    index=None,
    placeholder="select review",
    )
    if st.button("Delete"):
        sq.delete_review(option.split("-")[1])
        st.session_state.ballon = True
        st.rerun()


@st.dialog("Add a new order")
def orders_add():
    option = st.selectbox(
        "",
        sq.get_all_customers(),
        index=None,
        placeholder="Select customer",
    )
    if option is not None:
        customer = option.split("-")[1]
    
    date = st.date_input("Order Date", datetime.datetime.now())

    if "order_count" not in st.session_state:
        st.session_state.order_count = 1  
    def add_order():
        st.session_state.order_count += 1

    order_inputs = []

    for i in range(st.session_state.order_count):
        product_key = f"product_{i}"
        quantity_key = f"quantity_{i}"

        product_option = st.selectbox(
            f"Product {i+1}",
            sq.get_all_products(),
            index=None,
            placeholder="Select product",
            key=product_key
        )

        if product_option:
            product_id = product_option.split('-')[1]
            quantity = st.number_input(
                f"Quantity {i+1}",
                key=quantity_key,
                max_value=1000,
                min_value=1
            )
            order_inputs.append((product_id, quantity))

    st.button("Add More Orders", on_click=add_order)

    if st.button("Submit"):
        if not option:
            st.error("Please select a customer")
            return

        if not order_inputs:
            st.error("Please add at least one product")
            return

        order_id = sq.add_order(customer, date)
        sq.add_order_items(order_id, order_inputs)
        st.session_state.ballon = True
        st.success("Order successfully added!")
        st.rerun()

@st.dialog("Submit a Complaint")
def complaints_add():
    option = st.selectbox(
        "",
        sq.get_all_customers(),
        index=None,
        placeholder="Select customer",
    )
    if option is not None:
        customer_id = option.split("-")[1]
    
    product_option = st.selectbox(
        "Select Product",
        sq.get_all_products(),
        index=None,
        placeholder="Select product",
    )

    if product_option:
        product_id = product_option.split('-')[1]

    complaint_text = st.text_area("Describe your complaint")

    if st.button("Submit Complaint", type="primary"):
        if not option:
            st.error("Please select a customer")
            return
        if not product_option:
            st.error("Please select a product")
            return
        if not complaint_text.strip():
            st.error("Complaint cannot be empty!")
            return

        sq.add_complaint(customer_id, product_id, complaint_text)
        st.success("Complaint submitted successfully!")
        st.rerun()

@st.dialog("Select the order to delete")
def orders_delete():
    option = st.selectbox(
    "",
    sq.get_all_orders(),
    index=None,
    placeholder="select order",
    )
    if st.button("Delete"):
        sq.delete_order(option.split(":-")[1])
        st.session_state.ballon = True
        st.rerun()

@st.dialog("Select the order item to delete")
def order_items_delete():
    option = st.selectbox(
    "",
    sq.get_all_order_items(),
    index=None,
    placeholder="select order item",
    )
    if st.button("Delete"):
        sq.delete_order_item(option.split(":-")[1])
        st.session_state.ballon = True
        st.rerun()

@st.dialog("Add a new customer")
def customers_add():
    name = st.text_input("Customer name")
    email = st.text_input("Email")
    phone = st.text_input("Phone")
    if st.button("Submit"):
        sq.add_customer(name, email, phone)
        st.session_state.ballon = True
        st.rerun()

@st.dialog("Edit Customer")
def customers_edit():
    option = st.selectbox(
    "",
    sq.get_all_customers(),
    index=None,
    placeholder="select customer",
    )
    if option != None:
        id = option.split("-")[1]
        cust = sq.get_whole_customer(id)
        name = st.text_input("Customer name", value=cust[1])
        email = st.text_input("Email", value=cust[2])
        phone = st.text_input("Phone", value=cust[3])
        if st.button("Submit"):
            sq.edit_customer(option.split("-")[1], name, email, phone)
            st.session_state.ballon = True
            st.rerun()

def ball():
    st.balloons()

def logout():
    st.session_state.clear()
    st.rerun()

def insights():
    st.header(":red[**Market**] :violet-background[**Dashboard**]", divider='violet')

    sales_data = sq.get_monthly_sales()
    
    if sales_data:
        df = pd.DataFrame(sales_data)
        
        fig = px.line(df, x="month", y="total_sold", color="product_name",
                    title="Monthly Sales Trend", markers=True,
                    labels={"total_sold": "Units Sold", "month": "Month"})
        st.plotly_chart(fig)
    else:
        st.warning("No seasonal sales data available.")

    with st.container():
        col = st.columns([100,20,100])
        with col[2]:
            st.header("Product Sales & Revenue Analysis")
            sales_data = sq.get_all_product_sales() or []
            if sales_data:
                
                df = pd.DataFrame(sales_data).reset_index(drop=True)
                st.dataframe(df)
                
                fig = px.bar(df, x="product_name", y="total_revenue", 
                            title="Revenue Contribution by Product", 
                            labels={"total_revenue": "Revenue ($)", "product_name": "Product"},
                            color="total_revenue", color_continuous_scale="blues")
                st.plotly_chart(fig, use_container_width=True)
                
            else:
                st.warning("No sales data available.")
        with col[1]:
            pass
        with col[0]:

            sales_data = sq.get_all_product_sales() or []

            if sales_data:
                df = pd.DataFrame(sales_data).reset_index(drop=True) 
                df["total_sold"] = pd.to_numeric(df["total_sold"], errors="coerce")
                df["total_revenue"] = pd.to_numeric(df["total_revenue"], errors="coerce")

                fig2 = px.pie(df, names="product_name", values="total_sold", 
                title="Sales Distribution", hole=0.4)
                st.plotly_chart(fig2)

                st.subheader("Top 3 Best-Selling Products")
                top_selling = df.nlargest(3, 'total_sold')
                st.write(top_selling)

                st.subheader("Bottom 3 Underperforming Products")
                underperformers = df.nsmallest(3, 'total_sold')  
                st.write(underperformers)

                fig = px.bar(df, x="product_name", y="total_revenue", 
                            title="Revenue Contribution by Product", 
                            labels={"total_revenue": "Revenue ($)", "product_name": "Product"},
                            color="total_revenue", color_continuous_scale="blues")
                st.plotly_chart(fig, use_container_width=True)
            else:
                st.warning("No sales data available.")

def products():
    st.write("")
    st.write("")


    option = st.selectbox(
        "",
        sq.get_all_products(),
        index=None,
        placeholder="🔍 Search a product...",
    )

    if option is not None:
        product = sq.get_product_details(option.split("-")[1])


        with st.container(border=True):
            c1, c2 = st.columns([6, 4]) 

            with c1:
                st.markdown(f"""
                    <div style="background-color:#222831; padding:15px; border-radius:12px; box-shadow: 0px 0px 15px rgba(255,140,0,0.5);">
                        <h3 style="color:#FF8C00;">🔹 {product["product_name"]}</h3>
                        <p><strong style="color:#FFD700;">🛒 Category:</strong> <span style="color:#87CEEB;">{product["category_name"]}</span></p>
                        <p><strong style="color:#FFD700;">💲 Price:</strong> <span style="color:#00FF7F;">${product["price"]}</span></p>
                        <p><strong style="color:#FFD700;">📦 Stock:</strong> <span style="color:#FF4500;">{product["stock_quantity"]} units</span></p>
                    </div>
                """, unsafe_allow_html=True)

            with c2:
                st.markdown(f"""
                    <div style="background-color:#333945; padding:15px; border-radius:12px; box-shadow: 0px 0px 12px rgba(30,144,255,0.6);">
                        <h4 style="color:#1E90FF;">🏢 Supplier Info</h4>
                        <p><strong style="color:#FFD700;">🏷 Dealer:</strong> <span style="color:#FFFFFF;">{product["supplier_name"]}</span></p>
                        <p><strong style="color:#FFD700;">📧 Email:</strong> <span style="color:#FFFFFF;">{product["contact_email"]}</span></p>
                        <p><strong style="color:#FFD700;">📞 Phone:</strong> <span style="color:#FFFFFF;">{product["phone"]}</span></p>
                    </div>
                """, unsafe_allow_html=True)

                st.write("")
                if st.button("➕ **Add Stock**", type="primary"):
                    sq.add_stock(product["product_id"], 1)
                    st.success("✅ Stock updated successfully!", icon="📦")
    st.header(" Stock Level Alerts & Warnings")

    alert_type = st.selectbox(
        "Select Stock Alert Type:",
        ["Stock Demand Mismatch", "Low-Stock Products", "Overstocked Slow Movers"]
    )

    min_stock = 10
    min_sales = 5
    max_stock = 100

    if alert_type == "Low-Stock Products":
        min_stock = st.number_input("⚠️ Minimum Stock Threshold", min_value=1, value=50, step=1)

    elif alert_type == "Overstocked Slow Movers":
        min_sales = st.number_input("📉 Minimum Sales Threshold", min_value=0, value=50, step=1)
        max_stock = st.number_input("📦 Maximum Stock Threshold", min_value=10, value=100, step=10)


    procedure_mapping = {
        "Stock Demand Mismatch": ("CheckStockDemandMismatch", []),
        "Low-Stock Products": ("GetLowStockProducts", [min_stock]),
        "Overstocked Slow Movers": ("GetOverstockedSlowMovers", [min_sales, max_stock])
    }


    procedure_name, params = procedure_mapping[alert_type]
    df = sq.fetch_stock_alerts(procedure_name, *params)

    if df is not None and not df.empty:
        col1, col2 = st.columns([1, 1])


        with col1:
            st.subheader(":violet-background[Data Overview]")
            st.dataframe(df.style.set_properties(**{"background-color": "#2B2B2B", "color": "white"}))


        with col2:

            if alert_type == "Stock Demand Mismatch":
                fig = px.bar(df, x="name", y="stock_quantity", color="stock_status",
                            title="Stock vs. Demand", height=500)
            elif alert_type == "Low-Stock Products":
                fig = px.bar(df, x="name", y="stock_quantity", color="stock_quantity",
                            title="Low Stock Products", height=500)
            else: 
                fig = px.scatter(df, x="stock_quantity", y="total_sold", text="name",
                                title="Overstocked vs. Slow Sales", size="stock_quantity",
                                color="total_sold", height=500)
            
            st.plotly_chart(fig)

    else:
        st.warning("✅ No critical stock issues detected!")

def admin():
    st.markdown("<h1 style='text-align: center; color: #4CAF50;'>Admin Dashboard 🛠️</h1>", unsafe_allow_html=True)
    st.markdown("<h5 style='text-align: center; color: grey;'>Manage Your Inventory with Ease</h5>", unsafe_allow_html=True)
    st.write("---")

    if st.session_state.get("ballon", False):
        ball()
        st.session_state.ballon = False

    tables = {
        "Categories": {"desc": "Manage product categories", "buttons": ["➕ Add", "❌ Delete", "✏️ Edit"], "color": "#FF6F61"},
        "Suppliers": {"desc": "Manage suppliers", "buttons": ["➕ Add", "❌ Delete", "✏️ Edit"], "color": "#6B5B95"},
        "Products": {"desc": "Manage available products", "buttons": ["➕ Add", "❌ Delete", "✏️ Edit"], "color": "#88B04B"},
        "Users": {"desc": "Manage registered users", "buttons": ["➕ Add", "❌ Delete", "✏️ Edit"], "color": "#FFAA1D"},
        "Discounts": {"desc": "Manage product discounts", "buttons": ["➕ Add", "❌ Delete"], "color": "#009B77"},
        "Reviews": {"desc": "Manage customer reviews", "buttons": ["➕ Add", "❌ Delete"], "color": "#D65076"},
        "Orders": {"desc": "Manage customer orders", "buttons": ["➕ Add", "❌ Delete"], "color": "#45B8AC"},
        "Order_Items": {"desc": "Manage items within orders", "buttons": ["❌ Delete"], "color": "#EFC050"},
        "Customers": {"desc": "Manage customer data", "buttons": ["➕ Add", "✏️ Edit"], "color": "#5B5EA6"}
    }


    actions = {
        "categories_add": categories_add, "categories_delete": categories_delete, "categories_edit": categories_edit,
        "suppliers_add": suppliers_add, "suppliers_delete": suppliers_delete, "suppliers_edit": suppliers_edit,
        "products_add": products_add, "products_delete": products_delete, "products_edit": products_edit,
        "users_add": users_add, "users_delete": users_delete, "users_edit": users_edit,
        "discounts_add": discounts_add, "discounts_delete": discounts_delete,
        "reviews_add": reviews_add, "reviews_delete": reviews_delete,
        "orders_add": orders_add, "orders_delete": orders_delete,
        "order_items_delete": order_items_delete,
        "customers_add": customers_add, "customers_edit": customers_edit
    }


    cols = st.columns(3)

    for i, (table, data) in enumerate(tables.items()):
        with cols[i % 3]:  
            with st.container(border=True):
                st.markdown(f"""
                    <div style='background-color: {data["color"]}; padding: 10px; border-radius: 10px; text-align: center;'>
                        <h3 style='color: white; margin-bottom: 5px;'>{table}</h3>
                        <p style='color: white; font-size: 14px;'>{data["desc"]}</p>
                    </div>
                """, unsafe_allow_html=True)
                st.write("")

                for button in data["buttons"]:
                    button = button.split(" ")[1]
                    btn_key = f"{table}_{button}".lower()
                    if st.button(label=button, key=btn_key, use_container_width=True):
                        if btn_key in actions:
                            actions[btn_key]()

def customer():
    st.markdown("<h1 style='text-align: center; color: #4CAF50;'>Customer Dashboard 🛍️</h1>", unsafe_allow_html=True)
    st.markdown("<h5 style='text-align: center; color: grey;'>Manage Accounts, Orders, and Complaints</h5>", unsafe_allow_html=True)
    st.write("---")

    if st.session_state.get("ballon", False):
        ball()
        st.session_state.ballon = False

    tables = {
        "Customers": {"desc": "Manage customer data", "buttons": ["➕ Add"], "color": "#FF6F61"},
        "Orders": {"desc": "Manage customer orders", "buttons": ["➕ Add", "❌ Delete"], "color": "#45B8AC"},
        "Order_Items": {"desc": "Manage items within orders", "buttons": ["❌ Delete"], "color": "#EFC050"},
        "Complaints": {"desc": "Manage customer complaints", "buttons": ["➕ Add"], "color": "#D9534F"}
    }

    actions = {
        "orders_add": orders_add,
        "orders_delete": orders_delete,
        "order_items_delete": order_items_delete,
        "customers_add": customers_add,
        "complaints_add": complaints_add
    }

    cols = st.columns(3)

    for i, (table, data) in enumerate(tables.items()):
        with cols[i % 3]:  
            with st.container(border=True):
                st.markdown(f"""
                    <div style='background-color: {data["color"]}; padding: 10px; border-radius: 10px; text-align: center;'>
                        <h3 style='color: white; margin-bottom: 5px;'>{table}</h3>
                        <p style='color: white; font-size: 14px;'>{data["desc"]}</p>
                    </div>
                """, unsafe_allow_html=True)
                st.write("")

                for button in data["buttons"]:
                    button = button.split(" ")[1]
                    btn_key = f"{table}_{button}".lower()
                    if st.button(label=button, key=btn_key, use_container_width=True):
                        if btn_key in actions:
                            actions[btn_key]()
        
def reviews():
    st.markdown("<h1 style='text-align: center; color: #FFA500;'> Customer Review Insights</h1>", unsafe_allow_html=True)

    st.write(":violet-background[**Select Analysis Type**]")

    analysis_type = st.selectbox(
        "",
        ["Review Impact on Sales", "Review-Based Sales Trends", "Review Collection Strategies"]
    )

    col1, col2, col3 = st.columns([1, 1, 1])

    review_threshold = 50  
    min_reviews = 10       
    min_sales = 100        

    if analysis_type == "Review-Based Sales Trends":
        with col1:
            review_threshold = st.number_input("🔢 Review Threshold", min_value=1, value=35, step=5)

    elif analysis_type == "Review Collection Strategies":
        with col1:
            min_reviews = st.number_input("📝 Max Reviews", min_value=0, value=30, step=1)
        with col2:
            min_sales = st.number_input("💰 Min Sales", min_value=0, value=10, step=10)


    procedure_mapping = {
        "Review Impact on Sales": ("AnalyzeReviewImpact", []),
        "Review-Based Sales Trends": ("ReviewBasedSalesTrends", [review_threshold]),
        "Review Collection Strategies": ("RecommendReviewCollection", [min_reviews, min_sales])
    }

    procedure_name, params = procedure_mapping[analysis_type]
    df = sq.fetch_review_insights(procedure_name, *params)

    if df is not None and not df.empty:
        col1, col2 = st.columns([1, 1])

        with col1:
            st.markdown("<h3 style='color: #DC143C;'> Data Table</h3>", unsafe_allow_html=True)
            st.dataframe(df.style.set_properties(**{'background-color': '#222831', 
                                                     'color': '#00ADB5', 
                                                     'border-color': 'white'}))

        with col2:
            st.markdown("<h3 style='color: #FFD700;'> Visualization</h3>", unsafe_allow_html=True)

            if analysis_type == "Review Impact on Sales":
                fig = px.bar(df, x="name", y="total_sales", color="avg_rating",
                             title="💰 Sales Performance by Ratings",
                             labels={"total_sales": "Units Sold", "avg_rating": "Rating"},
                             height=500, template="plotly_dark")
                st.plotly_chart(fig, use_container_width=True)

            elif analysis_type == "Review-Based Sales Trends":
                fig = px.pie(df, names="review_category", values="total_sales",
                             title="📈 Sales Distribution by Review Count",
                             color_discrete_sequence=px.colors.qualitative.Set3)
                st.plotly_chart(fig, use_container_width=True)

            elif analysis_type == "Review Collection Strategies":
                fig = px.bar(df, x="name", y="total_sales", color="total_reviews",
                             title="💡 High-Selling but Low-Reviewed Products",
                             labels={"total_sales": "Units Sold", "total_reviews": "Reviews"},
                             height=500, template="plotly_dark")
                st.plotly_chart(fig, use_container_width=True)

    else:
        st.markdown(
            "<h3 style='text-align: center; color: #FF4500;'>⚠️ No data available for the selected analysis.</h3>", 
            unsafe_allow_html=True
        )

def CSM():
    st.markdown("<h2 style='text-align: center; color: #FFA500;'>📝 Product Reviews</h2>", unsafe_allow_html=True)

    products = sq.get_all_products()
    product_option = st.selectbox(":blue-background[Select Product:]", products, index=None, placeholder="Choose a product")

    if product_option:
        product_id = product_option.split("-")[1]

        sort_order_sql = "DESC"

        df = sq.fetch_reviews(product_id, sort_order_sql)

        if df is not None and not df.empty:
            col1, col2 = st.columns([1, 2])

            with col1:
                st.markdown("<h3 style='color: #2E8B57;'>📜 Reviews Table</h3>", unsafe_allow_html=True)
                st.dataframe(df.style.set_properties(**{'background-color': '#222831', 
                                                         'color': '#00ADB5', 
                                                         'border-color': 'white'}))

            with col2:
                st.markdown("<h3 style='color: #FFD700;'>📊 Rating Distribution</h3>", unsafe_allow_html=True)
                fig = px.histogram(df, x="rating", nbins=5, title="Ratings Distribution", color_discrete_sequence=["#FF4500"])
                st.plotly_chart(fig, use_container_width=True)

        else:
            st.warning("⚠️ No reviews found for this product.")
    
    if st.button(":red[complaints]"):
        display_complaints()

def projected_price_and_revenue(trends_df, sales_df, product_id, selected_month, new_discount):

    product_data = trends_df[trends_df["product_id"] == product_id]
    sales_data = sales_df[sales_df["product_id"] == product_id]

    current_price = product_data[product_data["month"] == selected_month]["final_price"].values
    if len(current_price) == 0:
        return "No data available for this product and month.", None, None

    current_price = float(current_price[0])
    product_data["price_change"] = product_data["final_price"].astype(float).pct_change()
    avg_change = product_data["price_change"].mean() if not pd.isna(product_data["price_change"].mean()) else 0

    projected_price = current_price * (1 + avg_change)
    projected_price *= (1 - new_discount / 100)

    units_sold = sales_data[sales_data["month"] == selected_month]["total_units_sold"].values
    if len(units_sold) == 0:
        return round(projected_price, 2), None, None

    units_sold = int(units_sold[0])

    current_revenue = current_price * units_sold
    projected_revenue = projected_price * units_sold
    revenue_change = projected_revenue - current_revenue
    return round(projected_price, 2), round(revenue_change, 2), round(projected_revenue, 2)

def trends():
    st.header("💰 Revenue Optimization Strategies")

    analysis_type = st.selectbox(
        "Select Analysis Type:",
        ["Pricing Trends (2025)", "Product Sales (2025)", "Projected Pricing (2026)"]
    )

    if analysis_type == "Pricing Trends (2025)":
        st.subheader("📉 Pricing Trends in 2025")
        pricing_df = sq.fetch_pricing_trends_2025()

        if pricing_df.empty:
            st.warning("No pricing data available for 2025.")
            return

        pricing_df["month"] = pricing_df["month"].map({
            1: "Jan", 2: "Feb", 3: "Mar", 4: "Apr", 5: "May", 6: "Jun",
            7: "Jul", 8: "Aug", 9: "Sep", 10: "Oct", 11: "Nov", 12: "Dec"
        })

        fig = px.line(pricing_df, x="month", y="final_price", 
                      color="product_name", markers=True,
                      title="Monthly Price Trends",
                      labels={"final_price": "Price ($)", "month": "Month"},
                      line_shape="spline")

        st.plotly_chart(fig)
        st.dataframe(pricing_df)

    elif analysis_type == "Product Sales (2025)":
        st.subheader("📦 Product Sales in 2025")
        sales_df = sq.fetch_product_sales_2025()

        if sales_df.empty:
            st.warning("No sales data available for 2025.")
            return

        sales_df["month"] = sales_df["month"].map({
            1: "Jan", 2: "Feb", 3: "Mar", 4: "Apr", 5: "May", 6: "Jun",
            7: "Jul", 8: "Aug", 9: "Sep", 10: "Oct", 11: "Nov", 12: "Dec"
        })

        fig = px.bar(sales_df, x="month", y="total_units_sold", 
                     color="product_name",
                     title="Number of Units Sold per Month",
                     labels={"total_units_sold": "Units Sold", "month": "Month"},
                     barmode="group")

        st.plotly_chart(fig)
        st.dataframe(sales_df)

    elif analysis_type == "Projected Pricing (2026)":
        st.subheader("🔮 Projected Pricing for 2026")

        pricing_df = sq.fetch_pricing_trends_2025()
        sales_df = sq.fetch_product_sales_2025()

        if pricing_df.empty or sales_df.empty:
            st.warning("No data available for projection.")
            return

        selected_product = st.selectbox("Select Product:", pricing_df["product_name"].unique())
        selected_month = st.selectbox("Select Month:", list(range(1, 13)), format_func=lambda x: datetime.date(2025, x, 1).strftime("%B"))
        new_discount = st.number_input("New Discount (%)", min_value=0, max_value=100, value=0)

        product_id = pricing_df[pricing_df["product_name"] == selected_product]["product_id"].values[0]

        if st.button("Calculate Projected Price"):
            projected_price, revenue_change, projected_revenue = projected_price_and_revenue(
                pricing_df, sales_df, product_id, selected_month, new_discount
            )

            if projected_price is None:
                st.warning("No sufficient data to calculate projected price.")
            else:
                st.success(f"Projected Price for {selected_product} in {datetime.date(2026, selected_month, 1).strftime('%B %Y')}: **${projected_price}**")
                
                if revenue_change is not None:
                    change_symbol = "📈" if revenue_change > 0 else "📉"
                    st.write(f"**Total Revenue Change:** {change_symbol} **${revenue_change}**")
                    st.write(f"**Projected Revenue for {datetime.date(2026, selected_month, 1).strftime('%B %Y')}:** 💰 **${projected_revenue}**")