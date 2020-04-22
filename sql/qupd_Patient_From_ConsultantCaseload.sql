UPDATE tbl_Patient 
    SET isRealCons = TRUE
WHERE ClientID IN (
    SELECT ClientID FROM tbl_ConsultantCaseload WHERE isRealCons = TRUE )
;



/* Updates tbl_Patient from Consultant Caseload table


name:   qupd_Patient_From_ConsultantCaseload
status: Hidden

Normally never used, because the update goes the other way round - from Patient table to consultant

Also the status update could have been the one in jonined table

*/
