-- 6. Find shops that made the most revenue in August 2021

USE Shiokee;
GO

-- Select the shop with highest total revenue
SELECT TOP 1 SName

-- Join these 2 tables
FROM ProductsInOrders AS PO, Orders AS O
WHERE PO.OID=O.OID

-- Check time is August 2021
AND MONTH(O.DateTime) = 8
AND YEAR(O.DateTime) = 2021

-- gourp by each shop
GROUP BY SName 

-- Calculate total revenue, max revenue put on top
ORDER BY SUM(OPrice*OQuantity) DESC;
GO
