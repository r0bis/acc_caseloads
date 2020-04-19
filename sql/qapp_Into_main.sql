INSERT INTO main (
                  ClientID,
                  ClientName,
                  AllocatedHCPName,
                  NHSNumber,
                  TeamName
                  )
SELECT DISTINCT 
            ClientID,
            ClientName, 
            AllocatedHCPName, 
            NHSNumber,
            Team_Name AS TeamName 
FROM main_new_import
;

-- When pasting in Access, paste only the query; pasting also comments will generate errors


/* This makes main table compact 

name: qapp_Into_main

previously in VBA we have created the main table and the next 
step will be to create indexes on fields

when this will be used for other tasks - such as auditing waiting times
we will need to alter main table definition and select more columns 
from the temporary table main_new_import

main_new_import is quickly dropped to keep database size low


*/