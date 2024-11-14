# Retail-chain-store-analysis
KPIs

**TOTAL SALES**
 
SELECT CONCAT(ROUND(sum(transaction_qty * unit_price)/1000000,2),"M") AS Total_sales

FROM electronic_sales

WHERE  MONTH(transaction_date) = 3 -- using the month of march as Current Month


![image](https://github.com/user-attachments/assets/ee1a4748-258c-44ee-8ff7-f877601c524b)


--------------------------------------------------------------------------------------------------------------------------

**MONTH ON MONTH (MOM) SALES DIFFERENCE AND GROWTH**

SELECT month(transaction_date),

SUM(transaction_qty * unit_price) AS CURRENT_MONTH_SALES,

ROUND((SUM(transaction_qty * unit_price) - LAG(SUM(transaction_qty * unit_price),1) OVER(ORDER BY month(transaction_date))) / LAG(SUM(transaction_qty * unit_price),1) OVER(ORDER BY month(transaction_date)) *100 ,1) AS MOM_GROWTH_PERCENTAGE

FROM electronic_sales

WHERE month(transaction_date) IN (5,6)   -- using the months of May and June

GROUP BY month(transaction_date)

ORDER BY month(transaction_date)

![image](https://github.com/user-attachments/assets/f960394b-1a45-4d01-a7d6-41134b6b3801)

-------------------------------------------------------------------------------------------------------------------------------------

**TOTAL QUANTITY SOLD**

SELECT SUM(transaction_qty) FROM electronic_sales

WHERE month(transaction_date) = 5   -- Using the month of May

![image](https://github.com/user-attachments/assets/fb91bf75-7f75-4b99-a014-62a17aace98b)

--------------------------------------------------------------------------------------------------------------------------------

**MONTH ON MONTH (MOM) GROWTH IN QUANTITY SOLD**

SELECT month(transaction_date),

SUM(transaction_qty) AS CURRENT_MONTH_QUANTITY,

ROUND((SUM(transaction_qty) - LAG(SUM(transaction_qty),1) OVER(ORDER BY month(transaction_date))) / LAG(SUM(transaction_qty),1) OVER(ORDER BY month(transaction_date)) *100 ,1) AS MOM_GROWTH_PERCENTAGE
FROM electronic_sales

WHERE month(transaction_date) IN (2,3)   --   Using the months of February and March

GROUP BY month(transaction_date)

ORDER BY month(transaction_date)

![image](https://github.com/user-attachments/assets/2f6dac2b-3e88-4490-839a-c86de49f386b)

-------------------------------------------------------------------------------------------------------------------------------------------

**TOTAL ORDERS**

SELECT count(transaction_id) FROM electronic_sales

WHERE month(transaction_date) = 4 -- For the month of April

![image](https://github.com/user-attachments/assets/80e39ad5-2af3-4a6a-b3ee-e6e421e503e5)

--------------------------------------------------------------------------------------------------------------------------------

**MONTH ON MONTH (MOM)  GROWTH IN TOTAL ORDERS**

SELECT month(transaction_date),

COUNT(transaction_id) AS CURRENT_MONTH_ORDERS,

ROUND((COUNT(transaction_id) - LAG(COUNT(transaction_id),1) OVER(ORDER BY month(transaction_date))) / LAG(COUNT(transaction_id),1) OVER(ORDER BY month(transaction_date)) *100 ,1) AS MOM_GROWTH_PERCENTAGE

FROM electronic_sales

WHERE month(transaction_date) IN (2,3)  -- Using the months of February and March

GROUP BY month(transaction_date)

ORDER BY month(transaction_date)

![image](https://github.com/user-attachments/assets/a5f7a07e-03e8-466d-8d44-aed84fcc022c)

-----------------------------------------------------------------------------------------------------------------------------------------------

**CHART REQUIREMENTS**

**TOOLTIP REQUIREMENT TO DISPLAY TOTAL SALES, TOTAL ORDERS AND TOTAL QUANTITY FOR A SELECTED CALENDAR DATE**

SELECT SUM(unit_price * transaction_qty) AS total_sales,

SUM(transaction_qty) AS total_quantity_sold,

COUNT(transaction_id) AS total_orders

FROM  electronic_sales

WHERE    transaction_date = '2023-03-17'; -- Using 17th March 2023

![image](https://github.com/user-attachments/assets/a6a109b3-6fa2-4072-971a-02201aefe6f1)


---------------------------------------------------------------------------------------------------------------------------------------

**SALES ANALYSIS BY WEEKEND AND WEEKDAYS**

-- SUNDAY & SATURDAY = WEEKEND

-- MONDAY TO FRIDAY = WEEKDAY

 -- DAY OF WEEK (SUNDAY =1, MONDAY =2 …..  SATURDAY =7) 
 
 SELECT 
 
	CASE
 
		WHEN dayofweek(transaction_date) IN (1,7) THEN "WEEKEND"
  
          	ELSE "WEEKDAY"
            
  	 END AS DAY_TYPE,
    
 		 CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000000,2),"M") AS total_sales
  
 	FROM electronic_sales
    
        WHERE month(transaction_date) = 2   -- Using the month of February
    
   	GROUP BY DAY_TYPE


    

![image](https://github.com/user-attachments/assets/e42ef05a-c553-43eb-b41c-1e35fd8a1a18)



---------------------------------------------------------------------------------------------------------------------

**TOTAL SALES BY STORE LOCATION**

SELECT 

	store_location,
 
	SUM(unit_price * transaction_qty) as Total_Sales
 
FROM electronic_sales

WHERE MONTH(transaction_date) = 6     -- for the month of June

GROUP BY store_location

ORDER BY SUM(unit_price * transaction_qty) DESC


![image](https://github.com/user-attachments/assets/a3beee53-f37e-402c-b9ba-fd02ee000dad)

---------------------------------------------------------------------------------------------------------------------------------------------------

**SALES BY PRODUCT CATEGORY**

SELECT 
	product_category,
 
	ROUND(SUM(unit_price * transaction_qty),1) as Total_Sales
 
FROM electronic_sales

WHERE MONTH(transaction_date) = 5 

GROUP BY product_category

ORDER BY SUM(unit_price * transaction_qty) DESC

![image](https://github.com/user-attachments/assets/962f22f4-7b9c-442c-a7d2-d9a33a7c3958)

-------------------------------------------------------------------------------------------------------------------------------------------------















