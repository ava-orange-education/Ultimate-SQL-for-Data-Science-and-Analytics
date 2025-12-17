/*
USE MASTER
GO

DROP DATABASE METRO_TRANSIT

CREATE DATABASE METRO_TRANSIT
GO

USE METRO_TRANSIT
GO
*/

CREATE TABLE tblDRIVER
(DriverID INTEGER IDENTITY(1,1) PRIMARY KEY,
Fname VARCHAR(25) NOT NULL,
Lname VARCHAR(25) NOT NULL,
BirthDate DATE NOT NULL,
Salary Numeric (8,2) NOT NULL,
LicenseNumber VARCHAR(35) NULL)
GO


CREATE TABLE tblROUTE_TYPE
(RouteTypeID INTEGER IDENTITY(1,1) PRIMARY KEY,
RouteTypeName VARCHAR(50) NOT NULL,
RouteTypeDescr VARCHAR(500) NULL)
GO


CREATE TABLE tblROUTE
(RouteID INTEGER IDENTITY(1,1) PRIMARY KEY,
RouteName VARCHAR(100) NOT NULL,
RouteTypeID INTEGER NOT NULL,
RouteAbbrev VARCHAR(20) NOT NULL,
RouteDescr VARCHAR(500) NULL)
GO


CREATE TABLE tblVEHICLE_TYPE
(VehicleTypeID INTEGER IDENTITY(1,1) PRIMARY KEY,
VehicleTypeName VARCHAR(100) NOT NULL,
NumSeats INTEGER NOT NULL,
TotalCapacity INTEGER NOT NULL,
VehicleTypeDescr VARCHAR(500) NULL)
GO


CREATE TABLE tblVEHICLE
(VehicleID INTEGER IDENTITY(1,1) PRIMARY KEY,
VehicleName VARCHAR(50) NOT NULL,
VehicleTypeID INTEGER NOT NULL,
PlateNumber VARCHAR(20) NOT NULL,
PurchasePrice Numeric(10,2) NOT NULL,
VehiclePurchaseDate DATE NOT NULL)
GO


CREATE TABLE tblNEIGHBORHOOD
(NeighborhoodID INTEGER IDENTITY(1,1) PRIMARY KEY,
NeighborhoodName VARCHAR(50) NOT NULL,
NeighborhoodDescr VARCHAR(500) NULL)
GO


CREATE TABLE tblSTOP_TYPE
(StopTypeID INTEGER IDENTITY(1,1) PRIMARY KEY,
StopTypeName VARCHAR(50) NOT NULL,
StopTypeDescr VARCHAR(500) NULL)
GO


CREATE TABLE tblSTOP
(StopID INTEGER IDENTITY(1,1) PRIMARY KEY,
StopName VARCHAR(50) NOT NULL,
StopTypeID INTEGER NOT NULL,
NeighborhoodID INTEGER NOT NULL,
GPS_CorOrd VARCHAR(50) NULL)
GO


CREATE TABLE tblROUTE_STOP
(RouteStopID INTEGER IDENTITY(1,1) PRIMARY KEY,
RouteID INTEGER NOT NULL,
StopID INTEGER NOT NULL,
SequenceNumber INTEGER NULL,
RevisedDate DATE NOT NULL)
GO


CREATE TABLE tblTRIP
(TripID INTEGER IDENTITY(1,1) PRIMARY KEY,
DriverID INTEGER NOT NULL,
VehicleID INTEGER NOT NULL,
RouteID INTEGER NOT NULL,
BeginDateTime DATETIME NOT NULL,
EndDateTime DATETIME NULL)
GO


CREATE TABLE tblTRIP_STOP
(TripStopID INTEGER IDENTITY(1,1) PRIMARY KEY,
TripID INTEGER NOT NULL,
StopID INTEGER NOT NULL,
TripStopDateTime DATETIME NOT NULL)
GO


CREATE TABLE tblCUSTOMER
(CustomerID INTEGER IDENTITY(1,1) PRIMARY KEY,
Fname VARCHAR(25) NOT NULL,
Mname VARCHAR (25) NULL,
Lname VARCHAR(25) NOT NULL,
BirthDate DATE NULL,
CustAddress VARCHAR (100) NULL,
CustCity VARCHAR(50) NULL,
CustState VARCHAR(50) NULL,
PostalCode VARCHAR(15) NULL)
GO

--Code Example 5.3: SQL code to establish 12 tables


CREATE TABLE tblBOARDING
(BoardingID INTEGER IDENTITY(1,1) PRIMARY KEY,
CustomerID INTEGER FOREIGN KEY REFERENCES tblCUSTOMER (CustomerID) NOT NULL,
TripStopID INTEGER FOREIGN KEY REFERENCES tblTRIP_STOP (TripStopID) NOT NULL,
BoardingDateTime DATETIME NOT NULL,
Fare Numeric(5,2) NOT NULL)
GO


PRINT 'Completed CREATE TABLE statements for all tables in abbreviated METRO_TRANSIT'
GO

--Code Example 5.4: SQL code to create table tblBOARDING


ALTER TABLE tblROUTE
ADD CONSTRAINT FK_tblROUTE_RouteTypeID
FOREIGN KEY (RouteTypeID)
REFERENCES tblROUTE_TYPE (RouteTypeID)
GO


ALTER TABLE tblVEHICLE
ADD CONSTRAINT FK_tblVEHICLE_VehicleTypeID
FOREIGN KEY (VehicleTypeID)
REFERENCES tblVEHICLE_TYPE (VehicleTypeID)
GO


ALTER TABLE tblSTOP
ADD CONSTRAINT FK_tblSTOP_StopTypeID
FOREIGN KEY (StopTypeID)
REFERENCES tblSTOP_TYPE (StopTypeID)
GO


ALTER TABLE tblSTOP
ADD CONSTRAINT FK_tblSTOP_NeighborhoodID
FOREIGN KEY (NeighborhoodID)
REFERENCES tblNEIGHBORHOOD (NeighborhoodID)
GO


ALTER TABLE tblROUTE_STOP
ADD CONSTRAINT FK_tblROUTE_STOP_StopID
FOREIGN KEY (StopID)
REFERENCES tblSTOP (StopID)
GO


ALTER TABLE tblROUTE_STOP
ADD CONSTRAINT FK_tblROUTE_STOP_RouteID
FOREIGN KEY (RouteID)
REFERENCES tblROUTE (RouteID)
GO


ALTER TABLE tblTRIP
ADD CONSTRAINT FK_tblTRIP_DriverID
FOREIGN KEY (DriverID)
REFERENCES tblDRIVER (DriverID)
GO

ALTER TABLE tblTRIP
ADD CONSTRAINT FK_tblTRIP_VehicleID
FOREIGN KEY (VehicleID)
REFERENCES tblVEHICLE (VehicleID)
GO


ALTER TABLE tblTRIP
ADD CONSTRAINT FK_tblTRIP_RouteID
FOREIGN KEY (RouteID)
REFERENCES tblROUTE (RouteID)
GO


ALTER TABLE tblTRIP_STOP
ADD CONSTRAINT FK_tblTRIP_STOP_TripID
FOREIGN KEY (TripID)
REFERENCES tblTRIP (TripID)
GO

ALTER TABLE tblTRIP_STOP
ADD CONSTRAINT FK_tblTRIP_STOP_StopID
FOREIGN KEY (StopID)
REFERENCES tblSTOP (StopID)
GO

PRINT 'Completed ALTER TABLE statements for adding foreign keys'
GO

--Code Example 5.5: SQL code to establish foreign keys



INSERT INTO tblDRIVER (Fname, Lname, BirthDate, Salary, LicenseNumber)
VALUES 
('Jimi', 'Hendrix', 'November 27, 1942', 42590, 'JMHend3487RR'),
('Bruce', 'Lee', 'November 27, 1940', 42590, 'BTLee*2198DL'),
('Jim', 'Morrison', 'December 8, 1943', 47625, 'JPMorr7762WS'),
('Meryl', 'Streep', 'June 22, 1949', 46965, 'MDStre8121UJ') 
GO

-- Code Example 5.7: SQL to insert sample data into tblDRIVER


INSERT INTO tblROUTE_TYPE (RouteTypeName, RouteTypeDescr)
VALUES
('Express', 'An express route is often designed to have limited stops during the morning and evening commute hours'), 

('Special Event', 'A special event route is often scheduled for high-attendance events at sporting venues or downtown'),

('Regular', 'A regular route is any route not identified as express or special event'),

('Inclement Weather/Reduced Service', 'Any route affected by weather')
GO
-- Code Example 5.8: SQL code to insert more sample data into table tblROUTE_TYPE



INSERT INTO tblROUTE (RouteName, RouteTypeID, RouteAbbrev, RouteDescr)
VALUES 
('Sodo-Downtown Express', (SELECT RouteTypeID FROM tblROUTE_TYPE WHERE RouteTypeName = 'Express'), '42-E', 'Express route from South of Downtown to main stops downtown'),

('Sodo-Downtown', (SELECT RouteTypeID FROM tblROUTE_TYPE WHERE RouteTypeName = 'Regular'), '42', 'Commuter route from South of Downtown to main stops downtown'),

('Fremont-Downtown Express', (SELECT RouteTypeID FROM tblROUTE_TYPE WHERE RouteTypeName = 'Express'), '78-E', 'Express route from Fremont to main stops downtown'),

('Fremont-Downtown', (SELECT RouteTypeID FROM tblROUTE_TYPE WHERE RouteTypeName = 'Regular'), '78', 'Commuter route from Fremont to main stops downtown'),

('Fremont-Waterfront-Downtown', (SELECT RouteTypeID FROM tblROUTE_TYPE WHERE RouteTypeName = 'Special Event'), '78-S', 'Special route from Fremont along waterfront to main stops downtown during summer weekend concert series'),

('Capitol Hill-Downtown', (SELECT RouteTypeID FROM tblROUTE_TYPE WHERE RouteTypeName = 'Regular'), '32', 'Regular route from Capitol Hill to main stops downtown')
GO


INSERT INTO tblVEHICLE_TYPE (VehicleTypeName, NumSeats, TotalCapacity,
VehicleTypeDescr)
VALUES 
('Standard Bus', 54, 76, 'Standard bus is primary use for residential neighborhoods during non-commute hours'),

('Double-Decker Bus', 96, 144, 'Double Decker bus is primary coach on state highways between major population centers as well as for special events'),

('Standard Light Rail Car', 58, 88, 'Standard Light Rail car is staple for fixed-track, high-volume routes that connect suburban and urban centers with the airport often in alignments with 4 connected cars'),

('Heavy Rail Single Passenger Train', 40, 50, 'Heavy Rail Single cars are placed on routes that are greater than 85 KM from major urban centers; these often are aligned with 12 connected cars')
GO

--	Code Example 5.9: SQL code to insert sample data into table tblVEHICLE_TYPE


INSERT INTO tblVEHICLE (VehicleName, VehicleTypeID, PlateNumber, PurchasePrice, VehiclePurchaseDate)
VALUES 
('GS203', (SELECT VehicleTypeID FROM tblVEHICLE_TYPE WHERE VehicleTypeName = 'Double-Decker Bus'), 'DRE-657J',887533, 'March 3, 2019'),

('GS204', (SELECT VehicleTypeID FROM tblVEHICLE_TYPE WHERE VehicleTypeName = 'Double-Decker Bus'), 'GTT-7JHS',887533, 'March 3, 2019'),

('PA7', (SELECT VehicleTypeID FROM tblVEHICLE_TYPE WHERE VehicleTypeName = 'Standard Bus'), 'XYW-23KJ', 566988,'July 13, 2023'),

('GS208', (SELECT VehicleTypeID FROM tblVEHICLE_TYPE WHERE VehicleTypeName = 'Standard Bus'), 'TG8-99L2',604995,'August 9, 2024')
GO

INSERT INTO tblNEIGHBORHOOD (NeighborhoodName, NeighborhoodDescr)
VALUES

('Capitol Hill', 'Vibrant, colorful, and walkable neighborhood with many shops and services'),
('Waterfront', 'Naturally scenic, tourist-focused neighborhood with many food options'),

('Downtown', 'Urban, business-focused with many restaurants and transit connections to entire region'),

('SoDo', 'Gritty and industrial neighborhood'),

('Fremont', 'Eccentric and organic feel with shops and restaurants that fit a range of budgets')
GO


INSERT INTO tblSTOP_TYPE (StopTypeName, StopTypeDescr)
VALUES 
('Uncovered', 'Standard stop that has a 3-person bench and garbage can'),

('Covered', 'Upgraded 3-sided stop'),

('Tunnel Station', 'High capacity stop that has full service and security'),

('Elevated Rail Station', 'High capacity stop that serves only rail')
GO


INSERT INTO tblSTOP (StopName, StopTypeID, NeighborhoodID, GPS_CorOrd)
VALUES 
('Elliott Avenue and Mercer Street', (SELECT StopTypeID FROM tblSTOP_TYPE WHERE StopTypeName = 'UnCovered'), (SELECT NeighborhoodID FROM tblNEIGHBORHOOD WHERE NeighborhoodName = 'Waterfront'),'47.6567° N, 122.2470° W'),

('Hwy 99-N 36th', (SELECT StopTypeID FROM tblSTOP_TYPE WHERE StopTypeName = 'Covered'), (SELECT NeighborhoodID FROM tblNEIGHBORHOOD WHERE NeighborhoodName = 'Fremont'),'47.6567° N, 122.3474° W'),

('Fourth Avenue South and Lander Street', (SELECT StopTypeID FROM tblSTOP_TYPE WHERE StopTypeName = 'UnCovered'), (SELECT NeighborhoodID FROM tblNEIGHBORHOOD WHERE NeighborhoodName = 'SoDo'),'47.0117° N, 122.2430° W'),

('Sixth Avenue and Battery Street', (SELECT StopTypeID FROM tblSTOP_TYPE WHERE StopTypeName = 'UnCovered'), (SELECT NeighborhoodID FROM tblNEIGHBORHOOD WHERE NeighborhoodName = 'Downtown'),'47.6417° N, 122.3276° W'), 

('Hwy 99-N 54th', (SELECT StopTypeID FROM tblSTOP_TYPE WHERE StopTypeName = 'Covered'), (SELECT NeighborhoodID FROM tblNEIGHBORHOOD WHERE NeighborhoodName = 'Fremont'),'47.6697° N, 122.3964° W'),

('Fourth Avenue and Seneca Street', (SELECT StopTypeID FROM tblSTOP_TYPE WHERE StopTypeName = 'UnCovered'), (SELECT NeighborhoodID FROM tblNEIGHBORHOOD WHERE NeighborhoodName = 'Downtown'),'47.6398° N, 122.3371° W'),

('Broadway Avenue and Cherry Street', (SELECT StopTypeID FROM tblSTOP_TYPE WHERE StopTypeName = 'Covered'), (SELECT NeighborhoodID FROM tblNEIGHBORHOOD WHERE NeighborhoodName = 'Capitol Hill'),'47.6317° N, 122.3383° W'),

('First Avenue and Terry Street', (SELECT StopTypeID FROM tblSTOP_TYPE WHERE StopTypeName = 'Covered'), (SELECT NeighborhoodID FROM tblNEIGHBORHOOD WHERE NeighborhoodName = 'SoDo'),'47.6212° N, 122.3243° W')
GO


INSERT INTO tblROUTE_STOP (RouteID, StopID, SequenceNumber, RevisedDate)
VALUES 
((SELECT RouteID FROM tblROUTE WHERE RouteName = 'Fremont-Waterfront-Downtown'), (SELECT StopID FROM tblSTOP WHERE StopName = 'Sixth Avenue and Battery Street'), 4, 'May 1, 2024'),

((SELECT RouteID FROM tblROUTE WHERE RouteName = 'Fremont-Waterfront-Downtown'), (SELECT StopID FROM tblSTOP WHERE StopName = 'Hwy 99-N 36th'), 2, 'May 1, 2024'),

((SELECT RouteID FROM tblROUTE WHERE RouteName = 'Fremont-Waterfront-Downtown'), (SELECT StopID FROM tblSTOP WHERE StopName = 'Elliott Avenue and Mercer Street'), 3, 'May 1, 2024'),

((SELECT RouteID FROM tblROUTE WHERE RouteName = 'Fremont-Waterfront-Downtown'), (SELECT StopID FROM tblSTOP WHERE StopName = 'First Avenue and Terry Street'), 1, 'May 1, 2024'),

((SELECT RouteID FROM tblROUTE WHERE RouteName ='Sodo-Downtown Express'), (SELECT StopID FROM tblSTOP WHERE StopName = 'Fourth Avenue South and Lander Street'), 1, 'May 1, 2024'),

((SELECT RouteID FROM tblROUTE WHERE RouteName ='Sodo-Downtown Express'), (SELECT StopID FROM tblSTOP WHERE StopName = 'Sixth Avenue and Battery Street'), 2, 'May 1, 2024'),

((SELECT RouteID FROM tblROUTE WHERE RouteName = 'Capitol Hill-Downtown'), (SELECT StopID FROM tblSTOP WHERE StopName = 'Broadway Avenue and Cherry Street'), 1, 'May 1, 2024'),

((SELECT RouteID FROM tblROUTE WHERE RouteName = 'Capitol Hill-Downtown'), (SELECT StopID FROM tblSTOP WHERE StopName = 'Sixth Avenue and Battery Street'), 2, 'May 1, 2024')
GO


INSERT INTO tblCUSTOMER (Fname, Lname, CustAddress, CustCity, CustState, PostalCode, BirthDate)
VALUES
('Ivey','Hazekamp','7279 North Lavender Lake Avenue','PETROLEUM','Indiana, IN','46778','1995-12-24'),

('Darcel','Eustache','6087 West Cambridge Beach Sloop','FRUITA','Colorado, CO','81521','1995-06-11'),

('Kenyetta','Terron','6664 NW Arthur Terrace Drive','GRAND RIVER','Ohio, OH','44045','1995-09-27'),

('Janey','Lundgren','14351 N Oak Beach Walk','CENTRALIA','Illinois, IL','62801','1996-01-25')
GO


INSERT INTO tblTRIP (DriverID, VehicleID, RouteID, BeginDateTime, EndDateTime)
VALUES
((SELECT DriverID FROM tblDRIVER WHERE Fname = 'Meryl' AND Lname = 'Streep' AND BirthDate = 'June 22, 1949'), (SELECT VehicleID FROM tblVEHICLE WHERE VehicleName = 'GS204'), (SELECT RouteID FROM tblROUTE WHERE RouteName = 'Capitol Hill-Downtown'), '2025-04-24 06:17:00', NULL),

((SELECT DriverID FROM tblDRIVER WHERE Fname = 'Jimi' AND Lname = 'Hendrix' AND BirthDate = 'November 27, 1942'), (SELECT VehicleID FROM tblVEHICLE WHERE VehicleName = 'GS203'), (SELECT RouteID FROM tblROUTE WHERE RouteName = 'Fremont-Downtown Express'), '2025-04-24 06:42:55', NULL),

((SELECT DriverID FROM tblDRIVER WHERE Fname = 'Meryl' AND Lname = 'Streep' AND BirthDate = 'June 22, 1949'), (SELECT VehicleID FROM tblVEHICLE WHERE VehicleName = 'GS204'), (SELECT RouteID FROM tblROUTE WHERE RouteName = 'Fremont-Waterfront-Downtown'), '2025-04-23 07:23:00', NULL),

((SELECT DriverID FROM tblDRIVER WHERE Fname = 'Bruce' AND Lname = 'Lee' AND BirthDate = 'November 27, 1940'), (SELECT VehicleID FROM tblVEHICLE WHERE VehicleName = 'PA7'), (SELECT RouteID FROM tblROUTE WHERE RouteName = 'Capitol Hill-Downtown'), '2025-04-24 06:57:00', NULL),

((SELECT DriverID FROM tblDRIVER WHERE Fname = 'Meryl' AND Lname = 'Streep' AND BirthDate = 'June 22, 1949'), (SELECT VehicleID FROM tblVEHICLE WHERE VehicleName = 'GS204'), (SELECT RouteID FROM tblROUTE WHERE RouteName = 'Fremont-Downtown'), '2025-04-29 08:07:00', NULL)
GO


INSERT INTO tblTRIP_STOP (TripID, StopID, TripStopDateTime)
VALUES
((SELECT TripID FROM tblTRIP T
	JOIN tblDRIVER D ON D.DriverID = T.DriverID
	JOIN tblROUTE R ON T.RouteID = T.RouteID
WHERE D.Fname = 'Bruce' AND D.Lname = 'Lee'
AND R.RouteName = 'Capitol Hill-Downtown'
AND T.BeginDateTime = '2025-04-24 06:57:00'),
(SELECT S.StopID 
FROM tblSTOP S 
WHERE StopName = 'Broadway Avenue and Cherry Street'), '2025-04-24 07:06:51'),


--second value for tblTRIP_STOP
((SELECT TripID FROM tblTRIP T
	JOIN tblDRIVER D ON D.DriverID = T.DriverID
	JOIN tblROUTE R ON T.RouteID = T.RouteID
WHERE D.Fname = 'Bruce' AND D.Lname = 'Lee'
AND R.RouteName = 'Capitol Hill-Downtown'
AND T.BeginDateTime = '2025-04-24 06:57:00'),
(SELECT S.StopID FROM tblSTOP S 
	WHERE StopName = 'Fourth Avenue and Seneca Street'), '2025-04-24 07:15:23'),


-- third value for tblTRIP_STOP
((SELECT TripID FROM tblTRIP T
	JOIN tblDRIVER D ON D.DriverID = T.DriverID
	JOIN tblROUTE R ON T.RouteID = T.RouteID
WHERE D.Fname = 'Jimi' AND D.Lname = 'Hendrix'
AND R.RouteName = 'Fremont-Downtown Express'
AND T.BeginDateTime = '2025-04-24 06:42:55'),
(SELECT S.StopID 
FROM tblSTOP S 
WHERE StopName = 'Hwy 99-N 54th'), '2025-04-24 06:43:00'),


-- fourth value for tblTRIP_STOP
((SELECT TripID FROM tblTRIP T
	JOIN tblDRIVER D ON D.DriverID = T.DriverID
	JOIN tblROUTE R ON T.RouteID = T.RouteID
WHERE D.Fname = 'Jimi' AND D.Lname = 'Hendrix'
AND R.RouteName = 'Fremont-Downtown Express'
AND T.BeginDateTime = '2025-04-24 06:42:55'),
(SELECT S.StopID 
FROM tblSTOP S 
WHERE StopName = 'Hwy 99-N 36th'), '2025-04-24 06:47:23'),


-- fifth value for tblTRIP_STOP
((SELECT TripID FROM tblTRIP T
	JOIN tblDRIVER D ON D.DriverID = T.DriverID
	JOIN tblROUTE R ON T.RouteID = T.RouteID
WHERE D.Fname = 'Jimi' AND D.Lname = 'Hendrix'
AND R.RouteName = 'Fremont-Downtown Express'
AND T.BeginDateTime = '2025-04-24 06:42:55'),
(SELECT S.StopID 
FROM tblSTOP S 
WHERE StopName = 'Elliott Avenue and Mercer Street'), '2025-04-24 06:56:34'),


-- sixth value for tblTRIP_STOP
((SELECT TripID FROM tblTRIP T
	JOIN tblDRIVER D ON D.DriverID = T.DriverID
	JOIN tblROUTE R ON T.RouteID = T.RouteID
WHERE D.Fname = 'Meryl' AND D.Lname = 'Streep'
AND R.RouteName = 'Capitol Hill-Downtown'
AND T.BeginDateTime = '2025-04-23 07:23:00'),
(SELECT S.StopID 
FROM tblSTOP S 
	WHERE StopName = 'Sixth Avenue and Battery Street'), '2025-04-23 07:41:06')
GO


--Code Example 5.10: SQL code inserting sample data into tables tblVEHICLE, tblNEIGHBORHOOD, tblSTOP_TYPE, tblSTOP, tblROUTE_STOP, tblCUSTOMER, tblTRIP, and tblTRIP_STOP


INSERT INTO tblBOARDING (CustomerID, TripStopID, Fare, BoardingDateTime)
VALUES(
(SELECT CustomerID 
FROM tblCUSTOMER 
WHERE Fname = 'Ivey' AND Lname = 'Hazekamp' AND BirthDate = '1995-12-24'), 

(SELECT TripStopID FROM tblTRIP_STOP TS
	JOIN tblTRIP T ON TS.TripID = T.TripID
	JOIN tblROUTE R ON T.RouteID = T.RouteID
	JOIN tblSTOP S ON TS.StopID = S.StopID
WHERE R.RouteName = 'Capitol Hill-Downtown'
AND S.StopName = 'Sixth Avenue and Battery Street' 
AND BeginDateTime = '2025-04-23 07:23:00'), 
3.75, '2025-04-23 07:41:35')
GO

INSERT INTO tblBOARDING (CustomerID, TripStopID, Fare, BoardingDateTime)
VALUES(
(SELECT CustomerID 
FROM tblCUSTOMER 
WHERE Fname = 'Ivey' AND Lname = 'Hazekamp' AND BirthDate = '1995-12-24'), 

(SELECT TripStopID FROM tblTRIP_STOP TS
	JOIN tblTRIP T ON TS.TripID = T.TripID
	JOIN tblROUTE R ON T.RouteID = T.RouteID
	JOIN tblSTOP S ON TS.StopID = S.StopID
WHERE R.RouteName = 'Fremont-Downtown Express'
AND S.StopName = 'Hwy 99-N 36th' 
AND BeginDateTime = '2025-04-24 06:42:55.000'), 
3.75, '2025-04-24 06:47:23.000')
GO

INSERT INTO tblBOARDING (CustomerID, TripStopID, Fare, BoardingDateTime)
VALUES(
(SELECT CustomerID 
FROM tblCUSTOMER 
WHERE Fname = 'Kenyetta' AND Lname = 'Terron' AND BirthDate = '1995-09-27'), 

(SELECT TripStopID FROM tblTRIP_STOP TS
	JOIN tblTRIP T ON TS.TripID = T.TripID
	JOIN tblROUTE R ON T.RouteID = T.RouteID
	JOIN tblSTOP S ON TS.StopID = S.StopID
WHERE R.RouteName = 'Fremont-Downtown Express'
AND S.StopName = 'Hwy 99-N 36th'
AND BeginDateTime = '2025-04-24 06:42:55'), 
3.25,'2025-04-24 06:47:23')
GO

-- Code Example 5.11: SQL code to insert 3 values into tblBOARDING
