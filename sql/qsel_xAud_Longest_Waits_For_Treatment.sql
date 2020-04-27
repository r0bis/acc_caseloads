SELECT main.ClientName,
       main.ClientID,
       main.ReferralDateTime,
       main.AllocatedHCPStartDate,
       DATEDIFF("m", main.AllocatedHCPStartDate, now()) AS MonthsToNow,
       main.AllocatedHCPName
FROM main
INNER JOIN tbl_Clinician ON main.AllocatedHCPName = tbl_Clinician.AllocatedHCPName
WHERE 1=1
  AND tbl_Clinician.isTWLPD = TRUE
  AND main.AllocatedHCPName NOT IN ('Assessment (HLT) PD Waiting list',
                                    'Allocation (HLT) PD Waiting list')
ORDER BY main.AllocatedHCPStartDate ASC ;

