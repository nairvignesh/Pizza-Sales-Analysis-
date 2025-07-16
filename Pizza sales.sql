use [Pizza DB]

	select * from pizza_sales

--1. Total Revenue: Sum of total price of all pizza.

select SUM(total_price) as Total_Revenue from pizza_sales

-- 2. Average order value calculating by dividing total revenue by total number of order

select SUM(total_price)/COUNT(distinct order_id) as Average_order_value from pizza_sales

--3. Total Pizzas Sold sum of quantities of total pizzas sold

select SUM(quantity) as Total_pizzas_sold from pizza_sales

-- 4. Total orders Total numbers of orders placed 

select count(distinct order_id) as Total_orders from  pizza_sales

 -- 5. Average Pizzas per order the average number of pizza sold per order, calculated by dividing the  tota number of pizza sold
 -- by the total number of orders

 select cast(cast(SUM(quantity)as decimal (10,2)) / 
 cast(count(distinct order_id) as decimal (10,2)) as decimal (10,2)) as Average_Pizzas_sold_per_order from pizza_sales

-- CHART REQUIREMENTS

-- 1. Daily trends of order

select datename(DW,order_date) as order_day, COUNT(distinct order_id) as Total_orders from pizza_sales
Group by datename(DW,order_date)

--2. Hourly Trends or orders

select DATEPART(hour, order_time) as order_hour, COUNT(distinct order_id) as Total_orders from pizza_sales
group by DATEPART(hour, order_time)
order by DATEPART(hour, order_time)

--3. percentage of sales by pizza category

select pizza_category, sum(total_price) *100/ (select SUM(total_price) from pizza_sales)
as Percentage_of_sale_by_category
from pizza_sales
Group by pizza_category

-- Using filter by month/quarte/week--

select pizza_category,SUM(total_price) as total_sales, sum(total_price) *100/
(select SUM(total_price) from pizza_sales where month(order_date)=1)
as Percentage_of_sale_by_category
from pizza_sales
where month(order_date)=1
Group by pizza_category

--4 percentage of sales by pizza size.

select pizza_size,cast(SUM(total_price)as decimal(10,2)) as total_sales, cast(sum(total_price) *100/ (select SUM(total_price) from pizza_sales)
as decimal (10,2)) as Percentage_of_sale_by_size
from pizza_sales
Group by pizza_size
order by Percentage_of_sale_by_size desc


--by applying filter--
 
 select pizza_size, cast(SUM(total_price) as decimal (10,2))as total_sales, cast(sum(total_price) *100/ (select SUM(total_price)
 from pizza_sales where DATEPART(quarter, order_date)=1)
as decimal (10,2)) as Percentage_of_sale_by_size
from pizza_sales
where DATEPART(quarter, order_date)=1
Group by pizza_size
order by Percentage_of_sale_by_size desc

--5 total pizza sold by Category

select pizza_category, sum(quantity) as pizza_sold_by_category from pizza_sales
Group by  pizza_category

--6. Top 5 best seller by total pizza sold

select TOP 5 pizza_name, SUM(quantity) as total_pizza_sold
from pizza_sales
group by pizza_name
order by total_pizza_sold  desc


--7. bottom 5 worst seller by total pizza sold

select TOP 5 pizza_name, SUM(quantity) as total_pizza_sold
from pizza_sales
group by pizza_name
order by total_pizza_sold 