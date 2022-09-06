--5. Produce a list that contains 
--(i) all products made by Samsung, and
--(ii) for each of them, the number of shops on Shiokee that sell the product

USE Shiokee;
GO


-- (i) Get all products made by Samsung

CREATE OR ALTER VIEW SamsungProducts AS

SELECT P1.PName

-- Join these 2 tables
FROM Products AS P1

-- Find all products made by Samsung
WHERE P1.Maker = 'Samsung';
GO

SELECT * FROM SamsungProducts;



-- (2) Find number of shops for each Samsung product
SELECT P2.PName, COUNT(P2.SName) AS ShopCount

-- Product in Samsung Products
FROM ProductsInShops AS P2
WHERE PName in (SELECT * FROM SamsungProducts)

-- Group by product name
GROUP BY P2.PName;
GO
