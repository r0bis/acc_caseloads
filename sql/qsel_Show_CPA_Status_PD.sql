SELECT DISTINCT ClientID, ClientName, CPALevel
FROM main INNER JOIN tbl_Clinician 
  ON main.AllocatedHCPName = TBL_CLINICIAN.AllocatedHCPName
WHERE (TBL_CLINICIAN.isRealPD = TRUE 
        OR tbl_clinician.isTWLPD = TRUE)
AND main.clientID NOT IN (
            SELECT main.ClientID FROM main INNER JOIN tbl_clinician
            ON main.AllocatedHCPName = tbl_clinician.AllocatedHCPName
            WHERE TBL_CLINICIAN.isTWL = TRUE
    )
ORDER BY CPALevel DESC;



/* Shows PD patient CPA status

name: qsel_Show_CPA_Status_PD
status: Visible


*/