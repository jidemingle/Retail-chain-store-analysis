KPIs
1. TOTAL SALES 
SELECT CONCAT(ROUND(sum(transaction_qty * unit_price)/1000000,2),"M") AS Total_sales 
FROM electronic_sales
WHERE  MONTH(transaction_date) = 3 -- using the month of march as Current Month










