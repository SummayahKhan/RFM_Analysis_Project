# for  monthly order DATE_FORMAT(orderDate, '%Y-%m')
# DATEDIFF(MAX(ord.orderDate),MIN(ord.orderDate)) as lifespan_days
# Average gross margin = (Total Revenue - Cost of Sales)/ Total Revenue
# But in our Table we don't have Cost of Sales
# So we Assume that here Average gross margin is 30% 
# And Customer Acquisition Cost (CAC) is 5000

USE classicmodels;

# purchase value
# purchase frequency
# monthly lifespan

SELECT
        ord.customerNumber AS CustomerId,
        SUM(quantityOrdered * priceEach) AS purchase_value,
        COUNT(DISTINCT ord.orderNumber) AS purchase_frequency,
        MAX(ord.orderDate) AS max_ord_date,
        MIN(ord.orderDate) AS min_ord_date,
        TIMESTAMPDIFF(MONTH, MIN(ord.orderDate), MAX(ord.orderDate)) AS lifespan_in_months
FROM orders AS ord
JOIN orderdetails AS or_d1
	ON ord.orderNumber = or_d1.orderNumber
GROUP BY ord.customerNumber;

# average purchase value
# average purchase frequency
# average Customer lifespan
# CLV 

-- SubQuery --

SELECT  AVG(purchase_value) AS Avg_purchase_value, 
		AVG(purchase_frequency) AS Avg_purchase_frequency,
        AVG(lifespan_in_months) AS Avg_Customer_lifespan,
        (AVG(purchase_value) * AVG(purchase_frequency) * AVG(lifespan_in_months) * 0.3) - 5000 AS CLV
FROM (
SELECT
        ord.customerNumber AS CustomerId,
        SUM(quantityOrdered * priceEach) AS purchase_value,
        COUNT(DISTINCT ord.orderNumber) AS purchase_frequency,
        MAX(ord.orderDate) AS max_ord_date,
        MIN(ord.orderDate) AS min_ord_date,
        TIMESTAMPDIFF(MONTH, MIN(ord.orderDate), MAX(ord.orderDate)) AS lifespan_in_months
FROM orders AS ord
JOIN orderdetails AS or_d1
	ON ord.orderNumber = or_d1.orderNumber
WHERE orderDate IS NOT NULL
GROUP BY ord.customerNumber

) AS Table1;



