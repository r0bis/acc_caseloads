SELECT  COUNT(SQRY.ClientID) AS NumberOfPatients, 
        SQRY.Practice_Name AS Surgery
FROM (
  SELECT DISTINCT ClientID, 
                  Practice_Name 
      FROM main INNER JOIN tbl_Clinician 
        ON main.AllocatedHCPName = tbl_clinician.AllocatedHCPName 
        WHERE (TBL_CLINICIAN.isRealPD = TRUE  
                OR tbl_clinician.isTWLPD = TRUE) 
        AND main.clientID NOT IN (
          SELECT main.ClientID FROM main INNER JOIN tbl_clinician       
          ON main.AllocatedHCPName = tbl_clinician.AllocatedHCPName       
          WHERE TBL_CLINICIAN.isTWL = TRUE)
        )  AS SQRY
GROUP BY SQRY.Practice_Name
ORDER BY Count(SQRY.ClientID) DESC
;




/* Shows top PD patient surgeries

name: qsel_Top_Surgeries_PD
status: Visible

*/