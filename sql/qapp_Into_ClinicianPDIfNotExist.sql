INSERT INTO tbl_ClinicianPD ( id, AllocatedHCPName)
  SELECT  tbl_Clinician.id, 
          tbl_Clinician.AllocatedHCPName
  FROM tbl_Clinician
  WHERE 1 = 1
    AND tbl_Clinician.isRealPD = TRUE
    AND tbl_Clinician.AllocatedHCPName NOT IN (SELECT AllocatedHCPName FROM tbl_ClinicianPD)
;

-- When pasting in Access, paste only the query; pasting also comments will generate errors

/* This updates PD clinican table tbl_Clinician

name:   qapp_Into_ClinicianIfNotExist
status: Hidden

Actually is in use - called upon closing Clinican Tick forms. The PD Clinician table
tbl_ClinicianPD is used in some reports!
(Not in use at the moment, because keeping separate PD clinican table not needed.)

General form:

INSERT INTO [Table B] ( [Item Number] )
SELECT [Table A].[Item Number]
FROM [Table A]
WHERE [Table A].[Item Number] NOT IN (SELECT [Item Number] FROM [Table B]);


*/