


CREATE VIEW CustomerOrderSummary AS
WITH OrderSummary AS (
    SELECT
        c.Id AS CustomerId,
        c.Name AS CustomerName,
        COUNT(DISTINCT o.Id) AS TotalOrders,
        SUM(oi.Quantity * oi.UnitPrice) AS TotalSpent
    FROM Customers c
    LEFT JOIN Orders o ON c.Id = o.CustomerId
    LEFT JOIN OrderItems oi ON o.Id = oi.OrderId
    GROUP BY c.Id, c.Name
),
FavoriteCategory AS (
    SELECT
        cst.Id AS CustomerId,
        cat.Name AS CategoryName,
        ROW_NUMBER() OVER (
            PARTITION BY cst.Id
            ORDER BY COUNT(*) DESC
        ) AS rn
    FROM Customers cst
    JOIN Orders o ON cst.Id = o.CustomerId
    JOIN OrderItems oi ON o.Id = oi.OrderId
    JOIN Products p ON oi.ProductId = p.Id
    JOIN Categories cat ON p.CategoryId = cat.Id
    GROUP BY cst.Id, cat.Name
)
SELECT
    os.CustomerId,
    os.CustomerName,
    os.TotalOrders,
    os.TotalSpent,
    fc.CategoryName AS FavoriteCategory
FROM OrderSummary os
LEFT JOIN FavoriteCategory fc
    ON os.CustomerId = fc.CustomerId
   AND fc.rn = 1;


