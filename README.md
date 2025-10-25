# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Database**: `retail_sql_project`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries.
## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `retail_sql_project`.
- **Table Creation**: A table named `Retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql

CREATE TABLE retail_sales
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
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **--Q1: Write a SQL query to retrieve all column for sales made on '2022-11-05'**:
```sql
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';
```

2. **--Q2: Write a SQL query to retrieve all transactions where the category is 'clothing' and the quantity sold is more than 4 in the monthof nov-2022**:
```sql
SELECT *
FROM Retail_sales
WHERE category = 'Clothing' 
AND TO_CHAR(sale_date, 'YYYY-mm')='2022-11'
AND quantity >=4

```

3. **--Q3: Write a SQL query to calculate total sales(total_sale) for each category.**:
```sql
SELECT
     category,
	 SUM(total_sale) AS total_sales
FROM Retail_Sales
GROUP BY 1;
```

4. **--Q4: Write a SQL query to find the average age of customers who purchase items from the 'Beauty' Category.**:
```sql
SELECT 
	ROUND(AVG(age),2) AS avg_age
FROM Retail_sales
WHERE category ='Beauty';
```

5. **--Q5: Write a SQL query to find all transations where the total_sale is greater than 1000.**:
```sql
SELECT *
FROM Retail_sales
WHERE total_sale >1000;
```

6. **--Q6: Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each 'category.**:
```sql
SELECT 
	category,
	gender,
	COUNT(*) AS total_number_transaction
FROM Retail_sales
GROUP BY 1,2
ORDER BY 1;
```

7. **--Q7: Write a SQL query to calculate the average sale for each month. find out best selling month in each year**:
```sql
SELECT FROM
( SELECT 
     EXTRACT(year FROM sale_date) AS Year,
	 EXTRACT(month FROM sale_date) AS month,
	 SUM(total_sale) AS avg_sale,
	RANK() OVER(PARTITION BY EXTRACT(year FROM sale_date) ORDER BY SUM(total_sale) DESC) AS rnk
FROM Retail_sales
GROUP BY 1,2
) AS t1
WHERE rnk =1;
```

8. **--Q8: Write a SQL query to find the top 5 customers based on the higest total sales**:
```sql
SELECT 
	customer_id,
	SUM(total_sale) AS total_sales
FROM Retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
```

9. **--Q9: Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT 
	category,
	COUNT(DISTINCT customer_id) AS total_customer
FROM Retail_sales
GROUP BY 1
```

10. **--Q10: Write a SQL query to create each shift and number of orders (Example morning <=12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - Dilip Kumar

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. 
