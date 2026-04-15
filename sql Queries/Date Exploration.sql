-- Find the date of first and last order
-- How many years of sales are available

select MIN(order_date) First_order_date,
MAX(order_date) Last_order_date,
DATEDIFF(year,MIN(order_date),MAX(order_date)) order_range_months
from gold.fact_sales;


-- Find the youngest and the oldest Customer

select 
MIN(birthdate) Oldest_birthdate,
DATEDIFF(year,MIN(birthdate),GETDATE()) Oldest_age,
DATEDIFF(year,MAX(birthdate),GETDATE()) Youngest_age,
MAX(birthdate) Youngest_birthdate
from gold.dim_customers;
