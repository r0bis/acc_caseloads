CREATE TABLE tbl_ConsultantCaseload 
    (
    ClientID INTEGER NOT NULL PRIMARY KEY, 
    ClientName TEXT(100) NOT NULL, 
    AllocatedHCPName TEXT(100) NOT NULL,
    isRealCons BIT,
    Notes TEXT(255) 
    )
;


-- When pasting in Access, paste only the query; pasting also comments will generate errors


/* Creates Consultant Caseload table anew.

name:   qddl_Create_ConsultantCaseload
status: Hidden

This is a non persistent table

ClientID is made into PRIMARY KEY to prevent insertion of duplicates in this table
We know it would be quite impossible, but this still is a precaution 




*/