-- Create Inventory Database
CREATE DATABASE Inventory;
GO

USE Inventory;
GO

-- Create Tables

-- Categories Table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(50) NOT NULL
);
GO

-- Suppliers Table
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY IDENTITY(1,1),
    SupplierName NVARCHAR(100) NOT NULL,
    ContactName NVARCHAR(100),
    Address NVARCHAR(255),
    City NVARCHAR(50),
    PostalCode NVARCHAR(20),
    Country NVARCHAR(50),
    Phone NVARCHAR(50)
);
GO

-- Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100) NOT NULL,
    SupplierID INT NOT NULL,
    CategoryID INT NOT NULL,
    QuantityPerUnit NVARCHAR(50),
    UnitPrice DECIMAL(18, 2),
    UnitsInStock INT,
    UnitsOnOrder INT,
    ReorderLevel INT,
    Discontinued BIT DEFAULT 0,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);
GO

-- InventoryTransactions Table
CREATE TABLE InventoryTransactions (
    TransactionID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    TransactionDate DATETIME DEFAULT GETDATE(),
    TransactionType NVARCHAR(20) NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

-- Insert Sample Data

-- Categories
INSERT INTO Categories (CategoryName) VALUES
('Beverages'),
('Condiments'),
('Confections'),
('Dairy Products'),
('Grains/Cereals'),
('Meat/Poultry'),
('Produce'),
('Seafood');
GO

-- Suppliers
INSERT INTO Suppliers (SupplierName, ContactName, Address, City, PostalCode, Country, Phone) VALUES
('Exotic Liquids', 'Charlotte Cooper', '49 Gilbert St.', 'London', 'EC1 4SD', 'UK', '171-555-2222'),
('New Orleans Cajun Delights', 'Shelley Burke', 'P.O. Box 78934', 'New Orleans', '70117', 'USA', '(100) 555-4822'),
('Grandma Kelly Homestead', 'Regina Murphy', '707 Oxford Rd.', 'Ann Arbor', '48104', 'USA', '(313) 555-5735');
GO

-- Products
INSERT INTO Products (ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel) VALUES
('Chai', 1, 1, '10 boxes x 20 bags', 18.00, 39, 0, 10),
('Chang', 1, 1, '24 - 12 oz bottles', 19.00, 17, 40, 25),
('Aniseed Syrup', 1, 2, '12 - 550 ml bottles', 10.00, 13, 70, 25),
('Chef Anton Cajun Seasoning', 2, 2, '48 - 6 oz jars', 22.00, 53, 0, 0),
('Grandma Boysenberry Spread', 3, 2, '12 - 8 oz jars', 25.00, 120, 0, 25);
GO

-- Inventory Transactions
INSERT INTO InventoryTransactions (ProductID, Quantity, TransactionType) VALUES
(1, 50, 'Purchase'),
(2, 30, 'Purchase'),
(3, 25, 'Purchase'),
(4, 70, 'Purchase'),
(5, 90, 'Purchase'),
(1, -10, 'Sale'),
(2, -5, 'Sale'),
(3, -7, 'Sale'),
(4, -8, 'Sale'),
(5, -20, 'Sale');
GO
