DELETE * FROM tbl_PatientPDTWLPairing
WHERE AllocatedHCPName NOT IN (
SELECT AllocatedHCPName FROM tbl_Clinician WHERE isTWLPD = TRUE
)
;



-- When pasting in Access, paste only the query; pasting also comments will generate errors

/* This updates Patient and PD clinican Pairings table

Name:   qdel_OldPatientPDTWLPairing
status: Hidden

Used on closing the Clinican Classifying Tickbox forms. The notes in Clinician tables (if any) 
must be updated via manual editing the table 


*/