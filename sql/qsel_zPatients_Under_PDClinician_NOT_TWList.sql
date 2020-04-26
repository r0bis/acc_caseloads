SELECT main.ClientID, main.ClientName, main.AllocatedHCPName
FROM main INNER JOIN tbl_Clinician ON main.AllocatedHCPName = tbl_Clinician.AllocatedHCPName
WHERE tbl_Clinician.isRealPD = TRUE
     AND
     main.ClientID NOT IN (SELECT main.ClientID
                                           FROM main INNER JOIN tbl_Clinician
                                           ON main.AllocatedHCPName = tbl_Clinician.AllocatedHCPName
                                           WHERE tbl_Clinician.isTWLPD = TRUE
                                           )
     AND
     main.ClientID NOT IN (SELECT main.ClientID
                                           FROM main INNER JOIN tbl_Clinician
                                           ON main.AllocatedHCPName = tbl_Clinician.AllocatedHCPName
                                           WHERE tbl_Clinician.isTWL = TRUE
                                           )
     AND
     main.ClientID NOT IN (SELECT main.ClientID
                                           FROM main INNER JOIN tbl_Clinician
                                           ON main.AllocatedHCPName = tbl_Clinician.AllocatedHCPName
                                           WHERE tbl_Clinician.isReal = TRUE
                                           )
ORDER BY main.ClientName
;


/* Identifies clinicians that have patients for PD 
   who are not under PD Treatment-Waiting List

name: qsel_zPatients_Under_PDClinician_NOT_TWList
status: Visible

-- defines PD caseload as:
-- those under either PD Clinican or PD TWList
-- not under other TWLists (as would be with Theo's psychotherapy patients)
-- not under other clinicans (as would be with MAP patients)

-- query below is same but explained with comments - not for pasting into Access

*/

SELECT main.ClientID, main.ClientName, main.AllocatedHCPName
FROM main INNER JOIN tbl_Clinician ON main.AllocatedHCPName = tbl_Clinician.AllocatedHCPName
WHERE tbl_Clinician.isRealPD = TRUE
   AND
   main.ClientID NOT IN (SELECT main.ClientID
                                         FROM main INNER JOIN tbl_Clinician
                                         ON main.AllocatedHCPName = tbl_Clinician.AllocatedHCPName
                                         WHERE tbl_Clinician.isTWLPD = TRUE
                                         ) -- filters out those under TWListPD
   AND
   main.ClientID NOT IN (SELECT main.ClientID
                                         FROM main INNER JOIN tbl_Clinician
                                         ON main.AllocatedHCPName = tbl_Clinician.AllocatedHCPName
                                         WHERE tbl_Clinician.isTWL = TRUE
                                         ) -- filters out those under Other TWLists
   AND
   main.ClientID NOT IN (SELECT main.ClientID
                                         FROM main INNER JOIN tbl_Clinician
                                         ON main.AllocatedHCPName = tbl_Clinician.AllocatedHCPName
                                         WHERE tbl_Clinician.isReal = TRUE
                                         ) -- filters out those under Other Clinicans
ORDER BY main.ClientName
;

/*


*/