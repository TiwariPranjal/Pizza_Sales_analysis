Create Table pizza_sales(
pizza_id  INT,
order_id  INT,
pizza_name_id VARCHAR(50),
quantity smallInt,
order_date DATE,
order_time TIME,
unit_price Numeric(10,2),
total_price Numeric(10,2),
pizza_size  Varchar(50),
pizza_category  Varchar(50),
pizza_ingredients Varchar(250),
pizza_name Varchar(50)
);

Select * from pizza_sales;

-- Q1--> Total Revenue(the sum of the total price of all pizza orders)

Select Sum(total_price) As Total_Revenue from pizza_sale;

-- Q2--> Average Order Value: The average aount spent per order, calculated by dividing total revenue by the total numbers of orders

Select Round(Sum(total_price)/Count(Distinct order_id),2)
	as Avg_Order_Values from pizza_sales;

-- Q3-->Total pizza sold

Select Sum(quantity) As Total_pizza_Slod
	from pizza_sales

-- Q4--> Total order placed

Select Count(Distinct order_id) As total_orders from pizza_sales

-- Q5--> Avg no of pizza sold per order

Select * from pizza_sales

SELECT
    ROUND(
        SUM(quantity)::Numeric/ COUNT(DISTINCT order_id),
        2
    ) AS avg_pizzas_per_order
FROM pizza_sales;

-- or
SELECT
    ROUND(
        CAST(SUM(quantity) AS NUMERIC) 
        / CAST(COUNT(DISTINCT order_id) AS NUMERIC),
        2
    ) AS avg_pizzas_per_order
FROM pizza_sales;

-- Daily trend for total orders

Select * from pizza_sales

SELECT
    TO_CHAR(order_date, 'Day') AS day_name
	,COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
group by TO_CHAR(order_date, 'Day'),EXTRACT(DOW FROM order_date)
order by EXTRACT(DOW FROM order_date);

-- hourly trend for total order

Select 
	Extract(Hour from order_time) As order_hour,
	Count(Distinct order_id) as total_orders
from pizza_sales
group by Extract(Hour from order_time)
order by order_hour;

-- percentage of sales by pizza category

Select * from pizza_sales;

Select pizza_category,
	round(sum(total_price)*100/(Select Sum(total_price) from pizza_sales),2)as total_sales
from pizza_sales
group by pizza_category;

-- percenta of sales by pizza sizes

Select pizza_size,
	round(sum(total_price)*100/(Select Sum(total_price) from pizza_sales),2)as total_sales
from pizza_sales
group by pizza_size

-- total pizza sold by pizza category

Select pizza_category,
	round(sum(quantity),2)
from pizza_sales
group by pizza_category;

-- Top 5 best sellers by revenue, Total Quantity and total orders
Select * from pizza_sales;

SELECT
    pizza_name,
    ROUND(SUM(total_price), 2) AS revenue,
    SUM(quantity) AS total_quantity,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY revenue DESC
LIMIT 5;

