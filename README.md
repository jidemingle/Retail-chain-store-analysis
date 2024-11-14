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

--------------------------------------------------------------------------------------------------------------------------------

**MONTH ON MONTH (MOM) GROWTH IN QUANTITY SOLD**

SELECT month(transaction_date),

SUM(transaction_qty) AS CURRENT_MONTH_QUANTITY,

ROUND((SUM(transaction_qty) - LAG(SUM(transaction_qty),1) OVER(ORDER BY month(transaction_date))) / LAG(SUM(transaction_qty),1) OVER(ORDER BY month(transaction_date)) *100 ,1) AS MOM_GROWTH_PERCENTAGE
FROM electronic_sales

WHERE month(transaction_date) IN (2,3)   --   Using the months of February and March

GROUP BY month(transaction_date)

ORDER BY month(transaction_date)

-------------------------------------------------------------------------------------------------------------------------------------------







