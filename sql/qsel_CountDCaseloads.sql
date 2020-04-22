SELECT  main.AllocatedHCPName AS TWList, 
        Count(main.ClientID) AS Nr, 
        tbl_TWListPD.notes AS Explanation
FROM main INNER JOIN tbl_TWListPD 
        ON main.AllocatedHCPName = tbl_TWListPD.AllocatedHCPName
GROUP BY main.AllocatedHCPName, tbl_TWListPD.notes
ORDER BY Count(main.ClientID) DESC
;

-- When pasting in Access, paste only the query; pasting also comments will generate errors

/* List TW-List caseloads by count descending 

name:   qsel_CountDCaseloads
status: Hidden, old

Overview of Treatment and Waiting List Caseloads
With explanation of caseloads


*/

