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
Complaints (<ins>ID</ins>, UID, EmployeeID, Status, Text, FiledDateTime, HandledDateTime)<br/>
ComplaintsOnOrders (<ins>ComplaintsID</ins>, <ins>OID</ins>)<br/>
ComplaintOnShops (<ins>SName</ins>, <ins>ComplaintsID</ins>)<br/>
Employees (<ins>ID</ins>, Name, Salary)<br/>
Feedbacks (<ins>UID</ins>, <ins>PName</ins>, Rating, DateTime, Comment)<br/>
Orders (<ins>OID</ins>, UID, DateTime, ShippingAddress)<br/>
PriceHistory (<ins>PName</ins>, <ins>SName</ins>, Price, StartDate, EndDate)<br/>
Products (<ins>PName</ins>, Maker, Category)<br/>
ProductsInOrders (<ins>PName</ins>, <ins>SName</ins>, <ins>OID</ins>, Status, DeliveryDate, OPrice, OQuantiy)<br/>
ProductsInShops (<ins>PName</ins>, <ins>SName</ins>, SPID, SPrice, SQuantiy,)<br/>
SHOPS (<ins>SName</ins>)<br/>
USERS (<ins>UID</ins>, UName)
