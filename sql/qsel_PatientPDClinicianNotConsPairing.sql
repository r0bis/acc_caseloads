SELECT  tbl_Clinician.AllocatedHCPName, 
        main.ClientID, 
        tbl_Patient.ClientName, 
        tbl_Patient.notes
FROM (tbl_Clinician INNER JOIN main 
        ON tbl_Clinician.AllocatedHCPName = main.AllocatedHCPName) 
      INNER JOIN tbl_Patient ON main.ClientID = tbl_Patient.ClientID
      WHERE (((1)=1) 
        AND ((tbl_Clinician.isCons) = False) 
        AND ((tbl_Clinician.isRealPD)=True))
;


/*

name: qsel_PatientPDClinicianNotConsPairing
not-Hidden
cplx


This query is for the patient notes / RAG rating editing
When opened in form as Inconsistent Dynaset
It allows editing notes. 

Rest of fields are disabled for editing inthe form

Affected structures:

Doc Tables  qsel_PatientPDClinicianNotRKPairing   .Name 8
Qry qsel_PatientPDClinicianNotRKPairing           .Name 2
Frm fsub_ConsultantPatientSelection               .RecordSource 3
Frm fsub_ClinPatientList4Notes                    .RecordSource 3


*/