-- Find total Customers by countries

select 
country,
COUNT(customer_key) as Total_Customers
from gold.dim_customers
group by country
order by Total_Customers DESC;

-- Find total Customers by gender

select 
gender,
COUNT(customer_key) as Total_Customers
from gold.dim_customers
group by gender
order by Total_Customers DESC;

-- Find total products by category

select 
category,
COUNT(product_key) as Total_products
from gold.dim_products
group by category
order by Total_products DESC;

-- What is the average costs in each category ?

select 
category,
AVG(cost) as Average_cost
from gold.dim_products
group by category
order by Average_cost DESC;

-- What is the total revenue generated for each category ?

select 
p.category,
SUM(sales_amount) as Total_Revenue
from gold.fact_sales f
left join gold.dim_products p
on p.product_key = f.product_key
group by p.category
order by Total_Revenue DESC;

-- What is the total revenue generated for each customer ?

select 
c.customer_key,
c.first_name,
c.last_name,
SUM(sales_amount) as Total_Revenue
from gold.fact_sales f
left join gold.dim_customers c
on c.customer_key = f.customer_key
group by 
c.customer_key,
c.first_name,
c.last_name
order by Total_Revenue DESC;

-- What is the distribution of sold items across countries ?

select 
c.country,
SUM(quantity) as Total_Sold_Item
from gold.fact_sales f
left join gold.dim_customers c
on c.customer_key = f.customer_key
group by 
c.country
order by Total_Sold_Item DESC;