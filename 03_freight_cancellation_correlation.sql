-- Cart Analysis & Cancellation Correlation
-- Analyzes whether categories with high shipping costs suffer from higher cancellation rates.

SELECT 
    p.product_category_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(AVG(oi.freight_value), 2) AS avg_freight_cost,
    
    -- Conditional aggregation: only count the order ID if the status is 'canceled'
    COUNT(DISTINCT CASE WHEN o.order_status = 'canceled' THEN o.order_id END) AS canceled_orders,
    
    -- Math: (Canceled Orders / Total Orders) * 100
    ROUND((COUNT(DISTINCT CASE WHEN o.order_status = 'canceled' THEN o.order_id END) * 100.0) / COUNT(DISTINCT o.order_id), 2) AS cancellation_rate_pct

FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
JOIN products p 
    ON oi.product_id = p.product_id
WHERE p.product_category_name IS NOT NULL
GROUP BY p.product_category_name
HAVING total_orders > 50 -- Filters out niche categories with too few sales to be statistically relevant
ORDER BY avg_freight_cost DESC;