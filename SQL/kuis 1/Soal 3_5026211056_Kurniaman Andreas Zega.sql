SELECT prod.ProductID, prod.Name, AVG(ph.ListPrice) AS AverageListPrice

FROM Production.Product prod

INNER JOIN Production.ProductListPriceHistory ph ON prod.ProductID = ph.ProductID 

GROUP BY prod.ProductID, prod.Name;