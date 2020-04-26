CREATE TABLE main
  (
    TeamName TEXT (80),
    CareCoordinator (100),
    CPALevel TEXT (45),
    AllocatedHCPName TEXT (100),
    ClientID INT,
    ClientName TEXT (100),
    NHSNumber TEXT (10),
    DateOfBirth DATETIME,
    Age INT,
    Gender CHAR(7),
    Practice_Name CHAR(180),
    ReferralDateTime DATETIME,
    AllocatedHCPStartDate DATETIME,
    CarePlan_Date DATETIME,
    RiskAssessmentDate DATETIME,
    ProgNoteDate DATETIME,
    MostRecentContact DATETIME,
    ClusterAssessmentDate DATETIME,
    Crisis_Relapse_and_Contingency_Plan_Date DATETIME,
    CarePlan_Distributed_to_Client DATETIME,
    ClusterName TEXT (120),
    Diagnosis1Desc TEXT(120),
    Diagnosis1 CHAR (12),
    RAG_Rating TEXT (55)
  )
;


-- When pasting in Access, paste only the query; pasting also comments will generate errors


/* Creates main table

name:   qddl_Create_main
status: Hidden

Note that the only change from original in column names is TeamName from Team_Name
this is achieved in the SELECT query putting data into main table

Prepares table for insertion of new data.
main is temporary table - it gets dropped and recreated prior to new data import
import definition is 'main_new_importing' - it is saved in the database

Note that we cannot store NHS number as an integer - field size is too small
therefore it is stored as text

Also note that TeamName is the only changed element from original import
In the original it is Team_Name

Field sizes are considerably smaller that original import too.
Original import table gets dropped as soon as data are transferred into the
newly born main table.

*/