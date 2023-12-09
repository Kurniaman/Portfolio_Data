SELECT 
    sod.ProductID, 
    p.Name AS ProductName, 
    SUM(soh.SubTotal) as TotalSales, 
    SUM(sod.OrderQty) as TotalQuantity, 
    sr.Name as SalesReason
FROM 
    Sales.SalesOrderDetail sod
    JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID=soh.SalesOrderID 
    JOIN Sales.SalesOrderHeaderSalesReason sohsr ON soh.SalesOrderID=sohsr.SalesOrderID 
    JOIN Sales.SalesReason sr ON sohsr.SalesReasonID=sr.SalesReasonID
    JOIN Production.Product p ON sod.ProductID = p.ProductID
WHERE 
    sr.Name='Quality'
GROUP BY 
    sod.ProductID, 
    p.Name, 
    sr.Name
ORDER BY 
    TotalQuantity DESC;
