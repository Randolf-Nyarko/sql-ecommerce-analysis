-- Delivery Gap Analysis
-- Identifies states with the highest average delivery delays.

SELECT
	-- Select the state abbreviation
	c.customer_state,
	
	-- Count total number of delayed orders
	COUNT(o.order_id) AS total_delayed_orders,
	
	-- Calculate the difference in days then average and round it
	ROUND(AVG(julianday(o.order_delivered_customer_date) - julianday(o.order_estimated_delivery_date)),2) AS avg_delay_days
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id

-- Filter for completed orders that actually arrived later than their estimated date
WHERE o.order_status = 'delivered'
	AND o.order_delivered_customer_date > o.order_estimated_delivery_date

-- Group results by state to find the worst offending regions
GROUP BY c.customer_state
ORDER BY avg_delay_days DESC;
		