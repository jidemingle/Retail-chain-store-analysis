KPIs
1. TOTAL SALES 
SELECT CONCAT(ROUND(sum(transaction_qty * unit_price)/1000000,2),"M") AS Total_sales 
FROM electronic_sales
WHERE  MONTH(transaction_date) = 3 -- using the month of march as Current Month


![image](https://github.com/user-attachments/assets/899af37f-79d8-40ad-b687-e45562deca15)

