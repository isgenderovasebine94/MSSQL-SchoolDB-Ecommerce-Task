USE EcommerceDB;


  SELECT 
    c.Id,
    c.Name,
    COUNT(o.Id) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o ON c.Id = o.CustomerId
GROUP BY c.Id, c.Name;

SELECT 
    c.Id,
    c.Name,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.Id = o.CustomerId
JOIN OrderItems oi ON o.Id = oi.OrderId
GROUP BY c.Id, c.Name
HAVING SUM(oi.Quantity * oi.UnitPrice) > 5000;


ALTER TABLE Orders
ADD TotalAmount DECIMAL(10,2);

SELECT 
    c.Name AS CategoryName,
    SUM(oi.Quantity) AS TotalQuantity,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSales
FROM Categories c
JOIN Products p ON c.Id = p.CategoryId
JOIN OrderItems oi ON p.Id = oi.ProductId
GROUP BY c.Name;

WITH CategoryCount AS (
    SELECT
        cst.Id AS CustomerId,
        cst.Name AS CustomerName,
        cat.Name AS CategoryName,
        COUNT(*) AS OrderCount
    FROM Customers cst
    JOIN Orders o ON cst.Id = o.CustomerId
    JOIN OrderItems oi ON o.Id = oi.OrderId
    JOIN Products p ON oi.ProductId = p.Id
    JOIN Categories cat ON p.CategoryId = cat.Id
    GROUP BY cst.Id, cst.Name, cat.Name
)
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY CustomerId ORDER BY OrderCount DESC) AS rn
    FROM CategoryCount
) t
WHERE rn = 1;


