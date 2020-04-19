SELECT tbl_Patient.ClientName, tbl_Patient.ClientID, tbl_Patient.notes
FROM tbl_Patient
WHERE tbl_Patient.isRealCons=True
;



-- When pasting in Access, paste only the query; pasting also comments will generate errors

/*

name: qsel_PatientUnderConsultant

This is because tbl_Patient is the main place for tracking patients who are
actually under consultant. The other table for ConsultantCaseload is non-permanent
After creation and tbl_Patient update the isRealCons status is mirrored into
tbl_ConsultantCaseload

Affected:

Doc Tables  qsel_PatientUnderConsultant   .Name 8
Qry qsel_PatientUnderConsultant           .Name 2
Rpt qSubRKpatients subreport              .RecordSource 4
Rpt rsub_RKPatients                       .RecordSource 4


*/