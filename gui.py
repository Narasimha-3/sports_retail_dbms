import os

import streamlit as st
from streamlit_navigation_bar import st_navbar

import script as sq
import sql_api as sql

st.set_page_config(page_title="", layout="wide")

user_list = sql.get_all_users_creds()

USER_CREDENTIALS = {}
for user in user_list:
    USER_CREDENTIALS[user[2]] = {"password": user[3], "role": user[4]}

def authenticate_user():
    if "authenticated" not in st.session_state:
        st.session_state["authenticated"] = False

    if not st.session_state["authenticated"]:
        col = st.columns(3)
        with col[0]:
            pass
        with col[1]:
            st.image("HD-wallpaper-sike-logo-nike-nike-logo.jpg")
            st.text_input("Username:", key="user")
            password1 = st.text_input("Password:", key="passwd", type="password")

            if st.button("Login", type="primary") or password1:
                username = st.session_state.get("user", "").strip()
                password = st.session_state.get("passwd", "").strip()

                if username in USER_CREDENTIALS and USER_CREDENTIALS[username]["password"] == password:
                    st.session_state["authenticated"] = True
                    st.session_state["role"] = USER_CREDENTIALS[username]["role"]
                    st.rerun()
                else:
                    st.warning("Invalid Username or Password!")
        with col[2]:
            pass
        return False

    return True



if authenticate_user():

    pages = ["Insights", "Products", "Admin", "Trends", "customer", "Reviews", "CSM", "Logout"]

    styles = {
        "nav": {"background-color": "rgb(24, 27, 43)"},
        "div": {"max-width": "69rem", "width": "100%"},
        "span": {
            "border-radius": "0.5rem",
            "color": "rgb(255, 255, 255)",
            "margin": "0 0.125rem",
            "padding": "0.4375rem 0.625rem",
        },
        "active": {"background-color": "rgba(204, 204, 255, 0.9)"},
        "hover": {"background-color": "rgba(204, 204, 255, 0.7)"},
    }


    role = st.session_state["role"]
    # role = "admin"

    if role == "marketing_analyst":
        allowed_pages = ["Insights","Products", "Reviews", "Logout"]
    elif role == "sales_manager":
        allowed_pages = ["Insights", "Products", "Trends", "Reviews", "Logout"]
    elif role == "customer_support":
        allowed_pages = ["Reviews", "CSM", "customer", "Logout"]
    elif role == "admin":
        allowed_pages = pages

    page = st_navbar(allowed_pages, styles=styles, options=False)

    functions = {
        "Insights": sq.insights,
        "Reviews": sq.reviews,
        "Products": sq.products,
        "Admin": sq.admin,
        "customer": sq.customer,
        "CSM": sq.CSM,
        "Trends": sq.trends,
        "Logout": sq.logout
    }

    go_to = functions.get(page)
    if go_to:
        go_to()
