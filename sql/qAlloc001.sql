SELECT 
    tbl_ClinicianPD.AllocatedHCPName, 
    tbl_PatientPDClinicianPairing.ClientName, 
    tbl_PatientPDClinicianPairing.ClientID
FROM tbl_ClinicianPD 
    INNER JOIN tbl_PatientPDClinicianPairing 
    ON tbl_ClinicianPD.AllocatedHCPName = tbl_PatientPDClinicianPairing.AllocatedHCPName
;


/* 

name: qAlloc001.sql
status: Hidden

One of two queries that serve as basis for another query.

Puts together Clinicans and TWLs (Dummy clinicans) for sub-report.


*/