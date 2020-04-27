qsel_xAud_Longest_Waits_For_Assessment

SELECT main.ClientName,
       main.ClientID,
       main.ReferralDateTime,
       main.AllocatedHCPStartDate,
       DATEDIFF("m", main.ReferralDateTime, now()) AS MonthsToNow,
       main.AllocatedHCPName
FROM main
WHERE main.AllocatedHCPName IN ('Assessment (HLT) PD Waiting list',
                                'Allocation (HLT) PD Waiting list')
ORDER BY ReferralDateTime ASC ;

