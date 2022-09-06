-- 4. Let us define the latency of an employee 
-- by the average time he/she takes to process a complaint.
-- Find the employee with the smallest latency.

USE Shiokee;
GO

-- 1) Create a view to
--    calculate average latency for each employee based on minutes
CREATE OR ALTER VIEW EmployeeLatency AS

-- Calculate latency (minute) of employee
SELECT E.ID, E.Name, 
AVG(DATEDIFF(MINUTE,FiledDateTime, HandledDateTime)) AS AvgLatencyMinute

-- Join these 2 tables
FROM Complaints AS C, Employees AS E
WHERE C.EmployeeID = E.ID

-- Group by each employee
GROUP BY E.ID, E.Name;
GO


-- 2) Find the employee with smallest latency

-- Select employee name
SELECT Name AS MinLatencyEmployee
FROM EmployeeLatency

-- Find the one with minimum AvgLatencyMinute
WHERE AvgLatencyMinute = (SELECT MIN(AvgLatencyMinute) FROM EmployeeLatency);
GO


-- 3) Drop view
DROP VIEW EmployeeLatency;
GO