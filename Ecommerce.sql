CREATE DATABASE EcommerceDB;
USE EcommerceDB;

CREATE TABLE Customers(
Id int identity primary key,
Name nvarchar(100),
Email nvarchar(100),
Phone nvarchar(20)

);


CREATE TABLE Orders (
Id int identity primary key,
OrderDate DATETIME,
Status nvarchar(50),
CustomerId int,
FOREIGN KEY(CustomerId) REFERENCES Customers(Id)
);

CREATE TABLE Products(
Id int identity primary key,
Name nvarchar(100),
Description nvarchar(255),
Price DECIMAL(10,2),
CategoryId int
);

CREATE TABLE Categories(
Id int identity primary key,
Name nvarchar(100),
Description nvarchar(255)
);

ALTER TABLE Products
ADD FOREIGN KEY(CategoryId) REFERENCES Categories(Id);

CREATE TABLE OrderItems (
    Id INT IDENTITY PRIMARY KEY,
    OrderId INT,
    ProductId INT,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    FOREIGN KEY (OrderId) REFERENCES Orders(Id),
    FOREIGN KEY (ProductId) REFERENCES Products(Id)
);

CREATE TABLE Suppliers (
    Id INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(100),
    ContactInfo NVARCHAR(255)
);

CREATE TABLE ProductSuppliers (
    ProductId INT,
    SupplierId INT,
    PRIMARY KEY (ProductId, SupplierId),
    FOREIGN KEY (ProductId) REFERENCES Products(Id),
    FOREIGN KEY (SupplierId) REFERENCES Suppliers(Id)
);
