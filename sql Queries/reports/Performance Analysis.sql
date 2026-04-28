-- Analize the yearly performance of products by comparing their sales to 
-- both the average sales performance of the product and the previous year's sales
with yearly_product_sales AS (
select 
year(f.order_date) order_year,
p.product_name,
SUM(f.sales_amount) current_sales
from gold.fact_sales f
left join gold.dim_products p
on f.product_key = p.product_key
where f.order_date IS NOT NULL
group by 
year(f.order_date),
p.product_name
)
select 
order_year,
product_name,
current_sales,
AVG(current_sales) over(partition by product_name) avg_sales,
current_sales - AVG(current_sales) over(partition by product_name) AS diff_avg,
CASE 
	WHEN current_sales - AVG(current_sales) over(partition by product_name) > 0 THEN 'Above Average'
	WHEN current_sales - AVG(current_sales) over(partition by product_name) < 0 THEN 'Below Average'
ELSE 'Avg'
END AS AVG_change,
LAG(current_sales) over(partition by product_name order by order_year) prev_sales,
current_sales - LAG(current_sales) over(partition by product_name order by order_year) diff_prev,
CASE 
	WHEN current_sales - LAG(current_sales) over(partition by product_name order by order_year) > 0 THEN 'Increase'
	WHEN current_sales - LAG(current_sales) over(partition by product_name order by order_year) < 0 THEN 'Decrease'
ELSE 'No change'
END AS Prev_change
from yearly_product_sales
order by 
product_name,
order_year