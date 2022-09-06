-- 1. Find the average price of "iPhone Xs" on Shiokee 
-- from 1 August 2021 to 31 August 2021

USE Shiokee;
GO

-- 1) Create a view to list out all the calendar dates in Aug 2021, 
--    from 1 Aug 2021 to 31 Aug 2021

CREATE OR ALTER VIEW CalendarAug2021 AS

-- Select 31 records, from the date 20210801 onwards
SELECT  TOP 31
        DateInAug = DATEADD(DAY, ROW_NUMBER() OVER(ORDER BY a.object_id) - 1, '20210801')

-- From system objects
FROM    sys.all_objects a CROSS JOIN sys.all_objects b;

GO

---- Check the view
--SELECT * FROM CalendarAug2021;
--GO



-- 2) Create a view to merge TABLE PriceHistory and VIEW CalendarAug2021, 
--    to get all the price records from all shops on each day in Aug 021

--    For each DATE in August, from 1 Aug to 31 Aug 2021
--    list down all the records that fulfills this condition 
--    (this DATE is within the range between start date and end date)

--    Record Examples: 

--    2021-08-01, Shop 1, Price 123 
--    (Start Date 2021-08-01, End Date 2021-08-01)

--    2021-08-01, Shop 2, Price 456
--    (Start Date 2021-07-01, End Date 2021-08-31)

--    2021-08-02, Shop 2, Price 456
--    (Start Date 2021-07-01, End Date 2021-08-31)


-- Create a VIEW named AugPriceHistory
CREATE OR ALTER VIEW AugPriceHistory AS

-- Attributes: Dates in August, Product Name, Price, Shop Name
SELECT DateInAug, SName, Price

-- Data from TABLE PriceHistory, VIEW CalendarAug2021


FROM PriceHistory AS P, CalendarAug2021 AS C

-- Check condition: Product is iPhoneXs
WHERE P.PName='iPhone Xs'

-- Check condition: the date in August is in between the start data and end date
AND DateInAug >= CAST(StartDate as DATE)
AND (DateInAug <= CAST(EndDate as DATE) OR EndDate IS NULL);
GO

---- Check the view
--SELECT * FROM AugPriceHistory;
--GO


-- 3) Calculate the average price for each day, 
--    and add all the daily average and divided by 31 (the number of days in Aug)


-- (3.1) Get the average price for each day in Aug 2021

-- Use WITH clause to give the subquery a temporary name "TemDailyAvgPrice"
WITH TemDailyAvgPrice AS 

-- Attributes: Date in August, average price on each day
(SELECT DateInAug, AVG(Price) AS DailyAvgPrice 

-- Data from the VIEW AugPriceHistory
FROM AugPriceHistory

-- Group by dates in August
GROUP BY DateInAug) 


-- (3.2) Get the rolling average in August 2021

-- Sum the average price for each day in August 2021, divided by 31
SELECT SUM(DailyAvgPrice)/31 AS RollingAvgInAug

-- From the temporary table TemDailyAvgPrice
FROM TemDailyAvgPrice;

GO


-- 4）Drop views
DROP VIEW CalendarAug2021;
DROP VIEW AugPriceHistory;
GO
