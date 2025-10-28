-- 1. Display the first 10 rows
SELECT * FROM online_sales LIMIT 10;

-- 2. Convert order_date (text) to date format
SELECT order_id, order_date,
       STR_TO_DATE(order_date, '%Y-%m-%d') AS converted_date
FROM online_sales
LIMIT 10;

-- 3. Extract month and year from order_date
SELECT order_id,
       MONTH(STR_TO_DATE(order_date, '%Y-%m-%d')) AS month_no,
       YEAR(STR_TO_DATE(order_date, '%Y-%m-%d')) AS year_no
FROM online_sales
LIMIT 10;

-- 4. Add month_no and year_no columns
ALTER TABLE online_sales
ADD COLUMN month_no INT,
ADD COLUMN year_no INT;

set sql_safe_updates =0;
UPDATE online_sales
SET month_no = MONTH(STR_TO_DATE(order_date, '%Y-%m-%d')),
    year_no  = YEAR(STR_TO_DATE(order_date, '%Y-%m-%d'));

    
-- 5. Total revenue per month
SELECT year_no, month_no,
       SUM(amount) AS total_revenue
FROM online_sales
GROUP BY year_no, month_no;


-- 6. Total order volume per month
SELECT year_no, month_no,
       COUNT(DISTINCT order_id) AS total_orders
FROM online_sales
GROUP BY year_no, month_no;

-- 7. Revenue + order volume together
SELECT year_no, month_no,
       SUM(amount) AS total_revenue,
       COUNT(DISTINCT order_id) AS total_orders
FROM online_sales
GROUP BY year_no, month_no;

-- 8. Sort results chronologically
SELECT year_no, month_no,
       SUM(amount) AS total_revenue,
       COUNT(DISTINCT order_id) AS total_orders
FROM online_sales
GROUP BY year_no, month_no
ORDER BY year_no, month_no;
-- 9. Only for 2023
SELECT year_no, month_no,
       SUM(amount) AS total_revenue,
       COUNT(DISTINCT order_id) AS total_orders
FROM online_sales
WHERE year_no = 2023
GROUP BY year_no, month_no
ORDER BY month_no;

-- 10. Only for 2024
SELECT year_no, month_no,
       SUM(amount) AS total_revenue,
       COUNT(DISTINCT order_id) AS total_orders
FROM online_sales
WHERE year_no = 2024
GROUP BY year_no, month_no
ORDER BY month_no;

-- 11. First 6 months of 2023
SELECT year_no, month_no,
       SUM(amount) AS total_revenue,
       COUNT(DISTINCT order_id) AS total_orders
FROM online_sales
WHERE year_no = 2023 AND month_no BETWEEN 1 AND 6
GROUP BY year_no, month_no
ORDER BY month_no;
-- 12. Top 3 months by revenue
SELECT year_no, month_no,
       SUM(amount) AS total_revenue
FROM online_sales
GROUP BY year_no, month_no
ORDER BY total_revenue DESC
LIMIT 3;

-- 13. Top 3 months by order volume
SELECT year_no, month_no,
       COUNT(DISTINCT order_id) AS total_orders
FROM online_sales
GROUP BY year_no, month_no
ORDER BY total_orders DESC
LIMIT 3;

-- 14. Month with lowest revenue
SELECT year_no, month_no,
       SUM(amount) AS total_revenue
FROM online_sales
GROUP BY year_no, month_no
ORDER BY total_revenue ASC
LIMIT 1;

-- 15. Month with lowest order volume
SELECT year_no, month_no,
       COUNT(DISTINCT order_id) AS total_orders
FROM online_sales
GROUP BY year_no, month_no
ORDER BY total_orders ASC
LIMIT 1;
-- 16. Compare monthly revenue between 2023 and 2024
SELECT year_no, month_no,
       SUM(amount) AS total_revenue
FROM online_sales
WHERE year_no IN (2023, 2024)
GROUP BY year_no, month_no
ORDER BY year_no, month_no;

-- 17. Total revenue per city
SELECT city, SUM(amount) AS total_revenue
FROM online_sales
GROUP BY city
ORDER BY total_revenue DESC;

-- 18. Revenue per product per month
SELECT year_no, month_no, product_name,
       SUM(amount) AS total_revenue
FROM online_sales
GROUP BY year_no, month_no, product_name
ORDER BY year_no, month_no;

-- 19. Revenue per customer per month
SELECT year_no, month_no, cust_id,
       SUM(amount) AS total_revenue
FROM online_sales
GROUP BY year_no, month_no, cust_id
ORDER BY year_no, month_no;

-- 20. Create a summary view
CREATE VIEW v_sales_summary AS
SELECT year_no, month_no,
       COUNT(DISTINCT order_id) AS total_orders,
       SUM(amount) AS total_revenue
FROM online_sales
GROUP BY year_no, month_no
ORDER BY year_no, month_no;
