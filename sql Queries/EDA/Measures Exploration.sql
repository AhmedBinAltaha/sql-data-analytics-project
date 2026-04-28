-- Generate a Report that shows all key metrics of the business


select 'Total Sales' AS measure_name,SUM(sales_amount) AS measure_value from gold.fact_sales
union all 
select 'Total Quanties' ,SUM(quantity) from gold.fact_sales
union all 
select 'Average Price ' , AVG(price) from gold.fact_sales
union all 
select 'Total Nr.Orders', COUNT(order_number) from gold.fact_sales
union all 
select 'Total Nr.Products', COUNT(product_number) from gold.dim_products
union all 
select 'Total Nr.Customers', COUNT(customer_key) from gold.dim_customers

