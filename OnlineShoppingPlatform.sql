
create database onlineShoppingPlatform
  use onlineShoppingPlatform;
   -- customer table
   -- DDL SQL Statements
   -- 


CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    ShippingAddress TEXT NOT NULL,
    PaymentDetails TEXT
);

       -- seller table
CREATE TABLE Sellers (
    SellerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    ContactInfo TEXT NOT NULL,
    Address TEXT NOT NULL
);

      -- product table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Description TEXT,
    Price DECIMAL(10, 2) NOT NULL CHECK (Price >= 0),
    AvailableQuantity INT NOT NULL CHECK (AvailableQuantity >= 0)
);
 
           -- inventory table
           -- The Inventory table uses SellerID to link sellers with the products they offer.
           -- The Inventory table references ProductID to track stock levels
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY AUTO_INCREMENT,
    SellerID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity >= 0),
    FOREIGN KEY (SellerID) REFERENCES Sellers(SellerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

                -- shopping cart table
                -- Acts as a staging table before an order is created. It connects customers, products, and sellers.
CREATE TABLE ShoppingCart (
    CartID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    ProductID INT NOT NULL,
    SellerID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (SellerID) REFERENCES Sellers(SellerID)
);

                          -- orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    OrderDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(10, 2) NOT NULL CHECK (TotalAmount >= 0),
    ShippingDetails TEXT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

ALTER TABLE Orders
ADD COLUMN PaymentStatus VARCHAR(20);


                   -- OrderDetail table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    SellerID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    Price DECIMAL(10, 2) NOT NULL CHECK (Price >= 0),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (SellerID) REFERENCES Sellers(SellerID)
);

                -- Shippiment table
CREATE TABLE Shipment (
    ShipmentID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL,
    TrackingNumber VARCHAR(100),
    ShippedDate DATETIME,
    DeliveryDate DATETIME,
    Status VARCHAR(50) NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

ALTER TABLE Orders MODIFY COLUMN ShippingDetails VARCHAR(255) DEFAULT 'Not Provided';


                -- payments table 
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL DEFAULT 'VISA',
    PaymentDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Amount DECIMAL(10, 2) NOT NULL CHECK (Amount >= 0),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);


ALTER TABLE Payments
ADD COLUMN Tax DECIMAL(10, 2) DEFAULT 0.00;


ALTER TABLE payments
MODIFY PaymentMethod VARCHAR(50) NOT NULL DEFAULT 'Cash';



            -- cartslog table
            
CREATE TABLE CartLogs (
    LogID INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each log entry
    CustomerID INT NOT NULL,              -- ID of the customer whose cart item was deleted
    ProductID INT NOT NULL,               -- ID of the product that was deleted
    SellerID INT NOT NULL,                -- ID of the seller associated with the product
    Quantity INT NOT NULL,                -- Quantity of the product that was deleted
    DeletedAt DATETIME NOT NULL           -- Timestamp when the deletion occurred
);



-- the following are  DML SQL Statements

               -- the data inserts in the customers table


insert  into Customers (Name, Email, ShippingAddress, PaymentDetails) 
VALUES 
('Muller A', 'mulugetaa16@gmail.com', 'Australia, Sydney', 'Visa 1616'),
('Ezra L', 'ezral21@gmail.com', 'France, Paris', 'MasterCard 2121'),
('Keneni A', 'keneni19@gmail.com', 'USA, DC', 'Visa 1919');
-- other input
insert  into Customers (Name, Email, ShippingAddress, PaymentDetails) 
VALUES 
('Bereket m', 'berekt23@gmail.com', 'USA, DC', 'Visa 2222'),
('Betselot T', 'betselot27@gmail.com', 'Canada, Toronto', 'MasterCard 0989'),
('Dawit T', 'dawit@gmail.com', 'USA, DC', 'Visa 7865'),
('Tedy A', 'tedy@gmail.com', 'USA, NewYork', 'MasterCard 4554'),
('Abdulhafiz A', 'abdu@gmail.com', 'USA, California', 'Visa 3232'),
('Mihret A', 'mihret@gmail.com', 'USA, DC', 'MasterCard 5445'),
('Betty A', 'betty@gmail.com', 'USA, Verginia', 'MasterCard 0907');



           -- the data inserts in the seller tables
           
           
INSERT INTO Sellers (Name, ContactInfo, Address) 
VALUES 
('A Electronics', 'Abebe@gmail.com, +251912234354', 'Addis Abeba, Bole'),
('B Electronics', 'betelhem@gmail.com, +251905654323', 'Addis Abeba, Megenagna'),
('C Electronics', 'ciraji@gmail.com, +251912234314', 'Addis Abeba, Arat Kilo'),
('D Electronics', 'dagi@gmail.com, +251905654333', 'Addis Abeba, 6 Kilo'),
('E Electronics', 'eleni@gmail.com, +251912234344', 'Addis Abeba, Mexico'),
('F Electronics', 'fraoal@gmail.com, +251905654313', 'Addis Abeba, 22'),
('G Electronics', 'gech@gmail.com, +251912234394', 'Addis Abeba, Gerji'),
('H Electronics', 'henok@gmail.com, +251905054323', 'Addis Abeba, Ayat'),
('J Electronics', 'jemal@gmail.com, +251912274354', 'Addis Abeba, Piassa'),
('K Electronics', 'kelemu@gmail.com, +251905604323', 'Addis Abeba, Golagul');



               -- insert data into shoppingcart
               
               

-- Insert data into ShoppingCart
INSERT INTO ShoppingCart (CustomerID, ProductID, SellerID, Quantity) VALUES
(1, 1, 1, 49), 
(2, 2, 2, 45),
(3, 3, 3, 89), 
(4, 4, 4, 10),
(5, 5, 5, 98), 
(6, 6, 6, 20),
(7, 7, 7, 94), 
(8, 8, 8, 21);







                    --  Insert Data into the Products Table
                    
INSERT INTO Products (Name, Description, Price, AvailableQuantity) 
VALUES 
('Smartphone', 'Latest model smartphone with 128GB storage', 699.99, 100),
('Laptop', '15-inch laptop with 16GB RAM', 1199.99, 50),
('Smartphone', 'Latest model smartphone with 64GB storage', 650.99, 200),
('Laptop', '13-inch laptop with 16GB RAM', 1199.99, 50),
('Smartphone', 'Latest model smartphone with 32GB storage', 519.99, 100),
('Laptop', '14-inch laptop with 16GB RAM', 1199.99, 150),
('Smartphone', 'Latest model smartphone with 128GB storage', 699.99, 100),
('Laptop', '13-inch laptop with 32GB RAM', 2199.99, 240),
('Smartphone', 'Latest model smartphone with 128GB storage', 699.99, 90),
('Laptop', '15-inch laptop with 16GB RAM', 1199.99, 350);

           

       -- insert data into inventory


INSERT INTO Inventory (SellerID, ProductID, Quantity) 
VALUES 
(1, 1, 500), -- Seller 1  offers 500 Smartphones
(2, 10, 300), -- Seller 2  offers 300 Smartphones
(3, 2, 280), -- Seller 1  offers 200 Laptops
(4, 9, 1300), -- Seller 2  offers 10 Laptops
(5, 3, 540), -- Seller 1  offers 50 Smartphones
(6, 8, 300), -- Seller 2  offers 30 Smartphones
(7, 7, 260), -- Seller 1  offers 20 Laptops
(8, 5, 100), -- Seller 2  offers 10 Laptops
(9, 6, 100); -- Seller 2  offers 10 Laptops



      -- insert data into orders table
      
      
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount, ShippingDetails) 
VALUES 
(1, '2024-12-22 10:00:00', 1399.98, 'Addis, Summit'),
(2, '2024-12-11 11:00:00', 1199.99, 'Addis, Bole'),
(3, '2024-12-23 10:30:00', 1400.98, 'Addis, Megenagna'),
(4, '2024-12-18 11:43:12', 1145.99, 'Addis, 22'),
(5, '2024-12-21 10:16:04', 1123.98, 'Addis, Golagul'),
(6, '2024-12-27 09:23:11', 1897.99, 'Addis, Piassa'),
(7, '2024-12-09 08:00:32', 1221.98, 'Adama, Franko'),
(8, '2024-12-05 03:12:08', 890.99, 'Hawassa, University');



              --  insrt data into ordersDetail table
			
            
INSERT INTO OrderDetails (OrderID, ProductID, SellerID, Quantity, Price) 
VALUES 
(1, 1, 1, 2, 699.99), 
(2, 2, 2, 5, 1199.99), 
(3, 1, 3, 2, 699.99), 
(4, 2, 4, 23, 1199.99), 
(5, 3, 8, 20, 699.99), 
(6, 2, 5, 10, 1199.99), 
(7, 5, 6, 25, 699.99), 
(8, 4, 7, 30, 1199.99); 


                  -- insert data into shipment table



INSERT INTO Shipment (OrderID, TrackingNumber, ShippedDate, DeliveryDate, Status) 
VALUES 
(1, 'TRK123456', '2024-12-22 12:00:00', '2024-12-24 15:00:00', 'Shipped'),
(2, 'TRK654321', '2024-12-22 13:00:00', '2024-12-25 16:00:00', 'In Transit'),
(1, 'TRK123455', '2024-12-22 10:00:00', '2024-12-27 15:00:00', 'In Transit'),
(2, 'TRK654323', '2024-12-22 13:32:00', '2024-12-23 16:00:00', 'In Transit'),
(1, 'TRK123450', '2024-12-22 11:30:00', '2024-12-17 15:00:00', 'Shipped'),
(2, 'TRK654332', '2024-12-22 09:45:00', '2024-12-22 16:00:00', 'In Transit'),
(1, 'TRK123444', '2024-12-22 12:00:55', '2024-12-12 15:00:00', 'Shipped'),
(2, 'TRK654398', '2024-12-22 08:12:43', '2024-12-20 16:00:00', 'In Transit');



                    -- insert data into payment table
                    

INSERT INTO Payments (OrderID, PaymentMethod, PaymentDate, Amount) 
VALUES 
(1, 'Visa', '2024-12-22 10:05:00', 1399.98),
(2, 'MasterCard', '2024-12-21 11:05:00', 1199.99),
(3, 'Visa', '2024-12-18 10:05:00', 1299.98),
(4, 'MasterCard', '2024-12-19 11:05:00', 1099.99),
(5, 'Visa', '2024-12-25 10:05:00', 1209.98),
(6, 'MasterCard', '2024-12-20 11:05:00', 1009.99),
(7, 'Visa', '2024-12-21 10:05:00', 1399.98),
(8, 'MasterCard', '2024-12-28 11:05:00', 2999.99);



     -- we can use this to show all the datas in the tables
     -- Display data from each table
 SELECT * FROM Customers;
 SELECT * FROM Sellers;
 SELECT * FROM Products;
 SELECT * FROM Inventory;
 SELECT * FROM ShoppingCart;
 SELECT * FROM Orders;
 SELECT * FROM OrderDetails;
 SELECT * FROM Payments;
 SELECT * FROM Shipments;


           --  test the  Implement trigger SQL statements on update, insert and delete statements 
-- to insert and update in the inventory
DELIMITER //

CREATE TRIGGER update_inventory_after_order
AFTER INSERT ON OrderDetails
FOR EACH ROW
BEGIN
    UPDATE inventory
    SET Quantity = Quantity - NEW.Quantity
    WHERE ProductID = NEW.ProductID AND SellerID = NEW.SellerID;
END //

DELIMITER ;

-- to update shipment status
DELIMITER //

CREATE TRIGGER update_shipment_status
AFTER UPDATE ON shipment
FOR EACH ROW
BEGIN
    IF NEW.DeliveryDate IS NOT NULL THEN
        UPDATE shipment
        SET Status = 'Delivered'
        WHERE ShipmentID = NEW.ShipmentID;
    END IF;
END;
//
;

DROP TRIGGER IF EXISTS update_shipment_status;
UPDATE Shipment
        SET Status = 'Delivered'
        WHERE ShipmentID = 4;
        
        DELIMITER //





         -- trigger deleted part
         
         
DELIMITER //

CREATE TRIGGER log_deleted_cart
AFTER DELETE ON shoppingcart
FOR EACH ROW
BEGIN
    INSERT INTO CartLogs (CustomerID, ProductID, SellerID, Quantity, DeletedAt)
    VALUES (OLD.CustomerID, OLD.ProductID, OLD.SellerID, OLD.Quantity, NOW());
END;
//

DELIMITER ;



              -- Implement views to generate reports sales report, tax report, 
             -- inventory report, customers report, products report].  Sales Report
             -- It calculates sales by multiplying Quantity and Price from OrderDetails for each seller.
             -- The query is not stored in the database. It's just a one-time execution when called.
              
              
              
CREATE VIEW SalesReport AS
SELECT 
    s.Name AS SellerName,
    SUM(od.Quantity * od.Price) AS TotalSales
FROM 
    Sellers s
JOIN 
    OrderDetails od ON s.SellerID = od.SellerID
GROUP BY 
    s.SellerID;
    
    -- to display
    SELECT * FROM SalesReport;
          
          
          -- Tax Report
          -- Shows total amounts and tax for orders.
          -- Joins Orders and Customers to calculate taxes.
          
CREATE VIEW TaxReport AS
SELECT 
    o.OrderID,
    c.Name AS CustomerName,
    o.TotalAmount,
    o.TotalAmount * 0.1 AS Tax
FROM 
    Orders o
JOIN 
    Customers c ON o.CustomerID = c.CustomerID;
    -- to display
    SELECT * FROM TaxReport;

    
    
    -- Inventory Report
    -- Joins Inventory, Sellers, and Products to show stock details.
    
    
CREATE VIEW InventoryReport AS
SELECT 
    s.Name AS SellerName,
    p.Name AS ProductName,
    i.Quantity AS AvailableQuantity
FROM 
    Inventory i
JOIN 
    Sellers s ON i.SellerID = s.SellerID
JOIN 
    Products p ON i.ProductID = p.ProductID;
    
    -- to display
    SELECT * FROM InventoryReport;

    
    
    -- Customers Report
    -- Lists customers, their total orders, and total spending.
    -- Counts and sums data for each customer
    
    
CREATE VIEW CustomersReport AS
SELECT 
    c.Name AS CustomerName,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(o.TotalAmount) AS TotalSpent
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.CustomerID = o.CustomerID
GROUP BY 
    c.CustomerID;
    -- to display
    SELECT * FROM CustomersReport;

    
    
    
        -- Products Report
        -- Shows product details and sales data.
        -- Aggregates product sales using OrderDetails.
        
        
CREATE VIEW ProductsReport AS
SELECT 
    p.Name AS ProductName,
    p.Price,
    SUM(od.Quantity) AS TotalSold
FROM 
    Products p
LEFT JOIN 
    OrderDetails od ON p.ProductID = od.ProductID
GROUP BY 
    p.ProductID;

-- to display
SELECT * FROM ProductsReport;



	--  Stored Procedures
	-- Non-Parameterized Stored Procedure
	-- Generates a basic sales report.
    -- it store the procedure

DELIMITER //

CREATE PROCEDURE GenerateSalesReport()
BEGIN
    SELECT * FROM SalesReport;
END;
//

DELIMITER ;
 -- to retrieve
CALL GenerateSalesReport();

-- parameetraized
-- to retrive the specific customer from the table



DELIMITER //

CREATE PROCEDURE GetCustomerOrders(IN CustID INT)
BEGIN
    SELECT 
        o.OrderID,
        o.OrderDate,
        o.TotalAmount
    FROM 
        Orders o
    WHERE 
        o.CustomerID = CustID;
END;
//

DELIMITER ;

CALL GenerateSalesReport();
CALL GetCustomerOrders(3);

		    --  Inner Join
           -- Combines rows from both tables that have matching values in the specified column.
           --  This query returns the OrderID, CustomerName, and TotalAmount by joining the Orders
           -- and Customers tables where the CustomerID matches in both tables.

SELECT 
    o.OrderID,
    c.Name AS CustomerName,
    o.TotalAmount
FROM 
    Orders o
JOIN 
    Customers c ON o.CustomerID = c.CustomerID;
    
    
    
            --  Left Join
            -- Returns all rows from the left table, even if there are no matching rows in the right table.
            -- This query returns all customer names, along with their order details, but if a customer has no orders,
            -- it will still show the customer’s name with NULL values for OrderID and TotalAmount.
	
SELECT 
    c.Name AS CustomerName,
    o.OrderID,
    o.TotalAmount
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.CustomerID = o.CustomerID;


                  -- Full Outer Join
                 --  Returns all rows from both tables, with NULL where no match exists.
                 -- Use it to get results from both tables, including non-matching rows.
                 -- This query returns a list of sellers, their products, and available quantities.
                 -- A combination of all rows from the Sellers, Inventory, and Products tables.
                 
SELECT 
    s.Name AS SellerName,
    p.Name AS ProductName,
    i.Quantity
FROM 
    Sellers s
LEFT JOIN 
    Inventory i ON s.SellerID = i.SellerID
RIGHT JOIN 
    Products p ON i.ProductID = p.ProductID;



                   --  Cross Join
                   --  Returns all possible combinations of rows from two tables.
                   -- Use this when we want to analyze all possible pairings, 
                   -- such as all customers with all products (for marketing or analysis).
                   -- This query creates a result set that contains every combination of a customer and a product. 
                   -- If there are 100 customers and 50 products, the result set will contain 5000 rows.

SELECT 
    c.Name AS CustomerName,
    p.Name AS ProductName
FROM 
    Customers c
CROSS JOIN 
    Products p;

use onlineshopping





							-- transactions scenarios that emulate customers purchase, 
                            -- inventory changes, changes in payments and tax
                            
DELIMITER //
START TRANSACTION;

-- Step 1: Create an order
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount, PaymentStatus)
VALUES (9, NOW(), 100.00, 'Pending');

-- Step 2: Get the new OrderID
SET @OrderID = LAST_INSERT_ID();

-- Step 3: Add order details
INSERT INTO orderdetails (OrderID, ProductID, SellerID, Quantity, Price)
VALUES (@OrderID, 9, 4, 2, 50.00);

-- Step 4: Update inventory
UPDATE inventory
SET Quantity = Quantity - 1
WHERE ProductID = 9 AND SellerID = 4;

-- Step 5: Add payment details
INSERT INTO payments (OrderID, Amount, Tax, PaymentDate, PaymentStatus)
VALUES (@OrderID, 100.00, 10.00, NOW(), 'Completed');

-- Commit the transaction if everything is successful
COMMIT;

        -- those are used to show the transaction
        
SELECT * FROM Orders WHERE CustomerID = 9;
SELECT * FROM orderdetails WHERE OrderID = @OrderID;
SELECT * FROM inventory WHERE ProductID = 9 AND SellerID = 4;
SELECT * FROM payments WHERE OrderID = @OrderID;
SHOW VARIABLES LIKE 'autocommit';




             -- used to prevent errors when the quantity less than 0
UPDATE inventory
SET Quantity = Quantity - 2
WHERE ProductID = 9 AND SellerID = 4 AND Quantity >= 1;



          
ALTER TABLE payments
ADD COLUMN PaymentStatus  varchar(20);



           -- allowing specific people (users) to access the database and giving them only the permissions they need.
           -- a user named admin who can do everything and another user named viewer who can only see data but not change it.
           -- CREATE USER creates a new user in the database, GRANT gives the user specific permissions,FLUSH PRIVILEGES applies the changes.
           
-- Security
-- create user administrator for platform

CREATE USER 'admin'@'localhost' IDENTIFIED BY 'muller1616';
CREATE USER 'viewer'@'localhost' IDENTIFIED BY 'ezra1919';

-- Grant permissions
GRANT ALL PRIVILEGES ON OnlineShopping.* TO 'admin'@'localhost'; -- Full access for admin
GRANT SELECT ON OnlineShopping.* TO 'viewer'@'localhost'; -- Read-only access for viewer

-- Apply changes
FLUSH PRIVILEGES;

-- Check the permissions
SHOW GRANTS FOR 'admin'@'localhost';
SHOW GRANTS FOR 'viewer'@'localhost';

