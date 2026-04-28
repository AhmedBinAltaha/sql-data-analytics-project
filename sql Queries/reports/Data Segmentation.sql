/* Segment products into cost ranges and count 
how many products  fall into each segment */
with product_cte as (
select 
product_key,
product_name,
cost,
CASE 
	WHEN cost < 100 THEN 'below 100'
	WHEN cost between 100 and 500 THEN '100 - 500'
	WHEN cost between 500 and 1000 THEN '500 - 1000'
	ELSE 'above 1000'
END cost_range
from gold.dim_products)

select 
cost_range,
COUNT(product_key) Num_products
from product_cte
group by cost_range
order by COUNT(product_key) DESC;



/*Group customers into three segments based on their spending behavior:
	- VIP: Customers with at least 12 months of history and spending more than €5,000.
	- Regular: Customers with at least 12 months of history but spending €5,000 or less.
	- New: Customers with a lifespan less than 12 months.
And find the total number of customers by each group
*/

with customer_seg as (
    select
        c.customer_key,
        SUM(f.sales_amount)  TotalSales,
        MIN(f.order_date)  first_order,
        MAX(f.order_date)  last_order,
        DATEDIFF(MONTH, MIN(f.order_date), MAX(f.order_date))  lifespan
    from gold.fact_sales f
    LEFT JOIN gold.dim_customers c
    on f.customer_key = c.customer_key
    group by c.customer_key
)

select 
customer_segmentation,
COUNT(customer_key) Total_customers
from (
select
    customer_key,
    TotalSales,
    lifespan,
    CASE 
        WHEN TotalSales > 5000 AND lifespan > 12 THEN 'VIP'
        WHEN TotalSales <= 5000 AND lifespan > 12 THEN 'Regular'
        ELSE 'New'
    END AS customer_segmentation
from customer_seg)t
group by customer_segmentation
order by Total_customers DESC
