-- Q1: Create a list of all transactions that took place on January 15, 2024,
-- sorted by sale amount from highest to lowest
SELECT *
FROM sample_sales.online_sales
WHERE Date = '2024-01-15'
ORDER BY SalesTotal DESC;

-- Q2: Which transactions had a sale amount greater than $500?
-- Display the transaction date, store ID, product number, and sale amount
SELECT Date, ProdNum, SalesTotal
FROM sample_sales.online_sales
WHERE SalesTotal > 500;

-- Q3: Find all products whose product number begins with the prefix 105250.
-- What category do they belong to?
SELECT ProdNum, CategoryId
FROM sample_sales.products
WHERE ProdNum LIKE '105250%';

-- Q4: What is the total sales revenue across all transactions?
-- What is the average transaction amount?
SELECT 
    SUM(SalesTotal) AS total_revenue,
    AVG(SalesTotal) AS avg_transaction
FROM sample_sales.online_sales;

-- Q5: How many transactions were recorded for each product category?
-- Which category has the most transactions?
SELECT 
p.CategoryId,
COUNT(*) AS total_transactions
FROM sample_sales.online_sales os
JOIN sample_sales.products p 
ON os.ProdNum = p.ProdNum
GROUP BY p.CategoryId
ORDER BY total_transactions DESC;



