INSERT INTO tbl_PatientPDTWLPairing 
            ( 
              ClientID, 
              ClientName, 
              AllocatedHCPName 
            )
SELECT DISTINCT main.ClientID, main.ClientName, main.AllocatedHCPName
FROM tbl_Clinician INNER JOIN main 
      ON tbl_Clinician.AllocatedHCPName = main.AllocatedHCPName
WHERE ((1)=1) 
      AND (((main.AllocatedHCPName & main.ClientID) NOT IN 
            (SELECT DISTINCT AllocatedHCPName & ClientID FROM tbl_PatientPDTWLPairing)) 
      AND ((tbl_Clinician.isCons)=False) 
      AND ((tbl_Clinician.isTWLPD)=True))
;


-- When pasting in Access, paste only the query; pasting also comments will generate errors

/* Updates Patient and PD TW-List Pairings table

name:   qapp_NewPatientPDTWLPairing
status: Hidden

Update executed from closing the clinican checkbox form.

Note Access style concat function "&"

*/