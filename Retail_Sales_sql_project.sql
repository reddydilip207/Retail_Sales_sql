-- SQL Retail sales Analysis

DROP TABLE IF EXISTS retail_sales;
CREATE TABLE Retail_sales (
	      transactions_id INT PRIMARY KEY,
		  sale_date	DATE,
		  sale_time	TIME,
		  customer_id INT,
		  gender VARCHAR(15),
		  age INT,
		  category VARCHAR(15),
		  quantity INT,
		  price_per_unit FLOAT,
		  cogs FLOAT,
		  total_sale FLOAT
	);

SELECT * FROM Retail_sales
LIMIT 10;


SELECT 
   COUNT(*)
FROM Retail_sales;

-- Data Cleaning;

SELECT *
FROM Retail_sales
WHERE 
    transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL
	
DELETE FROM Retail_sales
WHERE 
    transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL

-- Data Exploration

--  How many sales we have?
SELECT COUNT(*) AS total_sales
FROM Retail_sales; 

--  How many Unique customers we have?
SELECT COUNT(DISTINCT customer_id) AS customer_count
FROM Retail_sales

-- How many Unique Category we have?
SELECT DISTINCT Category 
FROM Retail_sales

---------------------------------------------------- Data Analysis & Business key Problems & Answers ----------------------------------------------

--Q1: Write a SQL query to retrieve all column for sales made on '2022-11-05'
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05'


--Q2: Write a SQL query to retrieve all transactions where the category is 'clothing' and the quantity sold is more than 4 in the month
-- of nov-2022
SELECT *
FROM Retail_sales
WHERE category = 'Clothing' 
AND TO_CHAR(sale_date, 'YYYY-mm')='2022-11'
AND quantity >=4


--Q3: Write a SQL query to calculate total sales(total_sale) for each category
SELECT
     category,
	 SUM(total_sale) AS total_sales
FROM Retail_Sales
GROUP BY 1;


--Q4: Write a SQL query to find the average age of customers who purchase items from the 'Beauty' Category.
SELECT 
	ROUND(AVG(age),2) AS avg_age
FROM Retail_sales
WHERE category ='Beauty';



--Q5: Write a SQL query to find all transations where the total_sale is greater than 1000.
SELECT *
FROM Retail_sales
WHERE total_sale >1000;


--Q6: Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each 'category'
SELECT 
	category,
	gender,
	COUNT(*) AS total_number_transaction
FROM Retail_sales
GROUP BY 1,2
ORDER BY 1;


--Q7: Write a SQL query to calculate the average sale for each month. find out best selling month in each year
SELECT FROM
( SELECT 
     EXTRACT(year FROM sale_date) AS Year,
	 EXTRACT(month FROM sale_date) AS month,
	 SUM(total_sale) AS avg_sale,
	RANK() OVER(PARTITION BY EXTRACT(year FROM sale_date) ORDER BY SUM(total_sale) DESC) AS rnk
FROM Retail_sales
GROUP BY 1,2
) AS t1
WHERE rnk =1



--Q8: Write a SQL query to find the top 5 customers based on the higest total sales
SELECT 
	customer_id,
	SUM(total_sale) AS total_sales
FROM Retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;


--Q9: Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
	category,
	COUNT(DISTINCT customer_id) AS total_customer
FROM Retail_sales
GROUP BY 1


--Q10: Write a SQL query to create each shift and number of orders (Example morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sales AS(
SELECT *,
	CASE WHEN EXTRACT(HOUR FROM sale_time)<12 THEN 'Morning'
		 WHEN EXTRACT(HOUR FROM sale_time)  BETWEEN 12 AND 17 THEN 'Afternoon'
		 ELSE 'Evening'
	END AS shift
FROM Retail_sales
)
SELECT
    shift,
	COUNT(transactions_id) AS total_sales
FROM hourly_sales
GROUP BY shift

--------------------------------------------------------------- END OF PROJECT --------------------------------------------------------------------

