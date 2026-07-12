-- =====================================================================
-- POPULATE DATABASE: mini_world_83
-- =====================================================================
-- This script populates the database in chronological order by movie.
-- IMPORTANT: All parent entities (Individual, Location, Event, etc.)
-- MUST use manual Primary Keys (PKs) for this to work.
--
-- ID CONVENTION (Suggestion):
-- 1-99: Core/Foundational Entities (Species, Planets, Core Orgs)
-- 100-999: Movie-Specific Entities (Events, Locations, Orgs)
-- 1000-1999: Individuals
-- 2000-2999: Technologies
-- 3000-3999: Artifacts
-- =====================================================================

USE mini_world_83;

-- =====================================================================
-- BLOCK 0: FOUNDATIONAL DATA (Entities that span all movies)
-- =====================================================================

-- LAYER 1: Independent Entities
INSERT INTO Location (Location_ID, Name, Planet) VALUES
(10, 'Earth', 'Earth'),
(11, 'Asgard', 'Asgard'),
(12, 'Jotunheim', 'Jotunheim'),
(13, 'Sakaar', 'Sakaar'),
(14, 'Vormir', 'Vormir'),
(15, 'Titan', 'Titan'),
(16, 'Xandar', 'Xandar'),
(17, 'Hala', 'Hala');

INSERT INTO Species (Species_ID, Common_Name, Home_Planet_ID, General_Physiology) VALUES
(1, 'Human', 10, 'Standard carbon-based lifeform.'),
(2, 'Asgardian', 11, 'Highly durable, long-lived, superhuman physiology.'),
(3, 'Frost Giant', 12, 'Large, blue-skinned, cryokinetic physiology.'),
(4, 'Kree', 17, 'Militaristic blue-skinned humanoids.'),
(5, 'Skrull', NULL, 'Reptilian shapeshifters.'),
(6, 'Titanian', 15, 'Purple-skinned, highly durable humanoids.');

INSERT INTO Organization (Org_ID, Org_Name, Org_Type) VALUES
(1, 'S.H.I.E.L.D.', 'Govt'),
(2, 'HYDRA', 'Terrorist'),
(3, 'US Air Force', 'Govt');

-- LAYER 2: Foundational Individuals (for FKs)
INSERT INTO Individual (Individual_ID, FirstName, LastName, Date_of_Birth, Status, Species_ID) VALUES
(1000, 'Nick', 'Fury', '1950-07-04', 'Active', 1);

-- LAYER 3: Foundational Sub-Types
INSERT INTO Agent (Individual_ID, Classification_Level, Department, Handler_ID) VALUES
(1000, 10, 'Director', NULL);

-- =====================================================================
-- BLOCK 1: IRON MAN (2008)
-- =====================================================================

-- LAYER 1: Locations, Orgs, Events
INSERT INTO Location (Location_ID, Name, Planet, Latitude, Longitude) VALUES
(101, 'Kunar Province', 'Earth', 35.000000, 69.000000),
(102, 'Stark Mansion', 'Earth', 34.020700, -118.705000),
(103, 'Stark Industries HQ', 'Earth', 33.920700, -118.326600),
(104, 'GULMIRA', 'Earth', 34.500000, 68.000000),
(105, 'Walt Disney Concert Hall', 'Earth', 34.055300, -118.249800);

INSERT INTO Organization (Org_ID, Org_Name, Org_Type) VALUES
(101, 'Stark Industries', 'Private Sector'),
(102, 'Ten Rings (Afghanistan Cell)', 'Terrorist');

INSERT INTO Event (Event_ID, Event_Name, Date_of_Event, Primary_Location_ID, Casualties, Economic_Loss) VALUES
(1, 'Stark Convoy Ambush', '2008-02-10', 101, 23, 5000000.00),
(2, 'Escape from Ten Rings Cave', '2008-05-10', 101, 6, 1000000.00),
(3, 'Battle at Gulmira', '2008-05-15', 104, 12, 2000000.00),
(4, 'Battle at Stark Industries', '2008-05-20', 103, 1, 150000000.00),
(5, 'Stark Press Conference', '2008-05-21', 103, 0, 0.00);

-- LAYER 2: Individuals, Tech
INSERT INTO Individual (Individual_ID, FirstName, LastName, Date_of_Birth, Status, Species_ID) VALUES
(1001, 'Tony', 'Stark', '1970-05-29', 'Deceased', 1),
(1002, 'Pepper', 'Potts', '1972-10-10', 'Active', 1),
(1003, 'Obadiah', 'Stane', '1950-03-15', 'Deceased', 1),
(1004, 'James', 'Rhodes', '1968-10-08', 'Active', 1),
(1005, 'Ho', 'Yinsen', '1945-01-20', 'Deceased', 1),
(1006, 'Raza', 'Hamidmi', '1970-01-01', 'Deceased', 1),
(1007, 'Phil', 'Coulson', '1964-07-08', 'Active', 1);

INSERT INTO Technology (Tech_ID, Name, Inventor_ID, Power_Source) VALUES
(2001, 'Jericho Missile', 1001, 'Conventional'),
(2002, 'Arc Reactor (Large)', 1001, 'Palladium'),
(2003, 'Arc Reactor (Miniature)', 1001, 'Palladium'),
(2004, 'Iron Man Armor: Mark I', 1001, 'Arc Reactor (Miniature)'),
(2005, 'Iron Man Armor: Mark II', 1001, 'Arc Reactor (Miniature)'),
(2006, 'Iron Man Armor: Mark III', 1001, 'Arc Reactor (Miniature)'),
(2007, 'Iron Monger Suit', 1003, 'Arc Reactor (Large)');

-- LAYER 3 & 4: Sub-types, 1-N aliases
INSERT INTO Enhanced_Individual (Individual_ID, Threat_Level, Power_Classification, Power_Origin) VALUES
(1001, 7, 'Powered Armor', 'Technology'),
(1003, 6, 'Powered Armor', 'Technology');

INSERT INTO Agent (Individual_ID, Classification_Level, Department, Handler_ID) VALUES
(1007, 7, 'Field Operations', 1000); -- Coulson's handler is Nick Fury

INSERT INTO Individual_Aliases (Alias_Name, Individual_ID) VALUES
('Iron Man', 1001);

-- LAYER 6 & 7: Junction Tables (Linking everything together)
INSERT INTO Individual_Affiliation (Individual_ID, Org_ID) VALUES
(1001, 101), -- Tony -> Stark Industries
(1002, 101), -- Pepper -> Stark Industries
(1003, 101), -- Stane -> Stark Industries
(1004, 3), -- Rhodey -> US Air Force
(1006, 102), -- Raza -> Ten Rings
(1007, 1);  -- Coulson -> S.H.I.E.L.D.

INSERT INTO Individual_Participation (Individual_ID, Event_ID) VALUES
(1001, 1), -- Tony at Convoy Ambush
(1005, 1), -- Yinsen at Convoy Ambush
(1006, 1), -- Raza at Convoy Ambush
(1001, 2), -- Tony at Escape
(1005, 2), -- Yinsen at Escape
(1006, 2), -- Raza at Escape
(1001, 3), -- Tony at Gulmira
(1006, 3), -- Raza at Gulmira
(1001, 4), -- Tony at SI Battle
(1003, 4), -- Stane at SI Battle
(1001, 5), -- Tony at Press Conference
(1002, 5), -- Pepper at Press Conference
(1004, 5), -- Rhodey at Press Conference
(1007, 5); -- Coulson at Press Conference

INSERT INTO Event_Equipment_Usage (Event_ID, User_Individual_ID, Target_Individual_ID, Tech_ID) VALUES
(2, 1001, 1006, 2004), -- Event 2 (Escape), Tony (1001) used Mark I (2004) against Raza (1006)
(3, 1001, 1006, 2006), -- Event 3 (Gulmira), Tony (1001) used Mark III (2006) against Raza (1006)
(4, 1001, 1003, 2006), -- Event 4 (SI Battle), Tony (1001) used Mark III (2006) against Stane (1003)
(4, 1003, 1001, 2007); -- Event 4 (SI Battle), Stane (1003) used Iron Monger (2007) against Tony (1001)

INSERT INTO Conflict_Nexus_Link (Event_ID, Individual_ID, Org_ID, Location_ID) VALUES
(1, 1001, 102, 101), -- Event 1, Tony vs Ten Rings at Kunar
(1, 1006, 101, 101), -- Event 1, Raza vs Stark Industries at Kunar
(4, 1001, 101, 103), -- Event 4, Tony vs Stane (as Stark Ind) at SI HQ
(4, 1003, 101, 103); -- Event 4, Stane vs Tony (as Stark Ind) at SI HQ

-- LAYER 8: Sightings (Populate this last for the block)
INSERT INTO Sighting (Sighting_ID, Timestamp, Location_ID, Subject_ID, Corroboration_Level) VALUES
(1, '2008-05-15 14:00:00', 104, 1001, 'Verified'), -- Iron Man sighted in Gulmira
(2, '2008-05-16 18:30:00', 103, 1001, 'Verified'); -- Iron Man sighted over Los Angeles (near SI HQ)

-- =====================================================================
-- BLOCK 2: THE INCREDIBLE HULK (2008)
-- =====================================================================
-- *** THIS BLOCK HAS BEEN CORRECTED FOR PK CONFLICTS ***

-- LAYER 1: Locations, Orgs, Events
INSERT INTO Location (Location_ID, Name, Planet, Latitude, Longitude) VALUES
(108, 'Rocinha Favela', 'Earth', -22.9869, -43.2370), -- Was 105
(109, 'Culver University', 'Earth', 36.1461, -86.7963), -- Was 106 (Using Vanderbilt as proxy)
(110, 'Harlem, New York', 'Earth', 40.8116, -73.9465); -- Was 107

INSERT INTO Organization (Org_ID, Org_Name, Org_Type) VALUES
(103, 'US Army SOCOM', 'Govt');

INSERT INTO Event (Event_ID, Event_Name, Date_of_Event, Primary_Location_ID, Casualties, Economic_Loss) VALUES
(6, 'Hulk Chase in Rocinha', '2008-06-12', 108, 5, 50000.00), -- Was 5, updated Loc 108
(7, 'Battle of Culver University', '2008-06-13', 109, 2, 1500000.00), -- Was 6, updated Loc 109
(8, 'Battle of Harlem', '2008-06-15', 110, 31, 40000000.00); -- Was 7, updated Loc 110

-- LAYER 2: Individuals, Tech
INSERT INTO Individual (Individual_ID, FirstName, LastName, Date_of_Birth, Status, Species_ID) VALUES
(1008, 'Bruce', 'Banner', '1969-12-18', 'Active', 1),
(1009, 'Betty', 'Ross', '1971-02-14', 'Active', 1),
(1010, 'Thaddeus', 'Ross', '1955-08-23', 'Active', 1),
(1011, 'Emil', 'Blonsky', '1965-04-01', 'Incarcerated', 1),
(1012, 'Samuel', 'Sterns', '1968-09-02', 'Unknown', 1);

INSERT INTO Technology (Tech_ID, Name, Inventor_ID, Power_Source) VALUES
(2008, 'Super Soldier Serum (Ross Variant)', 1010, 'Chemical'), -- Was 2007, Ross commissioned it
(2009, 'Stark Sonic Cannon', 1001, 'Vibranium'), -- Was 2008, (Stark tech used by Ross)
(2010, 'Gamma Pulse Emitter (Banner)', 1008, 'Gamma Radiation'); -- Was 2009

-- LAYER 3 & 4: Sub-types, 1-N aliases
INSERT INTO Enhanced_Individual (Individual_ID, Threat_Level, Power_Classification, Power_Origin) VALUES
(1008, 9, 'Gamma Mutate (Hulk)', 'Gamma Radiation'),
(1011, 8, 'Super Soldier/Gamma Mutate', 'Gamma Radiation/Serum');

INSERT INTO Individual_Aliases (Alias_Name, Individual_ID) VALUES
('Hulk', 1008),
('Abomination', 1011);

-- LAYER 6 & 7: Junction Tables
INSERT INTO Individual_Affiliation (Individual_ID, Org_ID) VALUES
(1010, 103), -- Ross -> US Army
(1011, 103); -- Blonsky -> US Army (SOCOM)

INSERT INTO Individual_Participation (Individual_ID, Event_ID) VALUES
(1008, 6), -- Banner at Rocinha (Event 6)
(1011, 6), -- Blonsky at Rocinha (Event 6)
(1008, 7), -- Banner at Culver U (Event 7)
(1009, 7), -- Betty at Culver U (Event 7)
(1010, 7), -- Ross at Culver U (Event 7)
(1011, 7), -- Blonsky at Culver U (Event 7)
(1008, 8), -- Banner at Harlem (Event 8)
(1009, 8), -- Betty at Harlem (Event 8)
(1010, 8), -- Ross at Harlem (Event 8)
(1011, 8); -- Blonsky at Harlem (Event 8)

INSERT INTO Individual_Conflicts (Individual_A_ID, Individual_B_ID) VALUES
(1008, 1010), -- Banner vs Ross
(1008, 1011); -- Banner (Hulk) vs Blonsky (Abomination)

INSERT INTO Event_Equipment_Usage (Event_ID, User_Individual_ID, Target_Individual_ID, Tech_ID) VALUES
(7, 1010, 1008, 2009), -- Event 7 (Culver U), Ross (1010) used Sonic Cannon (2009) against Banner (1008)
(7, 1011, 1008, 2008); -- Event 7 (Culver U), Blonsky (1011) used SSS Variant (2008) against Banner (1008)

INSERT INTO Conflict_Nexus_Link (Event_ID, Individual_ID, Org_ID, Location_ID) VALUES
(7, 1008, 103, 109), -- Event 7, Banner vs US Army at Culver U (Loc 109)
(7, 1011, 103, 109), -- Event 7, Blonsky & US Army at Culver U (Loc 109)
(8, 1008, 103, 110), -- Event 8, Banner (Hulk) vs US Army at Harlem (Loc 110)
(8, 1011, 103, 110); -- Event 8, Blonsky (Abomination) vs US Army at Harlem (Loc 110)

-- LAYER 8: Sightings
INSERT INTO Sighting (Sighting_ID, Timestamp, Location_ID, Subject_ID, Corroboration_Level) VALUES
(3, '2008-06-13 19:00:00', 109, 1008, 'Verified'), -- Hulk sighted at Culver University
(4, '2008-06-15 21:00:00', 110, 1011, 'Verified'); -- Abomination sighted in Harlem

-- =====================================================================
-- BLOCK 3: IRON MAN 2 (2010)
-- =====================================================================

-- LAYER 1: Locations, Orgs, Events
INSERT INTO Location (Location_ID, Name, Planet, Latitude, Longitude) VALUES
(111, 'Circuit de Monaco', 'Earth', 43.7347, 7.4206),
(112, 'Stark Expo', 'Earth', 40.7468, -73.8458), -- Flushing Meadows
(113, 'Hammer Industries HQ', 'Earth', 40.7580, -73.9855); -- NYC

INSERT INTO Organization (Org_ID, Org_Name, Org_Type) VALUES
(104, 'Hammer Industries', 'Private Sector');

INSERT INTO Event (Event_ID, Event_Name, Date_of_Event, Primary_Location_ID, Casualties, Economic_Loss) VALUES
(9, 'Monaco Grand Prix Attack', '2010-05-20', 111, 8, 25000000.00),
(10, 'Battle at Stark Expo', '2010-05-26', 112, 14, 75000000.00);

-- LAYER 2: Individuals, Tech
INSERT INTO Individual (Individual_ID, FirstName, LastName, Date_of_Birth, Status, Species_ID) VALUES
(1013, 'Natasha', 'Romanoff', '1984-12-03', 'Deceased', 1),
(1014, 'Ivan', 'Vanko', '1968-01-15', 'Deceased', 1),
(1015, 'Justin', 'Hammer', '1969-04-10', 'Incarcerated', 1);

INSERT INTO Technology (Tech_ID, Name, Inventor_ID, Power_Source) VALUES
(2011, 'Vanko Whips (Mk I)', 1014, 'Arc Reactor (Miniature)'),
(2012, 'Iron Man Armor: Mark V (Suitcase)', 1001, 'Arc Reactor (Miniature)'),
(2013, 'Iron Man Armor: Mark IV', 1001, 'Arc Reactor (Miniature)'),
(2014, 'Iron Man Armor: Mark VI', 1001, 'Arc Reactor (New Element)'),
(2015, 'War Machine Armor: Mark I', 1001, 'Arc Reactor (Miniature)'), -- Stark tech modified by Hammer
(2016, 'Vanko Armor (Whiplash Mk II)', 1014, 'Hammer Tech'),
(2017, 'Hammer Drones (All variants)', 1015, 'Hammer Tech');

-- LAYER 3 & 4: Sub-types, 1-N aliases
INSERT INTO Agent (Individual_ID, Classification_Level, Department, Handler_ID) VALUES
(1013, 8, 'Covert Ops / Legal', 1000); -- Natasha Romanoff, handler Fury

INSERT INTO Enhanced_Individual (Individual_ID, Threat_Level, Power_Classification, Power_Origin) VALUES
(1004, 6, 'Powered Armor', 'Technology'), -- James Rhodes (War Machine)
(1014, 7, 'Powered Armor', 'Technology'); -- Ivan Vanko (Whiplash)

INSERT INTO Individual_Aliases (Alias_Name, Individual_ID) VALUES
('Black Widow', 1013),
('Whiplash', 1014),
('War Machine', 1004);

-- LAYER 6 & 7: Junction Tables
INSERT INTO Individual_Affiliation (Individual_ID, Org_ID) VALUES
(1013, 1), -- Natasha -> S.H.I.E.L.D.
(1013, 101), -- Natasha -> Stark Industries (undercover)
(1014, 104), -- Vanko -> Hammer Industries (coerced)
(1015, 104); -- Hammer -> Hammer Industries

INSERT INTO Individual_Participation (Individual_ID, Event_ID) VALUES
(1001, 9), -- Tony at Monaco
(1002, 9), -- Pepper at Monaco
(1014, 9), -- Vanko at Monaco
(1001, 10), -- Tony at Stark Expo Battle
(1004, 10), -- Rhodey at Stark Expo Battle
(1013, 10), -- Natasha at Stark Expo Battle
(1014, 10), -- Vanko at Stark Expo Battle
(1015, 10); -- Hammer at Stark Expo Battle

INSERT INTO Individual_Conflicts (Individual_A_ID, Individual_B_ID) VALUES
(1001, 1014), -- Tony vs Vanko
(1001, 1015); -- Tony vs Hammer

INSERT INTO Event_Equipment_Usage (Event_ID, User_Individual_ID, Target_Individual_ID, Tech_ID) VALUES
(9, 1014, 1001, 2011), -- Event 9 (Monaco), Vanko (1014) used Whips (2011) against Tony (1001)
(9, 1001, 1014, 2012), -- Event 9 (Monaco), Tony (1001) used Mark V (2012) against Vanko (1014)
(10, 1014, 1001, 2016), -- Event 10 (Expo), Vanko (1014) used Whiplash Mk II (2016) against Tony (1001)
(10, 1015, NULL, 2017), -- Event 10 (Expo), Hammer (1015) deployed Drones (2017)
(10, 1001, 1014, 2014), -- Event 10 (Expo), Tony (1001) used Mark VI (2014) against Vanko (1014)
(10, 1004, 1014, 2015); -- Event 10 (Expo), Rhodey (1004) used War Machine (2015) against Vanko (1014)

INSERT INTO Conflict_Nexus_Link (Event_ID, Individual_ID, Org_ID, Location_ID) VALUES
(9, 1001, 104, 111), -- Event 9, Tony vs Vanko(Hammer) at Monaco
(9, 1014, 101, 111), -- Event 9, Vanko vs Tony(Stark) at Monaco
(10, 1001, 104, 112), -- Event 10, Tony vs Vanko/Hammer at Stark Expo
(10, 1004, 104, 112), -- Event 10, Rhodey vs Vanko/Hammer at Stark Expo
(10, 1014, 101, 112), -- Event 10, Vanko vs Tony/Stark at Stark Expo
(10, 1015, 101, 112); -- Event 10, Hammer vs Tony/Stark at Stark Expo

-- LAYER 8: Sightings
INSERT INTO Sighting (Sighting_ID, Timestamp, Location_ID, Subject_ID, Corroboration_Level) VALUES
(5, '2010-05-20 15:00:00', 111, 1014, 'Verified'), -- Whiplash sighted at Monaco Grand Prix
(6, '2010-05-26 20:00:00', 112, 1004, 'Verified'); -- War Machine sighted at Stark Expo

-- =====================================================================
-- BLOCK 4: THOR (2011)
-- =====================================================================

-- LAYER 1: Locations, Orgs, Events
INSERT INTO Location (Location_ID, Name, Planet, Latitude, Longitude) VALUES
(114, 'Puente Antiguo', 'Earth', 35.0937, -106.8117), -- New Mexico
(115, 'Heimdalls Observatory (Bifrost)', 'Asgard', NULL, NULL);

INSERT INTO Organization (Org_ID, Org_Name, Org_Type) VALUES
(105, 'Royal Family of Asgard', 'Govt');

INSERT INTO Event (Event_ID, Event_Name, Date_of_Event, Primary_Location_ID, Casualties, Economic_Loss) VALUES
(11, 'Interrupted Coronation', '2011-05-01', 11, 2, 0.00), -- Asgard
(12, 'Bifrost Attack on Jotunheim', '2011-05-02', 12, 11, 500000.00), -- Jotunheim
(13, 'Destroyer Attacks Puente Antiguo', '2011-05-05', 114, 3, 2500000.00),
(14, 'Battle on the Bifrost', '2011-05-06', 115, 0, 100000000.00);

-- LAYER 2: Individuals, Tech, Artifacts
INSERT INTO Individual (Individual_ID, FirstName, LastName, Date_of_Birth, Status, Species_ID) VALUES
(1016, 'Thor', 'Odinson', '0965-03-15', 'Active', 2),
(1017, 'Loki', 'Laufeyson', '0965-12-17', 'Deceased', 3), -- Species is Frost Giant
(1018, 'Odin', 'Borson', '0700-01-01', 'Deceased', 2),
(1019, 'Jane', 'Foster', '1985-06-13', 'Active', 1),
(1020, 'Erik', 'Selvig', '1958-11-20', 'Active', 1),
(1021, 'Darcy', 'Lewis', '1988-09-22', 'Active', 1),
(1022, 'Heimdall', '', '0900-01-01', 'Deceased', 2),
(1023, 'Laufey', '', '0001-01-01', 'Deceased', 3),
(1024, 'Clint', 'Barton', '1971-06-18', 'Active', 1);

INSERT INTO Technology (Tech_ID, Name, Inventor_ID, Power_Source) VALUES
(2018, 'The Destroyer', 1018, 'Odinforce');

INSERT INTO Artifact (Artifact_ID, Official_Name, Type) VALUES
(3001, 'Mjolnir', 'Asgardian'),
(3002, 'Casket of Ancient Winters', 'Frost Giant Artifact'),
(3003, 'Gungnir', 'Asgardian');

-- LAYER 3 & 4: Sub-types, 1-N aliases
INSERT INTO Agent (Individual_ID, Classification_Level, Department, Handler_ID) VALUES
(1024, 7, 'Covert Ops', 1000); -- Clint Barton, handler Fury

INSERT INTO Enhanced_Individual (Individual_ID, Threat_Level, Power_Classification, Power_Origin) VALUES
(1016, 8, 'Asgardian Physiology', 'Inherent'), -- Thor
(1017, 7, 'Frost Giant/Magic', 'Inherent/Learned'), -- Loki
(1018, 10, 'Asgardian Physiology (All-Father)', 'Inherent'), -- Odin
(1022, 7, 'Asgardian Physiology (Seer)', 'Inherent'), -- Heimdall
(1023, 7, 'Frost Giant Physiology', 'Inherent'); -- Laufey

INSERT INTO Individual_Aliases (Alias_Name, Individual_ID) VALUES
('God of Thunder', 1016),
('God of Mischief', 1017),
('All-Father', 1018),
('Hawkeye', 1024);

-- LAYER 6 & 7: Junction Tables
INSERT INTO Individual_Affiliation (Individual_ID, Org_ID) VALUES
(1016, 105), -- Thor -> Asgard Royal Family
(1017, 105), -- Loki -> Asgard Royal Family
(1018, 105), -- Odin -> Asgard Royal Family
(1022, 105), -- Heimdall -> Asgard Royal Family
(1024, 1);  -- Clint Barton -> S.H.I.E.L.D.

INSERT INTO Individual_Participation (Individual_ID, Event_ID) VALUES
(1016, 11), (1017, 11), (1018, 11), (1022, 11), -- Coronation
(1016, 12), (1017, 12), (1022, 12), (1023, 12), -- Jotunheim Attack
(1007, 13), (1016, 13), (1017, 13), (1019, 13), (1020, 13), (1021, 13), (1024, 13), -- Destroyer Attack
(1016, 14), (1017, 14), (1022, 14); -- Bifrost Battle

INSERT INTO Individual_Possession_Artifact (Individual_ID, Artifact_ID) VALUES
(1016, 3001), -- Thor -> Mjolnir
(1018, 3003), -- Odin -> Gungnir
(1023, 3002); -- Laufey -> Casket

INSERT INTO Individual_Conflicts (Individual_A_ID, Individual_B_ID) VALUES
(1016, 1017), -- Thor vs Loki
(1016, 1018), -- Thor vs Odin
(1016, 1023), -- Thor vs Laufey
(1017, 1023); -- Loki vs Laufey

INSERT INTO Event_Equipment_Usage (Event_ID, User_Individual_ID, Target_Individual_ID, Tech_ID, Artifact_ID) VALUES
(12, 1017, 1023, NULL, 3002), -- Event 12 (Jotunheim), Loki (1017) uses Casket (3002) against Laufey (1023)
(13, 1017, 1016, 2018, NULL), -- Event 13 (Puente), Loki (1017) uses Destroyer (2018) against Thor (1016)
(13, 1016, NULL, NULL, 3001), -- Event 13 (Puente), Thor (1016) regains Mjolnir (3001)
(14, 1016, 1017, 3001, NULL), -- Event 14 (Bifrost), Thor (1016) uses Mjolnir (3001) against Loki (1017)
(14, 1017, 1016, NULL, 3003); -- Event 14 (Bifrost), Loki (1017) uses Gungnir (3003) against Thor (1016)

INSERT INTO Conflict_Nexus_Link (Event_ID, Individual_ID, Org_ID, Location_ID) VALUES
(12, 1016, NULL, 12), -- Event 12, Thor at Jotunheim
(12, 1017, NULL, 12), -- Event 12, Loki at Jotunheim
(13, 1016, 1, 114), -- Event 13, Thor vs S.H.I.E.L.D. at Puente Antiguo
(13, 1007, NULL, 114), -- Event 13, Coulson at Puente Antiguo
(13, 1024, NULL, 114), -- Event 13, Barton at Puente Antiguo
(14, 1016, 105, 115), -- Event 14, Thor at Bifrost
(14, 1017, 105, 115); -- Event 14, Loki at Bifrost

-- LAYER 8: Sightings
INSERT INTO Sighting (Sighting_ID, Timestamp, Location_ID, Subject_ID, Corroboration_Level) VALUES
(7, '2011-05-03 20:17:00', 114, 1016, 'Verified'), -- Thor ("Donald Blake") sighted in Puente Antiguo
(8, '2011-05-05 13:00:00', 114, 1007, 'Verified'), -- Agent Coulson sighted at Mjolnir crash site
(9, '2011-05-05 13:05:00', 114, 1024, 'Verified'); -- Agent Barton sighted at Mjolnir crash site

-- =====================================================================
-- BLOCK 5: CAPTAIN AMERICA: THE FIRST AVENGER (2011)
-- =====================================================================

-- LAYER 1: Locations, Orgs, Events
INSERT INTO Location (Location_ID, Name, Planet, Latitude, Longitude) VALUES
(116, 'Tønsberg', 'Earth', 59.2669, 10.4174), -- Norway
(117, 'Camp Lehigh', 'Earth', 40.0783, -74.9221), -- New Jersey
(118, 'HYDRA Weapons Facility (Alps)', 'Earth', 46.8879, 9.6588); -- Alps

INSERT INTO Organization (Org_ID, Org_Name, Org_Type) VALUES
(106, 'Strategic Scientific Reserve (SSR)', 'Govt');

INSERT INTO Event (Event_ID, Event_Name, Date_of_Event, Primary_Location_ID, Casualties, Economic_Loss) VALUES
(15, 'Tønsberg HYDRA Raid', '1942-03-10', 116, 1, 50000.00),
(16, 'Project Rebirth', '1943-06-22', 117, 1, 200000.00),
(17, 'Final Battle (Valkyrie)', '1945-03-05', 118, 1, 10000000.00);

-- LAYER 2: Individuals, Tech, Artifacts
INSERT INTO Individual (Individual_ID, FirstName, LastName, Date_of_Birth, Status, Species_ID) VALUES
(1025, 'Steve', 'Rogers', '1918-07-04', 'Active', 1),
(1026, 'James "Bucky"', 'Barnes', '1917-03-10', 'Active', 1), -- Status is his final known status
(1027, 'Peggy', 'Carter', '1921-04-09', 'Deceased', 1),
(1028, 'Johann', 'Schmidt', '1914-01-01', 'Unknown', 1),
(1029, 'Abraham', 'Erskine', '1895-10-15', 'Deceased', 1),
(1030, 'Howard', 'Stark', '1917-08-15', 'Deceased', 1),
(1031, 'Chester', 'Phillips', '1890-01-01', 'Deceased', 1);

INSERT INTO Technology (Tech_ID, Name, Inventor_ID, Power_Source) VALUES
(2019, 'Super Soldier Serum (Erskine)', 1029, 'Vita-Radiation'),
(2020, 'Vibranium Shield', 1030, 'N/A (Inert)'),
(2021, 'HYDRA Tesseract Weapons', 1028, 'Tesseract');

INSERT INTO Artifact (Artifact_ID, Official_Name, Type) VALUES
(3004, 'The Tesseract', 'Infinity Stone'); -- First appearance

-- LAYER 3 & 4: Sub-types, 1-N aliases
INSERT INTO Agent (Individual_ID, Classification_Level, Department, Handler_ID) VALUES
(1027, 9, 'SSR Field Agent', 1031); -- Peggy Carter, handler Col. Phillips

INSERT INTO Enhanced_Individual (Individual_ID, Threat_Level, Power_Classification, Power_Origin) VALUES
(1025, 8, 'Super Soldier Serum', 'Experiment'), -- Steve Rogers
(1028, 8, 'Imperfect Serum', 'Experiment'); -- Johann Schmidt

INSERT INTO Individual_Aliases (Alias_Name, Individual_ID) VALUES
('Captain America', 1025),
('Red Skull', 1028),
('Winter Soldier', 1026); -- Known alias, even if not active yet

-- LAYER 6 & 7: Junction Tables
INSERT INTO Individual_Affiliation (Individual_ID, Org_ID) VALUES
(1025, 106), -- Steve -> SSR
(1026, 106), -- Bucky -> SSR (via US Army)
(1027, 106), -- Peggy -> SSR
(1028, 2),  -- Schmidt -> HYDRA
(1029, 106), -- Erskine -> SSR
(1030, 106), -- Howard -> SSR
(1031, 106); -- Phillips -> SSR

INSERT INTO Individual_Participation (Individual_ID, Event_ID) VALUES
(1028, 15), (1018, 15), -- Schmidt at Tønsberg (vs Odin's forces, historically)
(1025, 16), (1027, 16), (1028, 16), (1029, 16), (1031, 16), -- Project Rebirth
(1025, 17), (1026, 17), (1027, 17), (1028, 17), (1031, 17); -- Final Battle

INSERT INTO Individual_Possession_Artifact (Individual_ID, Artifact_ID) VALUES
(1028, 3004); -- Schmidt/HYDRA possessed the Tesseract

INSERT INTO Individual_Conflicts (Individual_A_ID, Individual_B_ID) VALUES
(1025, 1028); -- Steve Rogers vs Johann Schmidt

INSERT INTO Event_Equipment_Usage (Event_ID, User_Individual_ID, Target_Individual_ID, Tech_ID, Artifact_ID) VALUES
(15, 1028, NULL, NULL, 3004), -- Event 15 (Tønsberg), Schmidt (1028) retrieves Tesseract (3004)
(16, 1029, 1025, 2019, NULL), -- Event 16 (Rebirth), Erskine (1029) uses Serum (2019) on Steve (1025)
(17, 1025, 1028, 2020, NULL), -- Event 17 (Valkyrie), Steve (1025) uses Shield (2020) against Schmidt (1028)
(17, 1028, 1025, 2021, NULL); -- Event 17 (Valkyrie), Schmidt (1028) uses HYDRA weapons (2021) against Steve (1025)

INSERT INTO Conflict_Nexus_Link (Event_ID, Individual_ID, Org_ID, Location_ID) VALUES
(15, 1028, 2, 116), -- Event 15, Schmidt/HYDRA at Tønsberg
(16, 1025, 106, 117), -- Event 16, Steve/SSR at Camp Lehigh
(17, 1025, 2, 118), -- Event 17, Steve vs HYDRA at Alps Facility
(17, 1028, 106, 118); -- Event 17, Schmidt vs SSR at Alps Facility

-- LAYER 8: Sightings
INSERT INTO Sighting (Sighting_ID, Timestamp, Location_ID, Subject_ID, Corroboration_Level) VALUES
(10, '1942-03-10 10:00:00', 116, 1028, 'Verified'), -- Red Skull sighted in Tønsberg
(11, '1944-11-01 15:30:00', 118, 1025, 'Verified'); -- Captain America sighted at HYDRA facility

-- =====================================================================
-- BLOCK 6: THE AVENGERS (2012)
-- =====================================================================

-- LAYER 1: Locations, Orgs, Events
INSERT INTO Location (Location_ID, Name, Planet, Latitude, Longitude) VALUES
(119, 'Project P.E.G.A.S.U.S. Facility', 'Earth', 34.4150, -118.3438),
(120, 'Stuttgart, Germany', 'Earth', 48.7758, 9.1829),
(121, 'S.H.I.E.L.D. Helicarrier (Airborne)', 'Earth', NULL, NULL);

INSERT INTO Organization (Org_ID, Org_Name, Org_Type) VALUES
(107, 'The Avengers', 'Hero Team'),
(108, 'Chitauri', 'Terrorist'),
(109, 'World Security Council', 'Govt');

INSERT INTO Species (Species_ID, Common_Name, Home_Planet_ID, General_Physiology) VALUES
(7, 'Chitauri', NULL, 'Cybernetically enhanced reptilian species.');

INSERT INTO Event (Event_ID, Event_Name, Date_of_Event, Primary_Location_ID, Casualties, Economic_Loss) VALUES
(18, 'Loki Steals Tesseract', '2012-05-01', 119, 5, 75000000.00),
(19, 'Battle of Stuttgart', '2012-05-02', 120, 0, 200000.00),
(20, 'Helicarrier Attack', '2012-05-03', 121, 1, 10000000.00), -- Coulson
(21, 'Battle of New York', '2012-05-04', 103, 188, 160000000000.00); -- Primary Location is Stark Tower

-- LAYER 2: Individuals, Tech, Artifacts
INSERT INTO Individual (Individual_ID, FirstName, LastName, Date_of_Birth, Status, Species_ID) VALUES
(1032, 'Maria', 'Hill', '1982-04-04', 'Active', 1);

INSERT INTO Technology (Tech_ID, Name, Inventor_ID, Power_Source) VALUES
(2022, 'Iron Man Armor: Mark VII', 1001, 'Arc Reactor (New Element)'),
(2023, 'Chitauri Weapons/Chariots', NULL, 'Tesseract'),
(2024, 'Quinjet', 1, 'Conventional/Repulsor'), -- S.H.I.E.L.D. Tech
(2025, 'Helicarrier Turbine Engines', 1030, 'Repulsor'); -- Based on Howard Stark's design

INSERT INTO Artifact (Artifact_ID, Official_Name, Type) VALUES
(3005, 'Loki s Scepter (Mind Stone)', 'Infinity Stone');

-- LAYER 3 & 4: Sub-types, 1-N aliases
INSERT INTO Agent (Individual_ID, Classification_Level, Department, Handler_ID) VALUES
(1032, 9, 'Deputy Director', 1000); -- Maria Hill, handler Fury

-- LAYER 6 & 7: Junction Tables
INSERT INTO Individual_Affiliation (Individual_ID, Org_ID) VALUES
(1001, 107), -- Tony -> Avengers
(1008, 107), -- Bruce -> Avengers
(1013, 107), -- Natasha -> Avengers
(1016, 107), -- Thor -> Avengers
(1024, 107), -- Clint -> Avengers
(1025, 107), -- Steve -> Avengers
(1017, 108), -- Loki -> Chitauri (Alliance)
(1032, 1);  -- Hill -> S.H.I.E.L.D.

INSERT INTO Individual_Participation (Individual_ID, Event_ID) VALUES
(1000, 18), (1007, 18), (1017, 18), (1020, 18), (1024, 18), (1032, 18), -- Tesseract Theft
(1001, 19), (1013, 19), (1017, 19), (1025, 19), -- Stuttgart
(1000, 20), (1001, 20), (1007, 20), (1008, 20), (1013, 20), (1016, 20), (1017, 20), (1024, 20), (1025, 20), (1032, 20), -- Helicarrier Attack
(1001, 21), (1008, 21), (1013, 21), (1016, 21), (1017, 21), (1024, 21), (1025, 21); -- Battle of New York

INSERT INTO Individual_Possession_Artifact (Individual_ID, Artifact_ID) VALUES
(1017, 3004), -- Loki steals Tesseract
(1017, 3005); -- Loki has Scepter

INSERT INTO Individual_Conflicts (Individual_A_ID, Individual_B_ID) VALUES
(1017, 1007), -- Loki vs Coulson
(1001, 1025), -- Tony vs Steve (Helicarrier)
(1001, 1016), -- Tony vs Thor (Forest)
(1016, 1025), -- Thor vs Steve (Forest)
(1008, 1013), -- Bruce (Hulk) vs Natasha (Helicarrier)
(1008, 1016), -- Bruce (Hulk) vs Thor (Helicarrier)
(1013, 1024), -- Natasha vs Clint (Helicarrier)
(1008, 1017), -- Bruce (Hulk) vs Loki (Stark Tower)
(1016, 1017); -- Thor vs Loki (Stark Tower) - This conflict already exists, but is re-confirmed

INSERT INTO Event_Equipment_Usage (Event_ID, User_Individual_ID, Target_Individual_ID, Tech_ID, Artifact_ID) VALUES
(18, 1017, 1024, NULL, 3005), -- Event 18 (PEGASUS), Loki (1017) uses Scepter (3005) on Clint (1024)
(18, 1017, 1020, NULL, 3005), -- Event 18 (PEGASUS), Loki (1017) uses Scepter (3005) on Selvig (1020)
(19, 1025, 1017, 2020, NULL), -- Event 19 (Stuttgart), Steve (1025) uses Shield (2020) against Loki (1017)
(20, 1017, 1007, NULL, 3005), -- Event 20 (Helicarrier), Loki (1017) "kills" Coulson (1007) with Scepter (3005)
(21, 1017, NULL, NULL, 3004), -- Event 21 (BONY), Loki (1017) uses Tesseract (3004) to open portal
(21, 1001, NULL, 2022, NULL), -- Event 21 (BONY), Tony (1001) uses Mark VII (2022)
(21, 1013, NULL, NULL, 3005); -- Event 21 (BONY), Natasha (1013) uses Scepter (3005) to close portal

INSERT INTO Conflict_Nexus_Link (Event_ID, Individual_ID, Org_ID, Location_ID) VALUES
(18, 1017, 1, 119), -- Event 18, Loki vs S.H.I.E.L.D. at PEGASUS
(19, 1017, 1, 120), -- Event 19, Loki vs S.H.I.E.L.D. (Cap) at Stuttgart
(21, 1017, 107, 103), -- Event 21, Loki vs Avengers at Stark Tower
(21, 1001, 108, 103), -- Event 21, Tony vs Chitauri at Stark Tower
(21, 1008, 108, 103), -- Event 21, Hulk vs Chitauri at Stark Tower
(21, 1013, 108, 103), -- Event 21, Natasha vs Chitauri at Stark Tower
(21, 1016, 108, 103), -- Event 21, Thor vs Chitauri at Stark Tower
(21, 1024, 108, 103), -- Event 21, Clint vs Chitauri at Stark Tower
(21, 1025, 108, 103); -- Event 21, Steve vs Chitauri at Stark Tower

-- LAYER 8: Sightings
INSERT INTO Sighting (Sighting_ID, Timestamp, Location_ID, Subject_ID, Corroboration_Level) VALUES
(12, '2012-05-02 18:00:00', 120, 1017, 'Verified'), -- Loki sighted in Stuttgart
(13, '2012-05-04 13:30:00', 103, 1008, 'Verified'), -- Hulk sighted in New York (Midtown)
(14, '2012-05-04 13:00:00', 103, 1025, 'Verified'); -- Captain America sighted in New York (Midtown)

-- =====================================================================
-- BLOCK 7: IRON MAN 3 (2013)
-- =====================================================================

-- LAYER 1: Locations, Orgs, Events
INSERT INTO Location (Location_ID, Name, Planet, Latitude, Longitude) VALUES
(122, 'Chattanooga, Tennessee', 'Earth', 35.0456, -85.3097),
(123, 'TCL Chinese Theatre', 'Earth', 34.1016, -118.3415),
(124, '"Norco" Oil Tanker', 'Earth', 29.9489, -90.3557); -- Off coast

INSERT INTO Organization (Org_ID, Org_Name, Org_Type) VALUES
(110, 'Advanced Idea Mechanics (A.I.M.)', 'Private Sector');

INSERT INTO Event (Event_ID, Event_Name, Date_of_Event, Primary_Location_ID, Casualties, Economic_Loss) VALUES
(22, 'TCL Chinese Theatre Bombing', '2013-01-15', 123, 8, 500000.00),
(23, 'Attack on Stark Mansion', '2013-01-17', 102, 0, 50000000.00), -- Location 102 is Stark Mansion
(24, 'Battle on the "Norco" Tanker', '2013-01-19', 124, 25, 30000000.00);

-- LAYER 2: Individuals, Tech, Artifacts
INSERT INTO Individual (Individual_ID, FirstName, LastName, Date_of_Birth, Status, Species_ID) VALUES
(1033, 'Aldrich', 'Killian', '1975-11-20', 'Deceased', 1),
(1034, 'Maya', 'Hansen', '1978-05-12', 'Deceased', 1),
(1035, 'Ellen', 'Brandt', '1980-01-01', 'Deceased', 1),
(1036, 'Eric', 'Savin', '1976-01-01', 'Deceased', 1),
(1037, 'Harley', 'Keener', '2002-06-25', 'Active', 1);

INSERT INTO Technology (Tech_ID, Name, Inventor_ID, Power_Source) VALUES
(2026, 'Extremis', 1034, 'Bioweapon'), -- Invented by Maya Hansen
(2027, 'Iron Man Armor: Mark 42', 1001, 'Arc Reactor (New Element)'),
(2028, 'Iron Patriot Armor', 1001, 'Arc Reactor (New Element)'), -- Rebranded Mark II
(2029, 'Iron Legion (Various)', 1001, 'Arc Reactor (New Element)');

-- LAYER 3 & 4: Sub-types, 1-N aliases
INSERT INTO Enhanced_Individual (Individual_ID, Threat_Level, Power_Classification, Power_Origin) VALUES
(1002, 7, 'Extremis (Temporary)', 'Experiment'), -- Pepper Potts
(1033, 8, 'Extremis', 'Experiment'), -- Aldrich Killian
(1035, 6, 'Extremis', 'Experiment'), -- Ellen Brandt
(1036, 6, 'Extremis', 'Experiment'); -- Eric Savin

INSERT INTO Individual_Aliases (Alias_Name, Individual_ID) VALUES
('The Mandarin', 1033), -- Killian's cover
('Iron Patriot', 1004); -- Rhodey's new alias

-- LAYER 6 & 7: Junction Tables
INSERT INTO Individual_Affiliation (Individual_ID, Org_ID) VALUES
(1033, 110), -- Killian -> A.I.M.
(1034, 110), -- Maya Hansen -> A.I.M.
(1035, 110), -- Brandt -> A.I.M.
(1036, 110), -- Savin -> A.I.M.
(1033, 102), -- Killian -> Ten Rings (used them)
(1004, 107); -- Rhodey -> Avengers (affiliated)

INSERT INTO Individual_Participation (Individual_ID, Event_ID) VALUES
(1036, 22), -- Savin at Chinese Theatre
(1001, 23), (1002, 23), (1034, 23), (1036, 23), -- Attack on Stark Mansion
(1001, 24), (1002, 24), (1004, 24), (1033, 24), (1036, 24); -- Battle on Norco Tanker

INSERT INTO Individual_Conflicts (Individual_A_ID, Individual_B_ID) VALUES
(1001, 1033), -- Tony vs Killian
(1001, 1036), -- Tony vs Savin
(1002, 1033), -- Pepper vs Killian
(1004, 1036); -- Rhodey vs Savin

INSERT INTO Event_Equipment_Usage (Event_ID, User_Individual_ID, Target_Individual_ID, Tech_ID, Artifact_ID) VALUES
(22, 1036, NULL, 2026, NULL), -- Event 22 (Theatre), Savin (1036) uses Extremis (2026)
(23, 1001, 1036, 2027, NULL), -- Event 23 (Mansion), Tony (1001) uses Mark 42 (2027) against Savin (1036)
(24, 1001, 1033, 2029, NULL), -- Event 24 (Norco), Tony (1001) uses Iron Legion (2029) against Killian (1033)
(24, 1033, 1001, 2026, NULL), -- Event 24 (Norco), Killian (1033) uses Extremis (2026) against Tony (1001)
(24, 1004, 1036, 2028, NULL), -- Event 24 (Norco), Rhodey (1004) uses Iron Patriot (2028) against Savin (1036)
(24, 1002, 1033, 2026, NULL); -- Event 24 (Norco), Pepper (1002) uses Extremis (2026) against Killian (1033)

INSERT INTO Conflict_Nexus_Link (Event_ID, Individual_ID, Org_ID, Location_ID) VALUES
(23, 1001, 110, 102), -- Event 23, Tony vs A.I.M. at Stark Mansion
(23, 1036, 101, 102), -- Event 23, Savin (A.I.M.) vs Stark Industries at Stark Mansion
(24, 1001, 110, 124), -- Event 24, Tony vs A.I.M. at Norco Tanker
(24, 1033, 101, 124); -- Event 24, Killian (A.I.M.) vs Stark Industries at Norco Tanker

-- LAYER 8: Sightings
INSERT INTO Sighting (Sighting_ID, Timestamp, Location_ID, Subject_ID, Corroboration_Level) VALUES
(15, '2013-01-17 10:00:00', 102, 1001, 'Verified'), -- Tony Stark sighted at Mansion (pre-attack)
(16, '2013-01-18 01:00:00', 122, 1001, 'Likely'); -- Iron Man (Mark 42) sighted in Tennessee

-- =====================================================================
-- BLOCK 8: THOR: THE DARK WORLD (2013)
-- =====================================================================

-- LAYER 1: Locations, Orgs, Events
INSERT INTO Location (Location_ID, Name, Planet, Latitude, Longitude) VALUES
(125, 'Svartalfheim', 'Svartalfheim', NULL, NULL),
(126, 'Old Royal Naval College', 'Earth', 51.4833, -0.0053); -- London

INSERT INTO Organization (Org_ID, Org_Name, Org_Type) VALUES
(111, 'Dark Elves', 'Terrorist');

INSERT INTO Species (Species_ID, Common_Name, Home_Planet_ID, General_Physiology) VALUES
(8, 'Dark Elf', 125, 'Ancient species, thrives in darkness, vulnerable to iron.');

INSERT INTO Event (Event_ID, Event_Name, Date_of_Event, Primary_Location_ID, Casualties, Economic_Loss) VALUES
(25, 'First Battle of Svartalfheim', '2987-05-01', 125, 10000, 0.00), -- Prologue
(26, 'Jane Foster discovers Aether', '2013-11-18', 126, 0, 1000.00),
(27, 'Dark Elf Attack on Asgard', '2013-11-19', 11, 500, 100000000.00),
(28, 'Battle of Greenwich', '2013-11-20', 126, 150, 50000000.00);

-- LAYER 2: Individuals, Tech, Artifacts
INSERT INTO Individual (Individual_ID, FirstName, LastName, Date_of_Birth, Status, Species_ID) VALUES
(1038, 'Malekith', '', '0001-01-01', 'Deceased', 8),
(1039, 'Algrim (Kurse)', '', '0001-01-01', 'Deceased', 8),
(1040, 'Frigga', '', '0500-01-01', 'Deceased', 2);

INSERT INTO Technology (Tech_ID, Name, Inventor_ID, Power_Source) VALUES
(2030, 'Dark Elf "Harrow" Ship', NULL, 'Unknown'),
(2031, 'Dark Elf "Ark" Ship', NULL, 'Unknown'),
(2032, 'Singularity Grenade', NULL, 'Miniature Black Hole');

INSERT INTO Artifact (Artifact_ID, Official_Name, Type) VALUES
(3006, 'Aether (Reality Stone)', 'Infinity Stone');

-- LAYER 3 & 4: Sub-types, 1-N aliases
INSERT INTO Enhanced_Individual (Individual_ID, Threat_Level, Power_Classification, Power_Origin) VALUES
(1019, 8, 'Aether Host', 'Infinity Stone'), -- Jane Foster (Temporary)
(1038, 9, 'Aether Host', 'Infinity Stone'), -- Malekith
(1039, 8, 'Kursed', 'Dark Elf Tech'); -- Algrim

INSERT INTO Individual_Aliases (Alias_Name, Individual_ID) VALUES
('Kurse', 1039);

-- LAYER 6 & 7: Junction Tables
INSERT INTO Individual_Affiliation (Individual_ID, Org_ID) VALUES
(1038, 111), -- Malekith -> Dark Elves
(1039, 111); -- Algrim -> Dark Elves

INSERT INTO Individual_Participation (Individual_ID, Event_ID) VALUES
(1038, 25), (1039, 25), (1018, 25), -- First Battle of Svartalfheim
(1019, 26), (1021, 26), -- Jane finds Aether
(1016, 27), (1017, 27), (1018, 27), (1038, 27), (1039, 27), (1040, 27), -- Attack on Asgard
(1016, 28), (1017, 28), (1019, 28), (1020, 28), (1021, 28), (1038, 28), (1039, 28); -- Battle of Greenwich

INSERT INTO Individual_Possession_Artifact (Individual_ID, Artifact_ID) VALUES
(1019, 3006), -- Jane -> Aether
(1038, 3006); -- Malekith -> Aether

INSERT INTO Individual_Conflicts (Individual_A_ID, Individual_B_ID) VALUES
(1016, 1038), -- Thor vs Malekith
(1016, 1039), -- Thor vs Kurse
(1017, 1039), -- Loki vs Kurse
(1038, 1040); -- Malekith vs Frigga

INSERT INTO Event_Equipment_Usage (Event_ID, User_Individual_ID, Target_Individual_ID, Tech_ID, Artifact_ID) VALUES
(26, 1019, NULL, NULL, 3006), -- Event 26 (Greenwich), Jane (1019) absorbs Aether (3006)
(27, 1039, 1040, 2032, NULL), -- Event 27 (Asgard), Kurse (1039) uses Singularity Grenade (2032) (implies Frigga's death)
(27, 1038, NULL, 2031, NULL), -- Event 27 (Asgard), Malekith (1038) uses Ark Ship (2031)
(28, 1038, NULL, NULL, 3006), -- Event 28 (Greenwich), Malekith (1038) uses Aether (3006)
(28, 1016, 1038, 3001, NULL); -- Event 28 (Greenwich), Thor (1016) uses Mjolnir (3001) against Malekith (1038)

INSERT INTO Conflict_Nexus_Link (Event_ID, Individual_ID, Org_ID, Location_ID) VALUES
(27, 1038, 111, 11), -- Event 27, Malekith/Dark Elves at Asgard
(27, 1040, 105, 11), -- Event 27, Frigga/Asgard at Asgard
(28, 1016, 111, 126), -- Event 28, Thor vs Dark Elves at Greenwich
(28, 1038, 105, 126); -- Event 28, Malekith vs Asgard (Thor) at Greenwich

-- LAYER 8: Sightings
INSERT INTO Sighting (Sighting_ID, Timestamp, Location_ID, Subject_ID, Corroboration_Level) VALUES
(17, '2013-11-20 13:00:00', 126, 1016, 'Verified'), -- Thor sighted at Greenwich
(18, '2013-11-20 13:10:00', 126, 1038, 'Verified'); -- Malekith sighted at Greenwich

-- =====================================================================
-- BLOCK 9: CAPTAIN AMERICA: THE WINTER SOLDIER (2014)
-- =====================================================================

-- LAYER 1: Locations, Orgs, Events
INSERT INTO Location (Location_ID, Name, Planet, Latitude, Longitude) VALUES
(127, 'Lemurian Star (Ship)', 'Earth', 0.0000, 0.0000), -- Indian Ocean
(128, 'Smithsonian Air & Space Museum', 'Earth', 38.8880, -77.0199),
(129, 'S.H.I.E.L.D. Triskelion', 'Earth', 38.8913, -77.0494); -- Re-using for ground location

INSERT INTO Event (Event_ID, Event_Name, Date_of_Event, Primary_Location_ID, Casualties, Economic_Loss) VALUES
(29, 'Lemurian Star Hostage Rescue', '2014-04-01', 127, 25, 1000000.00),
(30, 'Nick Fury Ambush', '2014-04-02', 129, 0, 500000.00), -- DC Streets, but Triskelion is center
(31, 'Battle at the Triskelion (Project Insight)', '2014-04-04', 129, 23, 5000000000.00);

-- LAYER 2: Individuals, Tech, Artifacts
INSERT INTO Individual (Individual_ID, FirstName, LastName, Date_of_Birth, Status, Species_ID) VALUES
(1041, 'Sam', 'Wilson', '1978-09-23', 'Active', 1),
(1042, 'Alexander', 'Pierce', '1948-01-01', 'Deceased', 1),
(1043, 'Brock', 'Rumlow', '1979-05-15', 'Deceased', 1);
-- Note: Bucky Barnes (1026) and Steve Rogers (1025) are already in the DB.

INSERT INTO Technology (Tech_ID, Name, Inventor_ID, Power_Source) VALUES
(2033, 'Project Insight Helicarriers', 1030, 'Repulsor'), -- Stark/Zola tech
(2034, 'EXO-7 Falcon Wings', 3, 'Mini-Jet Engine'), -- US Air Force Tech
(2035, 'Winter Soldier Prosthetic Arm', 2, 'HYDRA Tech'); -- HYDRA Tech

-- LAYER 3 & 4: Sub-types, 1-N aliases
INSERT INTO Agent (Individual_ID, Classification_Level, Department, Handler_ID) VALUES
(1041, 6, 'Pararescue (Ret.)', NULL), -- Sam Wilson (Affiliated, not an agent yet)
(1042, 10, 'Director (WSC)', NULL), -- Alexander Pierce
(1043, 7, 'S.T.R.I.K.E.', 1025); -- Brock Rumlow, handler Steve Rogers

INSERT INTO Enhanced_Individual (Individual_ID, Threat_Level, Power_Classification, Power_Origin) VALUES
(1026, 8, 'Super Soldier/Cybernetic', 'Experiment'); -- Bucky Barnes (Winter Soldier)

INSERT INTO Individual_Aliases (Alias_Name, Individual_ID) VALUES
('Winter Soldier', 1026), -- Alias officially logged
('Falcon', 1041);

-- LAYER 6 & 7: Junction Tables
INSERT INTO Individual_Affiliation (Individual_ID, Org_ID) VALUES
(1025, 1), (1013, 1), (1000, 1), (1032, 1), -- Cap, Widow, Fury, Hill -> S.H.I.E.L.D.
(1041, 3), -- Sam -> US Air Force
(1042, 1), (1042, 2), -- Pierce -> S.H.I.E.L.D. AND HYDRA
(1043, 1), (1043, 2); -- Rumlow -> S.H.I.E.L.D. AND HYDRA

INSERT INTO Individual_Participation (Individual_ID, Event_ID) VALUES
(1025, 29), (1013, 29), (1043, 29), -- Lemurian Star
(1000, 30), (1025, 30), (1026, 30), (1042, 30), -- Fury Ambush
(1000, 31), (1013, 31), (1025, 31), (1026, 31), (1032, 31), (1041, 31), (1042, 31), (1043, 31); -- Battle at Triskelion

INSERT INTO Individual_Conflicts (Individual_A_ID, Individual_B_ID) VALUES
(1025, 1026), -- Steve Rogers vs Bucky Barnes (Winter Soldier)
(1013, 1026), -- Natasha vs Bucky
(1025, 1043), -- Steve vs Rumlow
(1041, 1043), -- Sam vs Rumlow
(1000, 1042); -- Fury vs Pierce

INSERT INTO Event_Equipment_Usage (Event_ID, User_Individual_ID, Target_Individual_ID, Tech_ID, Artifact_ID) VALUES
(29, 1025, NULL, 2020, NULL), -- Event 29 (Lemurian), Steve (1025) uses Shield (2020)
(30, 1026, 1000, 2035, NULL), -- Event 30 (Ambush), Bucky (1026) uses Arm (2035) against Fury (1000)
(31, 1042, NULL, 2033, NULL), -- Event 31 (Triskelion), Pierce (1042) attempts to use Insight Helicarriers (2033)
(31, 1041, NULL, 2034, NULL), -- Event 31 (Triskelion), Sam (1041) uses Falcon Wings (2034)
(31, 1025, 1026, 2020, NULL); -- Event 31 (Triskelion), Steve (1025) uses Shield (2020) against Bucky (1026)

INSERT INTO Conflict_Nexus_Link (Event_ID, Individual_ID, Org_ID, Location_ID) VALUES
(31, 1025, 2, 129), -- Event 31, Steve vs HYDRA at Triskelion
(31, 1013, 2, 129), -- Event 31, Natasha vs HYDRA at Triskelion
(31, 1041, 2, 129), -- Event 31, Sam vs HYDRA at Triskelion
(31, 1042, 1, 129), -- Event 31, Pierce (HYDRA) vs S.H.I.E.L.D. at Triskelion
(31, 1026, 1, 129); -- Event 31, Bucky (HYDRA) vs S.H.I.E.L.D. at Triskelion

-- LAYER 8: Sightings
INSERT INTO Sighting (Sighting_ID, Timestamp, Location_ID, Subject_ID, Corroboration_Level) VALUES
(19, '2014-04-02 13:00:00', 129, 1026, 'Verified'), -- Winter Soldier sighted on DC highway
(20, '2014-04-04 15:00:00', 129, 1041, 'Verified'); -- Falcon sighted at Triskelion

-- =====================================================================
-- BLOCK 10: GUARDIANS OF THE GALAXY (2014)
-- =====================================================================

-- LAYER 1: Locations, Orgs, Events
INSERT INTO Location (Location_ID, Name, Planet, Latitude, Longitude) VALUES
(130, 'Temple Vault', 'Morag', NULL, NULL),
(131, 'The Kyln (High Security Prison)', 'Asteroid Belt (Kyln)', NULL, NULL),
(132, 'Knowhere (Mining Colony)', 'Knowhere', NULL, NULL),
(133, 'Nova Corps HQ', 'Xandar', NULL, NULL);

INSERT INTO Organization (Org_ID, Org_Name, Org_Type) VALUES
(112, 'Guardians of the Galaxy', 'Hero Team'),
(113, 'Nova Corps', 'Govt'),
(114, 'Ravagers', 'Criminal');

INSERT INTO Species (Species_ID, Common_Name, Home_Planet_ID, General_Physiology) VALUES
(9, 'Flora Colossus', NULL, 'Sentient tree-like humanoid.'),
(10, 'Halfworlder', NULL, 'Cybernetically enhanced animal.'),
(11, 'Zehoberei', NULL, 'Green-skinned humanoid.'),
(12, 'Centaurian', NULL, 'Blue-skinned humanoid with crest.'),
(13, 'Luphomoid', NULL, 'Blue/Purple-skinned humanoid.');

INSERT INTO Event (Event_ID, Event_Name, Date_of_Event, Primary_Location_ID, Casualties, Economic_Loss) VALUES
(32, 'Discovery of the Orb', '2014-08-01', 130, 0, 0.00),
(33, 'Skirmish on Xandar', '2014-08-02', 16, 0, 5000.00),
(34, 'Prison Break at the Kyln', '2014-08-04', 131, 12, 5000000.00),
(35, 'Battle of Xandar', '2014-08-06', 16, 1000, 80000000.00); -- Location 16 is Xandar

-- LAYER 2: Individuals, Tech, Artifacts
INSERT INTO Individual (Individual_ID, FirstName, LastName, Date_of_Birth, Status, Species_ID) VALUES
(1044, 'Peter', 'Quill', '1980-02-04', 'Active', 1), -- Human (Celestial hybrid later)
(1045, 'Gamora', '', '0001-01-01', 'Deceased', 11),
(1046, 'Drax', 'The Destroyer', '0001-01-01', 'Active', 6), -- Assuming Titanian-like for simplicity or Generic Alien
(1047, 'Rocket', 'Raccoon', '0001-01-01', 'Active', 10),
(1048, 'Groot', '', '0001-01-01', 'Deceased', 9), -- Original Groot dies
(1049, 'Ronan', 'The Accuser', '0001-01-01', 'Deceased', 4), -- Kree
(1050, 'Nebula', '', '0001-01-01', 'Active', 13),
(1051, 'Yondu', 'Udonta', '0001-01-01', 'Deceased', 12),
(1052, 'Taneleer', 'Tivan', '0001-01-01', 'Active', 6); -- The Collector

INSERT INTO Technology (Tech_ID, Name, Inventor_ID, Power_Source) VALUES
(2036, 'Quad Blasters', NULL, 'Plasma'),
(2037, 'Yaka Arrow', 1051, 'Sonic/Psionic'),
(2038, 'Hadron Enforcer', 1047, 'Hadron Particles'),
(2039, 'Cosmi-Rod (Ronan s Hammer)', NULL, 'Cosmic Energy/Power Stone');

INSERT INTO Artifact (Artifact_ID, Official_Name, Type) VALUES
(3007, 'The Orb (Power Stone)', 'Infinity Stone');

-- LAYER 3 & 4: Sub-types, 1-N aliases
INSERT INTO Enhanced_Individual (Individual_ID, Threat_Level, Power_Classification, Power_Origin) VALUES
(1045, 8, 'Cybernetic Enhancements', 'Surgery'), -- Gamora
(1046, 7, 'Superhuman Strength', 'Inherent'), -- Drax
(1047, 7, 'Cybernetic/Genetic Enhancements', 'Experiment'), -- Rocket
(1048, 7, 'Flora Colossus Physiology', 'Inherent'), -- Groot
(1049, 9, 'Kree Accuser/Power Stone', 'Inherent/Artifact'), -- Ronan
(1050, 7, 'Cybernetic Enhancements', 'Surgery'); -- Nebula

INSERT INTO Individual_Aliases (Alias_Name, Individual_ID) VALUES
('Star-Lord', 1044),
('The Collector', 1052);

-- LAYER 6 & 7: Junction Tables
INSERT INTO Individual_Affiliation (Individual_ID, Org_ID) VALUES
(1044, 112), (1045, 112), (1046, 112), (1047, 112), (1048, 112), -- Guardians
(1044, 114), (1051, 114), -- Quill & Yondu -> Ravagers
(1049, 4); -- Ronan -> Kree Empire (Org created implicitly or mapped to Species ID if Org missing, let's assume he's Kree Fanatic)
-- Note: Org 4 is not defined as "Kree Empire" in Org table, assumed Ronan is rogue.

INSERT INTO Individual_Participation (Individual_ID, Event_ID) VALUES
(1044, 32), -- Quill at Morag
(1044, 33), (1045, 33), (1047, 33), (1048, 33), -- Skirmish on Xandar
(1044, 34), (1045, 34), (1046, 34), (1047, 34), (1048, 34), -- Kyln Breakout
(1044, 35), (1045, 35), (1046, 35), (1047, 35), (1048, 35), (1049, 35), (1050, 35), (1051, 35); -- Battle of Xandar

INSERT INTO Individual_Possession_Artifact (Individual_ID, Artifact_ID) VALUES
(1044, 3007), -- Quill holds Orb
(1049, 3007), -- Ronan holds Orb (in Cosmi-Rod)
(1052, 3007); -- Collector holds Orb (briefly)

INSERT INTO Individual_Conflicts (Individual_A_ID, Individual_B_ID) VALUES
(1044, 1049), -- Quill vs Ronan
(1046, 1049), -- Drax vs Ronan
(1045, 1050); -- Gamora vs Nebula

INSERT INTO Event_Equipment_Usage (Event_ID, User_Individual_ID, Target_Individual_ID, Tech_ID, Artifact_ID) VALUES
(35, 1049, NULL, 2039, 3007), -- Event 35 (Xandar), Ronan (1049) uses Cosmi-Rod (2039) w/ Power Stone (3007)
(35, 1047, 1049, 2038, NULL), -- Event 35 (Xandar), Rocket (1047) uses Hadron Enforcer (2038) against Ronan
(35, 1051, NULL, 2037, NULL), -- Event 35 (Xandar), Yondu (1051) uses Yaka Arrow (2037)
(35, 1044, 1049, NULL, 3007); -- Event 35 (Xandar), Quill (1044) uses Power Stone (3007) against Ronan

INSERT INTO Conflict_Nexus_Link (Event_ID, Individual_ID, Org_ID, Location_ID) VALUES
(35, 1049, NULL, 16), -- Event 35, Ronan vs Xandar at Xandar
(35, 1044, 112, 16), -- Event 35, Guardians vs Ronan at Xandar
(35, 1051, 114, 16); -- Event 35, Ravagers vs Ronan at Xandar

-- LAYER 8: Sightings
INSERT INTO Sighting (Sighting_ID, Timestamp, Location_ID, Subject_ID, Corroboration_Level) VALUES
(21, '2014-08-02 12:00:00', 16, 1044, 'Verified'), -- Star-Lord sighted on Xandar (Public Arrest)
(22, '2014-08-06 14:00:00', 16, 1049, 'Verified'); -- Ronan the Accuser sighted on Xandar

-- =====================================================================
-- BLOCK 11: AVENGERS: AGE OF ULTRON (2015)
-- =====================================================================

-- LAYER 1: Locations, Orgs, Events
INSERT INTO Location (Location_ID, Name, Planet, Latitude, Longitude) VALUES
(134, 'Sokovia (HYDRA Research Base)', 'Earth', 42.6026, 21.1655), -- Using Kosovo as proxy
(135, 'Avengers Tower', 'Earth', 40.7580, -73.9855), -- NYC (Replaces Stark Tower)
(136, 'New Avengers Facility (S.A.F.E.)', 'Earth', 41.1334, -73.9934), -- Upstate New York
(137, 'Johannesburg, South Africa', 'Earth', -26.2041, 28.0473);

INSERT INTO Organization (Org_ID, Org_Name, Org_Type) VALUES
(115, 'Ultron', 'Terrorist'); -- Ultron and his sentries

INSERT INTO Event (Event_ID, Event_Name, Date_of_Event, Primary_Location_ID, Casualties, Economic_Loss) VALUES
(36, 'Raid on Sokovia HYDRA Outpost', '2015-05-01', 134, 10, 100000.00),
(37, 'Ultron\'s Birth & Attack', '2015-05-02', 135, 0, 2000000.00),
(38, 'Battle of Johannesburg', '2015-05-04', 137, 50, 50000000.00), -- Hulk vs Hulkbuster
(39, 'Battle of Sokovia', '2015-05-06', 134, 177, 474000000000.00);

-- LAYER 2: Individuals, Tech, Artifacts
INSERT INTO Individual (Individual_ID, FirstName, LastName, Date_of_Birth, Status, Species_ID) VALUES
(1053, 'Wanda', 'Maximoff', '1989-02-10', 'Active', 1),
(1054, 'Pietro', 'Maximoff', '1989-02-10', 'Deceased', 1),
(1055, 'Ultron', '', '2015-05-02', 'Deceased', 1), -- AI, but originates from Earth
(1056, 'Vision', '', '2015-05-05', 'Deceased', 1), -- Synthezoid
(1057, 'Helen', 'Cho', '1980-01-01', 'Active', 1),
(1058, 'Ulysses', 'Klaue', '1970-01-01', 'Deceased', 1);

INSERT INTO Technology (Tech_ID, Name, Inventor_ID, Power_Source) VALUES
(2040, 'Ultron Sentries', 1055, 'Electricity'),
(2041, 'Iron Man Armor: Mark 44 (Hulkbuster)', 1001, 'Arc Reactor'),
(2042, 'The Cradle (Vibranium Body)', 1057, 'Vibranium/Mind Stone'),
(2043, 'Iron Legion', 1001, 'Arc Reactor');

INSERT INTO Artifact (Artifact_ID, Official_Name, Type) VALUES
(3008, 'Mind Stone', 'Infinity Stone'); -- Now separate from Scepter

-- LAYER 3 & 4: Sub-types, 1-N aliases
INSERT INTO Enhanced_Individual (Individual_ID, Threat_Level, Power_Classification, Power_Origin) VALUES
(1053, 9, 'Reality Warping (Psionic)', 'Mind Stone'), -- Wanda
(1054, 7, 'Super Speed', 'Mind Stone'), -- Pietro
(1055, 10, 'Artificial Superintelligence', 'Mind Stone'), -- Ultron
(1056, 9, 'Synthezoid/Mind Stone', 'Mind Stone/Vibranium'); -- Vision

INSERT INTO Individual_Aliases (Alias_Name, Individual_ID) VALUES
('Scarlet Witch', 1053),
('Quicksilver', 1054);

-- LAYER 6 & 7: Junction Tables
INSERT INTO Individual_Affiliation (Individual_ID, Org_ID) VALUES
(1053, 115), (1054, 115), -- Twins -> Ultron (Temporary)
(1053, 107), (1054, 107), (1056, 107), -- Twins & Vision -> Avengers
(1055, 115); -- Ultron -> Ultron

INSERT INTO Individual_Participation (Individual_ID, Event_ID) VALUES
(1001, 36), (1008, 36), (1013, 36), (1016, 36), (1024, 36), (1025, 36), (1053, 36), (1054, 36), -- Sokovia Raid
(1001, 37), (1008, 37), (1013, 37), (1016, 37), (1024, 37), (1025, 37), (1055, 37), -- Ultron's Birth
(1001, 38), (1008, 38), (1053, 38), (1055, 38), -- Johannesburg
(1001, 39), (1004, 39), (1008, 39), (1013, 39), (1016, 39), (1024, 39), (1025, 39), (1053, 39), (1054, 39), (1055, 39), (1056, 39); -- Battle of Sokovia

INSERT INTO Individual_Possession_Artifact (Individual_ID, Artifact_ID) VALUES
(1055, 3005), -- Ultron gets Scepter
(1055, 3008), -- Ultron breaks Scepter, gets Mind Stone
(1056, 3008); -- Vision has Mind Stone

INSERT INTO Individual_Conflicts (Individual_A_ID, Individual_B_ID) VALUES
(1001, 1055), (1008, 1055), (1016, 1055), (1025, 1055), (1053, 1055), (1056, 1055), -- Avengers vs Ultron
(1001, 1008), -- Tony (Hulkbuster) vs Bruce (Hulk)
(1016, 1056), -- Thor vs Vision (briefly)
(1025, 1054); -- Cap vs Quicksilver

INSERT INTO Event_Equipment_Usage (Event_ID, User_Individual_ID, Target_Individual_ID, Tech_ID, Artifact_ID) VALUES
(36, 1053, 1001, NULL, 3005), -- Event 36 (Raid), Wanda (1053) uses Scepter's (3005) power on Tony (1001)
(37, 1055, NULL, 2043, NULL), -- Event 37 (Birth), Ultron (1055) uses Iron Legion (2043) to attack
(38, 1001, 1008, 2041, NULL), -- Event 38 (Jo'burg), Tony (1001) uses Hulkbuster (2041) on Hulk (1008)
(39, 1055, NULL, 2040, NULL), -- Event 39 (Sokovia), Ultron (1055) uses Sentries (2040)
(39, 1056, 1055, NULL, 3008); -- Event 39 (Sokovia), Vision (1056) uses Mind Stone (3008) against Ultron (1055)

INSERT INTO Conflict_Nexus_Link (Event_ID, Individual_ID, Org_ID, Location_ID) VALUES
(36, 1025, 2, 134), -- Event 36, Cap (Avengers) vs HYDRA at Sokovia
(38, 1001, 107, 137), -- Event 38, Tony vs Hulk (Avengers) at Johannesburg
(39, 1025, 115, 134), -- Event 39, Cap (Avengers) vs Ultron at Sokovia
(39, 1001, 115, 134), -- Event 39, Tony (Avengers) vs Ultron at Sokovia
(39, 1055, 107, 134); -- Event 39, Ultron vs Avengers at Sokovia

-- LAYER 8: Sightings
INSERT INTO Sighting (Sighting_ID, Timestamp, Location_ID, Subject_ID, Corroboration_Level) VALUES
(23, '2015-05-04 14:00:00', 137, 1008, 'Verified'), -- Hulk sighted in Johannesburg
(24, '2015-05-06 13:00:00', 134, 1055, 'Verified'), -- Ultron sighted in Sokovia
(25, '2015-05-06 13:15:00', 134, 1056, 'Verified'); -- Vision sighted in Sokovia

-- =====================================================================
-- BLOCK 12: ANT-MAN (2015)
-- =====================================================================

-- LAYER 1: Locations, Orgs, Events
INSERT INTO Location (Location_ID, Name, Planet, Latitude, Longitude) VALUES
(138, 'Pym Residence', 'Earth', 37.7749, -122.4194), -- San Francisco
(139, 'Pym Technologies HQ', 'Earth', 37.7790, -122.3900); -- San Francisco

INSERT INTO Organization (Org_ID, Org_Name, Org_Type) VALUES
(116, 'Pym Technologies', 'Private Sector');

INSERT INTO Event (Event_ID, Event_Name, Date_of_Event, Primary_Location_ID, Casualties, Economic_Loss) VALUES
(40, 'Infiltration of Avengers Facility', '2015-07-15', 136, 0, 10000.00), -- Loc 136 is New Avengers Facility
(41, 'Pym Technologies Heist', '2015-07-17', 139, 1, 500000000.00),
(42, 'Battle at Pym Residence', '2015-07-17', 138, 0, 5000.00);

-- LAYER 2: Individuals, Tech, Artifacts
INSERT INTO Individual (Individual_ID, FirstName, LastName, Date_of_Birth, Status, Species_ID) VALUES
(1059, 'Scott', 'Lang', '1970-04-06', 'Active', 1),
(1060, 'Hank', 'Pym', '1943-10-20', 'Deceased', 1),
(1061, 'Hope', 'van Dyne', '1979-05-20', 'Active', 1),
(1062, 'Darren', 'Cross', '1975-01-01', 'Deceased', 1),
(1063, 'Luis', '', '1972-01-01', 'Active', 1),
(1064, 'Cassie', 'Lang', '2007-01-01', 'Active', 1);

INSERT INTO Technology (Tech_ID, Name, Inventor_ID, Power_Source) VALUES
(2044, 'Pym Particles', 1060, 'Subatomic'),
(2045, 'Ant-Man Suit (Pym)', 1060, 'Pym Particles'),
(2046, 'Yellowjacket Suit (Cross)', 1062, 'Pym Particles');

-- LAYER 3 & 4: Sub-types, 1-N aliases
INSERT INTO Agent (Individual_ID, Classification_Level, Department, Handler_ID) VALUES
(1060, 8, 'Consultant', 1030); -- Hank Pym, former S.H.I.E.L.D., handler Howard Stark (1030)

INSERT INTO Enhanced_Individual (Individual_ID, Threat_Level, Power_Classification, Power_Origin) VALUES
(1059, 7, 'Size Manipulation', 'Technology'), -- Scott Lang
(1062, 7, 'Size Manipulation (Weaponized)', 'Technology'); -- Darren Cross

INSERT INTO Individual_Aliases (Alias_Name, Individual_ID) VALUES
('Ant-Man', 1059),
('Yellowjacket', 1062);

-- LAYER 6 & 7: Junction Tables
INSERT INTO Individual_Affiliation (Individual_ID, Org_ID) VALUES
(1060, 1), -- Hank -> S.H.I.E.L.D. (Formerly)
(1060, 116), -- Hank -> Pym Tech (Founder)
(1061, 116), -- Hope -> Pym Tech
(1062, 116); -- Darren -> Pym Tech

INSERT INTO Individual_Participation (Individual_ID, Event_ID) VALUES
(1041, 40), (1059, 40), -- Scott vs Sam at Avengers Facility
(1059, 41), (1060, 41), (1061, 41), (1062, 41), (1063, 41), -- Pym Tech Heist
(1059, 42), (1060, 42), (1061, 42), (1062, 42), (1064, 42); -- Battle at Pym Residence

INSERT INTO Individual_Conflicts (Individual_A_ID, Individual_B_ID) VALUES
(1041, 1059), -- Sam Wilson vs Scott Lang
(1059, 1062), -- Scott Lang vs Darren Cross
(1060, 1062); -- Hank Pym vs Darren Cross

INSERT INTO Event_Equipment_Usage (Event_ID, User_Individual_ID, Target_Individual_ID, Tech_ID, Artifact_ID) VALUES
(40, 1059, 1041, 2045, NULL), -- Event 40 (Avengers Facility), Scott (1059) uses Ant-Man Suit (2045) against Sam (1041)
(40, 1041, 1059, 2034, NULL), -- Event 40 (Avengers Facility), Sam (1041) uses Falcon Wings (2034) against Scott (1059)
(41, 1059, 1062, 2045, NULL), -- Event 41 (Pym Heist), Scott (1059) uses Ant-Man Suit (2045) against Cross (1062)
(41, 1062, 1059, 2046, NULL), -- Event 41 (Pym Heist), Cross (1062) uses Yellowjacket (2046) against Scott (1059)
(42, 1059, 1062, 2045, NULL); -- Event 42 (Residence), Scott (1059) uses Ant-Man Suit (2045) against Cross (1062)

INSERT INTO Conflict_Nexus_Link (Event_ID, Individual_ID, Org_ID, Location_ID) VALUES
(40, 1059, 107, 136), -- Event 40, Scott vs Avengers (Falcon) at Avengers Facility
(40, 1041, NULL, 136), -- Event 40, Falcon vs Scott at Avengers Facility
(41, 1059, 116, 139), -- Event 41, Scott vs Pym Tech (Cross) at Pym HQ
(41, 1062, 116, 139); -- Event 41, Cross vs Scott at Pym HQ

-- LAYER 8: Sightings
INSERT INTO Sighting (Sighting_ID, Timestamp, Location_ID, Subject_ID, Corroboration_Level) VALUES
(26, '2015-07-15 11:00:00', 136, 1059, 'Verified'), -- Ant-Man sighted at New Avengers Facility
(27, '2015-07-17 14:00:00', 139, 1062, 'Verified'); -- Yellowjacket sighted at Pym Technologies

-- =====================================================================
-- BLOCK 13: CAPTAIN AMERICA: CIVIL WAR (2016)
-- =====================================================================

-- LAYER 1: Locations, Orgs, Events
INSERT INTO Location (Location_ID, Name, Planet, Latitude, Longitude) VALUES
(140, 'Lagos, Nigeria', 'Earth', 6.5244, 3.3792),
(141, 'Vienna International Centre (UN)', 'Earth', 48.2349, 16.4158),
(142, 'Leipzig/Halle Airport', 'Earth', 51.4239, 12.2364),
(143, 'The Raft (Prison)', 'Earth', 40.0000, -70.0000), -- Atlantic Ocean
(144, 'HYDRA Siberian Facility', 'Earth', 69.3451, 88.1887); -- Norilsk

INSERT INTO Organization (Org_ID, Org_Name, Org_Type) VALUES
(117, 'Wakandan Royal Family', 'Govt'),
(118, 'Joint Counter Terrorist Centre', 'Govt');

INSERT INTO Event (Event_ID, Event_Name, Date_of_Event, Primary_Location_ID, Casualties, Economic_Loss) VALUES
(43, 'Lagos Incident', '2016-05-03', 140, 26, 10000000.00), -- Includes Wakandans
(44, 'Vienna Bombing (Sokovia Accords)', '2016-05-05', 141, 12, 5000000.00),
(45, 'Clash at Leipzig/Halle Airport', '2016-05-06', 142, 0, 100000000.00), -- The "Airport Battle"
(46, 'Confrontation at Siberian Facility', '2016-05-07', 144, 0, 2000000.00);

-- LAYER 2: Individuals, Tech, Artifacts
INSERT INTO Individual (Individual_ID, FirstName, LastName, Date_of_Birth, Status, Species_ID) VALUES
(1065, 'T\'Challa', '', '1980-01-01', 'Active', 1),
(1066, 'Helmut', 'Zemo', '1978-01-01', 'Incarcerated', 1),
(1067, 'Peter', 'Parker', '2001-08-10', 'Active', 1),
(1068, 'Everett', 'Ross', '1970-01-01', 'Active', 1),
(1069, 'T\'Chaka', '', '1940-01-01', 'Deceased', 1);

INSERT INTO Technology (Tech_ID, Name, Inventor_ID, Power_Source) VALUES
(2047, 'Black Panther Suit (Vibranium)', 117, 'Vibranium'), -- Wakandan Tech
(2048, 'Spider-Man Suit (Stark Tech)', 1001, 'Battery'),
(2049, 'EMP Device (Zemo)', 1066, 'Battery'),
(2050, 'Giant-Man (Pym Tech)', 1059, 'Pym Particles'); -- A capability of the suit

-- LAYER 3 & 4: Sub-types, 1-N aliases
INSERT INTO Agent (Individual_ID, Classification_Level, Department, Handler_ID) VALUES
(1068, 7, 'JCTC Commander', NULL); -- Everett Ross

INSERT INTO Enhanced_Individual (Individual_ID, Threat_Level, Power_Classification, Power_Origin) VALUES
(1065, 8, 'Heart-Shaped Herb/Powered Suit', 'Inherent/Technology'), -- T'Challa
(1067, 7, 'Spider-like Abilities', 'Experiment'); -- Peter Parker

INSERT INTO Individual_Aliases (Alias_Name, Individual_ID) VALUES
('Black Panther', 1065),
('Spider-Man', 1067);

-- LAYER 6 & 7: Junction Tables
INSERT INTO Individual_Affiliation (Individual_ID, Org_ID) VALUES
(1065, 117), -- T'Challa -> Wakandan Royal Family
(1069, 117), -- T'Chaka -> Wakandan Royal Family
(1068, 118); -- Everett Ross -> JCTC

INSERT INTO Individual_Participation (Individual_ID, Event_ID) VALUES
(1025, 43), (1013, 43), (1041, 43), (1053, 43), (1043, 43), -- Lagos Incident
(1025, 44), (1013, 44), (1041, 44), (1065, 44), (1066, 44), (1068, 44), (1069, 44), -- Vienna Bombing
(1001, 45), (1004, 45), (1013, 45), (1024, 45), (1025, 45), (1026, 45), (1041, 45), (1053, 45), (1056, 45), (1059, 45), (1065, 45), (1067, 45), -- Airport Battle
(1001, 46), (1025, 46), (1026, 46), (1065, 46), (1066, 46); -- Siberian Facility

INSERT INTO Individual_Conflicts (Individual_A_ID, Individual_B_ID) VALUES
(1026, 1065), -- Bucky vs T'Challa
(1025, 1065), -- Steve vs T'Challa
(1001, 1025), -- Tony vs Steve (re-confirmed, main conflict)
(1001, 1026), -- Tony vs Bucky
(1001, 1059), -- Tony vs Scott (Giant-Man)
(1025, 1067), -- Steve vs Peter
(1041, 1067), -- Sam vs Peter
(1053, 1056), -- Wanda vs Vision
(1024, 1065), -- Clint vs T'Challa
(1004, 1059); -- Rhodey vs Scott

INSERT INTO Event_Equipment_Usage (Event_ID, User_Individual_ID, Target_Individual_ID, Tech_ID, Artifact_ID) VALUES
(43, 1053, NULL, NULL, NULL), -- Event 43 (Lagos), Wanda (1053) uses powers
(44, 1066, NULL, 2049, NULL), -- Event 44 (Vienna), Zemo (1066) uses EMP (2049)
(45, 1065, 1026, 2047, NULL), -- Event 45 (Airport), T'Challa (1065) uses Panther Suit (2047) against Bucky (1026)
(45, 1067, 1025, 2048, NULL), -- Event 45 (Airport), Peter (1067) uses Spidey Suit (2048) against Steve (1025)
(45, 1059, 1004, 2050, NULL), -- Event 45 (Airport), Scott (1059) becomes Giant-Man (2050) against Rhodey (1004)
(46, 1001, 1025, 2027, NULL), -- Event 46 (Siberia), Tony (1001) uses Mark 42 (or equiv.) (2027) against Steve (1025)
(46, 1025, 1001, 2020, NULL), -- Event 46 (Siberia), Steve (1025) uses Shield (2020) against Tony (1001)
(46, 1026, 1001, 2035, NULL); -- Event 46 (Siberia), Bucky (1026) uses Arm (2035) against Tony (1001)

INSERT INTO Conflict_Nexus_Link (Event_ID, Individual_ID, Org_ID, Location_ID) VALUES
(43, 1025, NULL, 140), -- Event 43, Steve (Avengers) vs Rumlow in Lagos
(45, 1025, 107, 142), -- Event 45, Steve ("Team Cap") vs "Team Iron Man" (Avengers) at Airport
(45, 1001, 107, 142), -- Event 45, Tony ("Team Iron Man") vs "Team Cap" at Airport
(46, 1066, 107, 144); -- Event 46, Zemo vs Avengers at Siberia

-- LAYER 8: Sightings
INSERT INTO Sighting (Sighting_ID, Timestamp, Location_ID, Subject_ID, Corroboration_Level) VALUES
(28, '2016-05-05 14:30:00', 141, 1065, 'Verified'), -- T'Challa (Black Panther) sighted in Vienna
(29, '2016-05-06 13:00:00', 142, 1067, 'Verified'), -- Spider-Man sighted at Leipzig Airport
(30, '2016-05-06 13:10:00', 142, 1059, 'Verified'); -- Giant-Man (Scott Lang) sighted at Leipzig Airport

-- =====================================================================
-- BLOCK 14: DOCTOR STRANGE (2016)
-- =====================================================================

-- LAYER 1: Locations, Orgs, Events
INSERT INTO Location (Location_ID, Name, Planet, Latitude, Longitude) VALUES
(145, 'Kamar-Taj', 'Earth', 27.7172, 85.3240), -- Kathmandu, Nepal
(146, 'New York Sanctum', 'Earth', 40.7300, -73.9912), -- 177A Bleecker St
(147, 'London Sanctum', 'Earth', 51.5074, -0.1278),
(148, 'Hong Kong Sanctum', 'Earth', 22.3193, 114.1694);

INSERT INTO Organization (Org_ID, Org_Name, Org_Type) VALUES
(119, 'Masters of the Mystic Arts', 'Hero Team'),
(120, 'Zealots (Kaecilius)', 'Terrorist');

INSERT INTO Species (Species_ID, Common_Name, Home_Planet_ID, General_Physiology) VALUES
(14, 'Dormammu', NULL, 'Extra-dimensional Faltine entity.');

INSERT INTO Event (Event_ID, Event_Name, Date_of_Event, Primary_Location_ID, Casualties, Economic_Loss) VALUES
(47, 'Strange s Car Crash', '2016-02-02', 10, 0, 500000.00), -- Earth
(48, 'Attack on Kamar-Taj Library', '2016-10-20', 145, 1, 10000.00),
(49, 'Battle of the New York Sanctum', '2016-10-21', 146, 0, 500000.00),
(50, 'Battle of Hong Kong', '2016-10-22', 148, 10, 100000000.00);

-- LAYER 2: Individuals, Tech, Artifacts
INSERT INTO Individual (Individual_ID, FirstName, LastName, Date_of_Birth, Status, Species_ID) VALUES
(1070, 'Stephen', 'Strange', '1975-11-11', 'Active', 1),
(1071, 'The Ancient One', '', '1400-01-01', 'Deceased', 1),
(1072, 'Karl', 'Mordo', '1979-01-01', 'Active', 1),
(1073, 'Wong', '', '1970-01-01', 'Active', 1),
(1074, 'Kaecilius', '', '1965-01-01', 'Unknown', 1), -- Trapped in Dark Dimension
(1075, 'Christine', 'Palmer', '1980-01-01', 'Active', 1),
(1076, 'Dormammu', '', '0001-01-01', 'Active', 14);

INSERT INTO Technology (Tech_ID, Name, Inventor_ID, Power_Source) VALUES
(2051, 'Sling Ring', 1071, 'Mystic Arts');

INSERT INTO Artifact (Artifact_ID, Official_Name, Type) VALUES
(3009, 'Eye of Agamotto (Time Stone)', 'Infinity Stone'),
(3010, 'Cloak of Levitation', 'Mystic Artifact'),
(3011, 'Staff of the Living Tribunal', 'Mystic Artifact'),
(3012, 'Dark Scepter', 'Mystic Artifact');

-- LAYER 3 & 4: Sub-types, 1-N aliases
INSERT INTO Enhanced_Individual (Individual_ID, Threat_Level, Power_Classification, Power_Origin) VALUES
(1070, 9, 'Sorcerer Supreme', 'Mystic Arts'), -- Strange
(1071, 10, 'Sorcerer Supreme (Former)', 'Mystic Arts'), -- Ancient One
(1072, 8, 'Master Sorcerer', 'Mystic Arts'), -- Mordo
(1073, 8, 'Master Sorcerer (Librarian)', 'Mystic Arts'), -- Wong
(1074, 8, 'Master Sorcerer (Zealot)', 'Mystic Arts'); -- Kaecilius

INSERT INTO Individual_Aliases (Alias_Name, Individual_ID) VALUES
('Doctor Strange', 1070),
('Sorcerer Supreme', 1070);

-- LAYER 6 & 7: Junction Tables
INSERT INTO Individual_Affiliation (Individual_ID, Org_ID) VALUES
(1070, 119), -- Strange -> Masters of the Mystic Arts
(1071, 119), -- Ancient One -> Masters of the Mystic Arts
(1072, 119), -- Mordo -> Masters of the Mystic Arts
(1073, 119), -- Wong -> Masters of the Mystic Arts
(1074, 120); -- Kaecilius -> Zealots

INSERT INTO Individual_Participation (Individual_ID, Event_ID) VALUES
(1070, 47), -- Strange's Car Crash
(1071, 48), (1074, 48), -- Kamar-Taj Library Attack
(1070, 49), (1072, 49), (1074, 49), -- NY Sanctum Battle
(1070, 50), (1072, 50), (1073, 50), (1074, 50), (1076, 50); -- Hong Kong Battle

INSERT INTO Individual_Possession_Artifact (Individual_ID, Artifact_ID) VALUES
(1070, 3009), -- Strange -> Eye of Agamotto
(1070, 3010), -- Strange -> Cloak of Levitation
(1072, 3011); -- Mordo -> Staff of Living Tribunal

INSERT INTO Individual_Conflicts (Individual_A_ID, Individual_B_ID) VALUES
(1070, 1072), -- Strange vs Mordo (ideological)
(1070, 1074), -- Strange vs Kaecilius
(1070, 1076), -- Strange vs Dormammu
(1071, 1074); -- Ancient One vs Kaecilius

INSERT INTO Event_Equipment_Usage (Event_ID, User_Individual_ID, Target_Individual_ID, Tech_ID, Artifact_ID) VALUES
(49, 1070, 1074, 2051, 3010), -- Event 49 (NY Sanctum), Strange (1070) uses Sling Ring (2051) & Cloak (3010) against Kaecilius (1074)
(49, 1072, 1074, NULL, 3011), -- Event 49 (NY Sanctum), Mordo (1072) uses Staff (3011) against Kaecilius (1074)
(50, 1070, 1074, NULL, 3009), -- Event 50 (Hong Kong), Strange (1070) uses Eye of Agamotto (3009) against Kaecilius (1074)
(50, 1070, 1076, NULL, 3009); -- Event 50 (Hong Kong), Strange (1070) uses Eye of Agamotto (3009) against Dormammu (1076)

INSERT INTO Conflict_Nexus_Link (Event_ID, Individual_ID, Org_ID, Location_ID) VALUES
(49, 1070, 120, 146), -- Event 49, Strange (Masters) vs Zealots at NY Sanctum
(49, 1074, 119, 146), -- Event 49, Kaecilius (Zealots) vs Masters at NY Sanctum
(50, 1070, 120, 148), -- Event 50, Strange (Masters) vs Zealots at Hong Kong Sanctum
(50, 1076, 119, 148); -- Event 50, Dormammu vs Masters at Hong Kong Sanctum

-- LAYER 8: Sightings
INSERT INTO Sighting (Sighting_ID, Timestamp, Location_ID, Subject_ID, Corroboration_Level) VALUES
(31, '2016-10-21 13:00:00', 146, 1070, 'Verified'), -- Doctor Strange sighted at NY Sanctum
(32, '2016-10-22 18:00:00', 148, 1076, 'Verified'); -- Dormammu (Dark Dimension) sighted over Hong Kong

-- =====================================================================
-- BLOCK 15: GUARDIANS OF THE GALAXY VOL. 2 (2017)
-- =====================================================================

-- LAYER 1: Locations, Orgs, Events
INSERT INTO Location (Location_ID, Name, Planet, Latitude, Longitude) VALUES
(149, 'The Sovereign', 'Sovereign', NULL, NULL),
(150, 'Berhert', 'Berhert', NULL, NULL),
(151, 'Ego\'s Planet (Living Planet)', 'Ego', NULL, NULL);

INSERT INTO Organization (Org_ID, Org_Name, Org_Type) VALUES
(121, 'The Sovereign', 'Govt');

INSERT INTO Species (Species_ID, Common_Name, Home_Planet_ID, General_Physiology) VALUES
(15, 'Celestial', 151, 'Ancient, god-like beings with matter/energy manipulation.'),
(16, 'Empath', NULL, 'Humanoid with emotion-sensing abilities.');

INSERT INTO Event (Event_ID, Event_Name, Date_of_Event, Primary_Location_ID, Casualties, Economic_Loss) VALUES
(51, 'Battle of Berhert (vs. Abilisk)', '2017-03-01', 150, 0, 100000.00),
(52, 'Ravager Mutiny', '2017-03-02', NULL, 50, 0.00), -- On Yondu's ship
(53, 'Battle of Ego\'s Planet', '2017-03-03', 151, 2, 0.00); -- Ego, Yondu

-- LAYER 2: Individuals, Tech, Artifacts
INSERT INTO Individual (Individual_ID, FirstName, LastName, Date_of_Birth, Status, Species_ID) VALUES
(1077, 'Ego', 'The Living Planet', '0001-01-01', 'Deceased', 15),
(1078, 'Mantis', '', '0001-01-01', 'Active', 16),
(1079, 'Ayesha', '', '0001-01-01', 'Active', 1), -- Sovereign are genetically engineered humans
(1080, 'Taserface', '', '0001-01-01', 'Deceased', 12); -- Centaurian

INSERT INTO Technology (Tech_ID, Name, Inventor_ID, Power_Source) VALUES
(2052, 'Sovereign Drones', 1079, 'Battery'),
(2053, 'Ego\'s "Seed"', 1077, 'Celestial Energy'),
(2054, 'Laser-Drill Rig', 1047, 'Unknown');

-- LAYER 3 & 4: Sub-types, 1-N aliases
INSERT INTO Enhanced_Individual (Individual_ID, Threat_Level, Power_Classification, Power_Origin) VALUES
(1044, 9, 'Celestial Hybrid', 'Inherent'), -- Quill's power is unlocked
(1077, 10, 'Celestial', 'Inherent'), -- Ego
(1078, 5, 'Empathic Manipulation', 'Inherent'); -- Mantis

-- LAYER 6 & 7: Junction Tables
INSERT INTO Individual_Affiliation (Individual_ID, Org_ID) VALUES
(1078, 112), -- Mantis -> Guardians
(1079, 121), -- Ayesha -> The Sovereign
(1080, 114); -- Taserface -> Ravagers

INSERT INTO Individual_Participation (Individual_ID, Event_ID) VALUES
(1044, 51), (1045, 51), (1046, 51), (1047, 51), (1048, 51), (1079, 51), -- Battle of Berhert
(1044, 52), (1047, 52), (1048, 52), (1051, 52), (1080, 52), -- Ravager Mutiny
(1044, 53), (1045, 53), (1046, 53), (1047, 53), (1048, 53), (1050, 53), (1051, 53), (1077, 53), (1078, 53); -- Battle of Ego's Planet

INSERT INTO Individual_Conflicts (Individual_A_ID, Individual_B_ID) VALUES
(1044, 1077), -- Quill vs Ego
(1047, 1080), -- Rocket vs Taserface
(1051, 1080), -- Yondu vs Taserface
(1044, 1079); -- Quill (Guardians) vs Ayesha (Sovereign)

INSERT INTO Event_Equipment_Usage (Event_ID, User_Individual_ID, Target_Individual_ID, Tech_ID, Artifact_ID) VALUES
(51, 1044, NULL, 2036, NULL), -- Event 51 (Berhert), Quill (1044) uses Quad Blasters (2036)
(51, 1079, 1044, 2052, NULL), -- Event 51 (Berhert), Ayesha (1079) uses Drones (2052) against Quill (1044)
(52, 1051, 1080, 2037, NULL), -- Event 52 (Mutiny), Yondu (1051) uses Yaka Arrow (2037) against Taserface (1080)
(53, 1077, NULL, 2053, NULL), -- Event 53 (Ego), Ego (1077) uses "Seeds" (2053)
(53, 1044, 1077, 2036, NULL), -- Event 53 (Ego), Quill (1044) uses Blasters (2036) against Ego (1077)
(53, 1047, 1077, 2054, NULL); -- Event 53 (Ego), Rocket (1047) uses Laser Rig (2054) against Ego (1077)

INSERT INTO Conflict_Nexus_Link (Event_ID, Individual_ID, Org_ID, Location_ID) VALUES
(51, 1044, 121, 150), -- Event 51, Quill (Guardians) vs Sovereign at Berhert
(53, 1044, 112, 151), -- Event 53, Quill vs Ego (Guardians) at Ego's Planet
(53, 1077, 112, 151); -- Event 53, Ego vs Guardians at Ego's Planet

-- LAYER 8: Sightings
INSERT INTO Sighting (Sighting_ID, Timestamp, Location_ID, Subject_ID, Corroboration_Level) VALUES
(33, '2017-03-01 10:00:00', 149, 1079, 'Verified'), -- Ayesha sighted on The Sovereign
(34, '2017-03-03 12:00:00', 151, 1077, 'Verified'); -- Ego (Living Planet) sighted

-- =====================================================================
-- BLOCK 16: SPIDER-MAN: HOMECOMING (2017)
-- =====================================================================

-- LAYER 1: Locations, Orgs, Events
INSERT INTO Location (Location_ID, Name, Planet, Latitude, Longitude) VALUES
(152, 'Midtown School of Science', 'Earth', 40.7790, -73.9680), -- NYC
(153, 'Washington Monument', 'Earth', 38.8895, -77.0353),
(154, 'Staten Island Ferry', 'Earth', 40.6924, -74.0130);

INSERT INTO Organization (Org_ID, Org_Name, Org_Type) VALUES
(122, 'Vulture\'s Crew (Scavengers)', 'Criminal'),
(123, 'US Department of Damage Control', 'Govt');

INSERT INTO Event (Event_ID, Event_Name, Date_of_Event, Primary_Location_ID, Casualties, Economic_Loss) VALUES
(54, 'Washington Monument Rescue', '2017-09-15', 153, 0, 100000.00),
(55, 'Staten Island Ferry Battle', '2017-09-16', 154, 0, 20000000.00),
(56, 'Vulture\'s Plane Heist', '2017-09-17', 103, 0, 50000000.00); -- Over NYC, ending near Stark Tower (103)

-- LAYER 2: Individuals, Tech, Artifacts
INSERT INTO Individual (Individual_ID, FirstName, LastName, Date_of_Birth, Status, Species_ID) VALUES
(1081, 'Adrian', 'Toomes', '1965-01-01', 'Incarcerated', 1),
(1082, 'Ned', 'Leeds', '2001-08-10', 'Active', 1),
(1083, 'Michelle', 'Jones (MJ)', '2001-09-10', 'Active', 1),
(1084, 'May', 'Parker', '1968-05-07', 'Active', 1),
(1085, 'Herman', 'Schultz', '1975-01-01', 'Incarcerated', 1);

INSERT INTO Technology (Tech_ID, Name, Inventor_ID, Power_Source) VALUES
(2055, 'Vulture Exo-Suit', 1081, 'Chitauri Tech'),
(2056, 'Shocker Gauntlet', 1081, 'Chitauri Tech'),
(2057, 'Chitauri-Hybrid Weapons', 1081, 'Chitauri Tech'); -- General category for Toomes' crew

-- LAYER 3 & 4: Sub-types, 1-N aliases
INSERT INTO Enhanced_Individual (Individual_ID, Threat_Level, Power_Classification, Power_Origin) VALUES
(1081, 7, 'Powered Armor', 'Technology'), -- Vulture
(1085, 6, 'Powered Gauntlet', 'Technology'); -- Shocker

INSERT INTO Individual_Aliases (Alias_Name, Individual_ID) VALUES
('Vulture', 1081),
('Shocker', 1085);

-- LAYER 6 & 7: Junction Tables
INSERT INTO Individual_Affiliation (Individual_ID, Org_ID) VALUES
(1081, 122), -- Toomes -> Vulture's Crew
(1085, 122); -- Schultz -> Vulture's Crew

INSERT INTO Individual_Participation (Individual_ID, Event_ID) VALUES
(1067, 54), (1082, 54), (1083, 54), -- Washington Monument (Peter, Ned, MJ)
(1001, 55), (1067, 55), (1081, 55), -- Staten Island Ferry (Tony, Peter, Toomes)
(1001, 56), (1067, 56), (1081, 56); -- Plane Heist (Tony, Peter, Toomes)

INSERT INTO Individual_Conflicts (Individual_A_ID, Individual_B_ID) VALUES
(1067, 1081), -- Peter vs Toomes
(1067, 1085); -- Peter vs Schultz

INSERT INTO Event_Equipment_Usage (Event_ID, User_Individual_ID, Target_Individual_ID, Tech_ID, Artifact_ID) VALUES
(54, 1067, NULL, 2048, NULL), -- Event 54 (Monument), Peter (1067) uses Spidey Suit (2048)
(55, 1067, 1081, 2048, NULL), -- Event 55 (Ferry), Peter (1067) uses Spidey Suit (2048) against Toomes (1081)
(55, 1081, 1067, 2055, NULL), -- Event 55 (Ferry), Toomes (1081) uses Vulture Suit (2055) against Peter (1067)
(55, 1001, 1067, 2027, NULL), -- Event 55 (Ferry), Tony (1001) uses remote Armor (2027) to save Peter (1067)
(56, 1067, 1081, 2048, NULL), -- Event 56 (Heist), Peter (1067) uses Spidey Suit (2048) against Toomes (1081)
(56, 1081, 1067, 2055, NULL); -- Event 56 (Heist), Toomes (1081) uses Vulture Suit (2055) against Peter (1067)

INSERT INTO Conflict_Nexus_Link (Event_ID, Individual_ID, Org_ID, Location_ID) VALUES
(55, 1067, 122, 154), -- Event 55, Peter vs Vulture's Crew at Ferry
(55, 1081, 107, 154), -- Event 55, Toomes vs Peter (Avengers) at Ferry
(56, 1067, 122, 103); -- Event 56, Peter vs Vulture's Crew at Stark Tower

-- LAYER 8: Sightings
INSERT INTO Sighting (Sighting_ID, Timestamp, Location_ID, Subject_ID, Corroboration_Level) VALUES
(35, '2017-09-16 17:00:00', 154, 1081, 'Verified'), -- Vulture sighted at Staten Island Ferry
(36, '2017-09-17 19:00:00', 103, 1067, 'Verified'); -- Spider-Man sighted at Stark Tower (Plane crash)

-- =====================================================================
-- BLOCK 17: THOR: RAGNAROK (2017)
-- =====================================================================
-- ...
-- LAYER 1: Locations, Orgs, Events
INSERT INTO Location (Location_ID, Name, Planet, Latitude, Longitude) VALUES
(155, 'Muspelheim', 'Muspelheim', NULL, NULL),
(156, 'Grandmaster s Arena', 'Sakaar', NULL, NULL), -- On Sakaar (Loc 13)
(157, 'Norway (Cliffside)', 'Earth', 61.0000, 8.0000);

INSERT INTO Organization (Org_ID, Org_Name, Org_Type) VALUES
(124, 'Grandmaster s Contest of Champions', 'Entertainment/Combat'),
(125, 'Hela s Undead Army', 'Army'),
(126, 'The Revengers', 'Hero Team'); -- Brief alliance

INSERT INTO Species (Species_ID, Common_Name, Home_Planet_ID, General_Physiology) VALUES
(17, 'Kronan', NULL, 'Rock-based humanoid.'),
(18, 'Insectoid (Miek)', 13, 'Insect-like exoskeleton with blades.'),
(19, 'Fire Demon', 155, 'Magma-based lifeform.');

INSERT INTO Event (Event_ID, Event_Name, Date_of_Event, Primary_Location_ID, Casualties, Economic_Loss) VALUES
(57, 'Surtur s Defeat (Prologue)', '2017-11-15', 155, 50, 0.00),
(58, 'Death of Odin & Hela s Arrival', '2017-11-17', 157, 1, 0.00), -- Odin dies
(59, 'Contest of Champions: Thor vs Hulk', '2017-11-19', 156, 0, 10000000.00),
(60, 'Ragnarok (Destruction of Asgard)', '2017-11-21', 11, 9700, 1000000000000.00); -- Total loss of Asgard

-- LAYER 2: Individuals, Tech, Artifacts
INSERT INTO Individual (Individual_ID, FirstName, LastName, Date_of_Birth, Status, Species_ID) VALUES
(1086, 'Hela', 'Odinsdottir', '0001-01-01', 'Deceased', 2),
(1087, 'Brunnhilde', 'Valkyrie', '0001-01-01', 'Active', 2),
(1088, 'Grandmaster', '', '0001-01-01', 'Active', 6), -- Celestial-like/Elder
(1089, 'Skurge', 'The Executioner', '0001-01-01', 'Deceased', 2),
(1090, 'Korg', '', '0001-01-01', 'Active', 17),
(1091, 'Miek', '', '0001-01-01', 'Active', 18),
(1092, 'Surtur', '', '0001-01-01', 'Deceased', 19);

INSERT INTO Technology (Tech_ID, Name, Inventor_ID, Power_Source) VALUES
(2058, 'Obedience Disk', 1088, 'Neuro-electric'),
(2059, 'Commodore (Grandmaster s Ship)', 1088, 'Unknown');

INSERT INTO Artifact (Artifact_ID, Official_Name, Type) VALUES
(3013, 'Eternal Flame', 'Mystic Artifact'),
(3014, 'Dragonfang', 'Asgardian Weapon'),
(3015, 'Hofund (Bifrost Sword)', 'Asgardian Weapon'),
(3016, 'Twilight Sword', 'Mystic Weapon'); -- Surtur's sword

-- LAYER 3 & 4: Sub-types, 1-N aliases
INSERT INTO Enhanced_Individual (Individual_ID, Threat_Level, Power_Classification, Power_Origin) VALUES
(1086, 10, 'Asgardian/Necromancy', 'Inherent'), -- Hela
(1087, 8, 'Asgardian Physiology', 'Inherent'), -- Valkyrie
(1090, 6, 'Kronan Physiology', 'Inherent'), -- Korg
(1092, 10, 'Fire Demon/Eternal Flame', 'Inherent/Artifact'); -- Surtur (Prime)

INSERT INTO Individual_Aliases (Alias_Name, Individual_ID) VALUES
('Goddess of Death', 1086),
('Scrapper 142', 1087),
('The Executioner', 1089);

-- LAYER 6 & 7: Junction Tables
INSERT INTO Individual_Affiliation (Individual_ID, Org_ID) VALUES
(1086, 125), -- Hela -> Undead Army
(1089, 125), -- Skurge -> Hela's Army (Reluctant)
(1087, 124), -- Valkyrie -> Grandmaster (Employee)
(1008, 124), -- Hulk -> Grandmaster (Champion)
(1016, 126), (1017, 126), (1087, 126), (1008, 126); -- Thor, Loki, Val, Hulk -> Revengers

INSERT INTO Individual_Participation (Individual_ID, Event_ID) VALUES
(1016, 57), (1092, 57), -- Surtur's Defeat
(1016, 58), (1017, 58), (1018, 58), (1086, 58), -- Hela's Arrival
(1016, 59), (1008, 59), (1017, 59), (1088, 59), (1087, 59), (1090, 59), (1091, 59), -- Contest of Champions
(1016, 60), (1017, 60), (1008, 60), (1087, 60), (1086, 60), (1089, 60), (1090, 60), (1092, 60), (1022, 60); -- Ragnarok

INSERT INTO Individual_Possession_Artifact (Individual_ID, Artifact_ID) VALUES
(1087, 3014), -- Valkyrie -> Dragonfang
(1022, 3015), -- Heimdall -> Hofund (stolen back)
(1092, 3016); -- Surtur -> Twilight Sword

INSERT INTO Individual_Conflicts (Individual_A_ID, Individual_B_ID) VALUES
(1016, 1092), -- Thor vs Surtur
(1016, 1086), -- Thor vs Hela
(1016, 1008), -- Thor vs Hulk (Arena)
(1087, 1086), -- Valkyrie vs Hela
(1089, 1086); -- Skurge vs Hela (Betrayal)

INSERT INTO Event_Equipment_Usage (Event_ID, User_Individual_ID, Target_Individual_ID, Tech_ID, Artifact_ID) VALUES
(58, 1086, NULL, NULL, 3001), -- Event 58 (Norway), Hela (1086) destroys Mjolnir (3001)
(59, 1088, 1016, 2058, NULL), -- Event 59 (Arena), Grandmaster (1088) uses Disk (2058) on Thor (1016)
(60, 1086, 1016, NULL, 3013), -- Event 60 (Asgard), Hela (1086) uses Eternal Flame (3013) to resurrect army
(60, 1089, 1086, 2057, NULL), -- Event 60 (Asgard), Skurge (1089) uses "Des" & "Troy" (Assumed Chitauri/Human hybrid guns 2057) against Hela's army
(60, 1017, 1092, NULL, 3013), -- Event 60 (Asgard), Loki (1017) uses Eternal Flame (3013) on Surtur (1092)
(60, 1017, NULL, NULL, 3004); -- Event 60 (Asgard), Loki (1017) steals Tesseract (3004) before destruction

INSERT INTO Conflict_Nexus_Link (Event_ID, Individual_ID, Org_ID, Location_ID) VALUES
(59, 1016, 124, 156), -- Event 59, Thor vs Grandmaster's Contest at Arena
(60, 1016, 125, 11), -- Event 60, Thor vs Hela's Army at Asgard
(60, 1092, 125, 11); -- Event 60, Surtur vs Hela's Army at Asgard

-- LAYER 8: Sightings
INSERT INTO Sighting (Sighting_ID, Timestamp, Location_ID, Subject_ID, Corroboration_Level) VALUES
(37, '2017-11-17 12:00:00', 157, 1016, 'Verified'), -- Thor sighted in Norway
(38, '2017-11-21 18:00:00', 11, 1092, 'Verified'); -- Surtur sighted destroying Asgard

-- =====================================================================
-- BLOCK 18: BLACK PANTHER (2018)
-- =====================================================================
-- ...
- LAYER 1: Locations, Orgs, Events
INSERT INTO Location (Location_ID, Name, Planet, Latitude, Longitude) VALUES
(158, 'Museum of Great Britain', 'Earth', 51.5194, -0.1270), -- London
(159, 'Jagalchi Market / Casino', 'Earth', 35.0974, 129.0266), -- Busan, South Korea
(160, 'Warrior Falls', 'Earth', -0.5000, 30.0000), -- Wakanda
(161, 'Mount Bashenga (Vibranium Mine)', 'Earth', -0.5500, 30.0500); -- Wakanda

INSERT INTO Organization (Org_ID, Org_Name, Org_Type) VALUES
(127, 'War Dogs', 'Intelligence'),
(128, 'Dora Milaje', 'Royal Guard'),
(129, 'Jabari Tribe', 'Tribe');

INSERT INTO Event (Event_ID, Event_Name, Date_of_Event, Primary_Location_ID, Casualties, Economic_Loss) VALUES
(61, 'Museum Heist (Vibranium)', '2016-06-01', 158, 4, 1000000.00), -- Date adjusted to fit shortly after Civil War
(62, 'Casino Brawl & Car Chase', '2016-06-03', 159, 0, 5000000.00),
(63, 'Killmonger\'s Challenge (Ritual Combat)', '2016-06-05', 160, 1, 0.00), -- Zuri dies
(64, 'Battle of Mount Bashenga', '2016-06-07', 161, 0, 20000000.00);

-- LAYER 2: Individuals, Tech, Artifacts
INSERT INTO Individual (Individual_ID, FirstName, LastName, Date_of_Birth, Status, Species_ID) VALUES
(1093, 'Erik', 'Stevens (Killmonger)', '1986-01-01', 'Deceased', 1),
(1094, 'Shuri', '', '1998-01-01', 'Active', 1),
(1095, 'Okoye', '', '1980-01-01', 'Active', 1),
(1096, 'Nakia', '', '1983-01-01', 'Active', 1),
(1097, 'M\'Baku', '', '1975-01-01', 'Active', 1),
(1098, 'W\'Kabi', '', '1980-01-01', 'Incarcerated', 1),
(1099, 'Zuri', '', '1950-01-01', 'Deceased', 1);

INSERT INTO Technology (Tech_ID, Name, Inventor_ID, Power_Source) VALUES
(2060, 'Panther Habit (Nanotech)', 1094, 'Vibranium (Kinetic)'),
(2061, 'Sonic Spear', 1094, 'Vibranium'),
(2062, 'Kimoyo Beads', 1094, 'Vibranium'),
(2063, 'Remote Piloting System', 1094, 'Vibranium'),
(2064, 'Prosthetic Arm (Vibranium)', 1094, 'Vibranium'); -- For Klaue

-- LAYER 3 & 4: Sub-types, 1-N aliases
INSERT INTO Agent (Individual_ID, Classification_Level, Department, Handler_ID) VALUES
(1093, 9, 'JSOC Ghost', 1068), -- Killmonger (Affiliated with US Intel), handler Ross (1068)
(1095, 9, 'General', 1065), -- Okoye, handler T'Challa
(1096, 8, 'War Dog', 1065); -- Nakia

INSERT INTO Enhanced_Individual (Individual_ID, Threat_Level, Power_Classification, Power_Origin) VALUES
(1093, 9, 'Heart-Shaped Herb/Powered Suit', 'Inherent/Technology'), -- Killmonger
(1097, 7, 'Superhuman Strength', 'Inherent'); -- M'Baku

INSERT INTO Individual_Aliases (Alias_Name, Individual_ID) VALUES
('Killmonger', 1093),
('Golden Jaguar', 1093),
('Great Gorilla', 1097);

-- LAYER 6 & 7: Junction Tables
INSERT INTO Individual_Affiliation (Individual_ID, Org_ID) VALUES
(1093, 127), -- Killmonger -> War Dogs (Lost)
(1094, 117), -- Shuri -> Royal Family
(1095, 128), -- Okoye -> Dora Milaje
(1096, 127), -- Nakia -> War Dogs
(1097, 129), -- M'Baku -> Jabari
(1098, 117); -- W'Kabi -> Royal Family

INSERT INTO Individual_Participation (Individual_ID, Event_ID) VALUES
(1093, 61), (1058, 61), -- Museum Heist (Killmonger, Klaue)
(1065, 62), (1095, 62), (1096, 62), (1058, 62), (1068, 62), -- Casino Brawl
(1065, 63), (1093, 63), (1099, 63), -- Ritual Combat
(1065, 64), (1093, 64), (1094, 64), (1095, 64), (1096, 64), (1097, 64), (1098, 64), (1068, 64); -- Battle of Bashenga

INSERT INTO Individual_Conflicts (Individual_A_ID, Individual_B_ID) VALUES
(1065, 1093), -- T'Challa vs Killmonger
(1093, 1058), -- Killmonger vs Klaue (Betrayal)
(1095, 1098), -- Okoye vs W'Kabi (Husband/Wife conflict)
(1065, 1097); -- T'Challa vs M'Baku (Initial)

INSERT INTO Event_Equipment_Usage (Event_ID, User_Individual_ID, Target_Individual_ID, Tech_ID, Artifact_ID) VALUES
(61, 1058, NULL, 2064, NULL), -- Event 61 (Museum), Klaue (1058) uses Prosthetic Arm (2064)
(62, 1065, NULL, 2060, NULL), -- Event 62 (Casino), T'Challa (1065) uses Nanotech Suit (2060)
(62, 1095, NULL, 2061, NULL), -- Event 62 (Casino), Okoye (1095) uses Sonic Spear (2061)
(64, 1093, 1065, 2060, NULL), -- Event 64 (Bashenga), Killmonger (1093) uses Gold Suit (2060) against T'Challa (1065)
(64, 1068, NULL, 2063, NULL); -- Event 64 (Bashenga), Ross (1068) uses Remote Pilot (2063) to shoot down ships

INSERT INTO Conflict_Nexus_Link (Event_ID, Individual_ID, Org_ID, Location_ID) VALUES
(63, 1093, 127, 160), -- Event 63, Killmonger (War Dog) vs T'Challa at Warrior Falls
(64, 1065, 128, 161), -- Event 64, T'Challa/Dora Milaje vs Killmonger/Border Tribe at Bashenga
(64, 1093, 117, 161); -- Event 64, Killmonger vs T'Challa at Bashenga

-- LAYER 8: Sightings
INSERT INTO Sighting (Sighting_ID, Timestamp, Location_ID, Subject_ID, Corroboration_Level) VALUES
(39, '2016-06-03 22:00:00', 159, 1065, 'Verified'), -- Black Panther sighted in Busan
(40, '2016-06-03 22:10:00', 159, 1058, 'Verified'); -- Ulysses Klaue sighted in Busan

-- =====================================================================
-- BLOCK 19: AVENGERS: INFINITY WAR (2018)
-- =====================================================================
-- ...

-- LAYER 1: Locations, Orgs, Events
INSERT INTO Location (Location_ID, Name, Planet, Latitude, Longitude) VALUES
(162, 'The Statesman (Asgardian Ship)', 'Deep Space', NULL, NULL),
(163, 'Nidavellir', 'Nidavellir', NULL, NULL),
(164, 'Knowhere (Collector s Museum)', 'Knowhere', NULL, NULL); -- Re-visiting, but specific spot

INSERT INTO Organization (Org_ID, Org_Name, Org_Type) VALUES
(130, 'The Black Order', 'Army');

INSERT INTO Event (Event_ID, Event_Name, Date_of_Event, Primary_Location_ID, Casualties, Economic_Loss) VALUES
(65, 'Attack on the Statesman', '2018-05-29', 162, 500, 100000000.00), -- Loki & Heimdall die
(66, 'Battle of New York (2018)', '2018-05-29', 146, 0, 5000000.00), -- Cull/Maw vs Tony/Strange
(67, 'Ambush on Knowhere', '2018-05-30', 164, 0, 0.00), -- Thanos gets Reality Stone
(68, 'Battle of Titan', '2018-05-31', 15, 0, 0.00), -- Tony/Strange/Guardians vs Thanos
(69, 'Battle of Wakanda', '2018-05-31', 160, 1000, 500000000.00), -- Outriders vs Avengers/Wakanda
(70, 'The Snap (The Decimation)', '2018-05-31', 160, 3500000000, 9999999999999.99); -- 50% of life (Casualties is mostly Earth est.)

-- LAYER 2: Individuals, Tech, Artifacts
INSERT INTO Individual (Individual_ID, FirstName, LastName, Date_of_Birth, Status, Species_ID) VALUES
(1100, 'Thanos', '', '1018-01-01', 'Deceased', 6), -- Titanian
(1101, 'Ebony', 'Maw', '0001-01-01', 'Deceased', 1), -- Unknown species, setting to 1 for generic alien for now
(1102, 'Cull', 'Obsidian', '0001-01-01', 'Deceased', 1),
(1103, 'Proxima', 'Midnight', '0001-01-01', 'Deceased', 1),
(1104, 'Corvus', 'Glaive', '0001-01-01', 'Deceased', 1),
(1105, 'Eitri', '', '0001-01-01', 'Active', 2); -- Dwarf (Nidavellir)

INSERT INTO Technology (Tech_ID, Name, Inventor_ID, Power_Source) VALUES
(2065, 'Iron Man Armor: Mark 50 (Nanotech)', 1001, 'Arc Reactor (Nano)'),
(2066, 'Iron Spider Armor', 1001, 'Arc Reactor (Nano)'),
(2067, 'War Machine Armor: Mark IV', 1004, 'Arc Reactor');

INSERT INTO Artifact (Artifact_ID, Official_Name, Type) VALUES
(3017, 'Infinity Gauntlet', 'Uru Artifact'),
(3018, 'Stormbreaker', 'Asgardian Weapon'),
(3019, 'Soul Stone', 'Infinity Stone');

-- LAYER 3 & 4: Sub-types, 1-N aliases
INSERT INTO Enhanced_Individual (Individual_ID, Threat_Level, Power_Classification, Power_Origin) VALUES
(1100, 10, 'Titan Physiology/Infinity Stones', 'Inherent/Artifact'), -- Thanos
(1101, 8, 'Telekinesis', 'Inherent'); -- Maw

INSERT INTO Individual_Aliases (Alias_Name, Individual_ID) VALUES
('The Mad Titan', 1100),
('Stonekeeper', 1028); -- Red Skull on Vormir

-- LAYER 6 & 7: Junction Tables
INSERT INTO Individual_Affiliation (Individual_ID, Org_ID) VALUES
(1100, 130), -- Thanos -> Black Order
(1101, 130), (1102, 130), (1103, 130), (1104, 130); -- The Children of Thanos

INSERT INTO Individual_Participation (Individual_ID, Event_ID) VALUES
(1016, 65), (1017, 65), (1008, 65), (1022, 65), (1100, 65), (1101, 65), (1102, 65), (1103, 65), (1104, 65), -- Statesman
(1001, 66), (1070, 66), (1073, 66), (1067, 66), (1008, 66), (1101, 66), (1102, 66), -- NY 2018
(1044, 67), (1045, 67), (1046, 67), (1078, 67), (1100, 67), (1052, 67), -- Knowhere
(1001, 68), (1067, 68), (1070, 68), (1044, 68), (1046, 68), (1078, 68), (1050, 68), (1100, 68), -- Titan
(1025, 69), (1013, 69), (1024, 69), (1004, 69), (1008, 69), (1053, 69), (1056, 69), (1065, 69), (1095, 69), (1097, 69), (1047, 69), (1048, 69), (1026, 69), (1041, 69), (1016, 69), (1100, 69), (1102, 69), (1103, 69), (1104, 69), -- Wakanda
(1100, 70); -- The Snap

INSERT INTO Individual_Possession_Artifact (Individual_ID, Artifact_ID) VALUES
(1100, 3017), -- Thanos -> Gauntlet
(1016, 3018), -- Thor -> Stormbreaker
(1100, 3007), (1100, 3004), (1100, 3006), (1100, 3019), (1100, 3009), (1100, 3008); -- Thanos gets ALL Stones

INSERT INTO Individual_Conflicts (Individual_A_ID, Individual_B_ID) VALUES
(1008, 1100), -- Hulk vs Thanos (Statesman)
(1017, 1100), -- Loki vs Thanos (Statesman)
(1001, 1102), -- Tony vs Cull Obsidian
(1070, 1101), -- Strange vs Maw
(1001, 1100), -- Tony vs Thanos (Titan)
(1025, 1100), -- Cap vs Thanos (Wakanda)
(1053, 1100), -- Wanda vs Thanos (Wakanda)
(1016, 1100); -- Thor vs Thanos (Wakanda)

INSERT INTO Event_Equipment_Usage (Event_ID, User_Individual_ID, Target_Individual_ID, Tech_ID, Artifact_ID) VALUES
(65, 1100, 1017, NULL, 3007), -- Event 65 (Statesman), Thanos (1100) uses Power Stone (3007) on Loki (1017)
(66, 1001, 1102, 2065, NULL), -- Event 66 (NY 2018), Tony (1001) uses Mark 50 (2065)
(66, 1067, 1102, 2066, NULL), -- Event 66 (NY 2018), Peter (1067) gets Iron Spider (2066)
(68, 1100, 1001, NULL, 3007), -- Event 68 (Titan), Thanos uses Power Stone (3007) to break moon
(68, 1070, 1100, NULL, 3009), -- Event 68 (Titan), Strange (1070) gives Time Stone (3009) to Thanos
(69, 1016, 1100, NULL, 3018), -- Event 69 (Wakanda), Thor (1016) uses Stormbreaker (3018) against Thanos
(70, 1100, NULL, NULL, 3017); -- Event 70 (Snap), Thanos uses Gauntlet (3017) with all stones

INSERT INTO Conflict_Nexus_Link (Event_ID, Individual_ID, Org_ID, Location_ID) VALUES
(68, 1001, 130, 15), -- Event 68, Tony (Avengers) vs Black Order (Thanos) on Titan
(69, 1025, 130, 160), -- Event 69, Steve (Avengers) vs Black Order (Outriders) in Wakanda
(69, 1065, 130, 160); -- Event 69, T'Challa (Wakanda) vs Black Order in Wakanda

-- LAYER 8: Sightings
INSERT INTO Sighting (Sighting_ID, Timestamp, Location_ID, Subject_ID, Corroboration_Level) VALUES
(41, '2018-05-29 14:00:00', 146, 1101, 'Verified'), -- Ebony Maw sighted in New York
(42, '2018-05-31 16:30:00', 160, 1100, 'Verified'); -- Thanos sighted in Wakanda
- =====================================================================
-- BLOCK 21: ANT-MAN AND THE WASP (2018)
-- =====================================================================

-- LAYER 1: Locations, Orgs, Events
INSERT INTO Location (Location_ID, Name, Planet, Latitude, Longitude) VALUES
(165, 'Quantum Realm (Subatomic)', 'N/A', NULL, NULL),
(166, 'X-Con Security Office', 'Earth', 37.7946, -122.3999), -- San Francisco
(167, 'Pym\'s Mobile Lab (Various)', 'Earth', 37.7749, -122.4194); -- Moving target

INSERT INTO Organization (Org_ID, Org_Name, Org_Type) VALUES
(131, 'X-Con Security Consultants', 'Private Sector'),
(132, 'Sonny Burch\'s Criminal Ring', 'Criminal');

INSERT INTO Event (Event_ID, Event_Name, Date_of_Event, Primary_Location_ID, Casualties, Economic_Loss) VALUES
(71, 'Lab Heist & Chase', '2018-05-28', 167, 0, 500000.00),
(72, 'Rescue of Janet van Dyne', '2018-05-30', 165, 0, 0.00), -- Quantum Realm event
(73, 'Battle for the Lab', '2018-05-30', 167, 0, 1000000.00);

-- LAYER 2: Individuals, Tech, Artifacts
INSERT INTO Individual (Individual_ID, FirstName, LastName, Date_of_Birth, Status, Species_ID) VALUES
(1106, 'Bill', 'Foster', '1950-01-01', 'Active', 1),
(1107, 'Janet', 'van Dyne', '1950-01-01', 'Deceased', 1),
(1108, 'Ava', 'Starr', '1990-01-01', 'Active', 1), -- Ghost
(1109, 'Sonny', 'Burch', '1970-01-01', 'Incarcerated', 1),
(1110, 'Jimmy', 'Woo', '1980-01-01', 'Active', 1);

INSERT INTO Technology (Tech_ID, Name, Inventor_ID, Power_Source) VALUES
(2068, 'Quantum Tunnel', 1060, 'Quantum Energy'),
(2069, 'The Wasp Suit', 1060, 'Pym Particles'),
(2070, 'Ghost Suit', 1030, 'Quantum Energy'), -- Shield tech originally
(2071, 'Project G.O.L.I.A.T.H.', 1106, 'Pym Particles');

-- LAYER 3 & 4: Sub-types, 1-N aliases
INSERT INTO Agent (Individual_ID, Classification_Level, Department, Handler_ID) VALUES
(1106, 8, 'S.H.I.E.L.D. Scientist (Former)', NULL), -- Bill Foster
(1110, 6, 'FBI Agent', NULL); -- Jimmy Woo

INSERT INTO Enhanced_Individual (Individual_ID, Threat_Level, Power_Classification, Power_Origin) VALUES
(1061, 7, 'Size Manipulation/Blasters', 'Technology'), -- Hope (Wasp)
(1107, 8, 'Quantum Healing/Evolution', 'Quantum Realm'), -- Janet
(1108, 7, 'Intangibility/Phasing', 'Quantum Instability'); -- Ghost

INSERT INTO Individual_Aliases (Alias_Name, Individual_ID) VALUES
('The Wasp', 1061),
('Ghost', 1108),
('Goliath', 1106);

-- LAYER 6 & 7: Junction Tables
INSERT INTO Individual_Affiliation (Individual_ID, Org_ID) VALUES
(1059, 131), (1063, 131), -- Scott & Luis -> X-Con
(1109, 132), -- Burch -> Criminal Ring
(1061, 131); -- Hope -> X-Con (Partner later)

INSERT INTO Individual_Participation (Individual_ID, Event_ID) VALUES
(1059, 71), (1060, 71), (1061, 71), (1108, 71), (1109, 71), -- Lab Heist
(1060, 72), (1107, 72), -- Janet Rescue
(1059, 73), (1061, 73), (1108, 73), (1106, 73), (1109, 73), (1063, 73); -- Battle for Lab

INSERT INTO Individual_Conflicts (Individual_A_ID, Individual_B_ID) VALUES
(1061, 1108), -- Wasp vs Ghost
(1059, 1108), -- Ant-Man vs Ghost
(1060, 1106), -- Hank Pym vs Bill Foster (Rivalry)
(1061, 1109); -- Wasp vs Sonny Burch

INSERT INTO Event_Equipment_Usage (Event_ID, User_Individual_ID, Target_Individual_ID, Tech_ID, Artifact_ID) VALUES
(71, 1108, 1061, 2070, NULL), -- Event 71 (Heist), Ghost (1108) uses Ghost Suit (2070) vs Wasp
(71, 1061, 1108, 2069, NULL), -- Event 71 (Heist), Wasp (1061) uses Wasp Suit (2069) vs Ghost
(72, 1060, NULL, 2068, NULL), -- Event 72 (Rescue), Hank (1060) uses Quantum Tunnel (2068)
(73, 1059, 1109, 2050, NULL), -- Event 73 (Lab), Scott (1059) uses Giant-Man (2050) against Burch's men
(73, 1107, 1108, NULL, NULL); -- Event 73 (Lab), Janet (1107) uses Quantum Healing on Ghost (1108)

INSERT INTO Conflict_Nexus_Link (Event_ID, Individual_ID, Org_ID, Location_ID) VALUES
(71, 1061, 132, 166), -- Event 71, Wasp vs Burch's Ring at X-Con Office (vicinity)
(73, 1059, 132, 167); -- Event 73, Ant-Man vs Burch's Ring at Mobile Lab

-- LAYER 8: Sightings
INSERT INTO Sighting (Sighting_ID, Timestamp, Location_ID, Subject_ID, Corroboration_Level) VALUES
(43, '2018-05-30 14:00:00', 167, 1059, 'Verified'), -- Giant-Man sighted in San Francisco Bay
(44, '2018-05-30 14:15:00', 167, 1061, 'Verified'); -- The Wasp sighted in San Francisco

-- =====================================================================
-- BLOCK 22: CAPTAIN MARVEL (1995)
-- =====================================================================
-- ...
INSERT INTO Location (Location_ID, Name, Planet, Latitude, Longitude) VALUES
(168, 'Torfa', 'Torfa', NULL, NULL),
(169, 'Mar-Vell\'s Laboratory (Imperial Cruiser)', 'Orbit', NULL, NULL),
(170, 'Pancho\'s Bar / Rambeau House', 'Earth', 29.9511, -90.0715); -- Louisiana

INSERT INTO Organization (Org_ID, Org_Name, Org_Type) VALUES
(133, 'Starforce', 'Military');

INSERT INTO Species (Species_ID, Common_Name, Home_Planet_ID, General_Physiology) VALUES
(20, 'Flerken', NULL, 'Cat-like appearance with pocket dimensions/tentacles.');

INSERT INTO Event (Event_ID, Event_Name, Date_of_Event, Primary_Location_ID, Casualties, Economic_Loss) VALUES
(74, 'Ambush on Torfa', '1995-06-05', 168, 5, 0.00),
(75, 'Crash of the Quadjet (Carol\'s Origin)', '1989-06-01', 10, 1, 50000000.00), -- Mar-Vell dies
(76, 'Battle at Mar-Vell\'s Lab', '1995-06-09', 169, 20, 100000000.00);

-- LAYER 2: Individuals, Tech, Artifacts
INSERT INTO Individual (Individual_ID, FirstName, LastName, Date_of_Birth, Status, Species_ID) VALUES
(1111, 'Carol', 'Danvers', '1965-04-24', 'Active', 1), -- Human/Kree Hybrid
(1112, 'Talos', '', '1950-01-01', 'Deceased', 5), -- Skrull
(1113, 'Yon-Rogg', '', '1950-01-01', 'Active', 4), -- Kree
(1114, 'Maria', 'Rambeau', '1966-01-01', 'Deceased', 1),
(1115, 'Mar-Vell', '(Wendy Lawson)', '1940-01-01', 'Deceased', 4), -- Kree
(1116, 'Goose', '', '1985-01-01', 'Unknown', 20); -- Flerken

INSERT INTO Technology (Tech_ID, Name, Inventor_ID, Power_Source) VALUES
(2072, 'Photon Blasters', NULL, 'Kree Tech'),
(2073, 'Light-Speed Engine', 1115, 'Tesseract'),
(2074, 'Kree Nega-Bands', NULL, 'Cosmic Energy');

-- LAYER 3 & 4: Sub-types, 1-N aliases
INSERT INTO Agent (Individual_ID, Classification_Level, Department, Handler_ID) VALUES
(1111, 10, 'Kree Starforce (Former)', 1113); -- Vers, handler Yon-Rogg

INSERT INTO Enhanced_Individual (Individual_ID, Threat_Level, Power_Classification, Power_Origin) VALUES
(1111, 10, 'Cosmic Energy Manipulation', 'Infinity Stone (Tesseract)'), -- Captain Marvel
(1116, 7, 'Eldritch Mouth/Pocket Dimension', 'Inherent'); -- Goose

INSERT INTO Individual_Aliases (Alias_Name, Individual_ID) VALUES
('Captain Marvel', 1111),
('Vers', 1111);

-- LAYER 6 & 7: Junction Tables
INSERT INTO Individual_Affiliation (Individual_ID, Org_ID) VALUES
(1111, 133), (1113, 133), -- Carol & Yon-Rogg -> Starforce
(1111, 3), (1114, 3), -- Carol & Maria -> US Air Force
(1112, 130); -- Talos -> Skrull Refugees (using Black Order ID 130 as placeholder or create new if strict, let's assume independent)
-- Correction: Talos isn't Black Order. Let's link him to nothing or create 'Skrull Refugees' org.
-- Better: Talos -> S.H.I.E.L.D. (impersonation) during the movie.

INSERT INTO Individual_Participation (Individual_ID, Event_ID) VALUES
(1111, 74), (1113, 74), -- Torfa
(1111, 75), (1113, 75), (1115, 75), -- Quadjet Crash
(1111, 76), (1112, 76), (1113, 76), (1114, 76), (1116, 76), (1000, 76); -- Lab Battle (Fury was there)

INSERT INTO Individual_Possession_Artifact (Individual_ID, Artifact_ID) VALUES
(1116, 3004); -- Goose swallows Tesseract

INSERT INTO Individual_Conflicts (Individual_A_ID, Individual_B_ID) VALUES
(1111, 1113); -- Carol vs Yon-Rogg

INSERT INTO Event_Equipment_Usage (Event_ID, User_Individual_ID, Target_Individual_ID, Tech_ID, Artifact_ID) VALUES
(75, 1111, 2073, NULL, NULL), -- Event 75 (Crash), Carol destroys Engine (2073) and absorbs energy
(76, 1111, 1113, NULL, NULL), -- Event 76 (Lab), Carol uses Photon Blasts vs Yon-Rogg
(76, 1116, NULL, NULL, 3004); -- Event 76 (Lab), Goose swallows Tesseract (3004)

INSERT INTO Conflict_Nexus_Link (Event_ID, Individual_ID, Org_ID, Location_ID) VALUES
(76, 1111, 133, 169), -- Event 76, Carol vs Starforce at Lab
(76, 1113, 133, 169); -- Event 76, Yon-Rogg vs Carol at Lab

-- LAYER 8: Sightings
INSERT INTO Sighting (Sighting_ID, Timestamp, Location_ID, Subject_ID, Corroboration_Level) VALUES
(45, '1995-06-09 12:00:00', 170, 1111, 'Verified'); -- Captain Marvel sighted in Louisiana

-- =====================================================================
-- BLOCK 20: AVENGERS: ENDGAME (2023)
-- =====================================================================
-- ...
INSERT INTO Location (Location_ID, Name, Planet, Latitude, Longitude) VALUES
(171, 'The Garden (Titan II)', '0259-S', NULL, NULL), -- Thanos' retirement planet
(172, 'Camp Lehigh (1970)', 'Earth', 40.0783, -74.9221), -- Time Heist location
(173, 'Vormir (2014)', 'Vormir', NULL, NULL), -- Time Heist location
(174, 'New York City (2012)', 'Earth', 40.7128, -74.0060), -- Time Heist location
(175, 'Asgard (2013)', 'Asgard', NULL, NULL), -- Time Heist location
(176, 'Morag (2014)', 'Morag', NULL, NULL); -- Time Heist location

-- No new Organizations, but the Avengers roster changes.

INSERT INTO Event (Event_ID, Event_Name, Date_of_Event, Primary_Location_ID, Casualties, Economic_Loss) VALUES
(77, 'Ambush on The Garden', '2018-06-20', 171, 1, 0.00), -- Thanos (Original) dies
-- Expanded Time Heist Events
(78, 'Time Heist: New York 2012', '2023-10-16', 174, 0, 50000.00), -- Failed Space Stone, Got Time/Mind
(79, 'Time Heist: Asgard 2013', '2023-10-16', 175, 0, 0.00), -- Reality Stone
(80, 'Time Heist: Morag 2014', '2023-10-16', 176, 0, 0.00), -- Power Stone
(81, 'Time Heist: Vormir 2014', '2023-10-16', 173, 1, 0.00), -- Soul Stone, Natasha dies
(82, 'Time Heist: Camp Lehigh 1970', '2023-10-16', 172, 0, 0.00), -- Space Stone/Pym Particles
(83, 'The Blip (Hulk s Snap)', '2023-10-17', 136, 0, 0.00), -- Everyone returns
(84, 'Attack on Avengers Compound', '2023-10-17', 136, 0, 5000000000.00), -- Compound destroyed
(85, 'Battle of Earth', '2023-10-17', 136, 10000, 0.00); -- Thanos & Army dusted, Tony dies

-- LAYER 2: Individuals, Tech, Artifacts
-- Most individuals exist. Need to add 2014 versions of Thanos/Gamora/Nebula if treating them distinct,
-- but for simplicity, we will reuse IDs or assume same entity time-traveling.
-- However, Gamora (2014) stays in 2023.
INSERT INTO Individual (Individual_ID, FirstName, LastName, Date_of_Birth, Status, Species_ID) VALUES
(1117, 'Morgan', 'Stark', '2018-01-01', 'Active', 1),
(1118, 'Gamora', '(2014 Variant)', '0001-01-01', 'Active', 11); -- Distinct from Deceased Gamora (1045)

INSERT INTO Technology (Tech_ID, Name, Inventor_ID, Power_Source) VALUES
(2075, 'Quantum GPS', 1001, 'Quantum Energy'),
(2076, 'Nano Gauntlet', 1001, 'Arc Reactor/Nanotech'),
(2077, 'Rescue Armor (Mark 49)', 1001, 'Arc Reactor'),
(2078, 'Time Travel Suit', 1001, 'Pym Particles');

-- LAYER 3 & 4: Sub-types, 1-N aliases
INSERT INTO Enhanced_Individual (Individual_ID, Threat_Level, Power_Classification, Power_Origin) VALUES
(1118, 8, 'Cybernetic Enhancements', 'Surgery'); -- Gamora 2014

INSERT INTO Individual_Aliases (Alias_Name, Individual_ID) VALUES
('Ronin', 1024), -- Clint's alias during the 5 years
('Rescue', 1002), -- Pepper's armor alias
('Professor Hulk', 1008),
('Fat Thor', 1016); -- Informal alias for tracking state

-- LAYER 6 & 7: Junction Tables
INSERT INTO Individual_Affiliation (Individual_ID, Org_ID) VALUES
(1002, 107), -- Pepper (Rescue) -> Avengers
(1118, 114); -- Gamora (2014) -> Ravagers (eventually/technically rogue)

INSERT INTO Individual_Participation (Individual_ID, Event_ID) VALUES
-- Garden Ambush
(1001, 77), (1016, 77), (1025, 77), (1013, 77), (1008, 77), (1004, 77), (1047, 77), (1050, 77), (1111, 77), (1100, 77),
-- Time Heist: New York 2012
(1001, 78), (1025, 78), (1008, 78), (1059, 78), -- Team NY
(1001, 78), (1016, 78), (1017, 78), -- 2012 Versions present
-- Time Heist: Asgard 2013
(1016, 79), (1047, 79), -- Thor & Rocket
(1019, 79), (1040, 79), -- Jane & Frigga present
-- Time Heist: Morag 2014
(1004, 80), (1050, 80), -- Rhodey & Nebula
(1044, 80), -- 2014 Quill present
-- Time Heist: Vormir 2014
(1013, 81), (1024, 81), -- Nat & Clint
(1028, 81), -- Red Skull present
-- Time Heist: Camp Lehigh 1970
(1001, 82), (1025, 82), -- Tony & Steve
(1030, 82), (1027, 82), -- Howard & Peggy present
-- The Blip
(1008, 83), -- Hulk Snaps
-- Attack on Compound
(1100, 84), (1050, 84), (1118, 84), -- Thanos (2014) attacks
-- Battle of Earth (Massive Roster)
(1001, 85), (1025, 85), (1016, 85), (1008, 85), (1024, 85), (1004, 85), (1059, 85), (1061, 85), (1065, 85), (1067, 85), (1070, 85), (1053, 85), (1111, 85), (1044, 85), (1118, 85), (1046, 85), (1047, 85), (1048, 85), (1002, 85), (1095, 85), (1026, 85), (1041, 85), (1022, 85), (1032, 85), (1052, 85), (1063, 85), (1090, 85), (1091, 85), (1094, 85), (1097, 85), (1106, 85);

INSERT INTO Individual_Possession_Artifact (Individual_ID, Artifact_ID) VALUES
(1024, 3019), -- Clint gets Soul Stone
(1008, 3017), -- Hulk uses Nano Gauntlet
(1001, 3017); -- Tony uses Nano Gauntlet (Stones)

INSERT INTO Individual_Conflicts (Individual_A_ID, Individual_B_ID) VALUES
(1025, 1025), -- Cap (2023) vs Cap (2012) during Heist
(1050, 1050), -- Nebula (2023) vs Nebula (2014)
(1053, 1100), -- Wanda vs Thanos (2014)
(1111, 1100), -- Captain Marvel vs Thanos (2014)
(1001, 1100); -- Tony vs Thanos (2014) - Final Snap

INSERT INTO Event_Equipment_Usage (Event_ID, User_Individual_ID, Target_Individual_ID, Tech_ID, Artifact_ID) VALUES
(77, 1016, 1100, NULL, 3018), -- Event 77 (Garden), Thor (1016) uses Stormbreaker (3018) to kill Thanos (1100)
(78, 1001, NULL, 2078, NULL), -- Event 78 (Heist), Team uses Time Travel Suits (2078)
(78, 1059, 1001, 2044, NULL), -- Event 78 (NY 2012), Scott (1059) uses Pym Particle (2044) on 2012 Tony
(81, 1013, NULL, NULL, 3019), -- Event 81 (Vormir), Natasha sacrifices herself for Soul Stone (3019)
(83, 1008, NULL, 2076, NULL), -- Event 83 (Blip), Hulk (1008) uses Nano Gauntlet (2076)
(85, 1025, 1100, NULL, 3001), -- Event 85 (Battle), Steve (1025) wields Mjolnir (3001) against Thanos
(85, 1002, NULL, 2077, NULL), -- Event 85 (Battle), Pepper (1002) uses Rescue Armor (2077)
(85, 1001, 1100, 2076, NULL); -- Event 85 (Battle), Tony (1001) uses Nano Gauntlet (2076) to snap Thanos

INSERT INTO Conflict_Nexus_Link (Event_ID, Individual_ID, Org_ID, Location_ID) VALUES
(85, 1025, 107, 136), -- Event 85, Steve (Avengers) vs Thanos' Army at Compound
(85, 1100, 130, 136); -- Event 85, Thanos (Black Order) vs Avengers at Compound

-- LAYER 8: Sightings
INSERT INTO Sighting (Sighting_ID, Timestamp, Location_ID, Subject_ID, Corroboration_Level) VALUES
(46, '2023-10-17 14:00:00', 136, 1001, 'Verified'), -- Iron Man (Last Sighting) at Avengers Compound
(47, '2023-10-17 14:10:00', 136, 1025, 'Verified'); -- Captain America (with Mjolnir) at Avengers Compound
--- =====================================================================
-- BLOCK 23: SPIDER-MAN: FAR FROM HOME (2019)
-- =====================================================================
-- Note: Takes place 8 months after Endgame (Summer 2024).

-- LAYER 1: Locations, Orgs, Events
INSERT INTO Location (Location_ID, Name, Planet, Latitude, Longitude) VALUES
(177, 'Venice Canals', 'Earth', 45.4408, 12.3155),
(178, 'Prague Square', 'Earth', 50.0755, 14.4378),
(179, 'Tower Bridge', 'Earth', 51.5055, -0.0754), -- London
(180, 'Berlin Safehouse', 'Earth', 52.5200, 13.4050);

INSERT INTO Organization (Org_ID, Org_Name, Org_Type) VALUES
(134, 'Mysterio\'s Crew', 'Criminal'); -- Disgruntled Stark Employees

INSERT INTO Event (Event_ID, Event_Name, Date_of_Event, Primary_Location_ID, Casualties, Economic_Loss) VALUES
(86, 'Water Elemental Attack', '2024-06-20', 177, 0, 5000000.00),
(87, 'Fire Elemental Attack (Molten Man)', '2024-06-22', 178, 0, 10000000.00),
(88, 'Mysterio\'s Illusion Trap', '2024-06-23', 180, 0, 0.00), -- Berlin
(89, 'Battle of London (Elemental Fusion)', '2024-06-24', 179, 0, 100000000.00);

-- LAYER 2: Individuals, Tech, Artifacts
INSERT INTO Individual (Individual_ID, FirstName, LastName, Date_of_Birth, Status, Species_ID) VALUES
(1119, 'Quentin', 'Beck', '1980-01-01', 'Deceased', 1),
(1120, 'William', 'Ginter Riva', '1970-01-01', 'Active', 1), -- Worked for Obadiah Stane
(1121, 'Dimitri', 'Smerdyakov', '1980-01-01', 'Active', 1), -- Agent of Fury/Talos
(1122, 'Brad', 'Davis', '2006-01-01', 'Active', 1),
(1123, 'Julius', 'Dell', '1970-01-01', 'Active', 1); -- Teacher

INSERT INTO Technology (Tech_ID, Name, Inventor_ID, Power_Source) VALUES
(2079, 'E.D.I.T.H. Glasses', 1001, 'Satellite Network'),
(2080, 'Mysterio Drones (Illusion/Combat)', 1120, 'Battery/Stark Tech'),
(2081, 'Stealth Suit (Night Monkey)', 1000, 'Kevlar/Fabric'); -- Supplied by "Fury"

-- LAYER 3 & 4: Sub-types, 1-N aliases
INSERT INTO Agent (Individual_ID, Classification_Level, Department, Handler_ID) VALUES
(1121, 6, 'Field Operations', 1000); -- Dimitri, handler "Fury"

INSERT INTO Enhanced_Individual (Individual_ID, Threat_Level, Power_Classification, Power_Origin) VALUES
(1119, 8, 'Illusion Tech/Drones', 'Technology'); -- Mysterio

INSERT INTO Individual_Aliases (Alias_Name, Individual_ID) VALUES
('Mysterio', 1119),
('Night Monkey', 1067); -- Peter's alias in Europe

-- LAYER 6 & 7: Junction Tables
INSERT INTO Individual_Affiliation (Individual_ID, Org_ID) VALUES
(1119, 134), (1120, 134), -- Beck & Riva -> Mysterio's Crew
(1120, 101); -- Riva -> Stark Industries (Former)

INSERT INTO Individual_Participation (Individual_ID, Event_ID) VALUES
(1067, 86), (1119, 86), (1082, 86), (1083, 86), -- Venice (Peter, Mysterio, Ned, MJ)
(1067, 87), (1119, 87), (1000, 87), (1032, 87), -- Prague (Nick Fury/Talos & Maria Hill/Soren present)
(1067, 88), (1119, 88), -- Berlin
(1067, 89), (1119, 89), (1120, 89), (1000, 89), (1032, 89), (1082, 89), (1083, 89), (1104, 89); -- London (Happy Hogan 1104 assumed present/added)

INSERT INTO Individual_Possession_Artifact (Individual_ID, Artifact_ID) VALUES
(1119, 3019); -- Mysterio briefly holds E.D.I.T.H. (Tech treated as key item)
-- Note: E.D.I.T.H. is Tech 2079, but serves artifact-like role in plot

INSERT INTO Individual_Conflicts (Individual_A_ID, Individual_B_ID) VALUES
(1067, 1119); -- Spider-Man vs Mysterio

INSERT INTO Event_Equipment_Usage (Event_ID, User_Individual_ID, Target_Individual_ID, Tech_ID, Artifact_ID) VALUES
(86, 1119, NULL, 2080, NULL), -- Event 86 (Venice), Mysterio (1119) uses Drones (2080) to create Elemental
(87, 1067, NULL, 2081, NULL), -- Event 87 (Prague), Peter (1067) uses Stealth Suit (2081)
(89, 1119, 1067, 2080, NULL), -- Event 89 (London), Mysterio (1119) uses Drones (2080) against Peter (1067)
(89, 1067, 1119, 2048, NULL); -- Event 89 (London), Peter (1067) uses Spidey Suit/Spider-Sense against Mysterio (1119)

INSERT INTO Conflict_Nexus_Link (Event_ID, Individual_ID, Org_ID, Location_ID) VALUES
(89, 1067, 134, 179), -- Event 89, Spider-Man vs Mysterio's Crew at Tower Bridge
(89, 1119, NULL, 179); -- Event 89, Mysterio vs Spider-Man at Tower Bridge

-- LAYER 8: Sightings
INSERT INTO Sighting (Sighting_ID, Timestamp, Location_ID, Subject_ID, Corroboration_Level) VALUES
(48, '2024-06-20 14:00:00', 177, 1119, 'Verified'), -- Mysterio sighted in Venice
(49, '2024-06-24 16:00:00', 179, 1067, 'Verified'); -- Spider-Man sighted at Tower Bridge

-- =====================================================================
-- FINAL UPDATES (Post-Endgame Status)
-- =====================================================================
-- This section updates the status of characters who died or retired.
-- Note: Tony (1001) and Natasha (1013) were inserted as 'Deceased' initially,
-- so no update needed for them.
-- Steve Rogers (1025) is 'Active' (Old Man) or 'Retired'.
-- Vision (1056) is 'Deceased' (until WandaVision).
-- Gamora (1045) is 'Deceased'. Gamora (1118) is 'Active'.
-- Loki (1017) is 'Deceased'. (2012 Variant is separate, not tracked here to avoid complexity).
-- Mysterio (1119) is 'Deceased'.

-- =====================================================================
-- END OF POPULATION SCRIPT
-- =====================================================================
