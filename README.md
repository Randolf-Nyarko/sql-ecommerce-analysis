# E-Commerce Delivery & Sales Performance Analytics (SQL)

## Project Overview
This project uses **SQL (SQLite)** to analyse a real-world relational database from Olist, a Brazilian e-commerce platform. The goal of this project is to showcase advanced SQL querying techniques by answering complex business questions regarding supply chain efficiency, customer spending behavior, and order cancellation correlations.

**Tools Used:** DB Browser for SQLite, SQL (CTEs, Window Functions, Conditional Aggregation, Date Math)

## Database Schema
The dataset (sourced from Kaggle) consists of over 100,000 anonymised orders. I normalised the flat files into four core relational tables:
* `customers`: `customer_id`, `customer_zip_code`, `customer_city`, `customer_state`
* `orders`: `order_id`, `customer_id`, `order_status`, `purchase_timestamp`, `estimated_delivery_date`, `actual_delivery_date`
* `order_items`: `order_id`, `product_id`, `price`, `freight_value`
* `products`: `product_id`, `product_category_name`, `product_weight_g`, `product_length_cm`

## Business Questions & SQL Techniques
I utilised multi-table joins, subqueries, and advanced aggregations to answer three primary business questions:

### 1. The Delivery Gap (Date Math & Joins)
* **Goal:** Identify which states suffer from the worst supply chain bottlenecks by calculating the exact days between estimated and actual delivery.
* **Techniques:** `julianday()` date conversions, `AVG()`, `ROUND()`, multi-table `JOIN`s.

### 2. High-Value Customer Cohorts (Window Functions & CTEs)
* **Goal:** Segment the customer base into deciles (10 equal tiers) based on total spend to determine how much revenue the top VIP customers generate.
* **Techniques:** Common Table Expressions (CTEs), `NTILE()` window functions, Subqueries for percentage math.

### 3. Cart Analysis & Canceled Orders (Conditional Aggregation)
* **Goal:** Determine if categories with high average freight/shipping costs suffer from a higher rate of order cancellations.
* **Techniques:** `CASE WHEN` inside `COUNT()` functions, `HAVING` clauses to filter out statistically irrelevant categories.

## Key Business Insights Discovered
1. **Severe Regional Supply Chain Issues:** The state of Amapá (AP) experiences massive delivery bottlenecks, with packages arriving an average of **48.86 days late**. This indicates a need for a secondary logistics hub or a change in carrier partnerships for the northern region.
2. **The Pareto Principle in Effect:** The customer base is highly top-heavy. Tier 1 (the top 10% of customers) generates **38.05% of the total company revenue**. Marketing efforts should heavily prioritise VIP retention programs over general acquisition.
3. **Disproving the Shipping Cost Hypothesis:** Surprisingly, high freight costs do *not* trigger massive cancellation rates. Heavy/bulky categories (like PCs, appliances, and furniture) had the highest shipping costs but maintained near-zero cancellation rates (0% to 1.28%). This indicates that customers buying high-ticket, heavy items expect high shipping fees and have high purchase intent.

## How to Run the Queries
1. Download the [Olist E-Commerce Dataset from Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).
2. Import the `customers`, `orders`, `order_items`, and `products` CSV files into a local SQLite database (using a tool like DB Browser for SQLite).
3. Run the numbered `.sql` scripts provided in this repository to replicate the analysis.
