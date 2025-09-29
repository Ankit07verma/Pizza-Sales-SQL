-- QUESTIONS

--Retrieve the total number of orders placed.

SELECT COUNT(*) as TOTAL_ORDER_COUNT
FROM Orders

--Calculate the total revenue generated from pizza sales.

SELECT TRUNC(SUM(o.quantity*p.price)) as TOTAL_REVENUE
FROM PIZZAS p
JOIN order_Details o
ON p.pizza_id = o.pizza_id

--Identify the highest-priced pizza.

SELECT * FROM Pizzas
ORDER BY Price DESC
LIMIT 1

--Identify the most common pizza size ordered.

SELECT p.size, COUNT(o.*) as Total_orders
FROM pizzas p
JOIN order_details o
ON p.pizza_id = o.pizza_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1
	
--List the top 5 most ordered pizza types along with their quantities.

SELECT r.name, count(o.*) as Total_Orders
FROM Pizzas p
JOIN Order_details o
ON p.pizza_id = o.pizza_id
JOIN pizza_types r 
ON r.pizza_type_id = p.pizza_type
GROUP BY 1
order by 2 DESC
LIMIT 5

--Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT DISTINCT t.Category, SUM(o.Quantity) as Total_order
FROM Order_details o
JOIN Pizzas p
ON p.pizza_id = o.pizza_id
JOIN Pizza_types t
ON t.pizza_type_id = p.pizza_type
GROUP BY 1

--Determine the distribution of orders by hour of the day.

SELECT EXTRACT(Hours FROM time) as Hours, Count(*) as Total_orders
FROM orders
GROUP BY 1
ORDER BY 1
		
--Join relevant tables to find the category-wise distribution of pizzas.

SELECT DISTINCT Category, Count(*) as Available_Pizza_to_Order
FROM Pizza_types
GROUP BY 1
	
--Group the orders by date and calculate the average number of pizzas ordered per day.

--SELECT (sum(no_of_orders)/max(day)) as average_orders_per_day
FROM
(
SELECT extract(day FROM date) as Day, COUNt(*) as No_of_Orders
FROM Orders
GROUP BY 1
ORDER BY 1)

--Determine the top 3 most ordered pizza types based on revenue.

SELECT p.name,Trunc(sum(o.Quantity * r.price)) as Total_order_amount
FROM pizza_types p
JOIN pizzas r
ON r.pizza_type =p.pizza_type_id
JOIN Order_details o
ON o.pizza_id = r.pizza_id
GROUP BY 1
ORDER BY 2 desc
LIMIT 3

--Calculate the percentage contribution of each pizza type to total revenue.

SELECT p.category, TRUNC(SUM(r.price)) AS Total_amount, ROUND(((TRUNC(SUM(r.price)) * 100.0 / SUM(TRUNC(SUM(r.price))) OVER ()))::NUMERIC, 2) AS Percentage_of_Total
FROM pizzas r
JOIN pizza_types p ON r.pizza_type = p.pizza_type_id
JOIN order_details o ON o.pizza_id = r.pizza_id
GROUP BY p.category;

--Analyze the cumulative revenue generated over time.

WITH Daily_Sales AS (
    SELECT
        o.Date,
        SUM(d.quantity * p.price) AS Daily_Amount
    FROM Orders o
    JOIN order_details d ON d.order_id = o.order_id
    JOIN pizzas p ON d.pizza_id = p.pizza_id
    GROUP BY o.Date
)
SELECT
    Date,
    ROUND((Daily_Amount)::Numeric, 2),
   ROUND(SUM(Daily_Amount) OVER (ORDER BY Date ASC)::Numeric, 2) AS Cumulative_Amount
FROM Daily_Sales
ORDER BY Date;

--Determine the top 3 most ordered pizza types based on revenue for each pizza category.	
	
SELECT p.name, SUM(s.price*o.quantity) as Total_sales
FROM Pizza_types p
JOIN Pizzas s
ON p.pizza_type_id = s.Pizza_type
Join Order_details o
ON o.pizza_id = s.pizza_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3




SELECT * FROM Order_details

SELECT * FROM Orders

SELECT * FROM Pizza_types

SELECT * FROM Pizzas

	





	

