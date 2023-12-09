CREATE PROCEDURE CreateSalesOrder
    @ProductCode VARCHAR(50),
    @Quantity INT,
    @CustomerCode VARCHAR(50)
AS
BEGIN
    DECLARE @InvoiceNumber INT;
    DECLARE @LineUnits INT;
    DECLARE @LinePrice DECIMAL(10, 2);
    DECLARE @CustomerBalance DECIMAL(10, 2);
    DECLARE @QOH INT;
    DECLARE @Reorder INT;

    -- Selecting Product
    SELECT @QOH = P_QOH, @Reorder = P_MIN
    FROM PRODUCT
    WHERE P_CODE = @ProductCode;

    -- Choose the quantity
    IF @Quantity > @QOH
    BEGIN
        RAISERROR('Insufficient quantity on hand.', 16, 1);
        RETURN;
    END

    -- Make invoice
    INSERT INTO INVOICE (CUS_CODE, INV_DATE)
    VALUES (@CustomerCode, GETDATE());

    SET @InvoiceNumber = SCOPE_IDENTITY();

    -- Inserting line
    SET @LineUnits = @Quantity;
    SET @LinePrice = (SELECT P_PRICE FROM PRODUCT WHERE P_CODE = @ProductCode);

    INSERT INTO LINE (INV_NUMBER, LINE_NUMBER, P_Code, LINE_UNITS, LINE_PRICE)
    VALUES (@InvoiceNumber, 1, @ProductCode, @LineUnits, @LinePrice);

    -- Update quantity
    UPDATE PRODUCT
    SET P_QOH = P_QOH - @Quantity
    WHERE P_CODE = @ProductCode;

    -- Update Reorder
    IF @QOH - @Quantity < @Reorder
    BEGIN
        -- Perform reorder action here
        -- Update reorder status or trigger a notification, etc.
        PRINT 'Reorder required for product ' + @ProductCode;
    END

    -- Update Customer Balance
    SET @CustomerBalance = (SELECT CUS_BALANCE FROM CUSTOMER WHERE CUS_CODE = @CustomerCode);
    SET @CustomerBalance = @CustomerBalance + (@Quantity * @LinePrice);

    UPDATE CUSTOMER
    SET CUS_BALANCE = @CustomerBalance
    WHERE CUS_CODE = @CustomerCode;
END
GO

-- FILE EXECUTE BERADA DI FILE 2