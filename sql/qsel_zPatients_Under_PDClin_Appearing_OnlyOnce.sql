SELECT  main.ClientID, 
        main.ClientName, 
        main.AllocatedHCPName
FROM main INNER JOIN tbl_Clinician 
      ON main.AllocatedHCPName = tbl_Clinician.AllocatedHCPName
  WHERE TBL_CLINICIAN.isRealPD = TRUE 
  AND ClientID IN (SELECT ClientID FROM main
                    GROUP BY ClientID 
                    HAVING COUNT(*) = 1)
  ;


/*

name: qsel_zPatients_Under_PDClin_Appearing_OnlyOnce
status: Visible, cplx

has 'z' in name so that gets sorted towards the end of the list

the inner query returns those patients that appear n = 1 times in main

*/
