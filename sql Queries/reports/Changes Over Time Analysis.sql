select 
year(order_date) as order_year,
SUM(sales_amount) as Total_Sales,
COUNT(DISTINCT customer_key) Total_customers,
SUM(quantity) Total_quantities
from gold.fact_sales
where order_date IS NOT NULL
group by year(order_date)
order by year(order_date);

-----------------
select 
MONTH(order_date) as order_Month,
SUM(sales_amount) as Total_Sales,
COUNT(DISTINCT customer_key) Total_customers,
SUM(quantity) Total_quantities
from gold.fact_sales
where order_date IS NOT NULL
group by MONTH(order_date)
order by order_Month;
-------------------------

select 
DATETRUNC(year,order_date) as order_date,
SUM(sales_amount) as Total_Sales,
COUNT(DISTINCT customer_key) Total_customers,
SUM(quantity) Total_quantities
from gold.fact_sales
where order_date IS NOT NULL
group by DATETRUNC(year,order_date)
order by order_date;
--------------------------

select 
DATETRUNC(month,order_date) as order_date,
SUM(sales_amount) as Total_Sales,
COUNT(DISTINCT customer_key) Total_customers,
SUM(quantity) Total_quantities
from gold.fact_sales
where order_date IS NOT NULL
group by DATETRUNC(month,order_date)
order by order_date;
----------------------------

select 
FORMAT(order_date,'yyyy-MMM') as order_date,
SUM(sales_amount) as Total_Sales,
COUNT(DISTINCT customer_key) Total_customers,
SUM(quantity) Total_quantities
from gold.fact_sales
where order_date IS NOT NULL
group by FORMAT(order_date,'yyyy-MMM')
order by order_date;