-- High-Value Customer Cohorts
-- Uses CTEs and NTILE window function to segment customers into 10 spending tiers.

WITH CustomerSpend AS (
    -- Calculate total spend per customer
    SELECT 
        o.customer_id,
        SUM(oi.price + oi.freight_value) AS total_spend
    FROM orders o
    JOIN order_items oi 
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY o.customer_id
),
TieredCustomers AS (
    -- Use a window function to rank customers into 10 equal buckets (deciles)
    SELECT 
        customer_id,
        total_spend,
        NTILE(10) OVER (ORDER BY total_spend DESC) AS spending_tier
    FROM CustomerSpend
)

-- 1. SUM(total_spend) gets the revenue for just this specific tier.
-- 2. (SELECT SUM(total_spend) FROM CustomerSpend) gets the grand total revenue across all tiers.
-- 3. We Divide the tier revenue by the grand total revenue to get a decimal.
-- 4. Multiply by 100 to convert to a percentage, and ROUND() to 2 decimal places.
SELECT 
    spending_tier,
    COUNT(customer_id) AS total_customers,
    ROUND(SUM(total_spend), 2) AS tier_revenue,
    ROUND((SUM(total_spend) / (SELECT SUM(total_spend) FROM CustomerSpend)) * 100, 2) AS percentage_of_total_revenue
FROM TieredCustomers
GROUP BY spending_tier
ORDER BY spending_tier ASC;