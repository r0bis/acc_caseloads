SELECT ClientID,
       ClientName,
       AllocatedHCPName
FROM tbl_PatientPDTWLPairing
WHERE ClientID IN
    (SELECT ClientID
     FROM `tbl_PatientPDTWLPairing`
     GROUP BY ClientID HAVING COUNT(*) > 1) 
;

/* How many patients are in TWO or more PDTWLists

name: qsel_Patients_IN_TWO_PD_TWLists
status: visible

*/