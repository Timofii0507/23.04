USE SportStore;
GO

UPDATE Products
SET Quantity = 12,
    Cost = 55.00
WHERE ProductID = 1;
GO

UPDATE Employees
SET Position = 'Senior Sales Associate',
    Salary = 40000.00
WHERE EmployeeID = 1;
GO

UPDATE Customers
SET Email = 'new_email@example.com',
    Phone = '1231231234'
WHERE CustomerID = 1;
GO

UPDATE Sales
SET SalePrice = 80.00
WHERE SaleID = 1;
GO