USE SportStore;
GO

EXEC GetAllProductsInfo;
GO

EXEC GetTop3OldestCustomers;
GO

EXEC GetTopSellingEmployee;
GO

DECLARE @Manufacturer NVARCHAR(100) = 'SomeManufacturer';
DECLARE @Available BIT;

EXEC CheckManufacturerAvailability @Manufacturer, @Available OUTPUT;

IF @Available = 1
    PRINT 'Yes, products from manufacturer ' + @Manufacturer + ' are available.';
ELSE
    PRINT 'No, products from manufacturer ' + @Manufacturer + ' are not available.';

EXEC GetTopSellingManufacturer;
GO

DECLARE @Date DATE = '2023-01-01';
DECLARE @DeletedCount INT;

EXEC DeleteCustomersRegisteredAfterDate @Date, @DeletedCount OUTPUT;

PRINT 'Deleted ' + CAST(@DeletedCount AS NVARCHAR(10)) + ' customers registered after ' + CAST(@Date AS NVARCHAR(10)) + '.';