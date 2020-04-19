SELECT tbl_ClinicianPD.id, tbl_ClinicianPD.AllocatedHCPName
FROM tbl_ClinicianPD
  INNER JOIN tbl_Clinician
  ON tbl_ClinicianPD.AllocatedHCPName = tbl_Clinician.AllocatedHCPName
WHERE tbl_Clinician.isCons = FALSE
;


-- When pasting in Access, paste only the query; pasting also comments will generate errors


/* Record source for two subreports

name: qsel_Clinicians4PatientsRPTMain


The two affected subreports are:

rsub_ClinicianPDCaseloads           .RecordSource 4
rsub_ClinicianPDCaseloads4Notes     .RecordSource 4



*/