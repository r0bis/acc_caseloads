SELECT  main.AllocatedHCPName AS TWList, 
        Count(main.ClientID) AS Nr, 
        tbl_TWListPD.notes AS Explanation
FROM main INNER JOIN tbl_TWListPD 
    ON main.AllocatedHCPName = tbl_TWListPD.AllocatedHCPName
GROUP BY main.AllocatedHCPName, tbl_TWListPD.notes
ORDER BY Count(main.ClientID) DESC
;



/* Shows distribution of patients in TWLists for PD

name: sel_Top_TWLists_PD
status: Visible

*/