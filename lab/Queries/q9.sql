-- 9. Find products that are increasingly being purchased
-- over at least 3 months

USE Shiokee;
GO

-- 1) Create a view with records of 
--    ProductName, Year, Month, Total Quantity sold

CREATE OR ALTER VIEW SalesRecord AS 

-- Create Columns of product name, year, month, total quantity sold
SELECT PName, 
YEAR(DateTime) AS DateYear, 
MONTH(DateTime) AS DateMonth, 
SUM(OQuantity) AS TotalQuantity

-- From these 2 tables
FROM ProductsInOrders, Orders 

-- Join 2 tables
WHERE Orders.OID = ProductsInOrders.OID

-- Group Sum of Quantity based on Product name, year, month
GROUP BY PName, YEAR(DateTime), MONTH(DateTime);
GO


-- 2) Find products that have inscreasing sales for 3 months

-- Find the product name
SELECT S1.PName

-- From View SalesRecord
-- S1: first month, S2: second month, S3: third month
FROM SalesRecord AS S1, SalesRecord AS S2, SalesRecord AS S3

-- Conditions:
WHERE 
-- (1) Join 3 tables
S1.PName = S2.PName AND S2.PName = S3.PName

-- (2) Check increasing quantity
AND S1.TotalQuantity < S2.TotalQuantity 
AND S2.TotalQuantity < S3.TotalQuantity

-- (3) Check consective 3 months

-- (3.1) Check Month
AND (S1.DateMonth+1)%12=S2.DateMonth%12
AND (S2.DateMonth+1)%12=S3.DateMonth%12

-- (3.2) Check Year
AND S1.DateYear+(S1.DateMonth/12)=S2.DateYear 
AND S2.DateYear+(S2.DateMonth/12)=S3.DateYear;
GO


-- 3) Drop the view
DROP VIEW SalesRecord;
GO
