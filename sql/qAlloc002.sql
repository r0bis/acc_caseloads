SELECT DISTINCT 
    tbl_PatientPDClinicianPairing.ClientName, 
    tbl_PatientTWLPairing.AllocatedHCPName
FROM tbl_PatientPDClinicianPairing 
    INNER JOIN tbl_PatientTWLPairing 
    ON tbl_PatientPDClinicianPairing.ClientName = tbl_PatientTWLPairing.ClientName
;


/* 

name: qAlloc002.sql
status: Hidden

One of two queries that serve as basis for another query.

Puts together Clinicans and TWLs (Dummy clinicans) for sub-report.


*/