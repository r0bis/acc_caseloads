SELECT DISTINCT 
      main.ClientName, 
      main.ClientID, 
      main.ReferralDateTime, 
      main.AllocatedHCPStartDate, 
      (main.AllocatedHCPStartDate - main.ReferralDateTime  ) AS Days, 
      main.AllocatedHCPName
FROM main INNER JOIN tbl_TWListPD 
      ON main.AllocatedHCPName = tbl_TWListPD.AllocatedHCPName
ORDER BY (AllocatedHCPStartDate - ReferralDateTime  ) DESC
;




/* Shows time from referral date till TWL allocation

name: qsel_zTop_Waiting_TWList_PD_exp
status: Visible, experimental


*/