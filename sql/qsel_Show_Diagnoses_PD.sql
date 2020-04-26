SELECT DISTINCT ClientID, 
                ClientName, 
                IIF(Diagnosis1Desc IS NULL,"NO DIAGNOSIS",Diagnosis1Desc) AS Diagnosis
FROM main INNER JOIN tbl_Clinician 
    ON main.AllocatedHCPName = tbl_clinician.AllocatedHCPName
WHERE (TBL_CLINICIAN.isRealPD = TRUE 
OR tbl_clinician.isTWLPD = TRUE)
AND main.clientID NOT IN (
      SELECT main.ClientID FROM main INNER JOIN tbl_clinician
      ON main.AllocatedHCPName = tbl_clinician.AllocatedHCPName
      WHERE TBL_CLINICIAN.isTWL = TRUE
    )
ORDER BY ClientName DESC
;



/* Shows diagnoses for PD pathway patients

name: qsel_Show_Diagnoses_PD
status: Visible




*/