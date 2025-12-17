ALTER TABLE tblDRIVER
ADD MentorID INT 
FOREIGN KEY
REFERENCES tblDRIVER (DriverID)
GO
-- Code Example 6.3: SQL code to ALTER tblDRIVER to add column MentorID

-- Next, let’s update a few rows to reflect potential mentoring relationships.

UPDATE tblDRIVER
SET MentorID = 
(SELECT DriverID 
FROM tblDRIVER 
WHERE Fname = 'Bruce' and Lname = 'Lee')
WHERE DriverID = 
(SELECT DriverID 
FROM tblDRIVER 
WHERE Fname = 'Jimi' and Lname = 'Hendrix')
GO

UPDATE tblDRIVER
SET MentorID = 
(SELECT DriverID 
FROM tblDRIVER 
WHERE Fname = 'Jimi' and Lname = 'Hendrix')
WHERE DriverID = 
(SELECT DriverID 
FROM tblDRIVER 
WHERE Fname = 'Meryl' and Lname = 'Streep')
GO
-- Code Example 6.4: SQL code to INSERT values into tblDRIVER for MentorID