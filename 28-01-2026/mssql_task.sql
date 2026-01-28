CREATE DATABASE PRODUCT_DB;

CREATE TABLE Train(
order_id INT PRIMARY KEY,
order_date DATE ,
ship_date DATE ,
ship_mode VARCHAR(20) ,
customer_id VARCHAR(20),
segment VARCHAR(20) ,
country VARCHAR(20),
city VARCHAR(20),
state VARCHAR(20),
postal_code INT ,
region VARCHAR(20) ,
product_id VARCHAR(20),
category VARCHAR(20) ,
sub_category VARCHAR(20) ,
product_name VARCHAR(20),
sales INT );

BULK INSERT orders
FROM 'train.csv'
WITH
( FIRSTROW = 2,
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',   
    TABLOCK);

select * from train;

--1 Write a query to fetch all orders where sales are greater than the overall average sales. 
SELECT  ORDER_ID,PRODUCT_NAME,SALES
FROM TRAIN
WHERE SALES > (SELECT AVG(SALES)
               FROM TRAIN);

--2 Write a query to retrieve the top 5 cities by total sales, ordered from highest to lowest. 
SELECT TOP 5 CITY, SUM(SALES)AS TOTAL_SALES
FROM DBO.TRAIN
GROUP BY CITY
ORDER BY SUM(SALES) DESC;

--3 Write a query to find customers who have placed more than 5 orders, along with their total sales. 
SELECT CUSTOMER_ID,COUNT(ORDER_ID) AS CUST_ORDERS_COUNT
FROM TRAIN
GROUP BY CUSTOMER_ID
HAVING COUNT(ORDER_ID) > 5;

--4 Write a query to calculate total sales and total number of orders for each segment, sorted by total sales. 
SELECT SUM(SALES) AS TOTAL_SALES,COUNT(SALES) AS NO_OF_ORDERS
FROM TRAIN 
GROUP BY SEGMENT
ORDER BY SUM(SALES);

--5 Write a query to identify orders where the shipping duration exceeds 4 days (Ship_Date minus Order_Date greater than 4).

SELECT ORDER_ID , SHIP_DATE,ORDER_DATE
FROM TRAIN
WHERE DAY(SHIP_DATE) - DAY(ORDER_DATE) > 4;

--6 Write a query to calculate the percentage contribution of each ship mode based on the total number of orders. 
SELECT Ship_mode, COUNT(order_id) * 100.0 / SUM(COUNT(order_id)) OVER () AS Order_Percentage
FROM Train
GROUP BY Ship_mode;

--7 Write a query to rank cities within each country based on total sales using a window function.

SELECT country, city, SUM(Sales) AS TOTAL_SALES, DENSE_RANK() OVER(PARTITION BY Country Order BY SUM(Sales) DESC) AS City_Rank
FROM Train
GROUP BY country, city;

--8 Write a query to calculate the number of orders per month, grouped by year and month using Order_Date.
SELECT YEAR(order_date) AS Year, MONTH(order_date) AS Month, COUNT(order_id) AS number_of_orders
FROM TRAIN
GROUP BY YEAR(order_Date), MONTH(order_Date); 

--9 Write a query to identify orders where the ship date is earlier than the order date.
SELECT order_id
FROM Train
WHERE Ship_Date < Order_Date;



