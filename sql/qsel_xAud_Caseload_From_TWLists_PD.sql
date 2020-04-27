SELECT COUNT(ClientID)
FROM
  (SELECT DISTINCT ClientID
   FROM tbl_PatientPDTWL_Pairing)
;

/* Counts how many patients appear in 2 or more TWLists for PD

name: qsel_xAud_Caseload_From_TWLists_PD
status: visible


*/