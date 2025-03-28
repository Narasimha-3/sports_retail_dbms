# Sports Retail DBMS

A relational database for a sports retail store, with a Streamlit app on top. Products, suppliers, customers, orders, reviews, discounts and complaints live in MySQL. Triggers keep the data consistent, stored procedures do the analysis, and the Python code only calls them.

DBMS course project, IIT Hyderabad, March 2025.

## What the app does

Users log in, and each role sees different pages.

| Role | Pages |
|---|---|
| `admin` | Insights, Products, Admin, Trends, customer, Reviews, CSM |
| `sales_manager` | Insights, Products, Trends, Reviews |
| `marketing_analyst` | Insights, Products, Reviews |
| `customer_support` | Reviews, CSM, customer |

- **Insights:** monthly sales, sales and revenue by product, and the three best-selling and three weakest products.
- **Products:** search a product to see its price, stock and supplier, and add stock. Below that are stock alerts: demand mismatch, low stock, and overstocked slow movers.
- **Admin:** manage categories, suppliers, products, users, discounts, reviews, orders, order items and customers (add, edit or delete, depending on the table).
- **Trends:** monthly pricing trends and product sales for 2025, and a projected price and revenue for 2026 under a chosen discount.
- **Reviews:** the impact of reviews on sales, sales trends by review count, and review collection strategies.
- **CSM:** the reviews for one product.
- **customer:** add customers, orders and complaints, and delete orders and order items.

## Database

The database is called `sports_retail`. It has ten tables: `users`, `categories`, `suppliers`, `products`, `customers`, `orders`, `order_items`, `reviews`, `discounts` and `complaints`.

**Triggers** (`sql/main/TRIGGERS.sql`) hold the business rules:

- A new order item checks stock, takes the product's current price as its unit price, and reduces the stock. If there is not enough stock, the insert fails.
- An order's total is kept up to date when items are added or removed, using the highest discount that applies.
- A review is only accepted from a customer who bought that product, and the product's rating is updated after each review.
- Deleting an order, a product, a category or a supplier also deletes the rows that depend on it.
- Ids for new rows are assigned by triggers.

**View** (`sql/main/VIEWS.sql`): `max_discounts`, the highest discount for each product.

**Stored procedures** (`sql/main/STORED_PROCEDURES.sql`) cover:

- Lookups and edits for products and categories, and adding stock.
- Stock checks: `CheckStockDemandMismatch`, `GetLowStockProducts`, `GetOverstockedSlowMovers`.
- Pricing: `ApplyDiscounts` (by stock, rating and age), `ApplyDynamicPricing` (by demand), `OptimizeDiscounts` and `GetPricingTrends`.
- Reviews and sales: `AnalyzeReviewImpact`, `ReviewBasedSalesTrends`, `RecommendReviewCollection` and `GetTopSellingProducts`.

## Running it

You need Python 3 and MySQL.

1. Install the packages:

   ```bash
   pip install streamlit streamlit-navigation-bar mysql-connector-python pandas plotly
   ```

2. Create the database and load the schema and sample data:

   ```bash
   mysql -u root -p -e "CREATE DATABASE sports_retail"
   mysql -u root -p sports_retail < sql/database/loadALL.sql
   ```

3. Set your MySQL root password and start the app:

   ```bash
   export DB_PASSWORD='your-mysql-password'
   streamlit run gui.py
   ```

The app connects to MySQL on `localhost` as `root`.

### Sample logins

The sample data has these accounts. The username and password are the same.

| Username | Role |
|---|---|
| `admin` | admin |
| `sm` | sales_manager |
| `ma` | marketing_analyst |
| `csm` | customer_support |

## Optional HTTP API

`external api (optional-for production use)/` has the same calls behind a small FastAPI service (`test_api.py`) and a client for it (`syntax_api.py`). The client expects the service at `http://127.0.0.1:8000`. It needs `fastapi`, `uvicorn` and `requests`, and the same `DB_PASSWORD` variable. The Streamlit app does not use it.

## Layout

```text
gui.py            login and page routing
script.py         the pages
sql_api.py        Python wrappers around the stored procedures and queries
sql/main/         tables, triggers, view, stored procedures, sample entries
sql/database/     loadALL.sql, the full schema and sample data in one file
sql/              the scripts written while building it (triggers, procedures, sample reviews, clean-up)
external api (optional-for production use)/
```
