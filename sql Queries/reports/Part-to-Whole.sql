-- Which category contribute the most to overall sales ?

with sales_cte as (
select 
d.category,
SUM(f.sales_amount) as Total_sales
from gold.fact_sales f
left join gold.dim_products d
on f.product_key = d.product_key
group by d.category)

select 
category,
Total_sales,
SUM(Total_sales) over() as overall_sales,
CONCAT(ROUND((CAST(Total_sales as FLOAT) / SUM(Total_sales) over() * 100),2 ),'%') as Precentage_Of_Total
from sales_cte