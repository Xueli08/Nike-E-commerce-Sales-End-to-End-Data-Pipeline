# 📊 Nike E-commerce Sales & End-to-End Data Pipeline

##  Project Overview
This project demonstrates an end-to-end data engineering and analytics pipeline using e-commerce sales data. The objective was to transform raw transactional data into a dimensional data model (Star Schema) and surface actionable business insights regarding regional performance, profit margins, and inventory management.

##  Tech Stack & Architecture
* **Database / ETL:** PostgreSQL (DBeaver)
* **Data Modeling:** Star Schema (1 Fact Table, 2 Dimension Tables)
* **Data Visualization:** Power BI
* **Calculations:** Advanced SQL (Window Functions, CTEs) and DAX

##  Data Architecture
The data was modeled into a traditional Star Schema to optimize for analytical querying in Power BI:
* **`fact_sales`**: Core transactional data (`revenue`, `profit`, `units_sold`, `mrp`).
* **`dim_products`**: Product attributes (`product_name`, `gender_category`, `size`).
* **`dim_regions`**: Geographic dimensions (`region_name`).

##  Key Analytical Inquiries
The backend SQL queries (`02_business_analytics.sql`) and frontend Power BI dashboard were designed to answer five core business questions:
1. **Regional Rankings:** Which top 3 products generate the highest revenue per region?
2. **Growth Metrics:** What is the Month-over-Month (MoM) revenue growth percentage?
3. **Profitability:** How do profit margins compare across Retail vs. Online sales channels?
4. **Demographic Splits:** How does revenue distribute across Men's, Women's, and Kids' categories by channel?
5. **Inventory Management (Dead Stock):** Which high-ticket items (MRP > 2500) have low sales volume (Units < 500)?

##  Dashboard Preview
![Dashboard Preview](assets/dashboard_demo.gif)

## How to Run the Project
1. Execute `01_data_analysis` in your PostgreSQL environment to build the schema and insert the cleaned data.
2. Run `02_data_cleaning_and_modelling` to test the business logic and verify the outputs.
3. Open `Nike_Sales_Analytics.pbix` in Power BI Desktop to interact with the frontend visualizations.
