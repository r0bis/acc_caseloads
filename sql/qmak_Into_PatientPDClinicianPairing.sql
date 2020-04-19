SELECT DISTINCT 
        main.ClientID, 
        main.ClientName, 
        main.AllocatedHCPName
INTO tbl_PatientPDClinicianPairing
FROM tbl_Clinician INNER JOIN main 
      ON tbl_Clinician.AllocatedHCPName = main.AllocatedHCPName
  WHERE 1=1
  AND tbl_Clinician.isCons = FALSE 
  AND tbl_Clinician.isRealPD = TRUE
;



/* Recreates PD Clinican and Patient pairing from new data

name: qmak_Into_PatientPDClinicianPairing

Inner Join filters PD clinicians - not RK, because he is on all PD cases.
RK is filtered out by isCons FALSE flag 
Query creates DISTINCT patient -- PD Clinician pairings. 
It is called from VBA and the table is deleted before this query is called.

*/



