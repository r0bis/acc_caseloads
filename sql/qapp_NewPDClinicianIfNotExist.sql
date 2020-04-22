INSERT INTO tbl_ClinicianPD ( AllocatedHCPName )
SELECT DISTINCT AllocatedHCPName
FROM tbl_Clinician
WHERE 1 = 1
    AND tbl_Clinician.isRealPD = TRUE
    AND tbl_Clinician.AllocatedHCPName NOT IN (SELECT AllocatedHCPName FROM tbl_ClinicianPD)
;

-- When pasting in Access, paste only the query; pasting also comments will generate errors


/* This inserts into PD Clinicans table if not already there 

name: qapp_NewPDClinicianIfNotExist

This is executed through listUpdate() sub
meant for when the checklist for clinicans is updated

*/