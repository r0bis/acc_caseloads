SELECT 
    COUNT( `ClientID`) AS CNT, 
    IIF(`Diagnosis1Desc` IS NULL, "NO DIAGNOSIS", `Diagnosis1Desc`) AS Diagnosis
FROM main INNER JOIN tbl_TWListPD ON main.`AllocatedHCPName` = tbl_TWListPD.`AllocatedHCPName`
GROUP BY `Diagnosis1Desc`
ORDER BY COUNT( `ClientID`) DESC;


/* Top Diagnoses count for PD

name: qsel_Top_Diagnoses
status: Visible

Note IIF() as Access version of CASE statement

*/