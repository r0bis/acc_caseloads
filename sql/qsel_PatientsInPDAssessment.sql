SELECT main.ClientName, main.ClientID, main.AllocatedHCPName
FROM main
WHERE (((main.AllocatedHCPName)="Assessment (HLT) PD Treatment"))
;



-- When pasting in Access, paste only the query; pasting also comments will generate errors

/* Provides data for subreport PD patients undergoing assessment


name: qsel_PatientsInPDAssessment

Affected: 

Doc Tables  qsel_PatientsInPDAssessment   .Name 8
Qry qsel_PatientsInPDAssessment           .Name 2
Rpt rsub_PatientInDPAssesment             .RecordSource 4


*/