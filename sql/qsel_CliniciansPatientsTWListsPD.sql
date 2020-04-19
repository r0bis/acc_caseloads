SELECT 
    qAlloc001.AllocatedHCPName, 
    qAlloc001.ClientName, 
    qAlloc001.ClientID, 
    qAlloc002.AllocatedHCPName
FROM qAlloc001 
  LEFT JOIN qAlloc002 
    ON qAlloc001.ClientName = qAlloc002.ClientName
ORDER BY qAlloc001.ClientName
;


-- When pasting in Access, paste only the query; pasting also comments will generate errors


/* One of most important queries used in subreport for PD Clinican Caseloads

name: qsel_CliniciansPatientsTWListsPD

It gives pairings of clinicians, their patients and TW Lists
Therefore each clinican can know what TW-lists their patients are under

Affected structures are:

Doc Tables  qsel_CliniciansPatientsTWListsPD    .Name 8
Qry qsel_CliniciansPatientsTWListsPD            .Name 2
Rpt rsub_ClinicianCaseloadsPD                   .RecordSource 4



*/