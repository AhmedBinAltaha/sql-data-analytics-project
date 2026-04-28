-- Explore All Countries Our Customers come from

select Distinct country 
from gold.dim_customers;

-- Explore All Categories 'The Major Divisions'

select distinct category,subcategory,product_name 
from gold.dim_products
order by 1,2,3;
