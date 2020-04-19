SELECT 
  SUM(SWITCH (tbl_Clinician.isTWLPD = TRUE, 1, TRUE, 0)) AS 'Count_PDTWLists', 
  SUM(SWITCH (tbl_Clinician.isRealPD = TRUE, 1, TRUE, 0)) AS 'Count_RealClinPD', 
  SUM(SWITCH (tbl_Clinician.isTWL = TRUE, 1, TRUE, 0)) AS 'Count_TWLists', 
  SUM(SWITCH (tbl_Clinician.isReal = TRUE, 1, TRUE, 0)) AS 'Count_RealClin'
FROM tbl_Clinician
;


/* Gives overview how many clinicians have been checked

name: qsel_CheckClinicianStatus 
Hidden

A service query that gives back results of check marks in clinican table
if less than 1 checkmark in isRealPD, isTWLPD, isTWL
then brings up a form to edit this


*/