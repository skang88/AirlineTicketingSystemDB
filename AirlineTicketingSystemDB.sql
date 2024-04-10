/*
** This is airline ticketing database for 2023 FALL project (IFT530 Course)
** Author: Seokgyun Kang
** History
** Date Created		Comments
** 11/01/2023		Create Database
** 11/08/2023		Populate the tables
** 11/15/2023       Create view tables
** 11/17/2023       Create Audit table
** 11/22/2023       Create two stored procedures
** 11/27/2023       Create two cursor
*/


-- Create Database named my name and student ID
PRINT('Creating Database...')
USE master;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'SEOKG375')
BEGIN
    ALTER DATABASE SEOKG375 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE SEOKG375;
END
GO

CREATE DATABASE SEOKG375;
GO

USE SEOKG375;

-- Create Tables 6 reference tables and 2 transaction tables
PRINT('Creating tables...')

-- Passenger Table
IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID('dbo.Passenger'))
DROP TABLE dbo.Passenger;
CREATE TABLE Passenger (
    PassengerID VARCHAR(10) PRIMARY KEY,
    PassportNumber VARCHAR(30),
    FirstName VARCHAR(30),
    LastName VARCHAR(30),
    DateOfBirth DATE,
    Email VARCHAR(50),
    Phone VARCHAR(30)
);

-- Airport Table
IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID('dbo.Airport'))
DROP TABLE dbo.Airport;
CREATE TABLE Airport (
    AirportID VARCHAR(10) PRIMARY KEY,
    AirportName VARCHAR(30),
    Country VARCHAR(30),
    State VARCHAR(30),
    City VARCHAR(30)
);

-- Aircraft Table
IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID('dbo.Aircraft'))
DROP TABLE dbo.Aircraft;
CREATE TABLE Aircraft (
    AircraftID VARCHAR(10) PRIMARY KEY,
    AirplaneModel VARCHAR(30),
    Capacity INT,
    NumberofEconomy INT,
    NumberofBusiness INT,
    NumberofFirstClass INT
);

-- Airlines Table
IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID('dbo.Airlines'))
DROP TABLE dbo.Airlines;
CREATE TABLE Airlines (
    AirlineID VARCHAR(10) PRIMARY KEY,
    AirlineName VARCHAR(30),
    Country VARCHAR(30),
    State VARCHAR(30),
    City VARCHAR(30)
);

-- Flight Table
IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID('dbo.Flight'))
DROP TABLE dbo.Flight;
CREATE TABLE Flight (
    FlightID VARCHAR(10) PRIMARY KEY,
    AirlineCode VARCHAR(10) REFERENCES Airlines(AirlineID),
    FlightNumber VARCHAR(30),
    OriginAirportID VARCHAR(10) REFERENCES Airport(AirportID),
    DestinationAirportID VARCHAR(10) REFERENCES Airport(AirportID),
    DepartDateTime DATETIME,
    ArriveDateTime DATETIME,
    AirplaneID VARCHAR(10) REFERENCES Aircraft(AircraftID),
    GateNumber VARCHAR(10)
);

-- Seats Table
IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID('dbo.Seats'))
DROP TABLE dbo.Seats;
CREATE TABLE Seats (
    FlightID VARCHAR(10) REFERENCES Flight(FlightID),
    SeatID VARCHAR(10) PRIMARY KEY,
    SeatNumber VARCHAR(10),
    SeatClass VARCHAR(20),
    IsBooked BIT,
    Price INT
);

-- Booking Table
IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID('dbo.Booking'))
DROP TABLE dbo.Booking;
CREATE TABLE Booking (
    PassengerID VARCHAR(10) REFERENCES Passenger(PassengerID),
    BookingID VARCHAR(10) PRIMARY KEY,
    FlightID VARCHAR(10) REFERENCES Flight(FlightID),
    SeatID VARCHAR(10) REFERENCES Seats(SeatID)
);

-- Payment Table
IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID('dbo.Payment'))
DROP TABLE dbo.Payment;
CREATE TABLE Payment (
    TransactionID VARCHAR(10) PRIMARY KEY,
    BookingID VARCHAR(10) REFERENCES Booking(BookingID),
    PaymentMethod VARCHAR(30),
    PaymentAmount MONEY
);

PRINT('Finished!')


-- Populating tables
-- Passenger Table
INSERT INTO Passenger (PassengerID, PassportNumber, FirstName, LastName, DateOfBirth, Email, Phone)
VALUES
('P001', 'AB123456', 'John', 'Doe', '1980-05-15', 'john.doe@example.com', '123-456-7890'),
('P002', 'CD789012', 'Jane', 'Smith', '1992-08-22', 'jane.smith@example.com', '987-654-3210'),
('P003', 'EF345678', 'Michael', 'Johnson', '1975-03-10', 'michael.j@example.com', '456-789-0123'),
('P004', 'GH901234', 'Emily', 'Davis', '1988-11-28', 'emily.d@example.com', '789-012-3456'),
('P005', 'IJ567890', 'Christopher', 'Brown', '1995-06-05', 'chris.brown@example.com', '012-345-6789'),
('P006', 'KL123456', 'Sophia', 'Miller', '1982-09-18', 'sophia.m@example.com', '234-567-8901'),
('P007', 'MN789012', 'Daniel', 'Wilson', '1978-12-03', 'daniel.w@example.com', '567-890-1234'),
('P008', 'OP345678', 'Ava', 'Martinez', '1990-04-20', 'ava.martinez@example.com', '890-123-4567'),
('P009', 'QR901234', 'Matthew', 'Anderson', '1987-01-15', 'matthew.a@example.com', '123-234-5678'),
('P010', 'ST567890', 'Olivia', 'Taylor', '1999-07-28', 'olivia.t@example.com', '234-345-6789');

-- Airlines Table
INSERT INTO Airlines (AirlineID, AirlineName, Country, State, City)
VALUES
('A001', 'Airline1', 'USA', 'NY', 'New York'),
('A002', 'Airline2', 'Canada', 'ON', 'Toronto'),
('A003', 'Airline3', 'UK', 'England', 'London'),
('A004', 'Airline4', 'France', 'Île-de-France', 'Paris'),
('A005', 'Airline5', 'Germany', 'Bavaria', 'Munich'),
('A006', 'Airline6', 'Japan', 'Tokyo', 'Tokyo'),
('A007', 'Airline7', 'Australia', 'NSW', 'Sydney'),
('A008', 'Airline8', 'South Korea', 'Seoul', 'Seoul'),
('A009', 'Airline9', 'Brazil', 'SP', 'Sao Paulo'),
('A010', 'Airline10', 'China', 'Beijing', 'Beijing');

-- Airport Table
INSERT INTO Airport (AirportID, AirportName, Country, State, City)
VALUES
('AIR001', 'Airport1', 'USA', 'NY', 'New York'),
('AIR002', 'Airport2', 'USA', 'CA', 'Los Angeles'),
('AIR003', 'Airport3', 'Canada', 'ON', 'Toronto'),
('AIR004', 'Airport4', 'UK', 'England', 'London'),
('AIR005', 'Airport5', 'France', 'Île-de-France', 'Paris'),
('AIR006', 'Airport6', 'Germany', 'Bavaria', 'Munich'),
('AIR007', 'Airport7', 'Japan', 'Tokyo', 'Tokyo'),
('AIR008', 'Airport8', 'Australia', 'NSW', 'Sydney'),
('AIR009', 'Airport9', 'South Korea', 'Seoul', 'Seoul'),
('AIR010', 'Airport10', 'Brazil', 'SP', 'Sao Paulo');

-- Aircraft Table
INSERT INTO Aircraft (AircraftID, AirplaneModel, Capacity, NumberofEconomy, NumberofBusiness, NumberofFirstClass)
VALUES
('AC001', 'Model1', 150, 50, 50, 50),
('AC002', 'Model2', 200, 100, 50, 50),
('AC003', 'Model3', 180, 80, 40, 60),
('AC004', 'Model4', 170, 70, 50, 50),
('AC005', 'Model5', 160, 60, 40, 60),
('AC006', 'Model6', 190, 90, 40, 60),
('AC007', 'Model7', 210, 110, 50, 50),
('AC008', 'Model8', 180, 80, 50, 50),
('AC009', 'Model9', 200, 100, 60, 40),
('AC010', 'Model10', 220, 120, 50, 50);

-- Flight Table
INSERT INTO Flight (FlightID, AirlineCode, FlightNumber, OriginAirportID, DestinationAirportID, DepartDateTime, ArriveDateTime, AirplaneID, GateNumber)
VALUES
('F001', 'A001', 'AA101', 'AIR001', 'AIR002', '2023-01-15 08:00:00', '2023-01-15 10:30:00', 'AC001', 'GATE1'),
('F002', 'A002', 'BB202', 'AIR002', 'AIR003', '2023-02-20 12:30:00', '2023-02-20 15:00:00', 'AC002', 'GATE2'),
('F003', 'A001', 'CC303', 'AIR003', 'AIR001', '2023-03-25 16:45:00', '2023-03-25 19:15:00', 'AC001', 'GATE3'),
('F004', 'A003', 'DD404', 'AIR004', 'AIR005', '2023-04-10 09:15:00', '2023-04-10 12:45:00', 'AC003', 'GATE4'),
('F005', 'A004', 'EE505', 'AIR005', 'AIR006', '2023-05-05 18:30:00', '2023-05-05 21:00:00', 'AC004', 'GATE5'),
('F006', 'A002', 'FF606', 'AIR006', 'AIR002', '2023-06-15 11:45:00', '2023-06-15 14:15:00', 'AC002', 'GATE6'),
('F007', 'A005', 'GG707', 'AIR007', 'AIR008', '2023-07-20 15:30:00', '2023-07-20 18:00:00', 'AC005', 'GATE7'),
('F008', 'A006', 'HH808', 'AIR008', 'AIR009', '2023-08-10 07:00:00', '2023-08-10 09:30:00', 'AC006', 'GATE8'),
('F009', 'A007', 'II909', 'AIR009', 'AIR007', '2023-09-05 22:00:00', '2023-09-06 01:30:00', 'AC007', 'GATE9'),
('F010', 'A008', 'JJ1010', 'AIR010', 'AIR004', '2023-10-12 14:15:00', '2023-10-12 16:45:00', 'AC008', 'GATE10');

-- Seats Table
INSERT INTO Seats (FlightID, SeatID, SeatNumber, SeatClass, IsBooked, Price)
VALUES
('F001', 'S001', '1A', 'Business', 0, 200.00),
('F001', 'S002', '1B', 'Business', 1, 200.00),
('F001', 'S003', '2A', 'Economy', 0, 100.00),
('F001', 'S004', '2B', 'Economy', 1, 100.00),
('F001', 'S005', '3A', 'First Class', 0, 300.00),
('F001', 'S006', '3B', 'First Class', 0, 300.00),
('F001', 'S007', '1C', 'Economy', 0, 100.00),
('F001', 'S008', '1D', 'Economy', 0, 100.00),
('F001', 'S009', '2C', 'Business', 0, 200.00),
('F001', 'S010', '2D', 'Business', 0, 200.00),
('F002', 'S011', '1A', 'Business', 0, 200.00),
('F002', 'S012', '1B', 'Business', 1, 200.00),
('F002', 'S013', '2A', 'Economy', 0, 100.00),
('F002', 'S014', '2B', 'Economy', 1, 100.00),
('F002', 'S015', '3A', 'First Class', 0, 300.00),
('F002', 'S016', '3B', 'First Class', 0, 300.00),
('F002', 'S017', '1C', 'Economy', 0, 100.00),
('F002', 'S018', '1D', 'Economy', 0, 100.00),
('F002', 'S019', '2C', 'Business', 0, 200.00),
('F002', 'S020', '2D', 'Business', 0, 200.00),
('F003', 'S021', '1A', 'Business', 0, 200.00),
('F003', 'S022', '1B', 'Business', 1, 200.00),
('F003', 'S023', '2A', 'Economy', 0, 100.00),
('F003', 'S024', '2B', 'Economy', 1, 100.00),
('F003', 'S025', '3A', 'First Class', 0, 300.00),
('F003', 'S026', '3B', 'First Class', 0, 300.00),
('F003', 'S027', '1C', 'Economy', 0, 100.00),
('F003', 'S028', '1D', 'Economy', 0, 100.00),
('F003', 'S029', '2C', 'Business', 0, 200.00),
('F003', 'S030', '2D', 'Business', 0, 200.00);

-- Booking Table
INSERT INTO Booking (PassengerID, BookingID, FlightID, SeatID)
VALUES
('P001', 'B001', 'F001', 'S001'),
('P002', 'B002', 'F002', 'S002'),
('P003', 'B003', 'F003', 'S003'),
('P004', 'B004', 'F001', 'S004'),
('P005', 'B005', 'F002', 'S005'),
('P006', 'B006', 'F003', 'S006'),
('P007', 'B007', 'F001', 'S007'),
('P008', 'B008', 'F002', 'S008'),
('P009', 'B009', 'F003', 'S009'),
('P010', 'B010', 'F001', 'S010'),
('P001', 'B011', 'F002', 'S011'),
('P002', 'B012', 'F003', 'S012'),
('P003', 'B013', 'F001', 'S013'),
('P004', 'B014', 'F002', 'S014'),
('P005', 'B015', 'F003', 'S015'),
('P006', 'B016', 'F001', 'S016'),
('P007', 'B017', 'F002', 'S017'),
('P008', 'B018', 'F003', 'S018'),
('P009', 'B019', 'F001', 'S019'),
('P010', 'B020', 'F002', 'S020'),
('P001', 'B021', 'F003', 'S021'),
('P002', 'B022', 'F001', 'S022'),
('P003', 'B023', 'F002', 'S023'),
('P004', 'B024', 'F003', 'S024'),
('P005', 'B025', 'F001', 'S025'),
('P006', 'B026', 'F002', 'S026'),
('P007', 'B027', 'F003', 'S027'),
('P008', 'B028', 'F001', 'S028'),
('P009', 'B029', 'F002', 'S029'),
('P010', 'B030', 'F003', 'S030');

-- Payment Table
INSERT INTO Payment (TransactionID, BookingID, PaymentMethod, PaymentAmount)
VALUES
('T001', 'B001', 'Credit Card', 150.00),
('T002', 'B002', 'PayPal', 200.00),
('T003', 'B003', 'Credit Card', 120.00),
('T004', 'B004', 'PayPal', 180.00),
('T005', 'B005', 'Credit Card', 130.00),
('T006', 'B006', 'PayPal', 190.00),
('T007', 'B007', 'Credit Card', 160.00),
('T008', 'B008', 'PayPal', 210.00),
('T009', 'B009', 'Credit Card', 140.00),
('T010', 'B010', 'PayPal', 220.00),
('T011', 'B011', 'Credit Card', 155.00),
('T012', 'B012', 'PayPal', 205.00),
('T013', 'B013', 'Credit Card', 125.00),
('T014', 'B014', 'PayPal', 185.00),
('T015', 'B015', 'Credit Card', 135.00),
('T016', 'B016', 'PayPal', 195.00),
('T017', 'B017', 'Credit Card', 165.00),
('T018', 'B018', 'PayPal', 215.00),
('T019', 'B019', 'Credit Card', 145.00),
('T020', 'B020', 'PayPal', 225.00),
('T021', 'B021', 'Credit Card', 160.00),
('T022', 'B022', 'PayPal', 210.00),
('T023', 'B023', 'Credit Card', 130.00),
('T024', 'B024', 'PayPal', 190.00),
('T025', 'B025', 'Credit Card', 140.00),
('T026', 'B026', 'PayPal', 200.00),
('T027', 'B027', 'Credit Card', 170.00),
('T028', 'B028', 'PayPal', 220.00),
('T029', 'B029', 'Credit Card', 150.00),
('T030', 'B030', 'PayPal', 230.00);
GO

-- Create view tables
-- PassengerBookingView
IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID('dbo.PassengerBookingView'))
DROP VIEW dbo.PassengerBookingView;
GO

CREATE VIEW PassengerBookingView AS
SELECT
    P.PassengerID,
    P.FirstName,
    P.LastName,
    B.BookingID,
    B.FlightID,
    B.SeatID
FROM
    Passenger AS P
JOIN
    Booking AS B ON P.PassengerID = B.PassengerID;
GO

SELECT * From PassengerBookingView;
GO

-- FlightSeatStatusView
IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID('dbo.FlightSeatStatusView'))
DROP VIEW dbo.FlightSeatStatusView;
GO

CREATE VIEW FlightSeatStatusView AS
SELECT
    F.FlightID,
    S.SeatID,
    S.SeatNumber,
    S.SeatClass,
    S.IsBooked
FROM
    Flight AS F
JOIN
    Seats AS S ON F.FlightID = S.FlightID;
GO

SELECT * From FlightSeatStatusView;
GO

-- PaymentSummaryView
IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID('dbo.PaymentSummaryView'))
DROP VIEW dbo.PaymentSummaryView;
GO

CREATE VIEW PaymentSummaryView AS
SELECT
    P.TransactionID,
    P.BookingID,
    B.FlightID,
    B.PassengerID,
    P.PaymentMethod,
    P.PaymentAmount
FROM
    Payment AS P
JOIN
    Booking AS B ON P.BookingID = B.BookingID;
GO

SELECT * From PaymentSummaryView;
GO


-- Create Audit tables
-- Create AirportAudit table
IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID('dbo.AirportAudit'))
DROP TABLE dbo.AirportAudit;

CREATE TABLE AirportAudit (
    AuditID INT PRIMARY KEY IDENTITY(1,1),
    AirportID VARCHAR(10),
    AirportName VARCHAR(30),
    Country VARCHAR(30),
    State VARCHAR(30),
    City VARCHAR(30),
    ChangeType VARCHAR(10),
    ChangeDate DATETIME
);
GO

-- Create Trigger for Airport table
IF OBJECT_ID('trg_Airport_Audit') IS NOT NULL
    DROP TRIGGER trg_Airport_Audit;
GO

CREATE TRIGGER trg_Airport_Audit
ON Airport
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Insert records into AirportAudit for INSERT operations
    INSERT INTO AirportAudit (AirportID, AirportName, Country, State, City, ChangeType, ChangeDate)
    SELECT
        i.AirportID,
        i.AirportName,
        i.Country,
        i.State,
        i.City,
        'INSERT',
        GETDATE()
    FROM
        inserted i;

    -- Insert records into AirportAudit for UPDATE operations
    INSERT INTO AirportAudit (AirportID, AirportName, Country, State, City, ChangeType, ChangeDate)
    SELECT
        d.AirportID,
        d.AirportName,
        d.Country,
        d.State,
        d.City,
        'UPDATE',
        GETDATE()
    FROM
        deleted d
    INNER JOIN
        inserted i ON d.AirportID = i.AirportID
    WHERE
        d.AirportName <> i.AirportName
        OR d.Country <> i.Country
        OR d.State <> i.State
        OR d.City <> i.City;

    -- Insert records into AirportAudit for DELETE operations
    INSERT INTO AirportAudit (AirportID, AirportName, Country, State, City, ChangeType, ChangeDate)
    SELECT
        d.AirportID,
        d.AirportName,
        d.Country,
        d.State,
        d.City,
        'DELETE',
        GETDATE()
    FROM
        deleted d;
END;
GO

-- TEST Audit tables
-- Test INSERT operation
INSERT INTO Airport (AirportID, AirportName, Country, State, City)
VALUES ('TEST001', 'Test Airport', 'Test Country', 'Test State', 'Test City');

-- Test UPDATE operation
UPDATE Airport
SET AirportName = 'Updated Airport'
WHERE AirportID = 'TEST001';

-- Test DELETE operation
DELETE FROM Airport
WHERE AirportID = 'TEST001';

-- View the audit records
SELECT * FROM AirportAudit;
GO


-- Create and Delete Stored Procedure
-- Drop Stored Procedure
IF OBJECT_ID('GetFlightInfo') IS NOT NULL
    DROP PROC GetFlightInfo;
GO

-- Create Stored procedure to get flight information
CREATE PROC GetFlightInfo
    @FlightID VARCHAR(10)
AS
BEGIN
    SELECT
        F.FlightID,
        F.AirlineCode,
        F.FlightNumber,
        A1.AirportName AS OriginAirport,
        A2.AirportName AS DestinationAirport,
        F.DepartDateTime,
        F.ArriveDateTime,
        F.GateNumber
    FROM
        Flight F
    INNER JOIN
        Airport A1 ON F.OriginAirportID = A1.AirportID
    INNER JOIN
        Airport A2 ON F.DestinationAirportID = A2.AirportID
    WHERE
        F.FlightID = @FlightID;
END;

-- Test GetFlightInfo procedure
EXEC GetFlightInfo @FlightID = 'F001';
GO

-- Drop Stored Procedure
IF OBJECT_ID('UpdateSeatStatus') IS NOT NULL
    DROP PROC UpdateSeatStatus;
GO

-- Create procedure to update seat reservation status
CREATE PROCEDURE UpdateSeatStatus
    @SeatID VARCHAR(10),
    @IsBooked BIT
AS
BEGIN
    UPDATE Seats
    SET IsBooked = @IsBooked
    WHERE SeatID = @SeatID;
END;
GO

-- Test UpdateSeatStatus procedure
EXEC UpdateSeatStatus @SeatID = 'S001', @IsBooked = 0;
SELECT * from Seats;
GO


-- Create cursors
-- Create cursor to retrieve passenger information for a specific flight
DECLARE PassengerCursor CURSOR FOR
    SELECT P.PassengerID, P.FirstName, P.LastName, B.FlightID, B.SeatID
    FROM Passenger P
    INNER JOIN Booking B ON P.PassengerID = B.PassengerID
    WHERE B.FlightID = 'F001';

OPEN PassengerCursor;

DECLARE @PassengerID VARCHAR(10), @FirstName VARCHAR(30), @LastName VARCHAR(30), @FlightID VARCHAR(10), @SeatID VARCHAR(10);

FETCH NEXT FROM PassengerCursor INTO @PassengerID, @FirstName, @LastName, @FlightID, @SeatID;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Passenger ID: ' + @PassengerID + ', Name: ' + @FirstName + ' ' + @LastName + ', Flight ID: ' + @FlightID + ', Seat ID: ' + @SeatID;

    FETCH NEXT FROM PassengerCursor INTO @PassengerID, @FirstName, @LastName, @FlightID, @SeatID;
END;

CLOSE PassengerCursor;
DEALLOCATE PassengerCursor;

-- Drop cursors if they exist
IF CURSOR_STATUS('global', 'PassengerCursor') >= 0
BEGIN
    CLOSE PassengerCursor;
    DEALLOCATE PassengerCursor;
END;
GO

-- Create cursor to update prices of all seats in the Business class
DECLARE PriceUpdateCursor CURSOR FOR
    SELECT SeatID
    FROM Seats
    WHERE SeatClass = 'Business';

OPEN PriceUpdateCursor;

DECLARE @SeatIDToUpdate VARCHAR(10);

FETCH NEXT FROM PriceUpdateCursor INTO @SeatIDToUpdate;

WHILE @@FETCH_STATUS = 0
BEGIN
    UPDATE Seats
    SET Price = 250
    WHERE SeatID = @SeatIDToUpdate;

    FETCH NEXT FROM PriceUpdateCursor INTO @SeatIDToUpdate;
END;

CLOSE PriceUpdateCursor;
DEALLOCATE PriceUpdateCursor;
GO

-- Drop cursors if they exist
IF CURSOR_STATUS('global', 'PriceUpdateCursor') >= 0
BEGIN
    CLOSE PriceUpdateCursor;
    DEALLOCATE PriceUpdateCursor;
END;
GO

SELECT * FROM Seats;

PRINT('All Finished!')


-- DROP DATABASE SEOKG375;
