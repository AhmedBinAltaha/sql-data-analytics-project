-- Which 5 products generate the highest revenue ?

select TOP 5
p.product_name,
SUM(sales_amount) as Total_Revenue
from gold.fact_sales f
left join gold.dim_products p
on p.product_key = f.product_key
group by p.product_name
order by Total_Revenue DESC;

-- or

select * from (
	select
		p.product_name,
		SUM(sales_amount) as Total_Revenue,
		ROW_NUMBER() over(order by SUM(sales_amount)DESC) as ranking
	from gold.fact_sales f
	left join gold.dim_products p
	on p.product_key = f.product_key
	group by p.product_name)t
	where ranking <= 5 ;


-- What are the 5 worest performing products in terms of sales ?

select TOP 5
p.product_name,
SUM(sales_amount) as Total_Revenue
from gold.fact_sales f
left join gold.dim_products p
on p.product_key = f.product_key
group by p.product_name
order by Total_Revenue ;

-- Find the top 10 customers who have generated the highest revenue 

select TOP 10
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

-- The 3 customers with the fewest orders placed 

select top 3
	c.customer_key,
	c.first_name,
	c.last_name,
	COUNT(DISTINCT order_number) as Total_Orders
from gold.fact_sales f
left join gold.dim_customers c
on c.customer_key = f.customer_key
group by 
	c.customer_key,
	c.first_name,
	c.last_name
order by Total_Orders ;

