-- Sales Territory Analyzed: Colorado
-- Region: West
-- Sales Manager: Jim Heck


SELECT * FROM sample_sales.online_sales;
SELECT DISTINCT ShiptoState
FROM sample_sales.online_sales;

-- Question 1:What is the total revenue for the selected sales territory,and what is the date range of the data?
SELECT 
    ShiptoState,
    SUM(SalesTotal) AS total_revenue,
    MIN(Date) AS start_date,
    MAX(Date) AS end_date
FROM sample_sales.online_sales
WHERE ShiptoState = 'Colorado'
GROUP BY ShiptoState;

-- Question 2: What is the month-by-month revenue breakdown for the sales territory?
SELECT 
    DATE_FORMAT(Date, '%Y-%m') AS month,
    SUM(SalesTotal) AS monthly_revenue
FROM sample_sales.online_sales
WHERE ShiptoState = 'Colorado'
GROUP BY month
ORDER BY month;

-- Question 3: Provide a comparison of total revenue for the specific sales territory and the region it belongs to
SELECT 
    m.Region,
    os.ShiptoState,
    SUM(os.SalesTotal) AS total_revenue
FROM sample_sales.online_sales os
JOIN sample_sales.management m
    ON os.ShiptoState = m.State
WHERE m.Region = 'West'
GROUP BY m.Region, os.ShiptoState
ORDER BY total_revenue DESC;

-- Q4 Step 1:
-- Number of transactions per month for Colorado
SELECT 
    DATE_FORMAT(Date, '%Y-%m') AS month,
    COUNT(*) AS total_transactions
FROM sample_sales.online_sales
WHERE ShiptoState = 'Colorado'
GROUP BY month
ORDER BY month;

-- Q4 Step 2: Add average transaction size
SELECT 
    DATE_FORMAT(Date, '%Y-%m') AS month,
    COUNT(*) AS total_transactions,
    AVG(SalesTotal) AS avg_transaction_size
FROM sample_sales.online_sales
WHERE ShiptoState = 'Colorado'
GROUP BY month
ORDER BY month;

-- Q4 Step 3:
-- Join sales with products to see categories
SELECT 
    os.Date,
    os.SalesTotal,
    p.Subcategoryid
FROM sample_sales.online_sales os
JOIN sample_sales.products p
    ON os.ProdNum = p.ProdNum
WHERE os.ShiptoState = 'Colorado'
LIMIT 10;

-- Question 4 (FINAL FIXED)
SELECT 
    DATE_FORMAT(os.Date, '%Y-%m') AS month,
    p.Subcategoryid,
    COUNT(*) AS total_transactions,
    AVG(os.SalesTotal) AS avg_transaction_size
FROM sample_sales.online_sales os
JOIN sample_sales.products p
    ON os.ProdNum = p.ProdNum
WHERE os.ShiptoState = 'Colorado'
GROUP BY month, p.Subcategoryid
ORDER BY month, p.Subcategoryid;

-- Q5 Step 1: Total revenue by state in the West region
SELECT 
    m.Region,
    os.ShiptoState,
    SUM(os.SalesTotal) AS total_revenue
FROM sample_sales.online_sales os
JOIN sample_sales.management m
    ON os.ShiptoState = m.State
WHERE m.Region = 'West'
GROUP BY m.Region, os.ShiptoState
ORDER BY total_revenue DESC;

-- Q5 Step 2: Add ranking by revenue
SELECT 
    os.ShiptoState,
    SUM(os.SalesTotal) AS total_revenue,
    RANK() OVER (ORDER BY SUM(os.SalesTotal) DESC) AS revenue_rank
FROM sample_sales.online_sales os
JOIN sample_sales.management m
    ON os.ShiptoState = m.State
WHERE m.Region = 'West'
GROUP BY os.ShiptoState;





