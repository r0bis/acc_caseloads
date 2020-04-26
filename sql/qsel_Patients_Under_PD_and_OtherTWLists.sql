/* UNFINISHED

-- this shows patients who currently are under one of 
-- PD TWLists and some other TWList as well

SELECT main.ClientID, main.ClientName, main.AllocatedHCPName
FROM main
  INNER JOIN tbl_Clinician
  ON main.AllocatedHCPName = tbl_Clinician.AllocatedHCPName
  WHERE tbl_Clinician.isRealPD = TRUE
;

*/