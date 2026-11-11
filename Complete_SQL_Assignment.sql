CREATE TABLE Customers (
    CustomerID INTEGER PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Country VARCHAR(50),
    Score INTEGER
);

CREATE TABLE Products (
    ProductID INTEGER PRIMARY KEY,
    Product VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Employees (
    EmployeeID INTEGER PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    BirthDate DATE,
    Gender VARCHAR(10),
    Salary DECIMAL(10,2),
    ManagerID INTEGER,
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE Orders (
    OrderID INTEGER PRIMARY KEY,
    ProductID INTEGER,
    CustomerID INTEGER,
    SalesPersonID INTEGER,
    OrderDate DATE,
    ShipDate DATE,
    OrderStatus VARCHAR(30),
    ShipAddress VARCHAR(150),
    BillAddress VARCHAR(150),
    Quantity INTEGER,
    Sales DECIMAL(10,2),
    CreationTime DATETIME,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (SalesPersonID) REFERENCES Employees(EmployeeID)
);

INSERT INTO Customers (CustomerID, FirstName, LastName, Country, Score)
VALUES
(1, 'Anna', 'Smith', 'USA', 350),
(2, 'John', 'Brown', 'Germany', 450),
(3, 'Sara', 'Davis', 'UK', 500),
(4, 'Mike', 'Wilson', 'USA', 400),
(5, 'Emma', 'Taylor', 'France', 300);

INSERT INTO Products (ProductID, Product, Category, Price)
VALUES
(101, 'Laptop', 'Electronics', 1200),
(102, 'Mouse', 'Accessories', 25),
(103, 'Keyboard', 'Accessories', 50),
(104, 'Monitor', 'Electronics', 300),
(105, 'Desk', 'Furniture', 200);

INSERT INTO Employees
(EmployeeID, FirstName, LastName, Department, BirthDate, Gender, Salary, ManagerID)
VALUES
(1, 'David', 'Miller', 'IT', '1985-04-12', 'Male', 5000, NULL),
(2, 'James', 'Wilson', 'Sales', '1990-06-20', 'Male', 4000, 1),
(3, 'Emily', 'Brown', 'HR', '1988-09-15', 'Female', 3500, 1),
(4, 'Sophia', 'Davis', 'IT', '1992-11-08', 'Female', 4500, 1),
(5, 'Daniel', 'Taylor', 'Sales', '1987-02-25', 'Male', 4200, 2);

INSERT INTO Orders
(OrderID, ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderStatus, ShipAddress, BillAddress, Quantity, Sales, CreationTime)
VALUES
(1, 101, 1, 1, '2025-01-10', '2025-01-12', 'Delivered', 'Baku', 'Baku', 2, 2400, '2025-01-10 10:00:00'),
(2, 102, 2, 2, '2025-01-15', '2025-01-17', 'Delivered', 'Berlin', 'Berlin', 3, 75, '2025-01-15 11:00:00'),
(3, 103, 3, 3, '2025-02-01', '2025-02-04', 'Shipped', 'London', 'London', 1, 50, '2025-02-01 12:00:00'),
(4, 104, 4, 4, '2025-02-10', '2025-02-12', 'Pending', 'Baku', 'Baku', 2, 600, '2025-02-10 13:00:00'),
(5, 105, 5, 5, '2025-03-05', '2025-03-08', 'Delivered', 'Paris', 'Paris', 1, 200, '2025-03-05 14:00:00');

SELECT * FROM Customers;

SELECT * FROM Products;

SELECT * FROM Employees;

SELECT * FROM Orders;


SELECT * FROM Customers;
SELECT FirstName, LastName, Country FROM Customers;


SELECT CustomerID, FirstName, LastName, Country
FROM Customers
WHERE Country = 'Germany';


SELECT CustomerID, FirstName, LastName, Country, Score
FROM Customers
WHERE Score >= 300 AND Country IN ('Germany', 'France');


SELECT ProductID, Product, Category, Price
FROM Products
ORDER BY Price DESC;


SELECT Product, Price
FROM Products
WHERE Price BETWEEN 50 AND 300;


SELECT Product, Category
FROM Products
WHERE Product LIKE '%Phone%';


SELECT DISTINCT Category
FROM Products
ORDER BY Category ASC;


SELECT Orders.OrderID, Customers.FirstName, Customers.LastName
FROM Orders
INNER JOIN Customers
ON Orders.CustomerID = Customers.CustomerID;


SELECT OrderStatus, COUNT(*) AS OrderCount, SUM(Sales) AS TotalSales
FROM Orders
GROUP BY OrderStatus
ORDER BY TotalSales DESC;


INSERT INTO Products (ProductID, Product, Category, Price)
VALUES (9999, 'Temporary Test Product', 'Test', 10);


UPDATE Products
SET Price = 15
WHERE ProductID = 9999;


SELECT ProductID, Product, Price
FROM Products
WHERE ProductID = 9999;


DELETE FROM Products
WHERE ProductID = 9999;


SELECT FirstName, LastName, Country, Score
FROM Customers
WHERE Score > 500
ORDER BY Score DESC;


SELECT FirstName, LastName, Country, Score
FROM Customers
WHERE Country IN ('Germany', 'France', 'USA')
AND Score >= 300;


SELECT Customers.FirstName, Customers.LastName,
       Orders.OrderID, Orders.OrderDate, Orders.Sales
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;


SELECT Customers.CustomerID, Customers.FirstName,
       Customers.LastName, Customers.Country
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.OrderID IS NULL;


SELECT Customers.FirstName, Customers.LastName,
       SUM(Orders.Sales) AS TotalSales
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.FirstName, Customers.LastName
ORDER BY TotalSales DESC;


SELECT Customers.FirstName, Customers.LastName,
       SUM(Orders.Sales) AS TotalSales
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.FirstName, Customers.LastName
HAVING SUM(Orders.Sales) > 1000;


SELECT Customers.FirstName, Customers.LastName,
       Customers.Country, SUM(Orders.Sales) AS TotalSales
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.FirstName,
         Customers.LastName, Customers.Country
ORDER BY TotalSales DESC
LIMIT 5;


SELECT OrderID, CustomerID, OrderDate, ShipDate, OrderStatus
FROM Orders
WHERE OrderDate >= '2026-10-01'
AND OrderDate < '2026-11-01';


SELECT *
FROM Orders
WHERE OrderStatus = 'Pending'
ORDER BY OrderDate ASC;


SELECT Orders.OrderID, Customers.FirstName, Customers.LastName,
       Orders.OrderDate, Orders.ShipDate
FROM Orders
INNER JOIN Customers
ON Orders.CustomerID = Customers.CustomerID
WHERE julianday(Orders.ShipDate) - julianday(Orders.OrderDate) > 7;


SELECT DISTINCT Customers.FirstName, Customers.LastName, Customers.Country
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
WHERE julianday(Orders.ShipDate) - julianday(Orders.OrderDate) > 7;


SELECT *
FROM Orders
WHERE OrderID = 105;


UPDATE Orders
SET OrderStatus = 'Shipped',
    ShipDate = '2026-11-05'
WHERE OrderID = 105;


SELECT *
FROM Orders
WHERE OrderID = 110;


UPDATE Orders
SET ShipAddress = '45 Main Street, Baku'
WHERE OrderID = 110;


SELECT *
FROM Orders
WHERE OrderID = 999;


DELETE FROM Orders
WHERE OrderID = 999;


SELECT OrderStatus, COUNT(*) AS OrderCount
FROM Orders
GROUP BY OrderStatus;


SELECT Orders.OrderID, Customers.FirstName, Customers.LastName,
       Orders.OrderDate, Orders.OrderStatus
FROM Orders
INNER JOIN Customers
ON Orders.CustomerID = Customers.CustomerID
WHERE Orders.ShipDate IS NULL;


SELECT Product, Category, Price
FROM Products
WHERE Price BETWEEN 50 AND 300
ORDER BY Price ASC;


SELECT Product, Category, Price
FROM Products
WHERE Category = 'Electronics'
AND Price > 500;


SELECT Products.Product, Products.Category,
       Orders.Quantity, Orders.Sales
FROM Products
INNER JOIN Orders
ON Products.ProductID = Orders.ProductID;


SELECT Products.Product, SUM(Orders.Quantity) AS TotalQuantity
FROM Products
INNER JOIN Orders
ON Products.ProductID = Orders.ProductID
GROUP BY Products.Product
ORDER BY TotalQuantity DESC
LIMIT 5;


SELECT Products.ProductID, Products.Product, Products.Category
FROM Products
LEFT JOIN Orders
ON Products.ProductID = Orders.ProductID
WHERE Orders.OrderID IS NULL;


SELECT Employees.FirstName, Employees.LastName,
       Employees.Department, SUM(Orders.Sales) AS TotalSales
FROM Employees
INNER JOIN Orders
ON Employees.EmployeeID = Orders.SalesPersonID
GROUP BY Employees.EmployeeID, Employees.FirstName,
         Employees.LastName, Employees.Department;


SELECT Employees.FirstName, Employees.LastName,
       SUM(Orders.Sales) AS TotalSales
FROM Employees
INNER JOIN Orders
ON Employees.EmployeeID = Orders.SalesPersonID
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName
HAVING SUM(Orders.Sales) > 5000
ORDER BY TotalSales DESC;


INSERT INTO Products (ProductID, Product, Category, Price)
VALUES (501, 'Wireless Keyboard', 'Electronics', 75);


UPDATE Products
SET Price = 90
WHERE ProductID = 501;


ALTER TABLE Products
ADD COLUMN StockQuantity INTEGER;


SELECT FirstName, LastName
FROM Customers
UNION
SELECT FirstName, LastName
FROM Employees;


SELECT Products.Category,
       SUM(Orders.Quantity) AS TotalQuantity,
       SUM(Orders.Sales) AS TotalSales
FROM Products
INNER JOIN Orders
ON Products.ProductID = Orders.ProductID
GROUP BY Products.Category
HAVING SUM(Orders.Sales) > 2000
ORDER BY TotalSales DESC;


