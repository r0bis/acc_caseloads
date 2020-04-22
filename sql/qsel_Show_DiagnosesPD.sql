
SELECT DISTINCT 
    `ClientName`, 
    `ClientID`, 
    `Diagnosis1Desc`
FROM main INNER JOIN tbl_TWListPD 
    ON main.`AllocatedHCPName` = tbl_TWListPD.`AllocatedHCPName`
WHERE main.`Diagnosis1Desc` IS NOT NULL;


/* Show Diagnoses in PD 

name: qsel_Show_DiagnosesPD
status: Visible

*/