SELECT 
    tbl_ClinicianPD.AllocatedHCPName, 
    tbl_PatientPDClinicianPairing.ClientName, 
    tbl_PatientPDClinicianPairing.ClientID
FROM tbl_ClinicianPD 
    INNER JOIN tbl_PatientPDClinicianPairing 
    ON tbl_ClinicianPD.AllocatedHCPName = tbl_PatientPDClinicianPairing.AllocatedHCPName
;


