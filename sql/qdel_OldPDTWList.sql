DELETE *
FROM tbl_TWListPD
WHERE AllocatedHCPName NOT IN (
SELECT AllocatedHCPName FROM tbl_Clinician WHERE isTWLPD = TRUE
)
;


-- When pasting in Access, paste only the query; pasting also comments will generate errors

/* This updates PD TWList table tbl_TWLPD

Name = qdel_OldPDTWList

Used on closing the Clinican Classifying Tickbox forms. The notes in Clinician tables (if any) 
must be updated via manual editing the table 


*/