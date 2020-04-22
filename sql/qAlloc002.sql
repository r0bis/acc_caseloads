SELECT DISTINCT 
    tbl_PatientPDClinicianPairing.ClientName, 
    tbl_PatientTWLPairing.AllocatedHCPName
FROM tbl_PatientPDClinicianPairing 
    INNER JOIN tbl_PatientTWLPairing 
    ON tbl_PatientPDClinicianPairing.ClientName = tbl_PatientTWLPairing.ClientName
;
