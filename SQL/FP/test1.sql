/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [PurchaseOrderID]
      ,[RevisionNumber]
      ,[Status]
      ,[EmployeeID]
      ,[VendorID]
      ,[ShipMethodID]
      ,[OrderDate]
      ,[ShipDate]
      ,[SubTotal]
      ,[TaxAmt]
      ,[Freight]
      ,[TotalDue]
      ,[ModifiedDate]
  FROM [AdventureWorks2012].[Purchasing].[PurchaseOrderHeader]