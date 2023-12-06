CREATE DATABASE orders;
go

USE orders;
go

DROP TABLE review;
DROP TABLE shipment;
DROP TABLE productinventory;
DROP TABLE warehouse;
DROP TABLE orderproduct;
DROP TABLE incart;
DROP TABLE product;
DROP TABLE category;
DROP TABLE ordersummary;
DROP TABLE paymentmethod;
DROP TABLE customer;


CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE category (
    categoryId          INT IDENTITY,
    categoryName        VARCHAR(50),    
    PRIMARY KEY (categoryId)
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(40),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(100),
    productImage        VARBINARY(MAX),
    productDesc         VARCHAR(1000),
    categoryId          INT,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),    
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(100),   
    warehouseId         INT, 
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,   
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(1000),          
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO category(categoryName) VALUES ('Premier League');
INSERT INTO category(categoryName) VALUES ('La liga');
INSERT INTO category(categoryName) VALUES ('Bundesliga');
INSERT INTO category(categoryName) VALUES ('Indian Super league');
INSERT INTO category(categoryName) VALUES ('Uber Eats Ligue 1');


INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Arsenal Jersey 24/25', 1, 'Embrace the legacy of Arsenal with our official 2024-2025 edition jersey, a symbol of pride for every devoted fan',18.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('West Ham Jersey 23/24', 1, 'Embrace the legacy of West Ham with our official 2023-2024 edition jersey, a symbol of pride for every devoted fan',38.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Liverpool Jersey 23/24', 1, 'Embrace the legacy of Liverpool with our official 2023-2024 edition jersey, a symbol of pride for every devoted fan',108.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Manchester City Jersey 21/22', 1, 'Embrace the legacy of Manchester City with our official 2021-2022 edition jersey, a symbol of pride for every devoted fan',1.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Manchester United  Jersey 21/22', 1, 'Embrace the legacy of Manchester United with our official 2021-2022 edition jersey, a symbol of pride for every devoted fan',70.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Real Madrid Jersey 23/24', 2, 'Embrace the legacy of Real Madrid with our official 2023-2024 edition jersey, a symbol of pride for every devoted fan',130.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('FC Barcelona Jersey 24/25', 2, 'Embrace the legacy of Barcelona with our official 2024-2025 edition jersey, a symbol of pride for every devoted fan',70.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Atletico Madrid Jersey 22/23', 2, 'Embrace the legacy of Atletico Madrid with our official 2022-2023 edition jersey, a symbol of pride for every devoted fan',11.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Getafe Jersey 24/25', 2, 'Embrace the legacy of Getafe with our official 2024-2025 edition jersey, a symbol of pride for every devoted fan',20.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Girona Jersey 24/25', 2, 'Embrace the legacy of Girona with our official 2024-2025 edition jersey, a symbol of pride for every devoted fan',31.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Bayern Munich Jersey 24/25', 3, 'Embrace the legacy of Bayern Munich with our official 2024-2025 edition jersey, a symbol of pride for every devoted fan',90.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Dortmund Jersey 24/25', 3, 'Embrace the legacy of Dortmund with our official 2024-2025 edition jersey, a symbol of pride for every devoted fan',60.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Frankfurt Jersey 24/25', 3, 'Embrace the legacy of Frankfurt with our official 2024-2025 edition jersey, a symbol of pride for every devoted fan',15.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Hamburger SV Jersey 24/25', 3, 'Embrace the legacy of Hamburger SV with our official 2024-2025 edition jersey, a symbol of pride for every devoted fan',18.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Hannover 96 Jersey 24/25', 3, 'Embrace the legacy of Hannover with our official 2024-2025 edition jersey, a symbol of pride for every devoted fan',18.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Mumbai City Fc Jersey 23/24', 4, 'Embrace the legacy of Mumbai City  with our official 2023-2024 edition jersey, a symbol of pride for every devoted fan',35.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Kerala Blasters FC Jersey 23/24', 4, 'Embrace the legacy of Kerala Blasters with our official 2023-2024 edition jersey, a symbol of pride for every devoted fan',10.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('FC Goa Jersey 24/25', 4, 'Embrace the legacy of Goa with our official 2024-2025 edition jersey, a symbol of pride for every devoted fan',50.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('North East United FC Jersey 24/25', 4, 'Embrace the legacy of North East United  with our official 2024-2025 edition jersey, a symbol of pride for every devoted fan',7.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Chennaiyan FC Jersey 24/25', 4, 'Embrace the legacy of Arsenal with our official 2024-2025 edition jersey, a symbol of pride for every devoted fan',19.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Paris-Saint-Germain Jersey 24/25', 5, 'Embrace the legacy of PSG with our official 2024-2025 edition jersey, a symbol of pride for every devoted fan',15.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Lille Jersey 24/25', 5, 'Embrace the legacy of Lille with our official 2024-2025 edition jersey, a symbol of pride for every devoted fan',15.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES (' Olympique Marseille Jersey 24/25', 5, 'Embrace the legacy of Olympique Marseille with our official 2024-2025 edition jersey, a symbol of pride for every devoted fan',15.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Monaco FC Jersey 24/25', 5, 'Embrace the legacy of Monaco with our official 2024-2025 edition jersey, a symbol of pride for every devoted fan',15.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Olympique Lyon Jersey 24/25', 5, 'Embrace the legacy of Arsenal with our official 2024-2025 edition jersey, a symbol of pride for every devoted fan',15.00);



INSERT INTO warehouse(warehouseName) VALUES ('Main warehouse');
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (1, 1, 5, 18);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (2, 1, 10, 38.00);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (3, 1, 3, 108.00);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (4, 1, 2, 1.00);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (5, 1, 6, 70.00);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (6, 1, 3, 130.00);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (7, 1, 1, 70.00);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (8, 1, 0, 11.00);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (9, 1, 2, 20.00);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (10, 1, 3, 31.00);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (11, 1, 3, 90.00);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (12, 1, 3, 60.00);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (13, 1, 3, 15.00);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (14, 1, 3, 18.00);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (15, 1, 3, 18.00);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (16, 1, 3, 18.00);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (17, 1, 3, 18.00);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (18, 1, 3, 18.00);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (19, 1, 3, 35.00);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (20, 1, 3, 10.00);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (21, 1, 3, 50.00);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (22, 1, 3, 7.00);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (23, 1, 3, 19.00);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (24, 1, 3, 15.00);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (25, 1, 3, 15.00);


INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , '304Arnold!');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , '304Bobby!');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Candace', 'Cole', 'cole@charity.org', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'candace' , '304Candace!');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Darren', 'Doe', 'oe@doe.com', '250-807-2222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'darren' , '304Darren!');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Elizabeth', 'Elliott', 'engel@uiowa.edu', '555-666-7777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'beth' , '304Beth!');

-- Order 1 can be shipped as have enough inventory
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (1, '2019-10-15 10:25:55', 91.70)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 1, 1, 18)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 2, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 10, 1, 31);

INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-16 18:00:00', 106.75)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 5, 21.35);

-- Order 3 cannot be shipped as do not have enough inventory for item 7
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (3, '2019-10-15 3:30:22', 140)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 6, 2, 25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 7, 3, 30);

INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-17 05:45:11', 327.85)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 3, 4, 10)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 8, 3, 40)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 13, 3, 23.25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 28, 2, 21.05)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 29, 4, 14);

INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (5, '2019-10-15 10:25:55', 277.40)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 4, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 19, 2, 81)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 20, 3, 10);

-- New SQL DDL for lab 8
UPDATE Product SET productImageURL = 'img/arsh.png' WHERE ProductId = 1;
UPDATE Product SET productImageURL = 'img/whmh.png' WHERE ProductId = 2;
UPDATE Product SET productImageURL = 'img/livh.png' WHERE ProductId = 3;
UPDATE Product SET productImageURL = 'img/mcih.png' WHERE ProductId = 4;
UPDATE Product SET productImageURL = 'img/munh.png' WHERE ProductId = 5;
UPDATE Product SET productImageURL = 'img/rmh.png' WHERE ProductId = 6;
UPDATE Product SET productImageURL = 'img/barh.png' WHERE ProductId = 7;
UPDATE Product SET productImageURL = 'img/atmh.png' WHERE ProductId = 8;
UPDATE Product SET productImageURL = 'img/geth.png' WHERE ProductId = 9;
UPDATE Product SET productImageURL = 'img/girh.png' WHERE ProductId = 10;
UPDATE Product SET productImageURL = 'img/fcbh.png' WHERE ProductId = 11;
UPDATE Product SET productImageURL = 'img/doth.png' WHERE ProductId = 12;
UPDATE Product SET productImageURL = 'img/frkh.png' WHERE ProductId = 13;
UPDATE Product SET productImageURL = 'img/hsvh.png' WHERE ProductId = 14;
UPDATE Product SET productImageURL = 'img/h96h.png' WHERE ProductId = 15;
UPDATE Product SET productImageURL = 'img/mumh.png' WHERE ProductId = 16;
UPDATE Product SET productImageURL = 'img/kerh.png' WHERE ProductId = 17;
UPDATE Product SET productImageURL = 'img/goah.png' WHERE ProductId = 18;
UPDATE Product SET productImageURL = 'img/neuh.png' WHERE ProductId = 19;
UPDATE Product SET productImageURL = 'img/chnh.png' WHERE ProductId = 20;
UPDATE Product SET productImageURL = 'img/psgh.png' WHERE ProductId = 21;
UPDATE Product SET productImageURL = 'img/lilh.png' WHERE ProductId = 22;
UPDATE Product SET productImageURL = 'img/OMRH.png' WHERE ProductId = 23;
UPDATE Product SET productImageURL = 'img/monh.png' WHERE ProductId = 24;
UPDATE Product SET productImageURL = 'img/olyh.png' WHERE ProductId = 25;
