INSERT INTO tbl_TWListPD ( id, AllocatedHCPName )
SELECT  tbl_Clinician.id, 
        tbl_Clinician.AllocatedHCPName
FROM tbl_Clinician
WHERE 1 = 1
  AND tbl_Clinician.isTWLPD = TRUE
  AND tbl_Clinician.AllocatedHCPName NOT IN (SELECT AllocatedHCPName FROM tbl_TWListPD)
;


-- When pasting in Access, paste only the query; pasting also comments will generate errors


/* Updates PD service TW-Lists (a.k.a. Dummy clinicians)

name: qapp_Into_TWListPDIfNotExist


This adds new TWList in case if a new one is created on RiO
This would have to be checked in tbl_Clinician 
as isTWList = TRUE 

Probably updates only very rarely

*/