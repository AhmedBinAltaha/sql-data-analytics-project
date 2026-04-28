-- calculate the total sales per month
-- and the running total of sales over time

select 
order_date,
Total_sales,
SUM(Total_Sales) over(partition by order_date order by order_date) running_total_sales
from (
select
DATETRUNC(month,order_date) as order_date,
SUM(sales_amount) as Total_Sales 
from gold.fact_sales
where order_date IS NOT NULL
group by DATETRUNC(month,order_date)) t

----------------------------

select 
order_date,
Total_sales,
SUM(Total_Sales) over(order by order_date) running_total_sales,
AVG(avg_price) over(order by order_date) moving_avg_price
from (
select
DATETRUNC(year,order_date) as order_date,
SUM(sales_amount) as Total_Sales,
AVG(price) as avg_price
from gold.fact_sales
where order_date IS NOT NULL
group by DATETRUNC(year,order_date)) t
