SELECT DISTINCT ClientID, ClientName, Rag_Rating
FROM main INNER JOIN tbl_Clinician 
    ON main.AllocatedHCPName = TBL_CLINICIAN.AllocatedHCPName
WHERE (TBL_CLINICIAN.isRealPD = TRUE 
      OR tbl_clinician.isTWLPD = TRUE)
AND main.clientID NOT IN (
      SELECT main.ClientID FROM main INNER JOIN tbl_clinician
        ON main.AllocatedHCPName = tbl_clinician.AllocatedHCPName
        WHERE TBL_CLINICIAN.isTWL = TRUE
    )
;



/* RAG ratings as they appear in RiO

name: qsel_RAG_Status_RiO_PD
status: Visible

SELECT DISTINCT
  main.ClientID, 
  main.ClientName,
  main.RAG_Rating
FROM main
WHERE 1=1
AND main.ClientID IN (SELECT ClientID FROM tbl_PatientPDClinicianPairing)
OR main.ClientID IN (SELECT ClientID FROM tbl_PatientPDTWLPairing)
ORDER BY main.ClientName
;


-- 315 on PDTWL / 247 on PDClinician / 199 on both inner 
-- 

SELECT DISTINCT
  M.ClientID, 
  M.ClientName,
  M.RAG_Rating  
FROM (main AS M RIGHT JOIN tbl_PatientPDClinicianPairing AS C
  ON M.ClientID = C.ClientID)
  LEFT JOIN tbl_PatientPDTWLPairing AS T
  ON C.ClientID = T.ClientID
;

SELECT DISTINCT
  main.ClientID, 
  main.ClientName,
  main.RAG_Rating  
FROM (main INNER JOIN tbl_PatientPDClinicianPairing
  ON main.ClientID = tbl_PatientPDClinicianPairing.ClientID)
WHERE 1=1
ORDER BY main.ClientName
;
SELECT DISTINCT
  main.ClientID, 
  main.ClientName,
  main.RAG_Rating  
FROM (main INNER JOIN tbl_PatientPDTWLPairing
  ON main.ClientID = tbl_PatientPDTWLPairing.ClientID)
WHERE 1=1
ORDER BY main.ClientName
;
*/