SELECT 
    tbl_PatientPDClinicianPairing.AllocatedHCPName, 
    tbl_Patient.ClientName, 
    tbl_Patient.ClientID, 
    tbl_Patient.notes
FROM tbl_Patient INNER JOIN tbl_PatientPDClinicianPairing 
    ON 1 = 1
    AND tbl_Patient.ClientID = tbl_PatientPDClinicianPairing.ClientID
;




/* provides data for 2 subreports

name:   qsel_PatientPDClinician4Notes
status: Hidden

Used in 2 subreports: 

Doc Tables  qsel_PatientPDClinician4Notes .Name 8
Qry qsel_PatientPDClinician4Notes       .Name 2
Rpt rsub_ClinicianCaseloadsPD4Notes     .RecordSource 4
Rpt rsub_PDClinicanPatientNotes         .RecordSource 4

*/