-- Explore All Objects in The Database
select * from INFORMATION_SCHEMA.TABLES; 

-- Eplore All Columns in The Database
select * from INFORMATION_SCHEMA.COLUMNS;

------
select * from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'dim_customers';