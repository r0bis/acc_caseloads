INSERT INTO tbl_Clinician (AllocatedHCPName)
SELECT DISTINCT main.AllocatedHCPName
FROM main
  WHERE 1 = 1
  AND main.AllocatedHCPName NOT IN (SELECT AllocatedHCPName FROM tbl_Clinician)
;


-- When pasting in Access, paste only the query; pasting these comments will generate errors

/* Adds new clinicians to the persistent tbl_Clinician

Name = qapp_Into_ClinicianIfNotExist

We do not delete from tbl_Clinician - there are relatively few.
We select the ones we use for teams via checkboxes on Relevant_Clinician form


General form for such updates:

INSERT INTO [Table B] ( [Item Number] )
SELECT [Table A].[Item Number]
FROM [Table A]
WHERE [Table A].[Item Number] NOT IN (SELECT [Item Number] FROM [Table B]);


*/