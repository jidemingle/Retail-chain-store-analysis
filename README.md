# Retail-chain-store-analysis

-------------------------
KPIs
--------------------------

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

--------------------------------------------------------------------------------------------------------------------

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

**AVERAGE DAILY SALES**

SELECT  ROUND(avg(total_sales),0) as avg_sales    -- This means find the average of the total sales of the transaction date from the table formed by the inner query

FROM

( 

select transaction_date,

round(sum(unit_price * transaction_qty),0) as total_sales

from electronic_sales

where month(transaction_date) = 5 -- for May

group by transaction_date) as internal_query -- group by clause here is to make the internal query a table so that the average can be found using the count of dates in the month of May 


![image](https://github.com/user-attachments/assets/4c032f55-7cbf-40de-9f7e-bec33d69b8fa)

------------------------------------------------------------------------------------------------------------------------------------

**DAILY SALES FOR MONTH SELECTED**

   SELECT 
   
   DAY(transaction_date) AS day_of_month,
   
   ROUND(SUM(unit_price * transaction_qty),1) AS total_sales
   
   FROM    electronic_sales
   
   WHERE     MONTH(transaction_date) = 4  -- Filter for April
   
   GROUP BY  DAY(transaction_date)
    
   ORDER BY DAY(transaction_date);

   ![image](https://github.com/user-attachments/assets/fb01f331-0c32-4550-8ac4-712db603078b)
   

   ![image](https://github.com/user-attachments/assets/eaa0767b-a602-45bd-8a5f-7a08325a5e8d)

   ------------------------------------------------------------------------------------------------------------------------
   

 **COMPARING DAILY SALES WITH AVERAGE SALES – IF GREATER THAN “ABOVE AVERAGE” and LESSER THAN “BELOW AVERAGE”**

SELECT 

    day_of_month,
    
    CASE 
        WHEN total_sales > avg_sales THEN 'Above Average'
	
        WHEN total_sales < avg_sales THEN 'Below Average'
	
        ELSE 'Average'
	
    END AS sales_status,
    
    total_sales
    
FROM (

    SELECT 
    
        DAY(transaction_date) AS day_of_month,
	
        SUM(unit_price * transaction_qty) AS total_sales,
	
        AVG(SUM(unit_price * transaction_qty)) OVER () AS avg_sales
	
    FROM 
    
        electronic_sales
	
    WHERE 
    
        MONTH(transaction_date) = 5  -- Filter for May
	
    GROUP BY 
    
        DAY(transaction_date)
	
) AS sales_data

ORDER BY 

    day_of_month;

![image](https://github.com/user-attachments/assets/b58b5db7-1277-4a20-822b-1244026c6b67)


![image](https://github.com/user-attachments/assets/13d788a7-8830-4245-aefc-c434e124ec65)

---------------------------------------------------------------------------------------------------------------------------------------


**TOP 10 PRODUCT TYPES BY TOTAL SALES**

 SELECT product_type,
 
 sum(unit_price * transaction_qty) as Total_sales
 
 FROM electronic_sales
 
 where MONTH(transaction_date) = 4 -- For the month of April
 
 group by product_type
 
 ORDER BY Total_sales DESC
 
 LIMIT 10
 

 ![image](https://github.com/user-attachments/assets/da0f30c4-329e-45d6-a784-98918d35c6d9)

 -----------------------------------------------------------------------------------------------------------------------------


**TOTAL SALES BY DAY BY HOUR**

SELECT 

ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales,
    
SUM(transaction_qty) AS Total_Quantity,

COUNT(*) AS Total_Orders

FROM

electronic_sales

WHERE 

DAYOFWEEK(transaction_date) = 4 -- Filter for wednesday (1 is Sunday, 2 is Monday, ..., 7 is Saturday)
    
AND HOUR(transaction_time) = 10 -- Filter for hour number 5

    
AND MONTH(transaction_date) = 5; -- Filter for May (month number 5)


![image](https://github.com/user-attachments/assets/ff19bcb1-fe8c-4743-a6ff-0472d0154ad5)


------------------------------------------------------------------------------------------------------------------------------------

**TOTAL MONTHLY SALES FOR DAYS OF THE WEEK**

SELECT dayname(transaction_date) AS day_name, 

ROUND(SUM(unit_price * transaction_qty)) AS total_sales 

FROM electronic_sales

WHERE MONTH(transaction_date) = 5 

GROUP BY day_name


![image](https://github.com/user-attachments/assets/d9c7d8d0-58d3-47cc-a425-79d1316d08de)

---------------------------------------------------------------------------------------------------------------------------


















