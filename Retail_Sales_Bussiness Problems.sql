--RETAIL SALES DATA SQL PROJECT

--Create Table Retail Sales Data
drop table if exists retail_sales_data;
create table retail_sales_data(
	transactions_id int primary key,
	sale_date date,
	sale_time time,
	customer_id int,
	gender varchar(10),
	age int,
	category varchar(50),
	quantity int,
	price_per_unit int,
	cogs float,
	total_sale int
);

--Retrive Top 10 Rows from Data

select * from retail_sales_data limit 10;

--Count of Rows from Retail_sales_data

select count(*) 
from retail_sales_data;

--DATA CLEANING

select * from retail_sales_data
where 	sale_date isnull or
		sale_time isnull or
		customer_id isnull or
		gender isnull or
		age isnull or
		category is null or
		quantity isnull or
		price_per_unit isnull or
		cogs isnull or
		total_sale isnull;

delete from retail_sales_data 
where 	sale_date isnull or
		sale_time isnull or
		customer_id isnull or
		gender isnull or
		age isnull or
		category is null or
		quantity isnull or
		price_per_unit isnull or
		cogs isnull or
		total_sale isnull;

select * from retail_sales_data;

--DATA EXPLORATION
--How many sales we have?
select count(*) from retail_sales_data as Total_Sales;

--Count of Unique Customers?
select customer_id, count(customer_id)as customer_Order_count
from retail_sales_data
group by 1 order by 2 desc;

--How many unique Customers we have?

select count(distinct customer_id) from retail_sales_data;


--Distint Category from Retail Sales
select distinct category from retail_sales_data;


-- Data Analysis & Business Key Problems

-- My Analysis & Findings

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

select * from retail_sales_data where sale_date='2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

select * from retail_sales_data
where category='Clothing'
and TO_CHAR(sale_date, 'YYYY-MM')='2022-11'
and quantity>=4;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category, count(total_sale)as total_orders, Sum(total_sale) as Amount
from retail_sales_data
group by 1;


select count(category)as counts
from retail_sales_data where category='Electronics';


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select round(avg(age),2) as Average_Age 
from retail_sales_data 
where category='Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales_data
where total_sale>1000;


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category, gender, count(*) as Total_Transations
from retail_sales_data
group by 1,2 order by 1;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select year,month,avg_sale
from(
select 
extract(year from sale_date) as year,
extract(month from sale_date) as month,
round(avg(total_sale),2) as avg_sale,
RANK()OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) order by avg(total_sale) desc) as rank
from retail_sales_data
group by 1, 2
order by 4
) as t1
where rank=1;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select customer_id, 
sum(total_sale) as highest_sales from retail_sales_data
group by 1
order by 2 desc
limit 5;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

 select category, count(distinct customer_id) as Unique_customers
 from retail_sales_data 
 group by 1
 order by 2 desc;


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales_data
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift











		
		
		

