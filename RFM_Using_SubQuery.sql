USE classicmodels;

# FREQUENT BUYER AND HIGHER MONETORY VALUE IS BETTER
# When I use DENSE_RANK It give my ranking higher then 10 that'S why use NTILE
# The NTILE(n) function in SQL is a window function that splits your result set into n roughly equal buckets and assigns a bucket number to each row. 
# Give ERROR if we use like this NTILE() OVER(ORDER BY Frequency) AS Frequency_score 
#Use Instead NTILE() OVER(ORDER BY COUNT(ord.orderNumber)) AS Frequency_score

 -- TABLE 1 --
 -- Recency, Frequency, Monetary Score --
 
SELECT
        ord.customerNumber AS CustomerId,
        MAX(orderDate) AS Last_Purchase_Date,
        DATEDIFF(CURDATE(), MAX(orderDate)) AS Recency,
        COUNT(ord.orderNumber) AS Frequency,
        SUM(quantityOrdered * priceEach) AS Revenue,

        NTILE(9) OVER (ORDER BY DATEDIFF(CURDATE(), MAX(orderDate)) ASC) AS RecencyScore,
		NTILE(9) OVER (ORDER BY COUNT(ord.orderNumber) DESC) AS FrequencyScore,
		NTILE(9) OVER (ORDER BY SUM(quantityOrdered * priceEach)DESC) AS MonetaryScore

FROM orders AS ord
JOIN orderdetails AS or_d1
	ON ord.orderNumber = or_d1.orderNumber
WHERE orderDate IS NOT NULL
	AND status != 'Cancelled'
GROUP BY ord.customerNumber;

 -- TABLE 2 --
 -- RFM Segment --
 
SELECT 
		CustomerId,
		Last_Purchase_Date,
		Recency,
		Frequency,
		Revenue,
		RecencyScore,
		FrequencyScore,
		MonetaryScore,
		CONCAT(RecencyScore, FrequencyScore, MonetaryScore) AS RFM_Score,
		
		CASE 
			WHEN RecencyScore >= 8 AND FrequencyScore >= 8 AND MonetaryScore >= 8 THEN 'Champions'
			WHEN RecencyScore >= 6 AND FrequencyScore >= 6 THEN 'Loyal Customers'
			WHEN RecencyScore >= 7 AND FrequencyScore <= 4 THEN 'Potential Loyalist'
			WHEN RecencyScore >= 4 AND FrequencyScore >= 4 AND MonetaryScore >= 4 THEN 'Need Attention'
			WHEN RecencyScore <= 3 AND FrequencyScore <= 3 AND MonetaryScore <= 3 THEN 'Hibernating'
			WHEN RecencyScore <= 2 AND FrequencyScore >= 7 THEN 'At Risk'
			ELSE 'Others'
		END AS Segment 
	FROM (
			SELECT
					ord.customerNumber AS CustomerId,
					MAX(orderDate) AS Last_Purchase_Date,
					DATEDIFF(CURDATE(), MAX(orderDate)) AS Recency,
					COUNT(ord.orderNumber) AS Frequency,
					SUM(quantityOrdered * priceEach) AS Revenue,

					NTILE(9) OVER (ORDER BY DATEDIFF(CURDATE(), MAX(orderDate)) ASC) AS RecencyScore,
					NTILE(9) OVER (ORDER BY COUNT(ord.orderNumber) DESC) AS FrequencyScore,
					NTILE(9) OVER (ORDER BY SUM(quantityOrdered * priceEach)DESC) AS MonetaryScore

			FROM orders AS ord
			JOIN orderdetails AS or_d1
				ON ord.orderNumber = or_d1.orderNumber
			WHERE orderDate IS NOT NULL
				AND status != 'Cancelled'
			GROUP BY ord.customerNumber ) AS RFM;
            
-- TABLE 3 --
-- Customer_count per segment --

SELECT Segment, COUNT(*) AS customer_count
FROM (
		SELECT 
			CustomerId,
			Last_Purchase_Date,
			Recency,
			Frequency,
			Revenue,
			RecencyScore,
			FrequencyScore,
			MonetaryScore,
			CONCAT(RecencyScore, FrequencyScore, MonetaryScore) AS RFM_Score,
			
			CASE 
				WHEN RecencyScore >= 8 AND FrequencyScore >= 8 AND MonetaryScore >= 8 THEN 'Champions'
				WHEN RecencyScore >= 6 AND FrequencyScore >= 6 THEN 'Loyal Customers'
				WHEN RecencyScore >= 7 AND FrequencyScore <= 4 THEN 'Potential Loyalist'
				WHEN RecencyScore >= 4 AND FrequencyScore >= 4 AND MonetaryScore >= 4 THEN 'Need Attention'
				WHEN RecencyScore <= 3 AND FrequencyScore <= 3 AND MonetaryScore <= 3 THEN 'Hibernating'
				WHEN RecencyScore <= 2 AND FrequencyScore >= 7 THEN 'At Risk'
				ELSE 'Others'
			END AS Segment 
		FROM (
				SELECT
						ord.customerNumber AS CustomerId,
						MAX(orderDate) AS Last_Purchase_Date,
						DATEDIFF(CURDATE(), MAX(orderDate)) AS Recency,
						COUNT(ord.orderNumber) AS Frequency,
						SUM(quantityOrdered * priceEach) AS Revenue,

						NTILE(9) OVER (ORDER BY DATEDIFF(CURDATE(), MAX(orderDate)) ASC) AS RecencyScore,
						NTILE(9) OVER (ORDER BY COUNT(ord.orderNumber) DESC) AS FrequencyScore,
						NTILE(9) OVER (ORDER BY SUM(quantityOrdered * priceEach)DESC) AS MonetaryScore

				FROM orders AS ord
				JOIN orderdetails AS or_d1
					ON ord.orderNumber = or_d1.orderNumber
				WHERE orderDate IS NOT NULL
					AND status != 'Cancelled'
				GROUP BY ord.customerNumber ) AS RFM 
                ) AS Segment
GROUP BY Segment
ORDER BY customer_count DESC;
            