-- creating tables


CREATE TABLE coffee
(  
    transaction_id INT PRIMARY KEY, 
    transaction_date DATE,
    transaction_time TIME,
    transaction_qty INT, 
    store_id INT, 
    store_location VARCHAR(50),
    product_id INT, 
    unit_price NUMERIC(10, 2),
    product_category VARCHAR(50),
    product_type VARCHAR(50),
    product_detail VARCHAR (100)
  
)
--- imported csv with all records 



---Month-Over-Month (MoM) Percentage Increase:
 
SELECT sum(unit_price* transaction_qty) AS total_sale 
FROM coffee 
WHERE EXTRACT (MONTH FROM transaction_date) = 3

SELECT 
    EXTRACT(MONTH FROM transaction_date) AS "month",
    SUM(unit_price * transaction_qty) AS total_sales,
    (SUM(unit_price * transaction_qty) - 
        LAG(SUM(unit_price * transaction_qty)) OVER (ORDER BY EXTRACT(MONTH FROM transaction_date))
    ) / 
    NULLIF(LAG(SUM(unit_price * transaction_qty)) OVER (ORDER BY EXTRACT(MONTH FROM transaction_date)), 0) * 100 AS mom_per_increase
FROM 
    coffee
GROUP BY EXTRACT(MONTH FROM transaction_date)
ORDER BY "month"
    