-- 2. Find the products 
-- that received at least 100 ratings of "5" 
-- in August 2021, and 
-- order them by their average ratings


USE [Shiokee];

-- select column 'PName' and (create) column '[AverageRatings]' from computing the average ratings
SELECT [Feedbacks].[PName],
	   AVG([Feedbacks].[Rating] * 1.0) AS [AverageRatings]

-- from table [Feedbacks]
FROM [Feedbacks] 

-- where column 'PName' is found within any of the results in the following subquery
WHERE [Feedbacks].[PName] = ANY (

	-- select column 'PName'
	SELECT [Feedbacks].[PName] 
	
	-- from table [Feedbacks]
	FROM [Feedbacks] 
	
	-- where date is between 1 Aug 2021 to 31 Aug 2021 
	WHERE ([Feedbacks].[DateTime] BETWEEN '2021-08-01' AND '2021-08-31') 
	
	-- and rating is 5
	AND [Feedbacks].[Rating] = 5
	
	-- group by column '[PName]' from table [Feedbacks] accordingly.
	GROUP BY [Feedbacks].[PName]
	
	-- with at least 100 feedbacks regarding that product
	HAVING COUNT([Feedbacks].[PName]) >= 100
) 

-- group by column '[PName]' from table [Feedbacks] accordingly.
GROUP BY [Feedbacks].[PName]

-- sort the output based on the average rating in descending order.
ORDER BY AVG([Feedbacks].[Rating] * 1.0) DESC
