SELECT 
      main.ClientID, 
      main.ClientName, 
      main.AllocatedHCPName, 
      main.Practice_Name
FROM main
WHERE (((main.ClientName) Like "*" & [Name] & "*"))
;





/* Which clinicians is this patient associated to

finds patient(s) on partial name match and shows what clinicans and TW-Lists the patient belongs to.

name: qsel_Which_Clinican_Has_this_Patient
status: Visible

parametric query - via [Name]

*/