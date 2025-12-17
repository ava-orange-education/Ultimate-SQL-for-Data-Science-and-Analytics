/*
The following command in Code Example 6.1 will establish a new table called tblTOURIST_STOPS. As always, observe the structure of the command to see the pattern of how the cloumn names, data types, and NULL/NOT NULL are placed.
*/

CREATE TABLE tblTOURIST_STOPS
(TN_ID INTEGER IDENTITY(1,1) primary key,
NeighborhoodID INT not null,
NeighborhoodName varchar(50) not null,
StopID INT not null,
StopName varchar(50) not null,
GPS_CorOrd VARCHAR(50) NULL)
GO 

-- Code Example 6.1: SQL code to CREATE tblTOURIST_STOPS

/*
Give the query below a try! It is important to be able to assemble copies of data when we are on a mission to conduct a deeper investigation or build one-off reports.
*/

INSERT INTO tblTOURIST_STOPS (NeighborhoodID, NeighborhoodName, StopID, StopName, GPS_CorOrd)
SELECT N.NeighborhoodID, NeighborhoodName, S.StopID, StopName, GPS_CorOrd
FROM tblNEIGHBORHOOD N
	JOIN tblSTOP S ON N.NeighborhoodID = S.NeighborhoodID
WHERE N.NeighborhoodName IN ('Downtown', 'Waterfront', 'Fremont')

-- Code Example 6.2: SQL code to INSERT values into tblTOURIST_STOPS
