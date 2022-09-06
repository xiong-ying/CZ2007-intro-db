# CZ2007 Introduction To Databases - Lab

## Topic
a. Construct an entity-relationship model at a conceptual level.<br/>
b. Map the model into a schema of a relational DBMS.<br/>
c. Implement the given schema on a relational DBMS.<br/>
d. Use a database language (SQL) to retrieval data from a relational DBMS.

## Tool
MS SQl

## Directory
Table Creation - create the schema and database <br/>
Queries - 11 SQL queries


## Relational Schema
Complaints (<ins>ID</ins>, UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime)
ComplaintsOnOrders (<ins>ComplaintsID</ins>, <ins>OID)
ComplaintOnShops (<ins>SName</ins>, <ins>ComplaintsID</ins>)
Employees (<ins>ID</ins>, Name, Salary)
Feedbacks (<ins>UID</ins>, <ins>PName</ins>, Rating, DateTime, Comment)
Orders (<ins>OID</ins>, UID, DateTime, ShippingAddress)
PriceHistory (<ins>PName</ins>, <ins>SName</ins>, Price, StartDate, EndDate)
Products (<ins>PName</ins>, Maker, Category)
ProductsInOrders (<ins>PName</ins>, <ins>SName</ins>, <ins>OID</ins>, Status, DeliveryDate, OPrice, OQuantiy)
ProductsInShops (<ins>PName</ins>, <ins>SName</ins>, SPID, SPrice, SQuantiy,)
SHOPS (<ins>SName</ins>)
USERS (<ins>UID</ins>, UName)
