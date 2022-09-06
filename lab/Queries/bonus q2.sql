--2.
--Popular shops are shops 
--which have sold more than 3 items 
--in the last 30 days.

--Who are the top 3 shoppers in these shops in terms of the number of items they have purchased.

USE Shiokee;
GO

--1) Create view to find popular shops
CREATE OR ALTER VIEW PopularShops AS

SELECT SName
FROM ProductsInOrders AS P, Orders AS O
WHERE P.OID = O.OID

-- last 30 days
AND DateTime > DATEADD(DAY,-180,GETDATE())
AND DateTime <= GETDATE()

GROUP BY SName
-- sold more than 3 items
HAVING SUM(OQuantity)>1;
GO


--2) Find top 3 shoppers 
SELECT TOP 3 UID 
FROM PopularShops As PS, ProductsInOrders AS PO, Orders AS O
WHERE PS.SName = PO.SName AND PO.OID = O.OID
GROUP BY UID
ORDER BY SUM(OQuantity) DESC;