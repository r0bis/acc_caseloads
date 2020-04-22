UPDATE tbl_ConsultantCaseload 
    INNER JOIN tbl_Patient
    ON tbl_Patient.ClientID = tbl_ConsultantCaseload.ClientID
  SET tbl_ConsultantCaseload.isRealCons = tbl_Patient.isRealCons
;

-- When pasting in Access, paste only the query; pasting also comments will generate errors

/* Updates transitory  Consultant Caseload subsequent to edition of the persistent Patient table

name:   qupd_ConsCaseload_isRealCons
status: Hidden

Update after closing the consultant editing form. It should update all checkboxes in 
Consultant Caseload upon closing the form. In addition this should be run right after importing
populates the transitory ConsultantCaseload table.

*/