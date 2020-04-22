SELECT DISTINCT 
    `ClientName`, 
    `ClientID`, 
    `ReferralDateTime`, 
    `AllocatedHCPStartDate`, 
    (`AllocatedHCPStartDate` - `ReferralDateTime`  ) AS Days, 
    main.`AllocatedHCPName`
FROM main INNER JOIN tbl_ClinicianPD 
    ON `main`.`AllocatedHCPName` = `tbl_ClinicianPD`.`AllocatedHCPName`
WHERE main.`AllocatedHCPName` NOT IN
    (SELECT `AllocatedHCPName` FROM `tbl_Clinician` WHERE `isCons` = TRUE)
ORDER BY (`AllocatedHCPStartDate` - `ReferralDateTime`  ) DESC
;



/* Show waiting times for Real Clinican Allocation

name: qsel_Top_Waiting_RealClinicianPD
status: Visible


Note: This simply shows difference in days between the
original referral date and Real HCP allocation date

This excludes Consultant caseload, because that simply is the whole team's

*/