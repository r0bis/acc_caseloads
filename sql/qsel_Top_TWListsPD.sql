SELECT 
    main.AllocatedHCPName AS TWList, 
    Count(main.ClientID) AS Nr, 
    tbl_TWListPD.notes AS Explanation
FROM main INNER JOIN tbl_TWListPD 
    ON main.AllocatedHCPName = tbl_TWListPD.AllocatedHCPName
GROUP BY main.AllocatedHCPName, tbl_TWListPD.notes
ORDER BY Count(main.ClientID) DESC
;



/* TW-Lists PD with patient count arrenged descending 

name: qsel_Top_TWListsPD
status: Visible


*/