DELETE * FROM tbl_ClinicianPD
WHERE AllocatedHCPName NOT IN (
SELECT AllocatedHCPName FROM tbl_Clinician WHERE isRealPD = TRUE
)
;



-- When pasting in Access, paste only the query; pasting also comments will generate errors

/* This updates PD clinican table tbl_ClinicianPD

Name = qdel_OldPDClinician

Used on closing the Clinican Classifying Tickbox forms. The notes in Clinician tables (if any) 
must be updated via manual editing the table 


*/