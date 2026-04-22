/* TECHNICAL PROJECT: DATA AUDIT LAYER
Author: Sanika Karche
*/

-- 1. Identify Data Quality Issues (Filtering out zero/negative revenue)
SELECT * FROM sales.transactions 
WHERE sales_amount <= 0;

-- 2. Validate Market Mapping
-- Ensuring every transaction has a valid market code
SELECT count(*) FROM sales.transactions 
WHERE market_code NOT IN (SELECT markets_code FROM sales.markets);

-- 3. Currency Check (Identifying records needing USD to INR conversion)
SELECT DISTINCT(currency) FROM sales.transactions;

-- 4. Revenue Breakdown by Year (SQL Validation for Power BI)
SELECT d.year, SUM(t.sales_amount) as annual_revenue
FROM sales.transactions t
JOIN sales.date d ON t.order_date = d.date
GROUP BY d.year
ORDER BY d.year DESC;
