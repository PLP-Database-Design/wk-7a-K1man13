Question 1

SELECT OrderID, CustomerName, TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n.n), ',', -1)) AS Product
FROM ProductDetail
JOIN (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5) n
  ON CHAR_LENGTH(Products)
     -CHAR_LENGTH(REPLACE(Products, ',', '')) >= n.n - 1;


Question 2

  (a.) Create the Customers table:
  
      CREATE TABLE Customers (
        CustomerID INT PRIMARY KEY AUTO_INCREMENT,
        CustomerName VARCHAR(100)
    );

  (b.)  Insert customer data into the Customers table:

      INSERT INTO Customers (CustomerName)
      SELECT DISTINCT CustomerName
      FROM OrderDetails;

  (c.) Create the normalized OrderDetails table without CustomerName:

      CREATE TABLE OrderDetailsNormalized (
      OrderID INT,
      Product VARCHAR(100),
      Quantity INT,
      CustomerID INT,
      FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

  (d.) Populate the normalized OrderDetailsNormalized table:

      INSERT INTO OrderDetailsNormalized (OrderID, Product, Quantity, CustomerID)
      SELECT od.OrderID, od.Product, od.Quantity, c.CustomerID
      FROM OrderDetails od
      JOIN Customers c ON od.CustomerName = c.CustomerName;

EXPLANATION

Step 1: The Customers table stores customer data separately, ensuring CustomerName is no longer part of the OrderDetails table.

Step 2: We insert distinct customer names into the Customers table.

Step 3: We create the OrderDetailsNormalized table, removing the CustomerName column and adding CustomerID as a foreign key.

Step 4: We join the OrderDetails with the Customers table to insert the CustomerID into the OrderDetailsNormalized table.
