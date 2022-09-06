-- 7. For users that made the most amount of complaints, 
-- find the most expensive products he/she has ever purchased.

USE Shiokee;
GO

-- 1) Create view to find the number of complaints for each user

CREATE OR ALTER VIEW UserComplaints AS

-- Count number of compaints
SELECT UID, COUNT(ID) AS NumComplaints
FROM Complaints

-- Group by each user
GROUP BY UID;
GO


-- 2) Create view to find all the products purchased by that user 
--    with max amount of compaints

CREATE OR ALTER VIEW UserProductPrice AS

-- Select product and unit price
SELECT PName, OPrice

-- Join these 2 tables
FROM Orders AS O, ProductsInOrders AS P
WHERE O.OID = P.OID

-- Check the user ID of the order equals to
AND O.UID = (

	-- the user who made the most amount of complaints
	SELECT UID FROM UserComplaints
	WHERE NumComplaints = (SELECT MAX(NumComplaints) FROM UserComplaints));
GO


-- 3) Find the most expensive product purchased by that user
SELECT PName
FROM UserProductPrice
WHERE OPrice = (SELECT MAX(OPrice) FROM UserProductPrice);
GO


-- 4) Drop the views
DROP VIEW UserProductPrice;
DROP VIEW UserComplaints;
GO
