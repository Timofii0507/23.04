CREATE DATABASE SportStore;
GO

USE SportStore;
GO

CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Category NVARCHAR(50),
    Quantity INT,
    Cost MONEY,
    Manufacturer NVARCHAR(100),
    SalePrice MONEY
);
GO

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100) NOT NULL,
    Position NVARCHAR(50),
    HireDate DATE,
    Gender NVARCHAR(10),
    Salary MONEY
);
GO

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100),
    Phone NVARCHAR(20),
    Gender NVARCHAR(10),
    OrderHistory NVARCHAR(MAX),
    DiscountPercentage DECIMAL(5,2),
    SubscribedToNewsletter BIT
);
GO

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    SalePrice MONEY,
    Quantity INT,
    SaleDate DATE,
    EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID),
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID)
);
GO

CREATE TRIGGER InsertIntoHistory
ON Sales
AFTER INSERT
AS
BEGIN
    INSERT INTO History (SaleID, ProductID, SalePrice, Quantity, SaleDate, EmployeeID, CustomerID)
    SELECT SaleID, ProductID, SalePrice, Quantity, SaleDate, EmployeeID, CustomerID
    FROM inserted;
END;
GO

CREATE TRIGGER PreventDuplicateCustomers
ON Customers
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Customers c INNER JOIN inserted i ON c.FullName = i.FullName OR c.Email = i.Email)
    BEGIN
        RAISERROR ('Customer already exists!', 16, 1);
    END;
    ELSE
    BEGIN
        INSERT INTO Customers (FullName, Email, Phone, Gender, OrderHistory, DiscountPercentage, SubscribedToNewsletter)
        SELECT FullName, Email, Phone, Gender, OrderHistory, DiscountPercentage, SubscribedToNewsletter
        FROM inserted;
    END;
END;
GO

CREATE PROCEDURE GetAllProductsInfo
AS
BEGIN
    SELECT * FROM Products;
END;
GO

CREATE PROCEDURE GetProductsByCategory
    @Category NVARCHAR(50)
AS
BEGIN
    SELECT * FROM Products WHERE Category = @Category;
END;
GO

CREATE PROCEDURE GetTop3OldestCustomers
AS
BEGIN
    SELECT TOP 3 * FROM Customers ORDER BY HireDate;
END;
GO

CREATE PROCEDURE GetTopSellingEmployee
AS
BEGIN
    SELECT TOP 1 EmployeeID, FullName, SUM(SalePrice * Quantity) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID, FullName
    ORDER BY TotalSales DESC;
END;
GO

CREATE PROCEDURE CheckManufacturerAvailability
    @Manufacturer NVARCHAR(100),
    @Available BIT OUTPUT
AS
BEGIN
    IF EXISTS (SELECT * FROM Products WHERE Manufacturer = @Manufacturer)
        SET @Available = 1;
    ELSE
        SET @Available = 0;
END;
GO

CREATE PROCEDURE GetTopSellingManufacturer
AS
BEGIN
    SELECT TOP 1 p.Manufacturer, SUM(s.SalePrice * s.Quantity) AS TotalSales
    FROM Sales s
    INNER JOIN Products p ON s.ProductID = p.ProductID
    GROUP BY p.Manufacturer
    ORDER BY TotalSales DESC;
END;
GO

CREATE PROCEDURE DeleteCustomersRegisteredAfterDate
    @Date DATE,
    @DeletedCount INT OUTPUT
AS
BEGIN
    DELETE FROM Customers WHERE HireDate > @Date;
    SET @DeletedCount = @@ROWCOUNT;
END;
GO