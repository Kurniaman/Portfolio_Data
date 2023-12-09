CREATE PROCEDURE PurchaseProduct
    @VendorID INT,
    @ProductID INT,
    @OrderQty INT
AS
BEGIN
    -- Memulai transaksi
    BEGIN TRANSACTION
    
    -- Mendapatkan informasi harga dan status produk
    DECLARE @UnitPrice DECIMAL(18, 2)
    DECLARE @FinishedGoodsFlag BIT
    SELECT @UnitPrice = ListPrice, @FinishedGoodsFlag = FinishedGoodsFlag
    FROM Production.Product
    WHERE ProductID = @ProductID
    
    -- Mengecek apakah barang yang di-purchase adalah barang jadi atau setengah jadi
    IF @FinishedGoodsFlag = 1
    BEGIN
        -- Insert ke tabel PurchaseOrderHeader
INSERT INTO Purchasing.PurchaseOrderHeader (VendorID, SubTotal, Freight, ModifiedDate)
VALUES (@VendorID, @UnitPrice * @OrderQty, 0, GETDATE())

-- Mendapatkan PurchaseOrderID yang baru saja di-generate
DECLARE @PurchaseOrderID INT
SET @PurchaseOrderID = SCOPE_IDENTITY()

-- Insert ke tabel PurchaseOrderDetail
INSERT INTO Purchasing.PurchaseOrderDetail (PurchaseOrderID, OrderQty, ProductID, UnitPrice, LineTotal, ModifiedDate)
VALUES (@PurchaseOrderID, @OrderQty, @ProductID, @UnitPrice, @UnitPrice * @OrderQty, GETDATE())

        
        -- Update stock dan kuantitas barang yang masuk di tabel ProductInventory
        UPDATE Production.ProductInventory
        SET Quantity = Quantity + @OrderQty
        WHERE ProductID = @ProductID
        
        -- Commit transaksi
        COMMIT TRANSACTION
    END
    ELSE
    BEGIN
        -- Jika barang bukan barang jadi, lempar error
        THROW 50000, 'Barang yang dipurchase haruslah barang jadi.', 1
    END
END
