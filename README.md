# 🍕 Pizza Sales Analysis (PostgreSQL)

## 📌 Project Overview
This project analyzes pizza sales data using **PostgreSQL** to derive key business insights such as revenue, order trends, best-selling pizzas, and customer ordering behavior.

**Project Title**:Pizza Sales Analysis
This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. 

## 🛠️ Tools & Technologies
- PostgreSQL
- Power BI

## 📊 Power BI Dashboard

An interactive Power BI dashboard was created to visualize key insights from the pizza sales data.

### Dashboard Highlights
- Sales KPIs (Revenue, Orders, AOV)
- Time-based order trends (Daily, Hourly, Monthly)
- Category & size performance
- Top-selling pizzas.


## Project Structure

### 1.Database Setup

- **Database Creation**: The project starts by creating a database named `Pizza_sales_Analysis`.
- **Table Creation**: A table named `pizza_sales` is created to store the sales data.
``` sql
CREATE DATABASE Pizza_Sales_Analysis;

CREATE TABLE pizza_sales
(
    pizza_id INT,
    order_id INT,
    pizza_name_id VARCHAR(50),
    quantity SMALLINT,
    order_date DATE,
    order_time TIME,
    unit_price NUMERIC(10,2),
    total_price NUMERIC(10,2),
    pizza_size VARCHAR(50),
    pizza_category VARCHAR(50),
    pizza_ingredients VARCHAR(250),
    pizza_name VARCHAR(50)
);
```
### 2. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

Q1: **Total Revenue.**
```sql
SELECT
    SUM(total_price) AS total_revenue
FROM pizza_sales;
```

Q2: **Average Order Value.**
```sql
SELECT
    ROUND(
        SUM(total_price) / COUNT(DISTINCT order_id),
        2
    ) AS avg_order_value
FROM pizza_sales;
```

Q3: **Total Pizzas Sold.**
```sql
SELECT
    SUM(quantity) AS total_pizzas_sold
FROM pizza_sales;
```

Q4: **Total Orders Placed.**
```sql
SELECT
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales;
```

Q5: **Average Pizzas Sold per Order.**
```sql
SELECT
    ROUND(
        CAST(SUM(quantity) AS NUMERIC) /
        CAST(COUNT(DISTINCT order_id) AS NUMERIC),
        2
    ) AS avg_pizzas_per_order
FROM pizza_sales;
```

Q6: **Daily Trend for Total Orders.**
```sql
SELECT
    TRIM(TO_CHAR(order_date, 'Day')) AS day_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY
    TRIM(TO_CHAR(order_date, 'Day')),
    EXTRACT(DOW FROM order_date)
ORDER BY
    EXTRACT(DOW FROM order_date);
```

Q7: **Monthly Trend for Total Orders.**
```sql
SELECT
    TRIM(TO_CHAR(order_date, 'Month')) AS month_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY
    TRIM(TO_CHAR(order_date, 'Month')),
    EXTRACT(MONTH FROM order_date)
ORDER BY
    EXTRACT(MONTH FROM order_date);
```

Q8: **Hourly Trend for Orders.**
```sql
SELECT
    EXTRACT(HOUR FROM order_time) AS order_hour,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY EXTRACT(HOUR FROM order_time)
ORDER BY order_hour;
```

Q9: **Percentage of Sales by Pizza Category.**
```sql
SELECT
    pizza_category,
    ROUND(
        SUM(total_price) * 100.0 /
        (SELECT SUM(total_price) FROM pizza_sales),
        2
    ) AS percentage_of_sales
FROM pizza_sales
GROUP BY pizza_category
ORDER BY percentage_of_sales DESC;
```

Q10: **Percentage of Sales by Pizza Size.**
```sql
SELECT
    pizza_size,
    ROUND(
        SUM(total_price) * 100.0 /
        (SELECT SUM(total_price) FROM pizza_sales),
        2
    ) AS percentage_of_sales
FROM pizza_sales
GROUP BY pizza_size
ORDER BY percentage_of_sales DESC;
```

Q11: **Total Pizzas Sold by Category.**
```sql
SELECT
    pizza_category,
    SUM(quantity) AS total_pizzas_sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY total_pizzas_sold DESC;
```

Q12: **Top 5 Best-Selling Pizzas.**
```sql
SELECT
    pizza_name,
    ROUND(SUM(total_price), 2) AS revenue,
    SUM(quantity) AS total_quantity,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY revenue DESC
LIMIT 5;
```

## 📊 Key Business Questions Answered
1. Total revenue generated
2. Average order value
3. Total pizzas sold
4. Total number of orders
5. Average pizzas per order
6. Daily, monthly, and hourly order trends
7. Percentage contribution of pizza categories and sizes
8. Top 5 best-selling pizzas by revenue, quantity, and orders

## 📈 Insights Generated
- Identified peak ordering hours
- Found top-performing pizza categories
- Analyzed customer ordering patterns
- Determined revenue contribution by size and category

## 📂 Files
- `pizza_sales.sql` → Complete SQL analysis
- `dataset/` → Raw sales data (optional)

## 🚀 How to Run
1. Create the table using the provided SQL
2. Load the dataset into PostgreSQL
3. Execute queries section-wise for insights

## 📎 Author
**Pranjal Tiwari**  
Aspiring Data Analyst | SQL | Data Analytics
