INSERT INTO tbl_PatientPDClinicianPairing 
            ( 
              ClientID, 
              ClientName, 
              AllocatedHCPName 
            )
SELECT DISTINCT main.ClientID, main.ClientName, main.AllocatedHCPName
FROM tbl_Clinician INNER JOIN main 
      ON tbl_Clinician.AllocatedHCPName = main.AllocatedHCPName
WHERE ((1)=1) 
      AND (((main.AllocatedHCPName) NOT IN 
            (SELECT DISTINCT AllocatedHCPName FROM tbl_PatientPDClinicianPairing)) 
      AND ((tbl_Clinician.isCons)=False) 
      AND ((tbl_Clinician.isRealPD)=True))
;


-- When pasting in Access, paste only the query; pasting also comments will generate errors

/* Updates Patient and PD Clinician Pairings table

name: qapp_NewPatientPDClinicianPairing

Update executed from closing the clinican checkbox form.

*/