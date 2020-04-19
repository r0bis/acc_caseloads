SELECT DISTINCT 
        main.ClientID, 
        main.ClientName, 
        main.AllocatedHCPName 
INTO tbl_PatientPDTWLPairing
FROM tbl_Clinician INNER JOIN main 
        ON tbl_Clinician.AllocatedHCPName = main.AllocatedHCPName
WHERE tbl_Clinician.isTWLPD = TRUE
;



/* Recreates Patient and PD Treatment-Waiting List pairings from new data

name: qmak_Into_PatientPDTWLPairing

Inner Join filters PD TWL clinicians. There are 2 TWL fields 
in the clinicans table. 1st is for any TW-list and 
2nd is for PD TW-lists. Query creates DISTINCT patient -- PDTWL pairings. It is called from VBA and is deleted before this query is called.


*/

