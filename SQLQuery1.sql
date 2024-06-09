USE SportStore;
GO

INSERT INTO Products (Name, Category, Quantity, Cost, Manufacturer, SalePrice)
VALUES 
    ('Running Shoes 1', 'Running Shoes', 10, 50.00, 'Nike', 75.00),
    ('Running Shoes 2', 'Running Shoes', 15, 45.00, 'Adidas', 65.00),
    ('Football', 'Sports Equipment', 20, 30.00, 'Nike', 45.00),
    ('Basketball', 'Sports Equipment', 25, 20.00, 'Wilson', 35.00),
    ('Tennis Racket', 'Sports Equipment', 8, 70.00, 'Wilson', 100.00);
GO

INSERT INTO Employees (FullName, Position, HireDate, Gender, Salary)
VALUES 
    ('John Doe', 'Sales Associate', '2019-03-15', 'Male', 35000.00),
    ('Jane Smith', 'Manager', '2018-01-10', 'Female', 60000.00),
    ('Robert Johnson', 'Cashier', '2020-06-20', 'Male', 30000.00);
GO

INSERT INTO Customers (FullName, Email, Phone, Gender, OrderHistory, DiscountPercentage, SubscribedToNewsletter)
VALUES 
    ('Alice Brown', 'alice@example.com', '1234567890', 'Female', NULL, 0.00, 1),
    ('Bob White', 'bob@example.com', '9876543210', 'Male', NULL, 0.00, 0),
    ('Eve Green', 'eve@example.com', '5555555555', 'Female', NULL, 0.00, 1);
GO

INSERT INTO Sales (ProductID, SalePrice, Quantity, SaleDate, EmployeeID, CustomerID)
VALUES 
    (1, 75.00, 2, '2024-04-20', 1, 1),
    (2, 65.00, 1, '2024-04-20', 2, 2),
    (3, 45.00, 3, '2024-04-21', 1, 3),
    (4, 35.00, 2, '2024-04-22', 3, 1),
    (5, 100.00, 1, '2024-04-23', 2, 2);
GO