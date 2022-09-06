--1. 
--Frequent shoppers are shoppers who have purchased 
--more than 2 items per shop 
--for at least 5 shops 
--in the last 30 days.

--who are the top 3 frequent shoppers in terms of the total cost of the items they have purchased.



USE Shiokee;
GO

-- 1) Create a view to find all shoppers, and the items they purchased, item price, etc
CREATE OR ALTER VIEW AllShoppers AS

-- Attributes: User ID, Shop Name, Product Name, Ordered DateTime, Item Quantity, Product Unit Price
SELECT U.UID, SName, PName, DateTime, OQuantity, OPrice

-- Join 3 tables
FROM Users AS U, Orders AS O, ProductsInOrders AS P
WHERE U.UID = O.UID AND P.OID = O.OID;

GO

--SELECT * FROM AllShoppers;
--GO



-- 2) Create a view to find frequent shoppers
CREATE OR ALTER VIEW FrequentShoppers AS

-- Attributes: User ID, Shop Name, Total quantity of items
SELECT UID, SName, SUM(OQuantity) AS ProductCount 

-- From the view AllShoppers
FROM AllShoppers

-- Check Time is within the past 30 days, 
-- Please note that: we don't have records in the last 30 days, 
-- for demo purpose, can change "-30" to "-365" to check the records in past year instead.
WHERE DateTime > DATEADD(day,-30,GETDATE())
AND   DateTime <= getdate()

-- Group by User Id and Shop Name
GROUP BY UID , SName

-- Check the Condition "who have purchased more than 2 items per shop "
HAVING SUM(OQuantity) > 2 ;

GO

--SELECT * FROM FrequentShoppers;
--GO



-- 3) Find the top 3 frequent shoppers 
-- Order them by the total cost of items they purchased

-- Select the top 3 records
SELECT TOP 3 FS.UID 

-- Join these 2 tables
FROM FrequentShoppers AS FS, AllShoppers AS S
WHERE FS.UID = S.UID

-- Group by User ID
GROUP BY FS.UID

-- Check the condition "for at least 5 shops"
HAVING COUNT(S.SName) >= 5

-- Order by total cost of items users purchased, descending order
ORDER BY SUM(S.OQuantity*S.OPrice) DESC;

GO


-- 4)Drop VIEWs
DROP VIEW AllShoppers;
DROP VIEW FrequentShoppers;