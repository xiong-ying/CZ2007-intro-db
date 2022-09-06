-- 8.Find the products that have never been purchased by some users, 
-- but are the top 5 most purchased products by other users in August 2021.
USE Shiokee;
GO

-- top 5 most purchased products
SELECT TOP 5 PName

-- Join these 2 tables
FROM ProductsInOrders INNER JOIN Orders ON ProductsInOrders.OID=Orders.OID
WHERE 

--Find product that have never been purchased by some users
PName IN (

--[All Products]
SELECT PName FROM ProductsInOrders

--Minus
EXCEPT 

--[Product purchased by all users]
SELECT PName FROM ProductsInOrders INNER JOIN Orders ON ProductsInOrders.OID=Orders.OID
GROUP BY PName
HAVING COUNT(DISTINCT UID) = (SELECT COUNT(*) FROM Users)
)

--Check time in August 2021
AND DateTime >= '2021-08-01 00:00:00.000'
AND DateTime < '2021-09-01 00:00:00.000'

-- group by product name
GROUP BY PName

--Sort the products based on total quantity sold, then sort by product name
ORDER BY SUM(OQuantity) DESC, PName ASC;
GO
