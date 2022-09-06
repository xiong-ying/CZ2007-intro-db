-- 3. For all products purchased in June 2021 
-- that have been delivered, 
-- find the average time 
-- from the ordering date to the delivery date.

USE Shiokee;
GO

-- Calculate Average Delivery Day
SELECT PName, AVG(day(DeliveryDate-DateTime)) AS AvgDeliverDay
FROM Orders AS O, ProductsInOrders AS P

-- Check time in June 2021
WHERE DateTime >= '2021-06-01 00:00:00.000'
AND DateTime < '2021-07-01 00:00:00.000'

-- Check status is "Delivered"
AND Status = 'Delivered'

-- Join 2 tables
AND O.OID  = P.OID

-- Group by product name
GROUP BY PName;
GO

