SELECT main.TeamName, COUNT ( DISTINCT ClientID)
FROM main INNER JOIN tbl_TWListPD
    ON main.AllocatedHCPName = tbl_TWListPD.AllocatedHCPName
;


SELECT TeamName, COUNT(ClientID) FROM
(SELECT DISTINCT  TeamName, ClientID FROM main)
GROUP BY TeamName
;



/* This selects records for report 


name:   qsel_Patient2Allocate4PDAssessment
status: Hidden


We want to select How many PD patients are under PD team 
from each locality team. To do that we have the Main table, however 
for some patients there are up to 6 entries. We could then
  - select unique pairings of LocTeams and ClientIDs
  - then see which of these exist in PDClin-and-PDTWL-pairings 

As a side note we should be able to compare clinician vs TWL pairings

*/