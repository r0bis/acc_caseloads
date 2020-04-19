UPDATE tbl_ConsultantCaseload 
    INNER JOIN tbl_Patient
    ON tbl_Patient.ClientID = tbl_ConsultantCaseload.ClientID
  SET tbl_ConsultantCaseload.isRealCons = TRUE
  WHERE tbl_Patient.isRealCons = TRUE
;

