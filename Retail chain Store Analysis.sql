KPIs
1. TOTAL SALES 
SELECT CONCAT(ROUND(sum(transaction_qty * unit_price)/1000000,2),"M") AS Total_sales 
FROM electronic_sales
WHERE  MONTH(transaction_date) = 3 -- using the month of march as Current Month

![image](https://github.com/user-attachments/assets/ee1a4748-258c-44ee-8ff7-f877601c524b)











