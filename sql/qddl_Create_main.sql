CREATE TABLE main
  (
    ClientID INT,
    ClientName TEXT (100),
    AllocatedHCPName TEXT(100),
    NHSNumber TEXT (10),
    TeamName TEXT (80)
  )
;


-- When pasting in Access, paste only the query; pasting also comments will generate errors


/* Creates main table

name: qddl_Create_main

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