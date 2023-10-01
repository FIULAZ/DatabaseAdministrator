CREATE SCHEMA app;

USE [Final];

CREATE TABLE app.Toko (
    Id INT PRIMARY KEY,
    [Store Destination] VARCHAR(255),
    [Store Address] VARCHAR(255)
);

INSERT INTO app.Toko (Id, [Store Destination], [Store Address])
VALUES 
(1, 'Apotek Agus Sari', 'Jln Angga Jaya Id 21'),
(2, 'Toko Maju Bersama', 'Jln Agus Salim Id 22'),
(3, 'Toko Anak Sehat', 'Jln Imam Bonjol Id 33'),
(4, 'Apotek Agung', 'Pasar Senen Id 301');


SELECT * FROM app.Toko;

CREATE TABLE app.Kendaraan (
    Id INT PRIMARY KEY,
    [Shipping Vehicle] VARCHAR(255),
    [Id Polisi] VARCHAR(255)
);

INSERT INTO app.Kendaraan (Id, [Shipping Vehicle], [Id Polisi])
VALUES 
(1, 'Box A001', 'B 1234 GA'),
(2, 'Box A002', 'B 3214 JS');

SELECT * FROM app.Kendaraan;

CREATE TABLE app.Operator (
    Id INT PRIMARY KEY,
    [Nama] VARCHAR(255),
);

INSERT INTO app.Operator (Id, [Nama])
VALUES 
(1, 'Ahmad Agus'),
(2, 'Fitrianto');

SELECT * FROM app.Operator;

CREATE TABLE app.Driver (
    Id INT PRIMARY KEY,
    [Nama] VARCHAR(255),
);

INSERT INTO app.Driver (Id, [Nama])
VALUES 
(1, 'Dimas Ahmad'),
(2, 'Hari Saputra'),
(3, 'Ginanjar'),
(4, 'Andi Wahyu'),
(5, 'Dadang Bima');

SELECT * FROM app.Driver;

EXEC sp_rename 'app.DataProduk.[no]', 'id', 'COLUMN';

SELECT * FROM app.DataProduk;


CREATE TABLE app.Pengiriman (
    Id INT PRIMARY KEY,
    ProductNo INT,
    Qty INT,
    StoreDestination INT,
    Operator INT,
    ShippingVehicle INT,
    ShippingDriver INT,
    ShippingCoDriver INT,
    SendingTime DATETIME,
    DeliveredTime DATETIME,
    ReceivedBy VARCHAR(255),
    FOREIGN KEY (StoreDestination) REFERENCES app.Toko(Id),
    FOREIGN KEY (Operator) REFERENCES app.Operator(Id),
    FOREIGN KEY (ShippingVehicle) REFERENCES app.Kendaraan(Id),
    FOREIGN KEY (ShippingDriver) REFERENCES app.Driver(Id),
    FOREIGN KEY (ShippingCoDriver) REFERENCES app.Driver(Id)
);

INSERT INTO app.Pengiriman (Id, ProductNo, Qty, StoreDestination, Operator, ShippingVehicle, ShippingDriver, ShippingCoDriver, SendingTime, DeliveredTime, ReceivedBy)
VALUES
    (1, 1, 5, 1, 1, 1, 1, 4, '2023-05-01 10:00', '2023-05-01 13:30', 'Dian Ayu'),
    (2, 5, 5, 1, 1, 1, 1, 4, '2023-05-01 10:00', '2023-05-01 13:30', 'Dian Ayu'),
    (3, 11, 10, 1, 1, 1, 1, 4, '2023-05-01 10:00', '2023-05-01 13:30', 'Dian Ayu'),
	(4, 1, 3, 2, 1, 2, 2, 5, '2023-05-01 11:00', '2023-05-01 13:00', 'Eriawan'),
    (5, 2, 2, 2, 1, 2, 2, 5, '2023-05-01 11:00', '2023-05-01 13:00', 'Eriawan'),
    (6, 52, 8, 2, 1, 2, 2, 5, '2023-05-01 11:00', '2023-05-01 13:00', 'Eriawan'),
	(7, 35, 10, 3, 2, 1, 3, 2, '2023-05-02 9:00', '2023-05-02 12:00', 'Aji'),
    (8, 36, 5, 3, 2, 1, 3, 2, '2023-05-02 9:00', '2023-05-02 12:00', 'Aji'),
    (9, 42, 12, 3, 2, 1, 3, 2, '2023-05-02 9:00', '2023-05-02 12:00', 'Aji'),
	(10, 24, 10, 3, 2, 1, 3, 2, '2023-05-02 9:00', '2023-05-02 12:00', 'Aji'),
    (11, 49, 5, 4, 2, 1, 3, 2, '2023-05-02 9:00', '2023-05-02 14:00', 'Jamal'),
    (12, 52, 4, 4, 2, 1, 3, 2, '2023-05-02 9:00', '2023-05-02 14:00', 'Jamal'),
	(13, 53, 6, 4, 2, 1, 3, 2, '2023-05-02 9:00', '2023-05-02 14:00', 'Jamal');

INSERT INTO app.Pengiriman (Id, ProductNo, Qty, StoreDestination, Operator, ShippingVehicle, ShippingDriver, ShippingCoDriver, SendingTime, DeliveredTime)
VALUES
	(14, 1, 5, 1, 1, 1, 1, 4, '2023-05-01 10:00', NULL);

INSERT INTO app.Pengiriman (Id, ProductNo, Qty, StoreDestination, Operator, ShippingVehicle, ShippingDriver, ShippingCoDriver, SendingTime)
VALUES
	(15, 1, 5, 1, 1, 1, 1, 4, '2023-05-01 10:00');

DELETE FROM app.pengiriman
WHERE Id IN (14, 16);

SELECT * FROM app.Pengiriman;


SELECT * FROM app.DataProduk;
DELETE FROM app.Pengiriman;


SELECT
    P.Id,
    DP.name,
    P.Qty,
    TD.[Store Destination] AS StoreName,
    O.Nama AS OperatorName,
    KV.[Shipping Vehicle] AS ShippingVehicleName,
    KD.Nama AS ShippingDriverName,
    KCD.Nama AS ShippingCoDriverName,
    P.SendingTime,
    P.DeliveredTime,
    P.ReceivedBy
FROM
    app.pengiriman P
    INNER JOIN app.DataProduk DP ON P.ProductNo = DP.Id
    INNER JOIN app.Toko TD ON P.StoreDestination = TD.Id
    INNER JOIN app.Operator O ON P.Operator = O.Id
    INNER JOIN app.Kendaraan KV ON P.ShippingVehicle = KV.Id
    INNER JOIN app.Driver KD ON P.ShippingDriver = KD.Id
    INNER JOIN app.Driver KCD ON P.ShippingCoDriver = KCD.Id;
--index
USE [Final];
CREATE INDEX idx_DataProduk_No ON app.DataProduk(id);
CREATE INDEX idx_DataProduk_Name ON app.DataProduk(Name);

CREATE INDEX idx_Toko_Id ON app.Toko(Id);
CREATE INDEX idx_Toko_StoreDestination ON app.Toko([Store Destination]);

CREATE INDEX idx_Kendaraan_Id ON app.Kendaraan(Id);
CREATE INDEX idx_Kendaraan_ShippingVehicle ON app.Kendaraan([Shipping Vehicle]);

CREATE INDEX idx_Operator_Id ON app.Operator(Id);
CREATE INDEX idx_Operator_Nama ON app.Operator([Nama]);

CREATE INDEX idx_Driver_Id ON app.Driver(Id);
CREATE INDEX idx_Driver_Nama ON app.Driver([Nama]);

CREATE INDEX idx_Pengiriman_Id ON app.Pengiriman(Id);
CREATE INDEX idx_Pengiriman_ProductNo ON app.Pengiriman(ProductNo);
CREATE INDEX idx_Pengiriman_StoreDestination ON app.Pengiriman(StoreDestination);
CREATE INDEX idx_Pengiriman_Operator ON app.Pengiriman(Operator);
CREATE INDEX idx_Pengiriman_ShippingVehicle ON app.Pengiriman(ShippingVehicle);
CREATE INDEX idx_Pengiriman_ShippingDriver ON app.Pengiriman(ShippingDriver);
CREATE INDEX idx_Pengiriman_ShippingCoDriver ON app.Pengiriman(ShippingCoDriver);
CREATE INDEX idx_Pengiriman_SendingTime ON app.Pengiriman(SendingTime);
CREATE INDEX idx_Pengiriman_DeliveredTime ON app.Pengiriman(DeliveredTime);



SELECT TOP 2
    D.Nama,
    COUNT(P.Id) AS TotalShipments
FROM
    app.pengiriman P
    INNER JOIN app.Driver D ON P.ShippingDriver = D.Id
WHERE
    MONTH(P.SendingTime) = 5 AND YEAR(P.SendingTime) = 2023
GROUP BY
    D.Nama
ORDER BY
    TotalShipments DESC;

SELECT TOP 10
    DP.name,
    COUNT(P.Id) AS TotalShipments
FROM
    app.pengiriman P
    INNER JOIN app.DataProduk DP ON P.ProductNo = DP.Id
WHERE
    MONTH(P.SendingTime) = 5 AND YEAR(P.SendingTime) = 2023
GROUP BY
    DP.name
ORDER BY
    TotalShipments DESC;

SELECT
    P.Id,
    DP.name,
    P.Qty,
    TD.[Store Destination] AS StoreName,
    O.Nama AS OperatorName,
    KV.[Shipping Vehicle] AS ShippingVehicleName,
    KD.Nama AS ShippingDriverName,
    KCD.Nama AS ShippingCoDriverName,
    P.SendingTime,
    P.DeliveredTime,
    P.ReceivedBy
FROM
    app.pengiriman P
    INNER JOIN app.DataProduk DP ON P.ProductNo = DP.Id
    INNER JOIN app.Toko TD ON P.StoreDestination = TD.Id
    INNER JOIN app.Operator O ON P.Operator = O.Id
    INNER JOIN app.Kendaraan KV ON P.ShippingVehicle = KV.Id
    INNER JOIN app.Driver KD ON P.ShippingDriver = KD.Id
    INNER JOIN app.Driver KCD ON P.ShippingCoDriver = KCD.Id
Where
    P.DeliveredTime IS NULL;

CREATE FUNCTION GenerateShipmentID()
RETURNS NVARCHAR(10)
AS
BEGIN
    DECLARE @ID NVARCHAR(10);
    DECLARE @CurrentDate NVARCHAR(10);
    DECLARE @MaxID INT;

    -- Mendapatkan tanggal saat ini dalam format yymmdd
    SET @CurrentDate = CONVERT(NVARCHAR(10), GETDATE(), 12);

    -- Mendapatkan ID Shipment tertinggi saat ini
    SELECT @MaxID = ISNULL(MAX(CAST(RIGHT(ID, 3) AS INT)), 0) 
    FROM app.pengiriman
    WHERE LEFT(ID, 6) = @CurrentDate;

    -- Menambahkan angka urutan dan mengonversikan ke dalam format yang diinginkan
    SET @ID = @CurrentDate + RIGHT('000' + CAST(@MaxID + 1 AS NVARCHAR(3)), 3);

    RETURN @ID;
END;

INSERT INTO app.pengiriman (Id, ProductNo, Qty, StoreDestination, Operator, ShippingVehicle, ShippingDriver, ShippingCoDriver, SendingTime, DeliveredTime, ReceivedBy)
VALUES
    (dbo.GenerateShipmentID(), 4, 5, 1, 1, 1, 1, 4, '2023-05-01 10:00', NULL, 'Dian Ayu');

CREATE PROCEDURE CreateNewShipment
    @ProductNo INT,
    @Qty INT,
    @StoreDestination INT,
    @Operator INT,
    @ShippingVehicle INT,
    @ShippingDriver INT,
    @ShippingCoDriver INT,
    @SendingTime DATETIME,
    @ReceivedBy VARCHAR(255)
AS
BEGIN
    DECLARE @ShipmentID NVARCHAR(10);
    
    -- Generate Shipment ID
    SET @ShipmentID = dbo.GenerateShipmentID();
    
    -- Insert data into pengiriman table
    INSERT INTO app.pengiriman (Id, ProductNo, Qty, StoreDestination, Operator, ShippingVehicle, ShippingDriver, ShippingCoDriver, SendingTime, ReceivedBy)
    VALUES (@ShipmentID, @ProductNo, @Qty, @StoreDestination, @Operator, @ShippingVehicle, @ShippingDriver, @ShippingCoDriver, @SendingTime, @ReceivedBy);
    
    -- Return the generated Shipment ID
    SELECT @ShipmentID AS ShipmentID;
END;

--contoh
DECLARE @ShipmentID NVARCHAR(10);

EXEC CreateNewShipment
    4, 5, 1, 1, 1, 1, 4, '2023-05-01 10:00', 'Dian Ayu',
    @ShipmentID = @ShipmentID OUTPUT; -- Memberikan nilai ke parameter keluaran

-- Menampilkan hasil variabel keluaran @ShipmentID
PRINT 'New Shipment ID: ' + @ShipmentID;

CREATE PROCEDURE AddProductToShipment
    @ShipmentID NVARCHAR(10),
    @ProductNo INT,
    @Qty INT
AS
BEGIN
    -- Insert product into pengiriman detail table
    INSERT INTO app.pengiriman (Id, ProductNo, Qty)
    VALUES (@ShipmentID, @ProductNo, @Qty);
END;

DROP PROCEDURE AddProductToShipment;


--contoh
DECLARE @ShipmentID NVARCHAR(10);

-- Asumsikan @ShipmentID adalah ID Shipment yang sudah ada
SET @ShipmentID = '231001002';

EXEC AddProductToShipment
    @ShipmentID = @ShipmentID,
    @ProductNo = 6,
    @Qty = 3;
