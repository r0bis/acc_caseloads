SELECT main.ClientName, main.ClientID, main.AllocatedHCPName
FROM main
WHERE (((main.AllocatedHCPName)="Assessment (HLT) PD Waiting list"))
;


-- When pasting in Access, paste only the query; pasting also comments will generate errors


/* This is for subreport for patients allocated and waiting for the first contact

name:   qsel_PatientWaiting4PDAssessment
status: Hidden

Affected:

Doc Tables  qsel_PatientWaiting4PDAssessment    .Name 8
Qry qsel_PatientWaiting4PDAssessment            .Name 2
Rpt rsub_PatientWaiting4PDAssessment            .RecordSource 4


*/