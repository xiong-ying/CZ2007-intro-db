-- CZ2007 Introduction To Databases
-- Team 3 Red
-- ver.1.0
--
-- This query file is used for population and creation of Database and Tables for Lab Project 'Shiokee'



-- BEGIN --

-- Sanity Check
-- SHOW DATABASES;

-- Create Database for [Shiokee], set to use.
IF NOT EXISTS (SELECT * FROM sys.databases WHERE NAME = N'Shiokee')
BEGIN
	CREATE DATABASE [Shiokee];
END;
GO

USE [Shiokee];
GO

-- Create Table for [Employees]
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Employees')
BEGIN
CREATE TABLE Employees (
	ID INT IDENTITY(1, 1) PRIMARY KEY,
	Name NVARCHAR(255) NOT NULL,
	Salary DECIMAL(7, 2) NOT NULL
);
END
GO

-- Create Table for [Complaints]
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Complaints')
BEGIN
CREATE TABLE Complaints (
	ID INT IDENTITY(1, 1) PRIMARY KEY,
	UID INT NOT NULL,
    EmployeeID INT,
    Status NVARCHAR(30) NOT NULL,
    Text NVARCHAR(500),
    FiledDateTime DATETIME NOT NULL,
    HandledDateTime DATETIME
);
END
GO

-- Create Table for [Shops]
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Shops')
BEGIN
CREATE TABLE Shops (
	SName NVARCHAR(100) PRIMARY KEY
    
	-- Foreign Key(s)
    -- Columns
);
END
GO

-- Create Table for [Users]
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Users')
BEGIN
CREATE TABLE Users (
	UID INT IDENTITY(1, 1) PRIMARY KEY,
    
    -- Foreign Key(s)
    -- Columns
    UName NVARCHAR(100) NOT NULL
);
END
GO

-- Create Table for [Orders]
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Orders')
BEGIN
CREATE TABLE Orders (
	OID INT IDENTITY(1, 1) PRIMARY KEY,
    
    -- Foreign Key(s)
    UID INT NOT NULL,
    
    -- Columns
    DateTime DATETIME NOT NULL,
    ShippingAddress TEXT NOT NULL
);
END
GO

-- Create Table for [Products]
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Products')
BEGIN
CREATE TABLE Products (
	PName NVARCHAR(100) PRIMARY KEY,
    
	-- Foreign Key(s)
    -- Columns
    Maker NVARCHAR(100),
    Category NVARCHAR (100)
);
END
GO

-- Create Table for [Price History]
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'PriceHistory')
BEGIN
CREATE TABLE PriceHistory (
	PName NVARCHAR(100) NOT NULL,
    SName NVARCHAR(100) NOT NULL,
    -- // PRIMARY KEY(PName, SName)
    -- NOTE: Should we set this as Primary Keys? Because it's possible to have duplicate records. This table is used for transaction recording
	
    -- Foreign Key(s)
    -- Columns
    Price DECIMAL(7, 2) NOT NULL,
    StartDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    EndDate DATETIME 
);
END
GO

-- Create Table for [Feedbacks]
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Feedbacks')
BEGIN
CREATE TABLE Feedbacks (
	UID INT NOT NULL,
    PName NVARCHAR(100) NOT NULL,
    PRIMARY KEY (UID, PName),
    
	-- Foreign Key(s)
    -- Columns
    Rating TINYINT NOT NULL,
    DateTime DATETIME DEFAULT CURRENT_TIMESTAMP,
    Comment NVARCHAR(500)
);
END
GO

-- Create Table for [Complaint On Shops]
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'ComplaintsOnShops')
BEGIN
CREATE TABLE ComplaintsOnShops (
    SName NVARCHAR(100) NOT NULL,
    ComplaintsID INT NOT NULL,
    PRIMARY KEY (SName, ComplaintsID)
    
    -- Foreign Key(s)
    -- Columns
);
END
GO

-- Create Table for [Complaint On Orders]
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'ComplaintsOnOrders')
BEGIN
CREATE TABLE ComplaintsOnOrders (
    ComplaintsID INT NOT NULL,
    OID INT NOT NULL,
    PRIMARY KEY (ComplaintsID, OID)
    
    -- Foreign Key(s)
    -- Columns
);
END
GO

-- Create Table for [Products In Shops]
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'ProductsInShops')
BEGIN
CREATE TABLE ProductsInShops (
    PName NVARCHAR(100) NOT NULL,
    SName NVARCHAR(100) NOT NULL,
    PRIMARY KEY (PName, SName),
    
    -- Foreign Key(s)
    -- Columns
    SPID VARCHAR(30) NOT NULL,
    SPrice DECIMAL (7, 2) NOT NULL,
    SQuantity INT NOT NULL
);
END
GO

-- Create Table for [Products In Orders]
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'ProductsInOrders')
BEGIN
CREATE TABLE ProductsInOrders (
    PName NVARCHAR(100) NOT NULL,
    SName NVARCHAR(100) NOT NULL,
    OID INT NOT NULL,
    PRIMARY KEY (PName, SName, OID),
    
    -- Foreign Key(s)
    -- Columns
    Status NVARCHAR(30) NOT NULL,
    DeliveryDate DATETIME,
    OPrice DECIMAL (7, 2) NOT NULL,
    OQuantity INT NOT NULL
);
END
GO

-- Reset and populate fake data for testing.

-- Complaints
TRUNCATE TABLE [Complaints];
INSERT Complaints (UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime) VALUES (1, 4, 'Addressed', 'Don Juan is a scammer! His Covid Vaccine doesn''t help me at all. I still got infected. I want a refund!', '2022-03-18 12:00:00', '2022-03-21 12:00:00');
INSERT Complaints (UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime) VALUES (2, 3, 'Being Handled', 'I bought a defect iPad from Johnny''s Shop and he is asking me to ship back the product in order to facilitate refund. I think that''s not right. Please expedite.', '2022-03-19 12:33:00', '2022-03-24 12:00:00');
INSERT Complaints (UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime) VALUES (3, 3, 'Being Handled', 'I bought an iPhone from Rinrin. Goods arrived in good condition but I can''t find any warranty information. Help!', '2022-03-19 16:37:00', '2022-03-22 12:00:00');
INSERT Complaints (UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime) VALUES (4, NULL, 'Pending', 'I want to report Don Juan! Bad service and very rude to me when I asked him about delivery details! This is so uncalled for!', '2022-03-20 12:00:00', NULL);
INSERT Complaints (UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime) VALUES (4, 1, 'Pending', 'Thiel and Sons wants to wiretap all of our telephones and computers.', '2022-03-20 12:00:00', NULL);
INSERT Complaints (UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime) VALUES (5, 1, 'Addressed', 'Ut efficitur dui vel metus lobortis tempus.', '2022-03-20 12:05:00', '2022-03-20 13:00:00');
INSERT Complaints (UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime) VALUES (6, 1, 'Addressed', 'Duis volutpat libero et augue condimentum, at fermentum sem molestie.', '2022-03-20 12:10:00', '2022-03-20 13:10:00');
INSERT Complaints (UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime) VALUES (5, 2, 'Addressed', 'Pellentesque euismod odio quis posuere aliquam.', '2022-03-20 12:15:00', '2022-03-20 13:00:00');
INSERT Complaints (UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime) VALUES (7, 3, 'Being Handled', 'Aenean mattis metus nec nulla imperdiet scelerisque.', '2022-03-20 12:15:30', '2022-03-20 13:00:00');
INSERT Complaints (UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime) VALUES (8, 3, 'Being Handled', 'Phasellus eget nibh id odio ultrices pretium at in velit.', '2022-03-20 12:30:30', '2022-03-20 13:05:00');
INSERT Complaints (UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime) VALUES (8, NULL, 'Pending', 'Mauris quis enim efficitur, faucibus dolor vitae, finibus ante.', '2022-03-20 13:30:00', NULL);
INSERT Complaints (UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime) VALUES (9, NULL, 'Pending', 'In ut enim ut eros auctor pretium.', '2022-03-20 13:30:30', NULL);
INSERT Complaints (UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime) VALUES (9, 4, 'Addressed', 'Donec maximus magna quis faucibus fermentum.', '2022-03-20 11:30:30', '2022-03-20 13:05:00');
INSERT Complaints (UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime) VALUES (10, 2, 'Addressed', 'Fusce efficitur quam suscipit arcu dapibus consequat.', '2022-03-20 10:30:30', '2022-03-20 13:00:00');
INSERT Complaints (UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime) VALUES (10, 3, 'Being Handled', 'Vestibulum eu ipsum non risus dapibus volutpat.', '2022-03-20 14:30:30', '2022-03-20 15:00:00');
INSERT Complaints (UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime) VALUES (6, 3, 'Being Handled', 'Donec sodales tellus nec egestas lobortis.', '2022-03-20 14:40:00', '2022-03-20 15:00:00');
INSERT Complaints (UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime) VALUES (6, 1, 'Being Handled', 'Vivamus scelerisque felis at neque dignissim scelerisque sed vel nunc.', '2022-03-20 23:55:00', '2022-03-21 06:00:00');
INSERT Complaints (UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime) VALUES (1, 3, 'Being Handled', 'Etiam consectetur magna vitae dui laoreet fringilla.', '2022-03-20 15:32:00', '2022-03-20 19:00:00');
INSERT Complaints (UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime) VALUES (2, 2, 'Addressed', 'Ut sagittis velit at lectus congue, in facilisis enim imperdiet.', '2022-03-21 00:28:00', '2022-03-21 08:03:00');
INSERT Complaints (UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime) VALUES (3, 4, 'Being Handled', 'Integer eu nisi pulvinar, vehicula diam ac, gravida nisi.', '2022-03-21 14:40:40', '2022-03-21 15:30:01');
INSERT Complaints (UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime) VALUES (4, 1, 'Addressed', 'Cras sed lorem sollicitudin, auctor ex et, pretium ex.', '2022-03-21 14:26:00', '2022-03-21 22:49:00');
INSERT Complaints (UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime) VALUES (5, 2, 'Addressed', 'Integer a ante ac magna iaculis aliquet.', '2022-03-21 15:08:00', '2022-03-21 15:19:00');
INSERT Complaints (UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime) VALUES (6, 3, 'Pending', 'Donec eu magna in risus imperdiet convallis sed sit amet nibh.', '2022-03-21 17:31:00', NULL);
INSERT Complaints (UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime) VALUES (7, 4, 'Addressed', 'Proin consequat sapien ac eros rutrum rutrum.', '2022-03-21 18:29:00', '2022-03-21 18:55:00');
INSERT Complaints (UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime) VALUES (8, 1, 'Addressed', 'Aliquam et erat in ipsum condimentum luctus.', '2022-03-21 20:20:20', '2022-03-21 21:01:00');
INSERT Complaints (UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime) VALUES (9, 2, 'Being Handled', 'Fusce vulputate est a libero elementum faucibus.', '2022-03-21 21:37:55', '2022-03-21 21:59:00');
INSERT Complaints (UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime) VALUES (10, 3, 'Being Handled', 'Phasellus quis felis at dolor tempor dictum id et tortor.', '2022-03-21 22:48:39', '2022-03-21 23:11:00');
INSERT Complaints (UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime) VALUES (10, 3, 'Being Handled', 'Sed nec elit nec felis hendrerit tempus at a lacus.', '2022-03-21 22:50:07', '2022-03-21 23:16:00');
INSERT Complaints (UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime) VALUES (10, 3, 'Being Handled', 'Donec finibus felis sed sapien bibendum ultrices.', '2022-03-21 22:55:41', '2022-03-21 23:21:00');
INSERT Complaints (UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime) VALUES (8, 4, 'Addressed', 'Fusce a nunc sed lacus dapibus auctor sit amet et nibh.', '2022-03-22 01:36:00', '2022-03-22 2:22:22');

-- ComplaintsOnOrders
TRUNCATE TABLE [ComplaintsOnOrders];
INSERT ComplaintsOnOrders (ComplaintsID, OID) VALUES (1, 5);
INSERT ComplaintsOnOrders (ComplaintsID, OID) VALUES (2, 4);
INSERT ComplaintsOnOrders (ComplaintsID, OID) VALUES (3, 6);
INSERT ComplaintsOnOrders (ComplaintsID, OID) VALUES (11, 52);
INSERT ComplaintsOnOrders (ComplaintsID, OID) VALUES (12, 34);
INSERT ComplaintsOnOrders (ComplaintsID, OID) VALUES (13, 1);
INSERT ComplaintsOnOrders (ComplaintsID, OID) VALUES (14, 9);
INSERT ComplaintsOnOrders (ComplaintsID, OID) VALUES (15, 13);
INSERT ComplaintsOnOrders (ComplaintsID, OID) VALUES (16, 24);
INSERT ComplaintsOnOrders (ComplaintsID, OID) VALUES (17, 7);
INSERT ComplaintsOnOrders (ComplaintsID, OID) VALUES (18, 33);
INSERT ComplaintsOnOrders (ComplaintsID, OID) VALUES (19, 2);
INSERT ComplaintsOnOrders (ComplaintsID, OID) VALUES (20, 1);
INSERT ComplaintsOnOrders (ComplaintsID, OID) VALUES (21, 1);
INSERT ComplaintsOnOrders (ComplaintsID, OID) VALUES (22, 25);
INSERT ComplaintsOnOrders (ComplaintsID, OID) VALUES (23, 6);
INSERT ComplaintsOnOrders (ComplaintsID, OID) VALUES (24, 44);
INSERT ComplaintsOnOrders (ComplaintsID, OID) VALUES (25, 47);
INSERT ComplaintsOnOrders (ComplaintsID, OID) VALUES (26, 23);
INSERT ComplaintsOnOrders (ComplaintsID, OID) VALUES (27, 1);
INSERT ComplaintsOnOrders (ComplaintsID, OID) VALUES (28, 1);
INSERT ComplaintsOnOrders (ComplaintsID, OID) VALUES (29, 35);
INSERT ComplaintsOnOrders (ComplaintsID, OID) VALUES (30, 39);

-- ComplaintsOnShops
TRUNCATE TABLE [ComplaintsOnShops];
INSERT ComplaintsOnShops (ComplaintsID, SName) VALUES (4, 'Don Juan''s Stockpile');
INSERT ComplaintsOnShops (ComplaintsID, SName) VALUES (5, 'Thiel and Sons');
INSERT ComplaintsOnShops (ComplaintsID, SName) VALUES (6, 'Maggio-Hudson');
INSERT ComplaintsOnShops (ComplaintsID, SName) VALUES (7, 'Kilback Inc');
INSERT ComplaintsOnShops (ComplaintsID, SName) VALUES (8, 'Daniel and Sons');
INSERT ComplaintsOnShops (ComplaintsID, SName) VALUES (9, 'Weissnat LLC');
INSERT ComplaintsOnShops (ComplaintsID, SName) VALUES (10, 'Weissnat LLC');

-- Employees (OK)
TRUNCATE TABLE [Employees];
INSERT Employees (Name, Salary) VALUES ('Jane Doe', 2000);
INSERT Employees (Name, Salary) VALUES ('Devi Sundram D/O Raju', 2000);
INSERT Employees (Name, Salary) VALUES ('Musa Bin Osman', 2000);
INSERT Employees (Name, Salary) VALUES ('Zhang San', 2000);

-- Feedbacks (OK)
TRUNCATE TABLE [Feedbacks];
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (8,'Huawei P10',1,'6/22/2021 9:00','Very bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (5,'Huawei P10',2,'6/18/2021 9:00','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (1,'Huawei P10',3,'6/14/2021 9:00','Not bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (9,'Huawei P10',3,'6/22/2021 9:00','Not bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (2,'Huawei P10',4,'6/14/2021 9:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (6,'Huawei P10',4,'6/18/2021 9:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (10,'Huawei P10',4,'6/22/2021 9:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (3,'Huawei P10',5,'6/14/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (4,'Huawei P10',5,'6/14/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (7,'Huawei P10',5,'6/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (7,'Huawei P11',1,'7/22/2021 9:00','Very bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (1,'Huawei P11',2,'7/14/2021 9:00','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (5,'Huawei P11',2,'7/18/2021 9:00','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (8,'Huawei P11',2,'7/22/2021 9:00','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (2,'Huawei P11',3,'7/14/2021 9:00','Not bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (9,'Huawei P11',3,'7/22/2021 9:00','Not bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (3,'Huawei P11',4,'7/14/2021 9:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (6,'Huawei P11',4,'7/18/2021 9:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (10,'Huawei P11',4,'7/22/2021 9:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (4,'Huawei P11',5,'7/14/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (35,'Huawei P19',1,'8/18/2021 9:00','Very bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (36,'Huawei P19',1,'8/18/2021 9:00','Very bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (37,'Huawei P19',1,'8/18/2021 9:00','Very bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (38,'Huawei P19',1,'8/18/2021 9:00','Very bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (39,'Huawei P19',1,'8/18/2021 9:00','Very bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (40,'Huawei P19',1,'8/18/2021 9:00','Very bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (111,'Huawei P19',2,'8/22/2021 9:00','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (112,'Huawei P19',2,'8/22/2021 9:00','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (113,'Huawei P19',2,'8/22/2021 9:00','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (114,'Huawei P19',2,'8/22/2021 9:00','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (115,'Huawei P19',2,'8/22/2021 9:00','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (116,'Huawei P19',2,'8/22/2021 9:00','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (104,'Huawei P19',3,'8/22/2021 9:00','Not bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (105,'Huawei P19',3,'8/22/2021 9:00','Not bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (106,'Huawei P19',3,'8/22/2021 9:00','Not bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (107,'Huawei P19',3,'8/22/2021 9:00','Not bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (108,'Huawei P19',3,'8/22/2021 9:00','Not bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (109,'Huawei P19',3,'8/22/2021 9:00','Not bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (23,'Huawei P19',4,'8/18/2021 9:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (24,'Huawei P19',4,'8/18/2021 9:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (25,'Huawei P19',4,'8/18/2021 9:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (26,'Huawei P19',4,'8/18/2021 9:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (27,'Huawei P19',4,'8/18/2021 9:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (28,'Huawei P19',4,'8/18/2021 9:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (29,'Huawei P19',4,'8/18/2021 9:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (30,'Huawei P19',4,'8/18/2021 9:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (31,'Huawei P19',4,'8/18/2021 9:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (32,'Huawei P19',4,'8/18/2021 9:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (33,'Huawei P19',4,'8/18/2021 9:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (34,'Huawei P19',4,'8/18/2021 9:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (1,'Huawei P19',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (2,'Huawei P19',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (3,'Huawei P19',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (4,'Huawei P19',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (5,'Huawei P19',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (6,'Huawei P19',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (7,'Huawei P19',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (8,'Huawei P19',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (9,'Huawei P19',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (10,'Huawei P19',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (11,'Huawei P19',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (12,'Huawei P19',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (13,'Huawei P19',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (14,'Huawei P19',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (15,'Huawei P19',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (16,'Huawei P19',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (17,'Huawei P19',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (18,'Huawei P19',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (19,'Huawei P19',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (20,'Huawei P19',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (21,'Huawei P19',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (22,'Huawei P19',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (41,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (42,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (43,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (44,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (45,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (46,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (47,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (48,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (49,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (50,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (51,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (52,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (53,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (54,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (55,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (56,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (57,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (58,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (59,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (60,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (61,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (62,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (63,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (64,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (65,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (66,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (67,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (68,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (69,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (70,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (71,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (72,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (73,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (74,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (75,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (76,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (77,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (78,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (79,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (80,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (81,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (82,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (83,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (84,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (85,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (86,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (87,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (88,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (89,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (90,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (91,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (92,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (93,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (94,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (95,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (96,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (97,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (98,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (99,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (100,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (101,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (102,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (103,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (110,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (117,'Huawei P19',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (118,'Huawei P19',5,'8/27/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (119,'Huawei P19',5,'8/27/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (120,'Huawei P19',5,'8/27/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (121,'Huawei P19',5,'8/27/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (122,'Huawei P19',5,'8/27/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (123,'Huawei P19',5,'8/27/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (124,'Huawei P19',5,'8/27/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (125,'Huawei P19',5,'8/27/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (126,'Huawei P19',5,'8/27/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (127,'Huawei P19',5,'8/27/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (128,'Huawei P19',5,'8/27/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (129,'Huawei P19',5,'8/27/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (130,'Huawei P19',5,'8/27/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (131,'Huawei P19',5,'8/27/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (132,'Huawei P19',5,'8/27/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (133,'Huawei P19',5,'8/27/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (134,'Huawei P19',5,'8/27/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (135,'Huawei P19',5,'8/27/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (136,'Huawei P19',5,'8/27/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (137,'Huawei P19',5,'8/27/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (138,'Huawei P19',5,'8/27/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (1,'iPhone 13',1,'8/1/2021 5:06','Very bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (2,'iPhone 13',1,'8/2/2021 5:06','Very bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (3,'iPhone 13',1,'8/3/2021 5:06','Very bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (4,'iPhone 13',2,'8/4/2021 5:06','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (5,'iPhone 13',3,'8/5/2021 5:06','Not bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (6,'iPhone 13',3,'8/6/2021 5:06','Not bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (7,'iPhone 13',4,'8/7/2021 5:06','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (8,'iPhone 13',4,'8/8/2021 5:06','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (9,'iPhone 13',4,'8/9/2021 5:06','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (10,'iPhone 13',4,'8/10/2021 0:09','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (11,'iPhone 13',4,'8/10/2021 0:09','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (12,'iPhone 13',4,'8/10/2021 1:02','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (14,'iPhone 13',4,'8/10/2021 2:03','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (15,'iPhone 13',4,'8/10/2021 2:03','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (16,'iPhone 13',4,'8/10/2021 5:01','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (17,'iPhone 13',4,'8/10/2021 5:01','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (18,'iPhone 13',4,'8/10/2021 5:06','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (19,'iPhone 13',4,'8/10/2021 8:02','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (21,'iPhone 13',4,'8/10/2021 8:07','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (22,'iPhone 13',4,'8/10/2021 8:07','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (23,'iPhone 13',4,'8/11/2021 5:06','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (24,'iPhone 13',4,'8/11/2021 6:03','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (26,'iPhone 13',4,'8/11/2021 8:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (27,'iPhone 13',4,'8/11/2021 8:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (28,'iPhone 13',4,'8/12/2021 0:08','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (29,'iPhone 13',4,'8/12/2021 0:08','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (30,'iPhone 13',4,'8/12/2021 1:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (32,'iPhone 13',4,'8/12/2021 1:01','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (34,'iPhone 13',4,'8/12/2021 5:06','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (35,'iPhone 13',4,'8/13/2021 0:02','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (37,'iPhone 13',4,'8/13/2021 0:09','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (38,'iPhone 13',4,'8/13/2021 0:09','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (39,'iPhone 13',4,'8/13/2021 1:01','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (40,'iPhone 13',4,'8/13/2021 1:01','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (41,'iPhone 13',4,'8/13/2021 3:07','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (43,'iPhone 13',4,'8/13/2021 4:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (44,'iPhone 13',4,'8/13/2021 4:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (45,'iPhone 13',4,'8/13/2021 5:03','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (46,'iPhone 13',4,'8/13/2021 5:03','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (47,'iPhone 13',4,'8/13/2021 6:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (48,'iPhone 13',4,'8/13/2021 6:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (49,'iPhone 13',4,'8/13/2021 8:04','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (50,'iPhone 13',4,'8/13/2021 8:04','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (51,'iPhone 13',4,'8/13/2021 8:09','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (52,'iPhone 13',4,'8/13/2021 8:09','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (53,'iPhone 13',4,'8/13/2021 8:09','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (55,'iPhone 13',4,'8/13/2021 9:04','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (56,'iPhone 13',4,'8/13/2021 9:04','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (57,'iPhone 13',4,'8/14/2021 5:08','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (58,'iPhone 13',4,'8/14/2021 5:08','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (59,'iPhone 13',4,'8/15/2021 0:04','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (60,'iPhone 13',4,'8/15/2021 0:04','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (61,'iPhone 13',4,'8/15/2021 0:04','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (62,'iPhone 13',4,'8/15/2021 0:04','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (63,'iPhone 13',4,'8/15/2021 3:04','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (64,'iPhone 13',4,'8/15/2021 3:04','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (65,'iPhone 13',4,'8/15/2021 5:02','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (67,'iPhone 13',4,'8/15/2021 8:09','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (68,'iPhone 13',4,'8/15/2021 8:09','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (69,'iPhone 13',4,'8/15/2021 9:02','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (70,'iPhone 13',4,'8/15/2021 9:02','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (71,'iPhone 13',4,'8/16/2021 3:07','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (72,'iPhone 13',4,'8/16/2021 3:07','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (73,'iPhone 13',4,'8/16/2021 7:03','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (74,'iPhone 13',4,'8/16/2021 7:03','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (75,'iPhone 13',4,'8/16/2021 8:02','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (76,'iPhone 13',4,'8/16/2021 8:02','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (77,'iPhone 13',4,'8/17/2021 0:01','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (78,'iPhone 13',4,'8/17/2021 0:01','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (79,'iPhone 13',4,'8/17/2021 2:07','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (80,'iPhone 13',4,'8/17/2021 2:07','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (81,'iPhone 13',4,'8/17/2021 3:02','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (82,'iPhone 13',4,'8/17/2021 3:02','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (83,'iPhone 13',4,'8/17/2021 4:01','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (85,'iPhone 13',4,'8/17/2021 8:01','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (86,'iPhone 13',4,'8/17/2021 8:01','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (87,'iPhone 13',4,'8/17/2021 8:05','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (89,'iPhone 13',4,'8/18/2021 1:02','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (90,'iPhone 13',4,'8/18/2021 1:02','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (91,'iPhone 13',4,'8/18/2021 4:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (92,'iPhone 13',4,'8/18/2021 4:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (93,'iPhone 13',4,'8/19/2021 2:02','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (94,'iPhone 13',4,'8/19/2021 2:02','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (95,'iPhone 13',4,'8/19/2021 6:06','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (97,'iPhone 13',4,'8/19/2021 7:02','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (98,'iPhone 13',4,'8/19/2021 7:02','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (99,'iPhone 13',4,'8/19/2021 7:06','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (100,'iPhone 13',4,'8/19/2021 7:06','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (13,'iPhone 13',5,'8/10/2021 1:02','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (20,'iPhone 13',5,'8/10/2021 8:02','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (25,'iPhone 13',5,'8/11/2021 6:03','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (31,'iPhone 13',5,'8/12/2021 1:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (33,'iPhone 13',5,'8/12/2021 1:01','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (36,'iPhone 13',5,'8/13/2021 0:02','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (42,'iPhone 13',5,'8/13/2021 3:07','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (54,'iPhone 13',5,'8/13/2021 8:09','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (66,'iPhone 13',5,'8/15/2021 5:02','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (84,'iPhone 13',5,'8/17/2021 4:01','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (88,'iPhone 13',5,'8/17/2021 8:05','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (96,'iPhone 13',5,'8/19/2021 6:06','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (7,'iPhone Xs',1,'8/18/2021 9:00','Very bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (88,'iPhone Xs',1,'8/22/2021 9:00','Very bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (1,'iPhone Xs',2,'8/14/2021 9:00','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (8,'iPhone Xs',2,'8/18/2021 9:00','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (89,'iPhone Xs',2,'8/22/2021 9:00','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (97,'iPhone Xs',2,'8/22/2021 9:00','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (2,'iPhone Xs',3,'8/14/2021 9:00','Not bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (9,'iPhone Xs',3,'8/18/2021 9:00','Not bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (90,'iPhone Xs',3,'8/22/2021 9:00','Not bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (91,'iPhone Xs',3,'8/22/2021 9:00','Not bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (3,'iPhone Xs',4,'8/14/2021 9:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (10,'iPhone Xs',4,'8/18/2021 9:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (11,'iPhone Xs',4,'8/18/2021 9:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (92,'iPhone Xs',4,'8/22/2021 9:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (93,'iPhone Xs',4,'8/22/2021 9:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (98,'iPhone Xs',4,'8/22/2021 9:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (4,'iPhone Xs',5,'8/14/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (5,'iPhone Xs',5,'8/14/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (6,'iPhone Xs',5,'8/14/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (12,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (13,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (14,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (15,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (16,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (17,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (18,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (19,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (20,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (21,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (22,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (23,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (24,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (25,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (26,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (27,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (28,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (29,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (30,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (31,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (32,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (33,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (34,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (35,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (36,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (37,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (38,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (39,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (40,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (41,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (42,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (43,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (44,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (45,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (46,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (47,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (48,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (49,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (50,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (51,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (52,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (53,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (54,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (55,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (56,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (57,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (58,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (59,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (60,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (61,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (62,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (63,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (64,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (65,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (66,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (67,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (68,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (69,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (70,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (71,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (72,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (73,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (74,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (75,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (76,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (77,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (78,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (79,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (80,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (81,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (82,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (83,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (84,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (85,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (86,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (87,'iPhone Xs',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (94,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (95,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (96,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (99,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (100,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (101,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (102,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (103,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (104,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (105,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (106,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (107,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (108,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (109,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (110,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (111,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (112,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (113,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (114,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (115,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (116,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (117,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (118,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (119,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (120,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (121,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (122,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (123,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (124,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (125,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (126,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (127,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (128,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (129,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (130,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (131,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (132,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (133,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (134,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (135,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (136,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (137,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (138,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (139,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (140,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (141,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (142,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (143,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (144,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (145,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (146,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (147,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (148,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (149,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (150,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (151,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (152,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (153,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (154,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (155,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (156,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (157,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (158,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (159,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (160,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (161,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (162,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (163,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (164,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (165,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (166,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (167,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (168,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (169,'iPhone Xs',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (1,'Samsung 2',2,'8/14/2021 9:00','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (2,'Samsung 2',2,'8/18/2021 9:00','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (1,'Samsung 3',2,'8/18/2021 9:00','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (2,'Samsung 3',2,'8/22/2021 9:00','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (1,'Samsung 4',2,'8/22/2021 9:00','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (2,'Samsung 4',2,'8/22/2021 9:00','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (3,'Samsung 4',2,'8/22/2021 9:00','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (1,'Samsung 5',2,'8/14/2021 9:00','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (2,'Samsung 5',2,'8/18/2021 9:00','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (3,'Samsung 5',2,'8/22/2021 9:00','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (6,'Samsung 6',1,'9/10/2021 7:09','Very bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (12,'Samsung 6',1,'9/15/2021 9:04','Very bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (13,'Samsung 6',1,'9/19/2021 8:01','Very bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (4,'Samsung 6',2,'1/18/2021 1:06','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (5,'Samsung 6',2,'3/13/2021 5:00','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (11,'Samsung 6',2,'9/15/2021 7:08','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (1,'Samsung 6',3,'1/11/2021 6:03','Not bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (7,'Samsung 6',3,'9/13/2021 8:06','Not bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (3,'Samsung 6',4,'1/17/2021 4:03','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (9,'Samsung 6',4,'9/15/2021 1:09','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (10,'Samsung 6',4,'9/15/2021 4:08','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (2,'Samsung 6',5,'1/15/2021 0:03','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (8,'Samsung 6',5,'9/14/2021 9:05','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (3,'Samsung 7',1,'1/12/2021 9:08','Very bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (18,'Samsung 7',1,'9/19/2021 9:05','Very bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (1,'Samsung 7',2,'1/11/2021 6:01','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (4,'Samsung 7',2,'1/13/2021 7:05','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (15,'Samsung 7',2,'9/19/2021 3:00','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (16,'Samsung 7',2,'9/19/2021 3:03','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (2,'Samsung 7',3,'1/12/2021 0:00','Not bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (9,'Samsung 7',3,'8/19/2021 5:05','Not bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (10,'Samsung 7',3,'9/10/2021 0:04','Not bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (11,'Samsung 7',3,'9/10/2021 2:07','Not bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (6,'Samsung 7',4,'1/18/2021 7:04','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (7,'Samsung 7',4,'8/14/2021 8:02','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (8,'Samsung 7',4,'8/16/2021 6:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (12,'Samsung 7',4,'9/10/2021 9:04','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (5,'Samsung 7',5,'1/16/2021 2:07','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (13,'Samsung 7',5,'9/13/2021 8:02','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (14,'Samsung 7',5,'9/16/2021 1:08','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (17,'Samsung 7',5,'9/19/2021 5:05','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (1,'Samsung 8',5,'1/12/2021 1:08','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (2,'Samsung 8',5,'1/12/2021 3:03','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (3,'Samsung 8',5,'1/12/2021 4:07','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (4,'Samsung 8',5,'1/12/2021 5:06','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (5,'Samsung 8',5,'1/12/2021 6:06','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (6,'Samsung 8',5,'1/12/2021 7:04','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (7,'Samsung 8',5,'1/14/2021 0:08','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (8,'Samsung 8',5,'1/14/2021 1:05','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (9,'Samsung 8',5,'1/15/2021 1:09','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (10,'Samsung 8',5,'1/15/2021 9:03','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (11,'Samsung 8',5,'1/17/2021 7:07','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (12,'Samsung 8',5,'1/19/2021 5:02','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (13,'Samsung 8',5,'2/11/2021 7:04','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (14,'Samsung 8',5,'2/12/2021 9:02','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (15,'Samsung 8',5,'2/13/2021 5:04','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (16,'Samsung 8',5,'2/13/2021 8:08','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (17,'Samsung 8',5,'2/13/2021 9:06','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (18,'Samsung 8',5,'2/14/2021 4:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (19,'Samsung 8',5,'2/15/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (20,'Samsung 8',5,'2/16/2021 2:03','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (21,'Samsung 8',5,'2/16/2021 4:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (22,'Samsung 8',5,'2/16/2021 4:02','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (23,'Samsung 8',5,'2/16/2021 4:04','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (24,'Samsung 8',5,'2/16/2021 8:07','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (25,'Samsung 8',5,'2/18/2021 0:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (26,'Samsung 8',5,'2/18/2021 8:04','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (27,'Samsung 8',5,'2/18/2021 8:06','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (28,'Samsung 8',5,'2/19/2021 7:04','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (29,'Samsung 8',5,'3/12/2021 1:08','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (30,'Samsung 8',5,'3/14/2021 0:04','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (31,'Samsung 8',5,'3/16/2021 0:07','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (32,'Samsung 8',5,'3/17/2021 1:05','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (33,'Samsung 8',5,'3/17/2021 6:01','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (34,'Samsung 8',5,'3/17/2021 8:04','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (35,'Samsung 8',5,'3/18/2021 0:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (36,'Samsung 8',5,'3/19/2021 4:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (37,'Samsung 8',5,'4/13/2021 5:07','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (38,'Samsung 8',5,'4/13/2021 9:05','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (39,'Samsung 8',5,'4/14/2021 4:04','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (40,'Samsung 8',5,'4/14/2021 6:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (41,'Samsung 8',5,'4/14/2021 7:07','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (42,'Samsung 8',5,'4/14/2021 9:03','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (43,'Samsung 8',5,'4/17/2021 3:06','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (44,'Samsung 8',5,'4/18/2021 1:06','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (45,'Samsung 8',5,'4/18/2021 9:07','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (46,'Samsung 8',5,'5/10/2021 4:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (47,'Samsung 8',5,'5/13/2021 8:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (48,'Samsung 8',5,'5/15/2021 7:04','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (49,'Samsung 8',5,'5/16/2021 2:07','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (50,'Samsung 8',5,'5/16/2021 2:08','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (51,'Samsung 8',5,'5/16/2021 6:07','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (52,'Samsung 8',5,'5/19/2021 0:04','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (53,'Samsung 8',5,'5/19/2021 0:06','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (54,'Samsung 8',5,'6/10/2021 3:02','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (55,'Samsung 8',5,'6/10/2021 4:02','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (56,'Samsung 8',5,'6/10/2021 4:06','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (57,'Samsung 8',5,'6/12/2021 0:09','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (58,'Samsung 8',5,'6/13/2021 8:08','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (59,'Samsung 8',5,'6/15/2021 7:07','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (60,'Samsung 8',5,'6/16/2021 3:09','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (61,'Samsung 8',5,'6/16/2021 3:09','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (62,'Samsung 8',5,'6/18/2021 1:03','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (63,'Samsung 8',5,'6/18/2021 2:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (64,'Samsung 8',5,'6/18/2021 2:05','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (65,'Samsung 8',5,'6/19/2021 1:09','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (66,'Samsung 8',5,'6/19/2021 2:01','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (67,'Samsung 8',5,'7/10/2021 5:06','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (68,'Samsung 8',5,'7/10/2021 6:01','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (69,'Samsung 8',5,'7/11/2021 9:04','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (70,'Samsung 8',5,'7/13/2021 4:02','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (71,'Samsung 8',5,'7/13/2021 8:06','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (72,'Samsung 8',5,'7/13/2021 9:04','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (73,'Samsung 8',5,'7/15/2021 7:02','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (74,'Samsung 8',5,'7/16/2021 3:07','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (75,'Samsung 8',5,'7/16/2021 9:07','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (76,'Samsung 8',5,'7/19/2021 1:04','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (77,'Samsung 8',5,'7/19/2021 2:04','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (78,'Samsung 8',5,'7/19/2021 4:06','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (79,'Samsung 8',5,'7/19/2021 9:02','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (80,'Samsung 8',5,'7/19/2021 9:06','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (81,'Samsung 8',5,'8/10/2021 3:08','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (82,'Samsung 8',5,'8/11/2021 3:05','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (83,'Samsung 8',5,'8/11/2021 4:01','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (84,'Samsung 8',5,'8/12/2021 0:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (85,'Samsung 8',5,'8/12/2021 9:07','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (86,'Samsung 8',5,'8/14/2021 1:07','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (87,'Samsung 8',5,'8/14/2021 3:05','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (88,'Samsung 8',5,'8/14/2021 7:03','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (89,'Samsung 8',5,'8/14/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (90,'Samsung 8',5,'8/17/2021 3:04','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (91,'Samsung 8',5,'8/17/2021 7:06','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (92,'Samsung 8',5,'8/18/2021 5:05','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (93,'Samsung 8',5,'8/18/2021 6:06','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (94,'Samsung 8',5,'8/18/2021 9:07','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (95,'Samsung 8',5,'9/11/2021 5:06','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (96,'Samsung 8',5,'9/12/2021 2:06','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (97,'Samsung 8',5,'9/14/2021 2:08','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (98,'Samsung 8',5,'9/16/2021 0:03','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (99,'Samsung 8',5,'9/16/2021 4:03','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (100,'Samsung 8',5,'9/16/2021 6:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (1,'Samsung 9',2,'8/14/2021 9:00','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (123,'Samsung 9',2,'8/22/2021 9:00','Bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (122,'Samsung 9',3,'8/22/2021 9:00','Not bad');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (2,'Samsung 9',4,'8/18/2021 9:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (3,'Samsung 9',4,'8/18/2021 9:00','Good!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (4,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (5,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (6,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (7,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (8,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (9,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (10,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (11,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (12,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (13,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (14,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (15,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (16,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (17,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (18,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (19,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (20,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (21,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (22,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (23,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (24,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (25,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (26,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (27,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (28,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (29,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (30,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (31,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (32,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (33,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (34,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (35,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (36,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (37,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (38,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (39,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (40,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (41,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (42,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (43,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (44,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (45,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (46,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (47,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (48,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (49,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (50,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (51,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (52,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (53,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (54,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (55,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (56,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (57,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (58,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (59,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (60,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (61,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (62,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (63,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (64,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (65,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (66,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (67,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (68,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (69,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (70,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (71,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (72,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (73,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (74,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (75,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (76,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (77,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (78,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (79,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (80,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (81,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (82,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (83,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (84,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (85,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (86,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (87,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (88,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (89,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (90,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (91,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (92,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (93,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (94,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (95,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (96,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (97,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (98,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (99,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (100,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (101,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (102,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (103,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (104,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (105,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (106,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (107,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (108,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (109,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (110,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (111,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (112,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (113,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (114,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (115,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (116,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (117,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (118,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (119,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (120,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (121,'Samsung 9',5,'8/18/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (124,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (125,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (126,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (127,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (128,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (129,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (130,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (131,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (132,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (133,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (134,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (135,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (136,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (137,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (138,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (139,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (140,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (141,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (142,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (143,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (144,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (145,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (146,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (147,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (148,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (149,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (150,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (151,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (152,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (153,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (154,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (155,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (156,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (157,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (158,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (159,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (160,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (161,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (162,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (163,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (164,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (165,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (166,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (167,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (168,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (169,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (170,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (171,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (172,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (173,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (174,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (175,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (176,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (177,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (178,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (179,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (180,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (181,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (182,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (183,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (184,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (185,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (186,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (187,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (188,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (189,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (190,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (191,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (192,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (193,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (194,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (195,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (196,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (197,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (198,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (199,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (200,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (201,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (202,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (203,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (204,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (205,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (206,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (207,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (208,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (209,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (210,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (211,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (212,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (213,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (214,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (215,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (216,'Samsung 9',5,'8/22/2021 9:00','Great!');
INSERT INTO Feedbacks(UID,PName,Rating,DateTime,Comment) VALUES (217,'Samsung 9',5,'8/22/2021 9:00','Great!');



-- Orders (OK)
TRUNCATE TABLE [Orders];
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (1, '2021-06-01 18:00:00', '381-389 Sha Tsui Road Young Ya Ind. Bldg 1 C/D, Yau Tsim Mong District, HK, +(852)-24906868');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (2, '2021-06-04 18:00:00', 'Rue du Pont Simon 407, Anvaing, Hainaut, Belgium, +(32)-0481 89 53 56');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (3, '2021-06-05 18:00:00', 'Ollenhauer Str. 72, Stuttgart Ost, Baden-Württemberg, Germany, +(49)-0711-40-50-82');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (3, '2021-06-08 18:00:00', 'Ollenhauer Str. 72, Stuttgart Ost, Baden-Württemberg, Germany, +(49)-0711-40-50-82');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (1, '2021-06-12 18:00:00', '381-389 Sha Tsui Road Young Ya Ind. Bldg 1 C/D, Yau Tsim Mong District, HK, +(852)-24906868');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (4, '2021-06-13 18:00:00', '97-7, Yeongtae ri 3, Wollong-myeon, Paju-si, Gyeonggi-do, KR, +(82)-7-549-6266');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (5, '2021-06-15 18:00:00', '2268 Forest Drive, Mclean, Virginia, United States, +(1)-703-854-6788');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (8, '2021-06-15 18:00:00', 'Rua Maria Jardim 1241 Nilópolis, Rio de Janeiro(RJ), Brazil, 26510-070 (21) 7788-2133');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (10, '2021-06-15 18:00:00', 'Jia Xing Lu 262 Hao Han Kang Men Shi Bu City Area - HongKou District, Shanghai, 200082 13063710342');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (4, '2021-06-16 18:00:00', '97-7, Yeongtae ri 3, Wollong-myeon, Paju-si, Gyeonggi-do, KR, +(82)-7-549-6266');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (5, '2021-06-19 18:00:00', '2268 Forest Drive, Mclean, Virginia, United States, +(1)-703-854-6788');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (6, '2021-06-19 18:00:00', '203 Henderson Road, 10-06 S159547, Singapore +65 6111 0123');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (7, '2021-06-24 18:00:00', 'A 10 Jln Kasawari 8 Taman Eng Ann 41150 41150 Malaysia 41150 Malaysia');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (5, '2021-06-25 18:00:00', '2268 Forest Drive, Mclean, Virginia, United States, +(1)-703-854-6788');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (8, '2021-06-29 18:00:00', 'Rua Maria Jardim 1241 Nilópolis, Rio de Janeiro(RJ), Brazil, 26510-070 (21) 7788-2133');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (9, '2021-06-30 18:00:00', 'Stationsstraat 156 Rijen, Noord-Brabant(NB), 5121 EE 06-38526609');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (6, '2021-07-01 18:00:00', '203 Henderson Road, 10-06 S159547, Singapore +65 6111 0123');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (7, '2021-07-06 18:00:00', 'A 10 Jln Kasawari 8 Taman Eng Ann 41150 41150 Malaysia 41150 Malaysia');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (10, '2021-07-15 18:00:00', 'Jia Xing Lu 262 Hao Han Kang Men Shi Bu City Area - HongKou District, Shanghai, 200082 13063710342');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (7, '2021-07-20 18:00:00', 'A 10 Jln Kasawari 8 Taman Eng Ann 41150 41150 Malaysia 41150 Malaysia');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (2, '2021-07-21 18:00:00', 'Rue du Pont Simon 407, Anvaing, Hainaut, Belgium, +(32)-0481 89 53 56');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (10, '2021-07-22 18:00:00', 'Jia Xing Lu 262 Hao Han Kang Men Shi Bu City Area - HongKou District, Shanghai, 200082 13063710342');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (4, '2021-07-30 18:00:00', '97-7, Yeongtae ri 3, Wollong-myeon, Paju-si, Gyeonggi-do, KR, +(82)-7-549-6266');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (3, '2021-07-31 18:00:00', 'Ollenhauer Str. 72, Stuttgart Ost, Baden-Württemberg, Germany, +(49)-0711-40-50-82');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (2, '2021-08-01 18:00:00', 'Rue du Pont Simon 407, Anvaing, Hainaut, Belgium, +(32)-0481 89 53 56');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (7, '2021-08-01 18:00:00', 'A 10 Jln Kasawari 8 Taman Eng Ann 41150 41150 Malaysia 41150 Malaysia')
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (5, '2021-08-01 18:00:00', '2268 Forest Drive, Mclean, Virginia, United States, +(1)-703-854-6788');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (4, '2021-08-01 18:00:00', '97-7, Yeongtae ri 3, Wollong-myeon, Paju-si, Gyeonggi-do, KR, +(82)-7-549-6266');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (6, '2021-08-02 18:00:00', '203 Henderson Road, 10-06 S159547, Singapore +65 6111 0123');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (9, '2021-08-04 18:00:00', 'Stationsstraat 156 Rijen, Noord-Brabant(NB), 5121 EE 06-38526609');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (3, '2021-08-05 18:00:00', 'Ollenhauer Str. 72, Stuttgart Ost, Baden-Württemberg, Germany, +(49)-0711-40-50-82');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (4, '2021-08-06 18:00:00', '97-7, Yeongtae ri 3, Wollong-myeon, Paju-si, Gyeonggi-do, KR, +(82)-7-549-6266');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (1, '2021-08-09 18:00:00', '381-389 Sha Tsui Road Young Ya Ind. Bldg 1 C/D, Yau Tsim Mong District, HK, +(852)-24906868');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (4, '2021-08-09 18:00:00', '97-7, Yeongtae ri 3, Wollong-myeon, Paju-si, Gyeonggi-do, KR, +(82)-7-549-6266');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (6, '2021-08-09 18:00:00', '203 Henderson Road, 10-06 S159547, Singapore +65 6111 0123');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (5, '2021-08-09 18:00:00', '2268 Forest Drive, Mclean, Virginia, United States, +(1)-703-854-6788');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (1, '2021-08-13 18:00:00', '381-389 Sha Tsui Road Young Ya Ind. Bldg 1 C/D, Yau Tsim Mong District, HK, +(852)-24906868');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (7, '2021-08-15 18:00:00', 'A 10 Jln Kasawari 8 Taman Eng Ann 41150 41150 Malaysia 41150 Malaysia')
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (10, '2021-08-15 18:00:00', 'Jia Xing Lu 262 Hao Han Kang Men Shi Bu City Area - HongKou District, Shanghai, 200082 13063710342');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (5, '2021-08-19 18:00:00', '2268 Forest Drive, Mclean, Virginia, United States, +(1)-703-854-6788');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (5, '2021-08-20 18:00:00', '2268 Forest Drive, Mclean, Virginia, United States, +(1)-703-854-6788');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (10, '2021-08-21 18:00:00', 'Jia Xing Lu 262 Hao Han Kang Men Shi Bu City Area - HongKou District, Shanghai, 200082 13063710342');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (5, '2021-08-22 18:00:00', '2268 Forest Drive, Mclean, Virginia, United States, +(1)-703-854-6788');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (9, '2021-08-22 18:00:00', 'Stationsstraat 156 Rijen, Noord-Brabant(NB), 5121 EE 06-38526609');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (3, '2021-08-24 18:00:00', 'Ollenhauer Str. 72, Stuttgart Ost, Baden-Württemberg, Germany, +(49)-0711-40-50-82');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (7, '2021-08-25 18:00:00', 'A 10 Jln Kasawari 8 Taman Eng Ann 41150 41150 Malaysia 41150 Malaysia')
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (8, '2021-08-28 18:00:00', 'Rua Maria Jardim 1241 Nilópolis, Rio de Janeiro(RJ), Brazil, 26510-070 (21) 7788-2133');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (2, '2021-08-29 18:00:00', 'Rue du Pont Simon 407, Anvaing, Hainaut, Belgium, +(32)-0481 89 53 56');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (3, '2021-08-29 18:00:00', 'Ollenhauer Str. 72, Stuttgart Ost, Baden-Württemberg, Germany, +(49)-0711-40-50-82');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (1, '2021-08-30 18:00:00', '381-389 Sha Tsui Road Young Ya Ind. Bldg 1 C/D, Yau Tsim Mong District, HK, +(852)-24906868');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (3, '2021-08-30 18:00:00', 'Ollenhauer Str. 72, Stuttgart Ost, Baden-Württemberg, Germany, +(49)-0711-40-50-82');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (6, '2021-08-31 18:00:00', '203 Henderson Road, 10-06 S159547, Singapore +65 6111 0123');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (2, '2021-11-30 18:00:00', '381-389 Sha Tsui Road Young Ya Ind. Bldg 1 C/D, Yau Tsim Mong District, HK, +(852)-24906868');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (3, '2021-12-30 18:00:00', 'Ollenhauer Str. 72, Stuttgart Ost, Baden-Württemberg, Germany, +(49)-0711-40-50-82');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (4, '2022-01-31 18:00:00', '203 Henderson Road, 10-06 S159547, Singapore +65 6111 0123');
INSERT Orders (UID, DateTime, ShippingAddress) VALUES (4, '2022-02-25 18:00:00', '203 Henderson Road, 10-06 S159547, Singapore +65 6111 0123');


-- PriceHistory (OK)
TRUNCATE TABLE [PriceHistory];
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P10', 'Cheryl''s Vault', 1302, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P11', 'Cheryl''s Vault', 1350, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P12', 'Cheryl''s Vault', 1371, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P14', 'Cheryl''s Vault', 1583, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P15', 'Cheryl''s Vault', 1771, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P16', 'Cheryl''s Vault', 1521, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P18', 'Cheryl''s Vault', 1602, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone 13', 'Cheryl''s Vault', 1320, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Cheryl''s Vault', 987, '2021-06-01 18:00:00', '2021-06-15 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Cheryl''s Vault', 1204, '2021-06-15 18:00:00', '2021-06-30 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Cheryl''s Vault', 1154, '2021-06-30 18:00:00', '2021-07-05 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Cheryl''s Vault', 924, '2021-07-05 18:00:00', '2021-08-07 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Cheryl''s Vault', 816, '2021-08-07 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 0', 'Cheryl''s Vault', 1562, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 1', 'Cheryl''s Vault', 1707, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 2', 'Cheryl''s Vault', 1555, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 3', 'Cheryl''s Vault', 1261, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 6', 'Cheryl''s Vault', 1473, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 7', 'Cheryl''s Vault', 1413, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P11', 'Daniel and Sons', 1324, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P13', 'Daniel and Sons', 1355, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P15', 'Daniel and Sons', 1523, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P16', 'Daniel and Sons', 1392, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P18', 'Daniel and Sons', 1319, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P19', 'Daniel and Sons', 1716, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone 13', 'Daniel and Sons', 1278, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Daniel and Sons', 1594, '2021-06-01 18:00:00', '2021-06-30 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Daniel and Sons', 1350, '2021-06-30 18:00:00', '2021-07-14 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Daniel and Sons', 1400, '2021-07-14 18:00:00', '2021-07-31 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Daniel and Sons', 1015, '2021-07-31 18:00:00', '2021-08-12 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Daniel and Sons', 1348, '2021-08-12 18:00:00', '2021-08-20 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Daniel and Sons', 1289, '2021-08-20 18:00:00', '2021-08-28 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Daniel and Sons', 1228, '2021-08-28 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 1', 'Daniel and Sons', 1612, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 3', 'Daniel and Sons', 1774, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 4', 'Daniel and Sons', 1565, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 5', 'Daniel and Sons', 1747, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 6', 'Daniel and Sons', 1687, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 7', 'Daniel and Sons', 1659, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 8', 'Daniel and Sons', 1666, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 9', 'Daniel and Sons', 1244, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P10', 'Don Juan''s Stockpile', 1638, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P11', 'Don Juan''s Stockpile', 1762, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P14', 'Don Juan''s Stockpile', 1532, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P15', 'Don Juan''s Stockpile', 1239, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P16', 'Don Juan''s Stockpile', 1602, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P17', 'Don Juan''s Stockpile', 1521, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P19', 'Don Juan''s Stockpile', 1461, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone 13', 'Don Juan''s Stockpile',  1257, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Don Juan''s Stockpile', 1502, '2021-06-01 18:00:00', '2021-06-23 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Don Juan''s Stockpile', 1432, '2021-06-23 18:00:00', '2021-06-29 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Don Juan''s Stockpile', 1345, '2021-06-29 18:00:00', '2021-07-14 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Don Juan''s Stockpile', 1045, '2021-07-14 18:00:00', '2021-08-01 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Don Juan''s Stockpile', 973, '2021-08-01 18:00:00', '2021-08-15 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Don Juan''s Stockpile', 862, '2021-08-15 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 1', 'Don Juan''s Stockpile', 1269, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 2', 'Don Juan''s Stockpile',  1428, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 4', 'Don Juan''s Stockpile', 1502, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 5', 'Don Juan''s Stockpile', 1435, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 7', 'Don Juan''s Stockpile', 1534, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 8', 'Don Juan''s Stockpile', 1750, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 9', 'Don Juan''s Stockpile', 1297, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P11', 'Jerde Inc', 1658, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P12', 'Jerde Inc', 1766, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P16', 'Jerde Inc', 1724, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P18', 'Jerde Inc', 1540, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone 13', 'Jerde Inc', 1785, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Jerde Inc', 1037, '2021-06-01 18:00:00', '2021-06-30 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Jerde Inc', 1152, '2021-06-30 18:00:00', '2021-07-12 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Jerde Inc', 1108, '2021-07-12 18:00:00', '2021-07-31 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Jerde Inc', 1094, '2021-07-31 18:00:00', '2021-08-15 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Jerde Inc', 1037, '2021-08-15 18:00:00', '2021-08-31 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Jerde Inc', 1037, '2021-08-31 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 0', 'Jerde Inc', 1567, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 1', 'Jerde Inc', 1376, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 3', 'Jerde Inc', 1339, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P11', 'Johnny''s Shop', 1422, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P12', 'Johnny''s Shop', 1779, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P14', 'Johnny''s Shop', 1324, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P15', 'Johnny''s Shop', 1333, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P16', 'Johnny''s Shop', 1483, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P17', 'Johnny''s Shop', 1784, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P18', 'Johnny''s Shop', 1567, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P19', 'Johnny''s Shop', 1437, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone 13', 'Johnny''s Shop', 1420, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Johnny''s Shop', 1810, '2021-06-01 18:00:00', '2021-06-30 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Johnny''s Shop', 1400, '2021-06-30 18:00:00', '2021-08-01 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Johnny''s Shop', 1026, '2021-08-01 18:00:00', '2021-08-15 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Johnny''s Shop', 988, '2021-08-15 18:00:00', '2021-08-25 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Johnny''s Shop', 929, '2021-08-25 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 0', 'Johnny''s Shop', 1607, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 2', 'Johnny''s Shop', 1389, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 3', 'Johnny''s Shop', 1596, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 4', 'Johnny''s Shop', 1645, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 5', 'Johnny''s Shop', 1511, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 6', 'Johnny''s Shop', 1538, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 7', 'Johnny''s Shop', 1315, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 8', 'Johnny''s Shop', 1723, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 9', 'Johnny''s Shop', 1672, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P13', 'Kilback Inc', 1664, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P14', 'Kilback Inc', 1372, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P15', 'Kilback Inc', 1445, '2021-06-01 18:00:00', NULL);;
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P16', 'Kilback Inc', 1282, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P17', 'Kilback Inc', 1489, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P18', 'Kilback Inc', 1782, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P19', 'Kilback Inc', 1796, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone 13', 'Kilback Inc', 1708, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Kilback Inc', 1379, '2021-06-01 18:00:00', '2021-07-01 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Kilback Inc', 1279, '2021-07-01 18:00:00', '2021-08-01 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Kilback Inc', 1179, '2021-08-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 1', 'Kilback Inc', 1251, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 2', 'Kilback Inc', 1449, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 3', 'Kilback Inc', 1613, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 4', 'Kilback Inc', 1444, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 6', 'Kilback Inc', 1761, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 7', 'Kilback Inc', 1639, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 8', 'Kilback Inc', 1665, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 9', 'Kilback Inc', 1594, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P10', 'Maggio-Hudson', 1388, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P11', 'Maggio-Hudson', 1321, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P13', 'Maggio-Hudson', 1645, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P14', 'Maggio-Hudson', 1662, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P17', 'Maggio-Hudson', 1252, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P18', 'Maggio-Hudson', 1796, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P19', 'Maggio-Hudson', 1326, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone 13', 'Maggio-Hudson', 1778, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Maggio-Hudson', 1411, '2021-06-01 18:00:00', '2021-08-01 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Maggio-Hudson', 1980, '2021-08-01 18:00:00', '2021-08-05 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Maggio-Hudson', 890, '2021-08-05 18:00:00', '2021-08-15 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Maggio-Hudson', 811, '2021-08-15 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 1', 'Maggio-Hudson', 1442, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 2', 'Maggio-Hudson', 1303, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 4', 'Maggio-Hudson', 1743, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 5', 'Maggio-Hudson', 1688, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P10', 'Mueller Inc', 1245, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P12', 'Mueller Inc', 1540, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P13', 'Mueller Inc', 1601, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P15', 'Mueller Inc', 1437, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P19', 'Mueller Inc', 1777, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone 13', 'Mueller Inc', 1352, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Mueller Inc', 1345, '2021-06-01 18:00:00', '2021-07-01 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Mueller Inc', 1245, '2021-07-01 18:00:00', '2021-08-01 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Mueller Inc', 1045, '2021-08-01 18:00:00', '2021-08-10 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Mueller Inc', 987, '2021-08-10 18:00:00', '2021-08-20 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Mueller Inc', 887, '2021-08-20 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 1', 'Mueller Inc', 1692, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 2', 'Mueller Inc', 1308, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 6', 'Mueller Inc', 1544, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 8', 'Mueller Inc', 1445, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P10', 'Purdy-Mitchell', 1638, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P12', 'Purdy-Mitchell', 1635, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P13', 'Purdy-Mitchell', 1400, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P15', 'Purdy-Mitchell', 1382, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P16', 'Purdy-Mitchell', 1448, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P17', 'Purdy-Mitchell', 1392, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P18', 'Purdy-Mitchell', 1407, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P19', 'Purdy-Mitchell', 1418, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone 13', 'Purdy-Mitchell', 1332, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Purdy-Mitchell', 1077, '2021-06-01 18:00:00', '2021-08-01 18:00:00');
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Purdy-Mitchell', 877, '2021-08-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 0', 'Purdy-Mitchell', 1762, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 1', 'Purdy-Mitchell', 1509, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 2', 'Purdy-Mitchell', 1599, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 3', 'Purdy-Mitchell', 1479, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 4', 'Purdy-Mitchell', 1289, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 5', 'Purdy-Mitchell', 1649, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 6', 'Purdy-Mitchell', 1675, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 7', 'Purdy-Mitchell', 1323, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 8', 'Purdy-Mitchell', 1558, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 9', 'Purdy-Mitchell', 1424, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P10', 'Rinrin''s Store', 1681, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P11', 'Rinrin''s Store', 1690, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P12', 'Rinrin''s Store', 1477, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P13', 'Rinrin''s Store', 1401, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P14', 'Rinrin''s Store', 1413, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P15', 'Rinrin''s Store', 1768, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P16', 'Rinrin''s Store', 1244, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P17', 'Rinrin''s Store', 1380, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P18', 'Rinrin''s Store', 1752, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P19', 'Rinrin''s Store', 1759, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone 13', 'Rinrin''s Store', 1526, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Rinrin''s Store', 1066, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 0', 'Rinrin''s Store', 1712, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 1', 'Rinrin''s Store', 1753, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 2', 'Rinrin''s Store', 1800, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 3', 'Rinrin''s Store', 1306, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 4', 'Rinrin''s Store', 1362, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 5', 'Rinrin''s Store', 1426, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 6', 'Rinrin''s Store', 1344, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 7', 'Rinrin''s Store', 1539, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 8', 'Rinrin''s Store', 1353, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 9', 'Rinrin''s Store', 1387, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P10', 'Thiel and Sons', 1691, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P11', 'Thiel and Sons', 1687, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P12', 'Thiel and Sons', 1509, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P13', 'Thiel and Sons', 1799, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P14', 'Thiel and Sons', 1334, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P15', 'Thiel and Sons', 1681, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P16', 'Thiel and Sons', 1316, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P17', 'Thiel and Sons', 1600, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P18', 'Thiel and Sons', 1636, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P19', 'Thiel and Sons', 1637, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone 13', 'Thiel and Sons', 1549, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Thiel and Sons', 1070, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 0', 'Thiel and Sons', 1321, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 1', 'Thiel and Sons', 1482, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 2', 'Thiel and Sons', 1279, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 3', 'Thiel and Sons', 1331, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 4', 'Thiel and Sons', 1442, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 5', 'Thiel and Sons', 1699, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 6', 'Thiel and Sons', 1257, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 7', 'Thiel and Sons', 1417, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 8', 'Thiel and Sons', 1780, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 9', 'Thiel and Sons', 1565, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P11', 'Turner Group', 1778, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P12', 'Turner Group', 1727, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P15', 'Turner Group', 1274, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P16', 'Turner Group', 1337, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P18', 'Turner Group', 1277, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone 13', 'Turner Group', 1768, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Turner Group', 998, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 0', 'Turner Group', 1458, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 1', 'Turner Group', 1614, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 3', 'Turner Group', 1287, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 4', 'Turner Group', 1596, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 6', 'Turner Group', 1419, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 8', 'Turner Group', 1744, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 9', 'Turner Group', 1453, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P10', 'Weissnat LLC', 1504, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P12', 'Weissnat LLC', 1656, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P14', 'Weissnat LLC', 1669, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P15', 'Weissnat LLC', 1586, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P16', 'Weissnat LLC', 1358, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P17', 'Weissnat LLC', 1704, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P18', 'Weissnat LLC', 1254, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone 13', 'Weissnat LLC', 1627, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Weissnat LLC', 1151, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 0', 'Weissnat LLC', 1273, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 2', 'Weissnat LLC', 1487, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 3', 'Weissnat LLC', 1493, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 4', 'Weissnat LLC', 1722, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 5', 'Weissnat LLC', 1694, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 6', 'Weissnat LLC', 1519, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 8', 'Weissnat LLC', 1766, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 9', 'Weissnat LLC', 1245, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P10', 'Zemlak Group', 1276, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P12', 'Zemlak Group', 1605, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P13', 'Zemlak Group', 1766, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P14', 'Zemlak Group', 1759, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P15', 'Zemlak Group', 1357, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Huawei P16', 'Zemlak Group', 1233, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone 13', 'Zemlak Group', 1254, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('iPhone Xs', 'Zemlak Group', 864, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 0', 'Zemlak Group', 1750, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 1', 'Zemlak Group', 1442, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 3', 'Zemlak Group', 1329, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 4', 'Zemlak Group', 1299, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 6', 'Zemlak Group', 1329, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 7', 'Zemlak Group', 1290, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 8', 'Zemlak Group', 1385, '2021-06-01 18:00:00', NULL);
INSERT PriceHistory (PName, SName, Price, StartDate, EndDate) VALUES ('Samsung 9', 'Zemlak Group', 1202, '2021-06-01 18:00:00', NULL);

-- Products (OK)
TRUNCATE TABLE [Products];
INSERT Products (PName, Maker, Category) VALUES ('Huawei P10','Huawei','Smartphone');
INSERT Products (PName, Maker, Category) VALUES ('Huawei P11','Huawei','Smartphone');
INSERT Products (PName, Maker, Category) VALUES ('Huawei P12','Huawei','Smartphone');
INSERT Products (PName, Maker, Category) VALUES ('Huawei P13','Huawei','Smartphone');
INSERT Products (PName, Maker, Category) VALUES ('Huawei P14','Huawei','Smartphone');
INSERT Products (PName, Maker, Category) VALUES ('Huawei P15','Huawei','Smartphone');
INSERT Products (PName, Maker, Category) VALUES ('Huawei P16','Huawei','Smartphone');
INSERT Products (PName, Maker, Category) VALUES ('Huawei P17','Huawei','Smartphone');
INSERT Products (PName, Maker, Category) VALUES ('Huawei P18','Huawei','Smartphone');
INSERT Products (PName, Maker, Category) VALUES ('Huawei P19','Huawei','Smartphone');
INSERT Products (PName, Maker, Category) VALUES ('iPhone 13','Apple','Smartphone');
INSERT Products (PName, Maker, Category) VALUES ('iPhone Xs','Apple','Smartphone');
INSERT Products (PName, Maker, Category) VALUES ('Samsung 0','Samsung','Smartphone');
INSERT Products (PName, Maker, Category) VALUES ('Samsung 1','Samsung','Smartphone');
INSERT Products (PName, Maker, Category) VALUES ('Samsung 2','Samsung','Smartphone');
INSERT Products (PName, Maker, Category) VALUES ('Samsung 3','Samsung','Smartphone');
INSERT Products (PName, Maker, Category) VALUES ('Samsung 4','Samsung','Smartphone');
INSERT Products (PName, Maker, Category) VALUES ('Samsung 5','Samsung','Smartphone');
INSERT Products (PName, Maker, Category) VALUES ('Samsung 6','Samsung','Smartphone');
INSERT Products (PName, Maker, Category) VALUES ('Samsung 7','Samsung','Smartphone');
INSERT Products (PName, Maker, Category) VALUES ('Samsung 8','Samsung','Smartphone');
INSERT Products (PName, Maker, Category) VALUES ('Samsung 9','Samsung','Smartphone');


-- Products In Orders
TRUNCATE TABLE [ProductsInOrders];
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Huawei P10', 'Cheryl''s Vault', 1, 'Delivered', '2021-06-07 13:00:00', 1302, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('iPhone 13', 'Daniel and Sons', 2, 'Delivered', '2021-06-07 13:00:00', 1278, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 0', 'Jerde Inc', 2, 'Delivered', '2021-06-09 13:00:00', 1567, 12);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Huawei P14', 'Don Juan''s Stockpile', 3, 'Delivered', '2021-06-30 13:00:00', 1532, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Huawei P14', 'Kilback Inc', 4, 'Delivered', '2021-06-15 13:00:00', 1372, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Huawei P10', 'Cheryl''s Vault', 5, 'Delivered', '2021-06-18 13:00:00', 1302, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Huawei P17', 'Maggio-Hudson', 6, 'Delivered', '2021-06-20 13:00:00', 1252, 2);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 5', 'Maggio-Hudson', 6, 'Delivered', '2021-06-20 13:00:00', 1688, 2);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('iPhone 13', 'Weissnat LLC', 7, 'Delivered', '2021-06-25 13:00:00', 1627, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 9', 'Johnny''s Shop', 8, 'Delivered', '2021-06-18 13:00:00', 1672, 2);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('iPhone 13', 'Purdy-Mitchell', 9, 'Delivered', '2021-06-28 13:00:00', 1332, 2);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 7', 'Purdy-Mitchell', 9, 'Delivered', '2021-06-28 13:00:00', 1323, 2);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 9', 'Rinrin''s Store', 9, 'Delivered', '2021-06-21 13:00:00', 1690, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('iPhone X', 'Zemlak Group', 10, 'Delivered', '2021-06-26 13:00:00', 1202, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('iPhone Xs', 'Cheryl''s Vault', 11, 'Delivered', '2021-06-30 13:00:00', 1204, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('iPhone Xs', 'Cheryl''s Vault', 12, 'Delivered', '2021-06-30 13:00:00', 1204, 3);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 4', 'Daniel and Sons', 13, 'Delivered', '2021-07-01 13:00:00', 1565, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 4', 'Johnny''s Shop', 13, 'Delivered', '2021-06-30 13:00:00', 1645, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 4', 'Johnny''s Shop', 14, 'Delivered', '2021-06-30 13:00:00', 1645, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Huawei P10', 'Mueller Inc', 14, 'Delivered', '2021-07-05 13:00:00', 1245, 10);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Huawei P12', 'Mueller Inc', 14, 'Delivered', '2021-07-05 13:00:00', 1540, 10);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('iPhone 13', 'Mueller Inc', 14, 'Delivered', '2021-07-05 13:00:00', 1352, 10);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 6', 'Thiel and Sons', 15, 'Delivered', '2021-07-06 13:00:00', 1257, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Huawei P15', 'Turner Group', 16, 'Delivered', '2021-07-09 13:00:00', 1274, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Huawei P15', 'Turner Group', 17, 'Delivered', '2021-07-12 13:00:00', 1274, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('iPhone 13', 'Weissnat LLC', 18, 'Delivered', '2021-07-20 13:00:00', 1627, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Huawei P15', 'Zemlak Group', 19, 'Delivered', '2021-07-24 13:00:00', 1357, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 7', 'Purdy-Mitchell', 20, 'Delivered', '2021-07-28 13:00:00', 1323, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 9', 'Zemlak Group', 21, 'Delivered', '2021-08-08 13:00:00', 1202, 10);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 8', 'Zemlak Group', 21, 'Delivered', '2021-08-08 13:00:00', 1385, 10);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 7', 'Zemlak Group', 21, 'Delivered', '2021-08-08 13:00:00', 1290, 10);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 5', 'Weissnat LLC', 21, 'Delivered', '2021-08-10 13:00:00', 1694, 10);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 2', 'Weissnat LLC', 21, 'Delivered', '2021-08-10 13:00:00', 1487, 10);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('iPhone 13', 'Weissnat LLC', 22, 'Delivered', '2021-07-28 13:00:00', 1627, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 3', 'Rinrin''s Store', 23, 'Delivered', '2021-08-05 13:00:00', 1306, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 3', 'Rinrin''s Store', 24, 'Delivered', '2021-08-05 13:00:00', 1306, 3);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 3', 'Rinrin''s Store', 25, 'Delivered', '2021-08-06 13:00:00', 1306, 2);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 1', 'Daniel and Sons', 26, 'Delivered', '2021-08-11 13:00:00', 1612, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Huawei P11', 'Jerde Inc', 26, 'Delivered', '2021-08-07 13:00:00', 1658, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Huawei P16', 'Jerde Inc', 26, 'Delivered', '2021-08-07 13:00:00', 1724, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Huawei P11', 'Jerde Inc', 27, 'Delivered', '2021-08-07 13:00:00', 1658, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 5', 'Thiel and Sons', 28, 'Delivered', '2021-08-05 13:00:00', 1699, 2);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 5', 'Thiel and Sons', 29, 'Delivered', '2021-08-14 13:00:00', 1699, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 5', 'Thiel and Sons', 30, 'Delivered', '2021-08-14 13:00:00', 1699, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 7', 'Thiel and Sons', 30, 'Delivered', '2021-08-14 13:00:00', 1417, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Huawei P16', 'Weissnat LLC', 31, 'Delivered', '2021-08-15 13:00:00', 1358, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('iPhone 13', 'Zemlak Group', 31, 'Shipped', '2021-09-30 13:00:00', 1254, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 9', 'Purdy-Mitchell', 32, 'Delivered', '2021-08-15 13:00:00', 1424, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Huawei P19', 'Mueller Inc', 33, 'Delivered', '2021-08-21 13:00:00', 1777, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Huawei P12', 'Mueller Inc', 33, 'Delivered', '2021-08-21 13:00:00', 1540, 2);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Huawei P19', 'Mueller Inc', 34, 'Delivered', '2021-08-21 13:00:00', 1777, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Huawei P14', 'Kilback Inc', 35, 'Delivered', '2021-08-18 13:00:00', 1372, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('iPhone 13', 'Jerde Inc', 36, 'Delivered', '2021-08-18 13:00:00', 1785, 5);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('iPhone 13', 'Rinrin''s Store', 37, 'Delivered', '2021-08-25 13:00:00', 1526, 2);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 0', 'Rinrin''s Store', 38, 'Delivered', '2021-08-25 13:00:00', 1712, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 2', 'Rinrin''s Store', 38, 'Delivered', '2021-08-25 13:00:00', 1800, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 1', 'Cheryl''s Vault', 39, 'Delivered', '2021-08-25 13:00:00', 1707, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Huawei P19', 'Daniel and Sons', 40, 'Shipped', '2021-08-02 13:00:00', 1716, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 8', 'Turner Group', 41, 'Shipped', '2021-09-04 13:00:00', 1744, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Huawei P13', 'Purdy-Mitchell', 42, 'Shipped', '2021-09-04 13:00:00', 1400, 2);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 6', 'Mueller Inc', 43, 'Shipped', '2021-09-15 13:00:00', 1544, 2);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('iPhone Xs', 'Mueller Inc', 44, 'Shipped', '2021-09-15 13:00:00', 887, 18);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 1', 'Maggio-Hudson', 45, 'Shipped', '2021-09-08 13:00:00', 1442, 13);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 2', 'Maggio-Hudson', 45, 'Shipped', '2021-09-08 13:00:00', 1303, 21);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 4', 'Maggio-Hudson', 45, 'Shipped', '2021-09-08 13:00:00', 1743, 15);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 5', 'Maggio-Hudson', 45, 'Shipped', '2021-09-08 13:00:00', 1688, 9);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Huawei P14', 'Maggio-Hudson', 46, 'Being Processed', NULL, 1662, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('iPhone Xs', 'Johnny''s Shop', 47, 'Being Processed', NULL, 929, 4);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('iPhone 13', 'Jerde Inc', 48, 'Being Processed', NULL, 1785, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('iPhone 13', 'Jerde Inc', 49, 'Being Processed', NULL, 1785, 3);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Huawei P17', 'Jerde Inc', 50, 'Being Processed', NULL, 1521, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 2', 'Daniel and Sons', 50, 'Shipped', '2021-09-05 13:00:00', 1521, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 7', 'Cheryl''s Vault', 51, 'Shipped', '2021-09-08 13:00:00', 1555, 1);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('iPhone Xs', 'Johnny''s Shop', 52, 'Being Processed', NULL, 929, 5);
	-- Added 6 new records, to test query 9: for consective 3 months, NOV DEC JAN & DEC JAN FEB
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 2', 'Daniel and Sons', 53, 'Shipped', '2021-09-05 13:00:00', 1521, 10);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 2', 'Cheryl''s Vault', 54, 'Shipped', '2021-09-08 13:00:00', 1555, 20);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Samsung 2', 'Johnny''s Shop', 55, 'Being Processed', NULL, 929, 30);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Huawei P17', 'Daniel and Sons', 54, 'Shipped', '2021-09-05 13:00:00', 1521, 10);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Huawei P17', 'Cheryl''s Vault', 55, 'Shipped', '2021-09-08 13:00:00', 1555, 20);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('Huawei P17', 'Johnny''s Shop', 56, 'Being Processed', NULL, 929, 30);
	-- Added 4 new records, to test query 8: find the products that have never been purchased by some users, 
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('iPhone 13', 'Purdy-Mitchell', 10, 'Delivered', '2021-08-28 13:00:00', 1332, 2);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('iPhone 13', 'Purdy-Mitchell', 15, 'Delivered', '2021-08-28 13:00:00', 1332, 2);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('iPhone 13', 'Purdy-Mitchell', 16, 'Delivered', '2021-08-28 13:00:00', 1332, 2);
INSERT ProductsInOrders(PName, SName, OID, Status, DeliveryDate, OPrice, OQuantity) VALUES ('iPhone 13', 'Purdy-Mitchell', 17, 'Delivered', '2021-08-28 13:00:00', 1332, 2);

-- Products In Shops (OK)
TRUNCATE TABLE [ProductsInShops];
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P10', 'Cheryl''s Vault', 'CHR040', 1302,44);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P11', 'Cheryl''s Vault', 'CHR034', 1350,51);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P12', 'Cheryl''s Vault', 'CHR033', 1371,25);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P14', 'Cheryl''s Vault', 'CHR036', 1583,18);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P15', 'Cheryl''s Vault', 'CHR043', 1771,8);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P16', 'Cheryl''s Vault', 'CHR035', 1521,44);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P18', 'Cheryl''s Vault', 'CHR032', 1602,83);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('iPhone 13', 'Cheryl''s Vault', 'CHR031', 1320,70);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('iPhone Xs', 'Cheryl''s Vault', 'CHR055', 816,85);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 0', 'Cheryl''s Vault', 'CHR018', 1562,22);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 1', 'Cheryl''s Vault', 'CHR012', 1707,64);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 2', 'Cheryl''s Vault', 'CHR011', 1555,87);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 3', 'Cheryl''s Vault', 'CHR015', 1261,75);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 6', 'Cheryl''s Vault', 'CHR017', 1473,35);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 7', 'Cheryl''s Vault', 'CHR013', 1413,41);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P11', 'Daniel and Sons', 'DAS023', 1324,77);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P13', 'Daniel and Sons', 'DAS024', 1355,48);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P15', 'Daniel and Sons', 'DAS025', 1523,100);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P16', 'Daniel and Sons', 'DAS032', 1392,92);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P18', 'Daniel and Sons', 'DAS031', 1319,61);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P19', 'Daniel and Sons', 'DAS033', 1716,60);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('iPhone 13', 'Daniel and Sons', 'DAS022', 1278,3);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('iPhone Xs', 'Daniel and Sons', 'DAS044', 1228,33);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 1', 'Daniel and Sons', 'DAS006', 1612,74);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 3', 'Daniel and Sons', 'DAS003', 1774,95);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 4', 'Daniel and Sons', 'DAS011', 1565,4);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 5', 'Daniel and Sons', 'DAS002', 1747,35);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 6', 'Daniel and Sons', 'DAS010', 1687,51);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 7', 'Daniel and Sons', 'DAS004', 1659,79);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 8', 'Daniel and Sons', 'DAS007', 1666,51);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 9', 'Daniel and Sons', 'DAS001', 1244,34);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P10', 'Don Juan''s Stockpile', 'JOJO320', 1638,99);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P11', 'Don Juan''s Stockpile', 'JOJO328', 1762,89);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P14', 'Don Juan''s Stockpile', 'JOJO323', 1532,66);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P15', 'Don Juan''s Stockpile', 'JOJO326', 1239,71);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P16', 'Don Juan''s Stockpile', 'JOJO324', 1602,36);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P17', 'Don Juan''s Stockpile', 'JOJO321', 1521,36);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P19', 'Don Juan''s Stockpile', 'JOJO325', 1461,74);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('iPhone 13', 'Don Juan''s Stockpile', 'JOJO319', 1257,35);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('iPhone Xs', 'Don Juan''s Stockpile', 'JOJO339', 862,25);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 1', 'Don Juan''s Stockpile', 'JOJO301', 1269,26);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 2', 'Don Juan''s Stockpile', 'JOJO306', 1428,6);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 4', 'Don Juan''s Stockpile', 'JOJO302', 1502,42);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 5', 'Don Juan''s Stockpile', 'JOJO309', 1435,27);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 7', 'Don Juan''s Stockpile', 'JOJO305', 1534,32);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 8', 'Don Juan''s Stockpile', 'JOJO304', 1750,59);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 9', 'Don Juan''s Stockpile', 'JOJO300', 1297,47);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P11', 'Jerde Inc', 'JIC013', 1658,99);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P12', 'Jerde Inc', 'JIC011', 1766,81);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P16', 'Jerde Inc', 'JIC012', 1724,59);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P18', 'Jerde Inc', 'JIC014', 1540,13);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('iPhone 13', 'Jerde Inc', 'JIC010', 1785,93);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('iPhone Xs', 'Jerde Inc', 'JIC020', 1037,42);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 0', 'Jerde Inc', 'JIC001', 1567,99);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 1', 'Jerde Inc', 'JIC003', 1376,30);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 3', 'Jerde Inc', 'JIC004', 1339,22);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P11', 'Johnny''s Shop', 'SAS058', 1422,55);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P12', 'Johnny''s Shop', 'SAS067', 1779,71);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P14', 'Johnny''s Shop', 'SAS055', 1324,13);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P15', 'Johnny''s Shop', 'SAS053', 1333,65);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P16', 'Johnny''s Shop', 'SAS069', 1483,79);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P17', 'Johnny''s Shop', 'SAS052', 1784,51);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P18', 'Johnny''s Shop', 'SAS054', 1567,71);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P19', 'Johnny''s Shop', 'SAS071', 1437,5);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('iPhone 13', 'Johnny''s Shop', 'SAS049', 1420,99);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('iPhone Xs', 'Johnny''s Shop', 'SAS095', 929,74);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 0', 'Johnny''s Shop', 'SAS004', 1607,89);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 2', 'Johnny''s Shop', 'SAS021', 1389,48);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 3', 'Johnny''s Shop', 'SAS009', 1596,61);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 4', 'Johnny''s Shop', 'SAS024', 1645,60);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 5', 'Johnny''s Shop', 'SAS013', 1511,32);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 6', 'Johnny''s Shop', 'SAS023', 1538,87);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 7', 'Johnny''s Shop', 'SAS010', 1315,88);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 8', 'Johnny''s Shop', 'SAS014', 1723,2);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 9', 'Johnny''s Shop', 'SAS008', 1672,57);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P13', 'Kilback Inc', 'KIC037', 1664,74);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P14', 'Kilback Inc', 'KIC039', 1372,17);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P15', 'Kilback Inc', 'KIC038', 1445,8);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P16', 'Kilback Inc', 'KIC029', 1282,47);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P17', 'Kilback Inc', 'KIC027', 1489,31);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P18', 'Kilback Inc', 'KIC031', 1782,59);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P19', 'Kilback Inc', 'KIC035', 1796,8);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('iPhone 13', 'Kilback Inc', 'KIC026', 1708,12);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('iPhone Xs', 'Kilback Inc', 'KIC040', 1179,76);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 1', 'Kilback Inc', 'KIC011', 1251,11);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 2', 'Kilback Inc', 'KIC012', 1449,44);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 3', 'Kilback Inc', 'KIC003', 1613,62);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 4', 'Kilback Inc', 'KIC008', 1444,69);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 6', 'Kilback Inc', 'KIC001', 1761,5);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 7', 'Kilback Inc', 'KIC009', 1639,49);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 8', 'Kilback Inc', 'KIC005', 1665,9);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 9', 'Kilback Inc', 'KIC004', 1594,23);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P10', 'Maggio-Hudson', 'MHW021', 1388,87);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P11', 'Maggio-Hudson', 'MHW019', 1321,62);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P13', 'Maggio-Hudson', 'MHW024', 1645,89);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P14', 'Maggio-Hudson', 'MHW023', 1662,98);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P17', 'Maggio-Hudson', 'MHW020', 1252,26);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P18', 'Maggio-Hudson', 'MHW022', 1796,75);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P19', 'Maggio-Hudson', 'MHW018', 1326,28);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('iPhone 13', 'Maggio-Hudson', 'MHW016', 1778,64);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('iPhone Xs', 'Maggio-Hudson', 'MHW025', 811,94);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 1', 'Maggio-Hudson', 'MHW008', 1442,65);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 2', 'Maggio-Hudson', 'MHW001', 1303,2);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 4', 'Maggio-Hudson', 'MHW003', 1743,55);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 5', 'Maggio-Hudson', 'MHW005', 1688,47);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P10', 'Mueller Inc', 'MIC018', 1245,36);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P12', 'Mueller Inc', 'MIC017', 1540,38);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P13', 'Mueller Inc', 'MIC021', 1601,99);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P15', 'Mueller Inc', 'MIC019', 1437,65);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P19', 'Mueller Inc', 'MIC016', 1777,9);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('iPhone 13', 'Mueller Inc', 'MIC008', 1352,96);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('iPhone Xs', 'Mueller Inc', 'MIC028', 887,54);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 1', 'Mueller Inc', 'MIC005', 1692,63);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 2', 'Mueller Inc', 'MIC007', 1308,77);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 6', 'Mueller Inc', 'MIC003', 1544,74);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 8', 'Mueller Inc', 'MIC002', 1445,82);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P10', 'Purdy-Mitchell', 'PMS035', 1638,75);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P12', 'Purdy-Mitchell', 'PMS041', 1635,9);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P13', 'Purdy-Mitchell', 'PMS032', 1400,67);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P15', 'Purdy-Mitchell', 'PMS040', 1382,50);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P16', 'Purdy-Mitchell', 'PMS042', 1448,52);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P17', 'Purdy-Mitchell', 'PMS036', 1392,33);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P18', 'Purdy-Mitchell', 'PMS034', 1407,49);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P19', 'Purdy-Mitchell', 'PMS039', 1418,17);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('iPhone 13', 'Purdy-Mitchell', 'PMS015', 1332,99);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('iPhone Xs', 'Purdy-Mitchell', 'PMS056', 877,49);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 0', 'Purdy-Mitchell', 'PMS005', 1762,70);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 1', 'Purdy-Mitchell', 'PMS009', 1509,83);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 2', 'Purdy-Mitchell', 'PMS011', 1599,27);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 3', 'Purdy-Mitchell', 'PMS007', 1479,56);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 4', 'Purdy-Mitchell', 'PMS013', 1289,29);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 5', 'Purdy-Mitchell', 'PMS002', 1649,22);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 6', 'Purdy-Mitchell', 'PMS012', 1675,99);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 7', 'Purdy-Mitchell', 'PMS014', 1323,76);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 8', 'Purdy-Mitchell', 'PMS001', 1558,55);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 9', 'Purdy-Mitchell', 'PMS003', 1424,48);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P10', 'Rinrin''s Store', 'RIRI076', 1681,73);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P11', 'Rinrin''s Store', 'RIRI086', 1690,62);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P12', 'Rinrin''s Store', 'RIRI071', 1477,65);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P13', 'Rinrin''s Store', 'RIRI098', 1401,43);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P14', 'Rinrin''s Store', 'RIRI073', 1413,61);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P15', 'Rinrin''s Store', 'RIRI077', 1768,32);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P16', 'Rinrin''s Store', 'RIRI068', 1244,63);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P17', 'Rinrin''s Store', 'RIRI093', 1380,16);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P18', 'Rinrin''s Store', 'RIRI069', 1752,61);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P19', 'Rinrin''s Store', 'RIRI082', 1759,89);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('iPhone 13', 'Rinrin''s Store', 'RIRI037', 1526,72);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('iPhone Xs', 'Rinrin''s Store', 'RIRI128', 1066,100);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 0', 'Rinrin''s Store', 'RIRI023', 1712,17);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 1', 'Rinrin''s Store', 'RIRI020', 1753,62);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 2', 'Rinrin''s Store', 'RIRI029', 1800,41);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 3', 'Rinrin''s Store', 'RIRI021', 1306,85);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 4', 'Rinrin''s Store', 'RIRI027', 1362,67);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 5', 'Rinrin''s Store', 'RIRI036', 1426,96);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 6', 'Rinrin''s Store', 'RIRI012', 1344,41);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 7', 'Rinrin''s Store', 'RIRI008', 1539,84);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 8', 'Rinrin''s Store', 'RIRI034', 1353,8);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 9', 'Rinrin''s Store', 'RIRI024', 1387,30);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P10', 'Thiel and Sons', 'TAS055', 1691,91);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P11', 'Thiel and Sons', 'TAS060', 1687,84);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P12', 'Thiel and Sons', 'TAS066', 1509,96);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P13', 'Thiel and Sons', 'TAS065', 1799,66);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P14', 'Thiel and Sons', 'TAS057', 1334,97);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P15', 'Thiel and Sons', 'TAS070', 1681,17);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P16', 'Thiel and Sons', 'TAS059', 1316,95);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P17', 'Thiel and Sons', 'TAS072', 1600,69);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P18', 'Thiel and Sons', 'TAS063', 1636,84);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P19', 'Thiel and Sons', 'TAS062', 1637,25);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('iPhone 13', 'Thiel and Sons', 'TAS052', 1549,41);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('iPhone Xs', 'Thiel and Sons', 'TAS079', 1070,48);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 0', 'Thiel and Sons', 'TAS020', 1321,80);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 1', 'Thiel and Sons', 'TAS001', 1482,23);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 2', 'Thiel and Sons', 'TAS018', 1279,79);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 3', 'Thiel and Sons', 'TAS013', 1331,17);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 4', 'Thiel and Sons', 'TAS026', 1442,66);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 5', 'Thiel and Sons', 'TAS004', 1699,46);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 6', 'Thiel and Sons', 'TAS022', 1257,68);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 7', 'Thiel and Sons', 'TAS002', 1417,60);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 8', 'Thiel and Sons', 'TAS025', 1780,52);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 9', 'Thiel and Sons', 'TAS011', 1565,78);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P11', 'Turner Group', 'TGP032', 1778,42);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P12', 'Turner Group', 'TGP025', 1727,84);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P15', 'Turner Group', 'TGP030', 1274,43);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P16', 'Turner Group', 'TGP023', 1337,67);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P18', 'Turner Group', 'TGP029', 1277,54);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('iPhone 13', 'Turner Group', 'TGP012', 1768,33);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('iPhone Xs', 'Turner Group', 'TGP044', 998,37);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 0', 'Turner Group', 'TGP011', 1458,51);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 1', 'Turner Group', 'TGP008', 1614,65);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 3', 'Turner Group', 'TGP010', 1287,33);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 4', 'Turner Group', 'TGP005', 1596,18);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 6', 'Turner Group', 'TGP004', 1419,14);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 8', 'Turner Group', 'TGP006', 1744,70);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 9', 'Turner Group', 'TGP009', 1453,39);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P10', 'Weissnat LLC', 'WLC033', 1504,38);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P12', 'Weissnat LLC', 'WLC042', 1656,1);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P14', 'Weissnat LLC', 'WLC038', 1669,83);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P15', 'Weissnat LLC', 'WLC044', 1586,51);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P16', 'Weissnat LLC', 'WLC034', 1358,22);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P17', 'Weissnat LLC', 'WLC036', 1704,37);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P18', 'Weissnat LLC', 'WLC040', 1254,10);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('iPhone 13', 'Weissnat LLC', 'WLC016', 1627,48);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('iPhone Xs', 'Weissnat LLC', 'WLC060', 1151,44);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 0', 'Weissnat LLC', 'WLC007', 1273,97);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 2', 'Weissnat LLC', 'WLC008', 1487,49);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 3', 'Weissnat LLC', 'WLC010', 1493,79);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 4', 'Weissnat LLC', 'WLC012', 1722,43);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 5', 'Weissnat LLC', 'WLC003', 1694,81);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 6', 'Weissnat LLC', 'WLC014', 1519,21);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 8', 'Weissnat LLC', 'WLC002', 1766,51);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 9', 'Weissnat LLC', 'WLC009', 1245,59);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P10', 'Zemlak Group', 'ZGP030', 1276,13);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P12', 'Zemlak Group', 'ZGP036', 1605,19);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P13', 'Zemlak Group', 'ZGP037', 1766,15);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P14', 'Zemlak Group', 'ZGP032', 1759,77);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P15', 'Zemlak Group', 'ZGP031', 1357,52);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Huawei P16', 'Zemlak Group', 'ZGP042', 1233,19);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('iPhone 13', 'Zemlak Group', 'ZGP015', 1254,25);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('iPhone Xs', 'Zemlak Group', 'ZGP056', 864,93);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 0', 'Zemlak Group', 'ZGP002', 1750,62);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 1', 'Zemlak Group', 'ZGP009', 1442,39);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 3', 'Zemlak Group', 'ZGP013', 1329,82);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 4', 'Zemlak Group', 'ZGP011', 1299,33);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 6', 'Zemlak Group', 'ZGP005', 1329,43);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 7', 'Zemlak Group', 'ZGP008', 1290,41);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 8', 'Zemlak Group', 'ZGP001', 1385,61);
INSERT ProductsInShops(PName, SName, SPID, SPrice, SQuantity) VALUES ('Samsung 9', 'Zemlak Group', 'ZGP004', 1202,21);


-- Shops (OK)
TRUNCATE TABLE [Shops];
INSERT Shops (SName) VALUES ('Maggio-Hudson');
INSERT Shops (SName) VALUES ('Weissnat LLC');
INSERT Shops (SName) VALUES ('Turner Group');
INSERT Shops (SName) VALUES ('Daniel and Sons');
INSERT Shops (SName) VALUES ('Zemlak Group');
INSERT Shops (SName) VALUES ('Purdy-Mitchell');
INSERT Shops (SName) VALUES ('Jerde Inc');
INSERT Shops (SName) VALUES ('Kilback Inc');
INSERT Shops (SName) VALUES ('Mueller Inc');
INSERT Shops (SName) VALUES ('Thiel and Sons');
INSERT Shops (SName) VALUES ('Rinrin''s Store');
INSERT Shops (SName) VALUES ('Johnny''s Shop');
INSERT Shops (SName) VALUES ('Don Juan''s Stockpile');
INSERT Shops (SName) VALUES ('Cheryl''s Vault');

-- Users (OK)
TRUNCATE TABLE [Users];
INSERT INTO Users(UName) VALUES ('Zante1999');
INSERT INTO Users(UName) VALUES ('Paige Florence');
INSERT INTO Users(UName) VALUES ('CloverGarlic');
INSERT INTO Users(UName) VALUES ('ILuvJHope');
INSERT INTO Users(UName) VALUES ('3na#7567');
INSERT INTO Users(UName) VALUES ('Rigel Grimes');
INSERT INTO Users(UName) VALUES ('Elaine Lang');
INSERT INTO Users(UName) VALUES ('Vincent Stanton');
INSERT INTO Users(UName) VALUES ('Ginger Guerrero');
INSERT INTO Users(UName) VALUES ('Rhonda Brady');

-- END --