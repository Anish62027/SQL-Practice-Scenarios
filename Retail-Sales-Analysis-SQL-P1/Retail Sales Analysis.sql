create database p1_retail_db;

use p1_retail_db;

create table retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);

select * from retail_sales;

-- Data Cleaning
select count(*) as total_count from retail_sales;

select count(distinct customer_id) as unique_customer from retail_sales;

select distinct category as unique_category from retail_sales;

-- Null Value Check: Check for any null values in the dataset and delete records with missing data.

select * from retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
    
    
-- Data Analysis & Findings
-- The following SQL queries were developed to answer specific business questions:

-- Write a SQL query to retrieve all columns for sales made on '2022-11-05:


SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

select * from retail_sales
WHERE 
    category = 'Clothing'
    AND 
    DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
    AND
    quantity >= 4;
    
-- Write a SQL query to calculate the total sales (total_sale) for each category.:

select category , sum(total_sale) as net_sale , count(*) as total_order  
from retail_sales
group by 1;

-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select round(avg(age),2) as avg_age 
from retail_sales
where category = "Beauty";

-- Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from retail_sales
where total_sale > 1000;


-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category , gender , count(*) as total_trans from retail_sales
group by category , gender 
order by 1;

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    round(AVG(total_sale),2) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) 
    ORDER BY AVG(total_sale) DESC) as ran
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE ran = 1;

-- Write a SQL query to find the top 5 customers based on the highest total sales **:
select customer_id , sum(total_sale) as sales from retail_sales
group by customer_id
order by sales desc
limit 5;

-- Write a SQL query to find the number of unique customers who purchased items from each category.:
select category , count(distinct customer_id) as uni_cut_cou
from retail_sales
group by category;

-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift
order by shift ;

