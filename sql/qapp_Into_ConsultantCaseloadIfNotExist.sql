INSERT INTO tbl_ConsultantCaseload ( 
                            ClientName, 
                            ClientID, 
                            AllocatedHCPName 
                            )
SELECT main.ClientName, main.ClientID, main.AllocatedHCPName
FROM main
WHERE 1 = 1
  AND main.AllocatedHCPName = (SELECT TOP 1 AllocatedHCPName FROM tbl_Clinician WHERE isCons = TRUE)
  AND main.ClientName NOT IN (SELECT ClientName FROM tbl_ConsultantCaseload)
;

/* Updates Consultant Caseload Table

name:   qapp_Into_ConsultantCaseloadIfNotExist
status: Hidden

This is going to be a table dropped and recreated every time data is imported.
It will reflect the ones associated with the consultant of the service.

Still the patient list may need to come from tbl_Patient
because sometimes there will be errors and Consultant is 
not on some cases where they should be 

SELECT TOP 1 at the moment is precaution - what if 
someone clicks consultant checkbox when they should not
*/