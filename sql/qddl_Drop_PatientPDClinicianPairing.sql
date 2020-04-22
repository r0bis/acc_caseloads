DROP TABLE tbl_PatientPDClinicianPairing
;

-- When pasting in Access, paste only the query; pasting also comments will generate errors


/*

name:   qddl_Drop_PatientPDClinicianPairing
status: Hidden

Called from VBA - to clear before populated from new import data.

There are 4 such calls - immediately followed by 
creation and updating the same tables:

"qddl_Drop_PatientPDTWLPairing", dbFailOnError
"qddl_Drop_PatientTWLPairing", dbFailOnError
"qddl_Drop_PatientPDClinicianPairing", dbFailOnError
"qddl_Drop_ConsultantCaseload", dbFailOnError


*/