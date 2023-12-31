SELECT CUSTOMER.CUS_CODE, SUM(LINE.LINE_UNITS*LINE.LINE_PRICE) AS TOTAL_PURCHASES
FROM CUSTOMER, LINE, INVOICE
WHERE CUSTOMER.CUS_CODE = INVOICE.CUS_CODE
AND INVOICE.INV_NUMBER = LINE.INV_NUMBER
GROUP BY CUSTOMER.CUS_CODE

SELECT CUSTOMER.CUS_CODE, INVOICE.INV_NUMBER, INVOICE.INV_DATE, PRODUCT.P_DESCRIPT, LINE.LINE_UNITS, LINE.LINE_PRICE
FROM CUSTOMER, INVOICE, PRODUCT, LINE
WHERE CUSTOMER.CUS_CODE = INVOICE.CUS_CODE
AND INVOICE.INV_NUMBER = LINE.INV_NUMBER
AND LINE.P_CODE = PRODUCT.P_CODE
ORDER BY CUSTOMER.CUS_CODE,INVOICE.INV_NUMBER ;


SELECT 
	CUSTOMER.CUS_CODE,
	CUSTOMER.CUS_LNAME,
	CAST(SUM(LINE.LINE_UNITS * LINE.LINE_PRICE) AS DECIMAL(18,4)) AS "TOTAL PUCHASE"
FROM 
	CUSTOMER
	JOIN INVOICE ON CUSTOMER.CUS_CODE = INVOICE.CUS_CODE
	JOIN LINE ON INVOICE.INV_NUMBER = LINE.INV_NUMBER 
	JOIN PRODUCT ON LINE.P_CODE = PRODUCT.P_CODE
GROUP BY
	CUSTOMER.CUS_CODE,
	CUSTOMER.CUS_LNAME
ORDER BY 
	CUSTOMER.CUS_CODE ASC;

select CUSTOMER.CUS_CODE, CUSTOMER.CUS_LNAME, CUSTOMER.CUS_BALANCE, round(sum(line.LINE_UNITS * line.LINE_PRICE), 2) 
as TOTAL_PURCHASES, sum(line.line_units) as UNIT_PRICE, sum(line.LINE_UNITS * line.LINE_PRICE)/sum(line.line_units) 
as AVG_UNIT_PRICE_PURCHASED
from CUSTOMER join INVOICE
on CUSTOMER.CUS_CODE=INVOICE.CUS_CODE join LINE
on INVOICE.INV_NUMBER=LINE.INV_NUMBER
group by CUSTOMER.CUS_CODE, CUSTOMER.CUS_LNAME, CUSTOMER.CUS_BALANCE
order by CUSTOMER.CUS_CODE asc;

select INVOICE.INV_NUMBER, sum(round(LINE.LINE_UNITS*LINE.LINE_PRICE,2)) as INVOICE_TOTAL
from CUSTOMER join INVOICE
on CUSTOMER.CUS_CODE=INVOICE.CUS_CODE join LINE
on INVOICE.INV_NUMBER=LINE.INV_NUMBER join PRODUCT
on LINE.P_CODE=PRODUCT.P_CODE
group by INVOICE.INV_NUMBER
order by INVOICE.INV_NUMBER asc;