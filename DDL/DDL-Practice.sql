/* **********************************************
 * Simple Table Creation - Columns and Primary Keys
 *
 * Emergency Service & Product
 * Specification Document 1
 * Version 1.0.0
 *
 * Author: Dan Gilleland
 ********************************************** */
-- Select the CREATE DATABASE stement below to create the demo database.
-- CREATE DATABASE [ESP-A01]
USE [ESP-A01] -- this is a statement that tells us to switch to a particular database
-- Notice in the database name above, it is "wrapped" in square brackets because 
-- the name had a hypen in it. 
-- For all our other objects (tables, columns, etc), we won't use hypens or spaces, so
-- the use of square brackets are optional.
GO  -- this statement helps to "separate" various DDL statements in our script
    -- so that they are executed as "blocks" of code.

-- TIP: To refresh this script's knowledge of the DB, Press [ctrl] + [shift] + r



	-- To create a database table, we use the CREATE TABLE statement.
-- Note that the order in which we create/drop tables is important
-- because of how the tables are related via Foreign Keys.
/* DROP TABLE statements (to "clean up" the database for re-creation)  */
/*   You should drop tables in the REVERSE order in which you created them */
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'OrderDetails')
    DROP TABLE OrderDetails
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'InventoryItems')
    DROP TABLE InventoryItems
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Orders')
    DROP TABLE Orders
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Customers')
    DROP TABLE Customers

-- To create a database table, we use the CREATE TABLE statement.
-- Note that the order in which we create/drop tables is important
-- because of how the tables are related via Foreign Keys.
-- Note that square brackets around identifiers is a common standard in writing SQL.
-- Databases in SQL group all their contents into something called a "schema". 
CREATE TABLE Customers
(
    -- The body of a CREATE TABLE will identify a comma-separated list of
    -- Column Declarations and Table Constraints.
    CustomerNumber  int
        -- The following is a PRIMARY KEY constraint that has a specific name
        -- Primary Key constraints ensure a row of data being added to the table
        -- will have to have a unique value for the Primary Key column(s)
        CONSTRAINT PK_Customers_CustomerNumber
            PRIMARY KEY
        -- IDENTITY means the database will generate a unique whole-number
        -- value for this column
        IDENTITY(100, 1) -- The first number is the "seed",
                         -- and the last number is the "increment"
                                        NOT NULL,
    FirstName       varchar(50)         NOT NULL,
    LastName        varchar(60)         NOT NULL,
    [Address]       varchar(40)         NOT NULL,
    City            varchar(35)         NOT NULL,
    Province        char(2)             
		CONSTRAINT DF_Customers_Province
			DEFAULT ('AB')
		-- A Check constraint ensures that only the specified value(s)
		-- will be accepted when adding a row of data
		CONSTRAINT CK_Customers_Province
			Check (Province = 'AB' OR
				   Province = 'BC' OR
				   Province = 'SK' OR
				   Province = 'MB' OR
				   Province = 'QC' OR
				   Province = 'ON' OR
				   Province = 'NT' OR
				   Province = 'NS' OR
				   Province = 'NB' OR
				   Province = 'NL' OR
				   Province = 'YK' OR
				   Province = 'NU' OR
				   Province = 'PE')

										NOT NULL,
    PostalCode      char(6)             
		CONSTRAINT CK_Customers_PostalCode
			CHECK (PostalCode Like '[A-Z][0-9][A-Z][0-9][A-Z][0-9]')
										NOT NULL,
    PhoneNumber     char(13)                
		CONSTRAINT CK_Customers_PhoneNumber
			CHECK (PhoneNumber like
					'([0-9][0-9][0-9])[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
										NULL  -- NULL means the data is optional
)

CREATE TABLE Orders
(
    OrderNumber     int
        CONSTRAINT PK_Orders_OrderNumber
            PRIMARY KEY
        IDENTITY(200, 1)                NOT NULL,
    CustomerNumber  int
        -- Foreign Key constraints ensure that when a row of data is being
        -- inserted or updated, there is a row in the referenced table
        -- that has the same value as its Primary Key
        CONSTRAINT FK_Orders_CustomerNumber_Customers_CustomerNumber
            FOREIGN KEY REFERENCES
            Customers(CustomerNumber)   NOT NULL,
    [Date]          datetime            NOT NULL,
    Subtotal        money               
        CONSTRAINT CK_Orders_Subtotal
            CHECK (Subtotal > 0)		NOT NULL,
    GST             money               
        CONSTRAINT CK_Orders_GST
            CHECK (GST >= 0)			NOT NULL,
    Total           AS Subtotal + GST   -- This is now a Computed Column
)

CREATE TABLE InventoryItems
(
    ItemNumber          varchar(5)
        CONSTRAINT PK_InventoryItems_ItemNumber
            PRIMARY KEY                     NOT NULL,
    ItemDescription     varchar(50)             NULL,
    CurrentSalePrice    money
        CONSTRAINT CK_InventoryItems_CurrentSalePrice
            CHECK (CurrentSalePrice > 0)    NOT NULL,
    InStockCount        int                 NOT NULL,
    ReorderLevel        int                 NOT NULL
)

CREATE TABLE OrderDetails
(
    OrderNumber     int
        CONSTRAINT FK_OrderDetails_OrderNumber_Orders_OrderNumber
            FOREIGN KEY REFERENCES
            Orders(OrderNumber)         NOT NULL,
    ItemNumber      varchar(5)
        CONSTRAINT FK_OrderDetails_ItemNumber_InventoryItems_ItemNumber
            FOREIGN KEY REFERENCES
            InventoryItems(ItemNumber)  NOT NULL,
    Quantity        int                 
		CONSTRAINT DF_OrderDetails_Quantity
			DEFAULT (1)
		CONSTRAINT CK_OrderDetails_Quantity
			CHECK	(Quantity > 0)
										NOT NULL,
    SellingPrice    money
		CONSTRAINT CK_OrderDetails_SellingPrice
			CHECK (SellingPrice >= 0)   NOT NULL,
    Amount          AS Quantity * SellingPrice  ,
    -- The following is a Table Constraint
    -- A composite primary key MUST be done as a Table Constraint
    -- because it involves two or more columns
    CONSTRAINT PK_OrderDetails_OrderNumber_ItemNumber
        PRIMARY KEY (OrderNumber, ItemNumber) -- Specify all the columns in the PK
)

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PaymentLogDetails')
    DROP TABLE PaymentLogDetails
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Payments')
    DROP TABLE Payments

CREATE TABLE PaymentLogDetails
(
    ItemNumber          varchar(5)          NOT NULL,
    ItemDescription     varchar(50)             NULL,
    CurrentSalePrice    money               NOT NULL,
    InStockCount        int                 NOT NULL,
    ReorderLevel        int                 NOT NULL
)

CREATE TABLE Payments
(
    OrderNumber     int                 NOT NULL,
    ItemNumber      varchar(5)          NOT NULL,
    Quantity        int                 NOT NULL,
    SellingPrice    money               NOT NULL,
    Amount          money               NOT NULL
)
-- Let's insert a few rows of data for the tables (DML Statements)
PRINT 'Inserting customer data'
INSERT INTO Customers(FirstName, LastName, [Address], City, PostalCode)
    VALUES ('Clark','Kent', '344 Clinton Street', 'Metropolis', 'S0S0N0')
INSERT INTO Customers(FirstName, LastName, [Address], City, PostalCode)
    VALUES ('Jimmy', 'Olsen', '242 River Close', 'Bakerline', 'B4K3R1')
PRINT '-- end of customer data --'
Print ''

--Leet's write an SQL Query statement to view the data in the database
-- Select the customer information
SELECT CustomerNumber, FirstName,LastName,
       [Address] + '' + City + ',' + Province AS 'Customer Address',
       PhoneNumber
FROM Customers

-- Let's insert a few rows of data for inventory items
PRINT 'Inserting inventory items'
INSERT INTO InventoryItems(ItemNumber, ItemDescription, CurrentSalePrice, InStockCount, ReorderLevel)
	VALUES ('H8726', 'Cleaning Fan Belt', 29.95, 3 ,5),
		   ('H8621', 'Engine Fan Belt', 17.45, 10, 5)
		   
-- Let's do a "quick'n'dirty" select of Inventory Items

SELECT * FROM InventoryItems
-- Notice how the data in the InventoryItems is already sorted by the PK
-- This is because the PK of a table is (by default) a clustered 

-- Let's do another set of DML statements to add more data to the database
PRINT 'Inserting an order'
INSERT INTO Orders(CustomerNumber, [Date], Subtotal, GST)
    VALUES (100, GETDATE(), 17.45, 0.87)
INSERT INTO OrderDetails(OrderNumber, ItemNumber, Quantity, SellingPrice)
    VALUES (200, 'H8726', 1, 17.45)
PRINT '-- end of order data--'
PRINT ''
GO

/*************************
 * Change REquests for Spect 1
 * Perform table changes through ALTER statements.
 * Syntax for ALTER TABLE can be found at
 *  http://msdn.microsoft.com/en-us/library/ms190273.aspx
 * ALTER TABLE statements allows us to change an existing table without
 * having to drop it or lose information in the table
 ************************/
 -- A) Allow address, City, Province, and Postal Code to be NULL
ALTER TABLE Customers
	ALTER COLUMN [Address] varchar(40) NULL
GO -- this staements helps to "separate" various DDL statements in our script. It's optional.

ALTER TABLE Customers 
	ALTER COLUMN City varchar(35) NULL
GO

ALTER TABLE Customers
	ALTER COLUMN Province char(2) NULL
GO

ALTER TABLE Customers
	ALTER COLUMN PostalCode char(6) NULL
GO

 -- B) Add a check constraint on the First and Last name to require at least two letters.
--	% is a wildcard for zero or more characters (letter, digit, or other character)
--	_ is a wildcard for a single character (letter, digit, or other character)
--	[] are used to represent a range or set of characters that are allowed
ALTER TABLE Customers
	ADD CONSTRAINT CK_Customers_FirstName
		CHECK (FirstName LIKE '[A-Z][A-Z]%') -- two letters plus any other chars
--							   \ 1 /\ 1 /
ALTER TABLE Customers
	ADD CONSTRAINT CK_Customers_LastName
		CHECK (LastName LIKE '[A-Z][A-Z]%')

-- Once the ALTER TABLE changes are made for A) and B),
-- we can insert customer information allowing certain columns to be NULL.
INSERT INTO Customers(FirstName, LastName)
	VALUES ('Fred', 'Flintstone')
INSERT INTO Customers(FirstName, LastName)
	VALUES ('Barney', 'Rubble')
INSERT INTO Customers(FirstName, LastName, PhoneNumber)
	VALUES ('Wilma', 'Slaghoople', '(403)555-1212')
INSERT INTO Customers(FirstName, LastName, [Address], City)
	VALUES ('Betty', 'Mcbricker', '103 Granit Road', 'Bedrock')
GO
	-- Select the customer information
SELECT	CustomerNumber, FirstName, LastName, [Address] + '' + City + ',' + Province AS 'Customer Address', PhoneNumber
From	Customers
GO

 -- C) add an extra bit of information on the Customer table. The client wants to start tracking customer emails,
 --    so they can send out statements for outstanding payments that are due at the end of the month.
 ALTER TABLE Customers
	ADD Email varchar(30) NULL
	-- Adding this as a nullable column, because customers already exist, and we don't have emails for those customers.
GO

 -- D) Add indexes to the Customer's First and Last Name columns
CREATE NONCLUSTERED INDEX IX_Customers_FirstName
	ON Customers (FirstName)
CREATE NONCLUSTERED INDEX IX_Customers_LastName
	ON Customers (LastName)
Go -- End of a batch of instructions

 -- E) Add a defaullt constraint on the Orders.Date column to use the current date.
 -- GETDATE() is a global function in the SQL Server Database
 -- GETDATE() will obtain the current date/time on the database server
ALTER TABLE Orders
	ADD CONSTRAINT DF_Orders_Date
		DEFAULT GETDATE() FOR [DATE]
--		Use     \ this  /     \this column/ if no value was supplied when INSERTING data
GO
-- To illustrate the default value, consider this sample row for the Orders table
INSERT INTO Orders(CustomerNumber, Subtotal, GST)
	VALUES (101, 150.00, 7.50)
-- Select the current orders
SELECT	OrderNumber, CustomerNumber, Total, [Date]
From	Orders
GO 
 
 -- F) Change the InventoryItems. ItemDescription column to be NOT NULL

 -- G) Add an index on the Item's Description column, to improve search.

 --H) Data change requests: All inventory items that are less than $5.00 have to 
 --   have their prices increased by 10%.

/*=================Practive SQL Below=========================*/