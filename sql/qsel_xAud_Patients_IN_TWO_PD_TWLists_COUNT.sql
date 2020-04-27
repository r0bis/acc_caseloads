SELECT COUNT(ClientID) AS PatientsInTwoTreatments
FROM
  (SELECT DISTINCT ClientID
   FROM tbl_PatientPDTWLPairing
   WHERE (((tbl_PatientPDTWLPairing.[ClientID]) IN
             (SELECT ClientID
              FROM `tbl_PatientPDTWLPairing`
              GROUP BY ClientID HAVING COUNT(*) > 1)))) SQRY 
;

 /*

name: qsel_Patients_IN_TWO_PD_TWLists_COUNT
ststus: Visible

*/