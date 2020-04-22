INSERT INTO tbl_ConsultantCaseload 
      ( 
        ClientID, 
        ClientName, 
        AllocatedHCPName 
      )
SELECT DISTINCT 
      main.ClientID, 
      main.ClientName, 
      main.AllocatedHCPName
FROM main, tbl_Clinician
      WHERE 1=1
      AND main.AllocatedHCPName = tbl_Clinician.AllocatedHCPName
      AND (((tbl_Clinician.isCons)=True))
;


-- When pasting in Access, paste only the query; pasting also comments will generate errors


/*  Insert Consultant Caseload from fresh data

name:   qmak_Into_ConsultantCaseload
status: Hidden

This inserts current consultant caseload from new data.
Therefore tbl_ConsultantCaseload is non-persistent
Actual caseload lookups are still done from the patient table
tbl_Patient is persistent and
carries cumulative updates of patient list along the way.

There is no need to check if already not exists because
in VBA we have cleared the table in one of the previous lines.

However appending duplicate rows would also not be permitted
because when we create via qddl_Create_ConsultantCaseload
ClientID is made into PRIMARY KEY

JOIN operation not supported in UPDATE for Access therefore 
the following does not work:

INSERT INTO tbl_ConsultantCaseload (
                  ClientID,
                  ClientName,
                  AllocatedHCPName
                  )
SELECT DISTINCT main.ClientID, main.ClientName, main.AllocatedHCPName 
FROM main INNER JOIN tbl_Clinician 
ON 1=1
AND main.AllocatedHCPName = tbl_Clinician.AllocatedHCPName
WHERE (((tbl_Clinician.isCons)=True))
;



*/