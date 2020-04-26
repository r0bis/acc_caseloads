SELECT COUNT(SQRY.ClientID) AS CountDX, SQRY.Diagnosis
FROM (SELECT DISTINCT ClientID, 
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
)  AS SQRY
GROUP BY Diagnosis
ORDER BY Count(SQRY.ClientID) DESC;



/* Shows number of grouped diagnoses in PD pathway

name: qsel_Top_Diagnoses_PD
status: Visible

*/