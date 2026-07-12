-- =====================================================================
-- 1. DATABASE CREATION
-- =====================================================================

-- Drop the database if it exists to start fresh
DROP DATABASE IF EXISTS mini_world_83;

-- Create your new database
CREATE DATABASE mini_world_83;

-- Select the database to use for all following commands
USE mini_world_83;

-- =====================================================================
-- 2. PARENT TABLES (Independent Entities)
--    Create these first as other tables will reference them.
-- =====================================================================

-- *** MODIFIED TABLE (User Correction) ***
-- Home_Planet is now Home_Planet_ID, a FOREIGN KEY to Location
CREATE TABLE Species (
    Species_ID INT PRIMARY KEY,
    Common_Name VARCHAR(100) NOT NULL UNIQUE,
    Home_Planet_ID INT, -- Changed from VARCHAR(100)
    General_Physiology TEXT,
    
    FOREIGN KEY (Home_Planet_ID) REFERENCES Location(Location_ID)
        ON DELETE SET NULL -- A species can exist even if its home planet is unknown/deleted
);

CREATE TABLE Location (
    Location_ID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Planet VARCHAR(100) NOT NULL,
    Latitude DECIMAL(9, 6),
    Longitude DECIMAL(9, 6)
);

CREATE TABLE Event (
    Event_ID INT PRIMARY KEY,
    Event_Name VARCHAR(255) NOT NULL,
    Date_of_Event DATE,
    Primary_Location_ID INT,
    Casualties INT DEFAULT 0,
    Economic_Loss DECIMAL(15, 2),
    
    FOREIGN KEY (Primary_Location_ID) REFERENCES Location(Location_ID)
        ON DELETE SET NULL 
);

CREATE TABLE Artifact (
    Artifact_ID INT PRIMARY KEY,
    Official_Name VARCHAR(255) NOT NULL,
    Type VARCHAR(100)
);

CREATE TABLE Individual (
    Individual_ID INT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100),
    Date_of_Birth DATE,
    Status VARCHAR(50) CHECK (Status IN ('Active', 'Deceased', 'Unknown', 'Incarcerated')),
    Species_ID INT,
    
    FOREIGN KEY (Species_ID) REFERENCES Species(Species_ID)
        ON DELETE SET NULL 
);

CREATE TABLE Organization (
    Org_ID INT PRIMARY KEY,
    Org_Name VARCHAR(255) NOT NULL UNIQUE,
    Org_Type VARCHAR(100),
    Leader_ID INT,
    
    FOREIGN KEY (Leader_ID) REFERENCES Individual(Individual_ID)
        ON DELETE SET NULL
);

CREATE TABLE Technology (
    Tech_ID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Inventor_ID INT,
    Power_Source VARCHAR(100),
    
    FOREIGN KEY (Inventor_ID) REFERENCES Individual(Individual_ID)
        ON DELETE SET NULL
);

-- *** MODIFIED TABLE (Previous Fix) ***
-- This table is corrected to match the 3NF diagram (page 7)
-- by adding Subject_ID to link the sighting to an Individual.
CREATE TABLE Sighting (
    Sighting_ID INT PRIMARY KEY,
    Timestamp DATETIME NOT NULL,
    Location_ID INT,
    Subject_ID INT, -- This column was missing in the original file
    Corroboration_Level VARCHAR(50) CHECK (Corroboration_Level IN ('Verified', 'Likely', 'Unconfirmed')),
    
    FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID)
        ON DELETE SET NULL,
    -- This foreign key was missing in the original file
    FOREIGN KEY (Subject_ID) REFERENCES Individual(Individual_ID)
        ON DELETE SET NULL
);


-- =====================================================================
-- 3. CHILD TABLES (1:1 and 1:N Relationships)
-- =====================================================================

CREATE TABLE Individual_Aliases (
    Alias_ID INT PRIMARY KEY AUTO_INCREMENT, 
    Alias_Name VARCHAR(100) NOT NULL,
    Individual_ID INT NOT NULL,
    
    FOREIGN KEY (Individual_ID) REFERENCES Individual(Individual_ID)
        ON DELETE CASCADE 
);

CREATE TABLE Enhanced_Individual (
    Individual_ID INT PRIMARY KEY, 
    Threat_Level INT CHECK (Threat_Level BETWEEN 1 AND 10),
    Power_Classification VARCHAR(100),
    Power_Origin VARCHAR(255),
    
    FOREIGN KEY (Individual_ID) REFERENCES Individual(Individual_ID)
        ON DELETE CASCADE 
);

CREATE TABLE Agent (
    Individual_ID INT PRIMARY KEY, 
    Classification_Level INT,
    Department VARCHAR(100),
    Handler_ID INT, 
    
    FOREIGN KEY (Individual_ID) REFERENCES Individual(Individual_ID) ON DELETE CASCADE,
    FOREIGN KEY (Handler_ID) REFERENCES Individual(Individual_ID) ON DELETE SET NULL
);

CREATE TABLE Officer_Report_Log (
    Log_Serial_No INT PRIMARY KEY AUTO_INCREMENT,
    Timestamp DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Log_Text TEXT NOT NULL,
    Officer_ID INT, 
    
    FOREIGN KEY (Officer_ID) REFERENCES Agent(Individual_ID)
        ON DELETE SET NULL 
);

-- =====================================================================
-- 4. JUNCTION TABLES (N:M Relationships)
-- =====================================================================

CREATE TABLE Individual_Affiliation (
    Individual_ID INT,
    Org_ID INT,
    
    PRIMARY KEY (Individual_ID, Org_ID), 
    FOREIGN KEY (Individual_ID) REFERENCES Individual(Individual_ID) ON DELETE CASCADE,
    FOREIGN KEY (Org_ID) REFERENCES Organization(Org_ID) ON DELETE CASCADE
);

CREATE TABLE Individual_Participation (
    Individual_ID INT,
    Event_ID INT,
    
    PRIMARY KEY (Individual_ID, Event_ID),
    FOREIGN KEY (Individual_ID) REFERENCES Individual(Individual_ID) ON DELETE CASCADE,
    FOREIGN KEY (Event_ID) REFERENCES Event(Event_ID) ON DELETE CASCADE
);

CREATE TABLE Individual_Possession_Artifact (
    Individual_ID INT,
    Artifact_ID INT,
    
    PRIMARY KEY (Individual_ID, Artifact_ID),
    FOREIGN KEY (Individual_ID) REFERENCES Individual(Individual_ID) ON DELETE CASCADE,
    FOREIGN KEY (Artifact_ID) REFERENCES Artifact(Artifact_ID) ON DELETE CASCADE
);

CREATE TABLE Individual_Conflicts (
    Conflict_ID INT PRIMARY KEY AUTO_INCREMENT,
    Individual_A_ID INT,
    Individual_B_ID INT,
    
    FOREIGN KEY (Individual_A_ID) REFERENCES Individual(Individual_ID) ON DELETE CASCADE,
    FOREIGN KEY (Individual_B_ID) REFERENCES Individual(Individual_ID) ON DELETE CASCADE,
    CHECK (Individual_A_ID < Individual_B_ID) 
);

-- =====================================================================
-- 5. COMPLEX HUB TABLES
-- =====================================================================

-- This table from your diagram links many entities to an Event
CREATE TABLE Event_Equipment_Usage (
    Asset_ID INT PRIMARY KEY AUTO_INCREMENT,
    Event_ID INT NOT NULL,
    User_Individual_ID INT,
    Target_Individual_ID INT,
    Tech_ID INT,
    Artifact_ID INT,
    
    FOREIGN KEY (Event_ID) REFERENCES Event(Event_ID) ON DELETE CASCADE,
    FOREIGN KEY (User_Individual_ID) REFERENCES Individual(Individual_ID) ON DELETE SET NULL,
    FOREIGN KEY (Target_Individual_ID) REFERENCES Individual(Individual_ID) ON DELETE SET NULL,
    FOREIGN KEY (Tech_ID) REFERENCES Technology(Tech_ID) ON DELETE SET NULL,
    FOREIGN KEY (Artifact_ID) REFERENCES Artifact(Artifact_ID) ON DELETE SET NULL
);

-- *** NEW TABLE (User Correction) ***
-- This table was missing from the previous schema.
-- It represents the "Conflict Nexus" N-ary relationship.
CREATE TABLE Conflict_Nexus_Link (
    Conflict_Nexus_ID INT PRIMARY KEY AUTO_INCREMENT,
    Event_ID INT,
    Individual_ID INT,
    Org_ID INT,
    Location_ID INT,

    FOREIGN KEY (Event_ID) REFERENCES Event(Event_ID) ON DELETE SET NULL,
    FOREIGN KEY (Individual_ID) REFERENCES Individual(Individual_ID) ON DELETE SET NULL,
    FOREIGN KEY (Org_ID) REFERENCES Organization(Org_ID) ON DELETE SET NULL,
    FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID) ON DELETE SET NULL
);

-- =====================================================================
-- Schema creation complete.
-- =====================================================================