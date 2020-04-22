SELECT DISTINCT 
    `ClientName`, 
    `ClientID`, 
    `ReferralDateTime`, 
    `AllocatedHCPStartDate`, 
    (`AllocatedHCPStartDate` - `ReferralDateTime`  ) AS Days, 
    main.`AllocatedHCPName`
FROM main INNER JOIN tbl_TWListPD 
    ON `main`.`AllocatedHCPName` = `tbl_TWListPD`.`AllocatedHCPName`
ORDER BY (`AllocatedHCPStartDate` - `ReferralDateTime`  ) DESC
;



/* Show waiting times for Real Clinican Allocation

name: qsel_Top_Waiting_TWListPD
status: Visible


Note: This simply shows difference in days between the
original referral date and Treatment-Waiting List allocation date


*/