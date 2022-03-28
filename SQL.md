--SQL is not case sensetive

/\_

SELECT - extracts data from a database

UPDATE - updates data in a database

DELETE - deletes data from a database

INSERT INTO - inserts new data into a database

CREATE DATABASE - creates a new database

ALTER DATABASE - modifies a database

CREATE TABLE - creates a new table

ALTER TABLE - modifies a table

DROP TABLE - deletes a table

CREATE INDEX - creates an index (search key)

DROP INDEX - deletes an index

\_/

```sql
SELECT Phone FROM Shippers; -- get all data from a column names "Phone" of Shippers table
SELECT DISTINCT Phone FROM Shippers; -- get all unique columns with data from "Phone" of Shippers table
SELECT * FROM Shippers; -- get all columns from Shippers table


SELECT Country FROM Customers WHERE Country="Mexico" AND Name="Hunaima"
    -- using where we can filter the data putting a condition
    -- condition can be multiple using AND,OR,NOT operator
    
```
