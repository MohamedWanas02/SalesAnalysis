USE project
TABLE sales
SELECT *FROM sales WHERE NULL
SELECT DISTINCT customer_name FROM sales;
DELETE FROM sales WHERE sales IS NULL OR sales = '' OR profit IS NULL;

SELECT order_id, COUNT(*) 
FROM sales 
GROUP BY order_id 
HAVING COUNT(*) > 1;

#DATA EXPRESSIONS
--  Top 5 Products
SELECT product_name, SUM(sales) AS total_sales
FROM sales
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 5;

-- Average Discount
SELECT category, AVG(discount) AS avg_discount
FROM sales
GROUP BY category;

-- Orders with the Highest Profit
SELECT order_id, customer_name, sales, profit
FROM sales
ORDER BY profit DESC
LIMIT 10;

-- Sales by Year and Region
SELECT year, region, SUM(sales) AS total_sales
FROM sales
GROUP BY year, region
ORDER BY year, region;

--  Average Sales
SELECT AVG(sales) AS avg_sales
FROM sales;

-- customers with sales above this average
SELECT customer_name, SUM(sales) AS total_sales
FROM sales
GROUP BY customer_name
HAVING total_sales > (SELECT AVG(sales) FROM sales)
ORDER BY total_sales DESC;

-- Products with Sales Greater Than the Average
SELECT product_name, category, sales
FROM sales AS a
WHERE sales > (SELECT AVG(sales)
               FROM sales AS b
               WHERE a.category = b.category)
ORDER BY category, sales DESC;

-- Most Profitable Product in Each Category
SELECT category, product_name, MAX(total_profit) AS max_profit 
FROM (
    SELECT 
        category, 
        product_name, 
        SUM(profit) AS total_profit 
    FROM sales 
    GROUP BY category, product_name 
) AS sub 
GROUP BY category, product_name 
ORDER BY max_profit DESC 
LIMIT 2000;

-- Total Shipping Costs
SELECT ship_mode, SUM(shipping_cost) AS total_shipping_cost
FROM sales
GROUP BY ship_mode;
 
-- states with total sales above this average 
SELECT state, SUM(sales) AS total_sales
FROM sales
GROUP BY state
HAVING total_sales > (SELECT AVG(sales) FROM sales)
ORDER BY total_sales DESC;

-- Number of Orders per Customer
SELECT customer_name, COUNT(order_id) AS order_count
FROM sales
GROUP BY customer_name
ORDER BY order_count DESC;

-- Products Sold in More Than One Region
SELECT product_name, COUNT(DISTINCT region) AS region_count
FROM sales
GROUP BY product_name
HAVING region_count > 1
ORDER BY region_count DESC;

-- Average Profit Margin
SELECT product_name, AVG(profit / sales) AS avg_profit_margin
FROM sales
GROUP BY product_name
ORDER BY avg_profit_margin DESC;

-- State with the Highest Total Shipping Cost
SELECT state, SUM(shipping_cost) AS total_shipping_cost
FROM sales
GROUP BY state
ORDER BY total_shipping_cost DESC
LIMIT 1;

-- Products with Total Sales Greater Than the Average
SELECT product_name, SUM(sales) AS total_sales
FROM sales
GROUP BY product_name
HAVING total_sales > (SELECT AVG(total_sales)
                      FROM (SELECT SUM(sales) AS total_sales
                            FROM sales
                            GROUP BY product_name) AS sub)
ORDER BY total_sales DESC;

-- Total Profit by Year and Segment
SELECT year, segment, SUM(profit) AS total_profit
FROM sales
GROUP BY year, segment
ORDER BY year, segment;

-- Most Popular Products
SELECT product_name, SUM(quantity) AS total_quantity
FROM sales
GROUP BY product_name
ORDER BY total_quantity DESC
LIMIT 3;

-- Average Shipping Cost per Order Priority
SELECT order_priority, AVG(shipping_cost) AS avg_shipping_cost
FROM sales
GROUP BY order_priority;

-- Total Sales and Profit by Category and Sub-category
SELECT category, sub_category, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM sales
GROUP BY category, sub_category
ORDER BY category, sub_category;

-- Most Frequent Ship Mode per Segment
SELECT segment, ship_mode, COUNT(ship_mode) AS mode_count
FROM sales
GROUP BY segment, ship_mode
HAVING mode_count = (SELECT MAX(mode_count)
                     FROM (SELECT segment, ship_mode, COUNT(ship_mode) AS mode_count
                           FROM sales
                           GROUP BY segment, ship_mode) AS sub
                     WHERE sub.segment =sales.segment)
ORDER BY segment;

-- Average Order Quantity
SELECT ship_mode, AVG(quantity) AS avg_quantity
FROM sales
GROUP BY ship_mode;





