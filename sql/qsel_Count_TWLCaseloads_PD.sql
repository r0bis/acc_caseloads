SELECT COUNT(ClientID) AS PtNumber,
       AllocatedHCPName
FROM
  (SELECT DISTINCT ClientID,
                   AllocatedHCPName
   FROM tbl_PatientPDTWLPairing) SQRY
GROUP BY AllocatedHCPName
ORDER BY COUNT(ClientID) DESC;


 -- When pasting in Access, paste only the query; pasting also comments will generate errors
 /* List TW-List caseloads by count descending

name:   qsel_CountDCaseloads
status: Hidden

persistent table

Overview of Treatment and Waiting List Caseloads
With explanation of caseloads


*/