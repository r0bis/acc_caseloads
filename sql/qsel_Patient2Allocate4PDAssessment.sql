SELECT main.ClientName, main.ClientID, main.AllocatedHCPName
FROM main
WHERE (((main.AllocatedHCPName)="Allocation (HLT) PD Waiting list"))
;


-- When pasting in Access, paste only the query; pasting also comments will generate errors

/* Select patients awaiting allocation


name:   qsel_Patient2Allocate4PDAssessment
status: Hidden

Used in subreport rsub_Patient4DPAssessmentAllocation:

Doc Tables  qsel_Patient2Allocate4PDAssessment    .Name 8
Qry qsel_Patient2Allocate4PDAssessment            .Name 2
Rpt rsub_Patient4DPAssessmentAllocation           .RecordSource 4


*/