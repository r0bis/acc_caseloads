SELECT DISTINCT 
      main.ClientName, 
      main.ClientID, 
      main.ReferralDateTime, 
      main.AllocatedHCPStartDate, 
      (main.AllocatedHCPStartDate - main.ReferralDateTime  ) AS Days, 
      main.AllocatedHCPName
FROM main INNER JOIN tbl_ClinicianPD 
    ON main.AllocatedHCPName = tbl_ClinicianPD.AllocatedHCPName
WHERE main.AllocatedHCPName NOT IN 
      (SELECT AllocatedHCPName FROM tbl_Clinician WHERE isCons = TRUE)
ORDER BY (AllocatedHCPStartDate - ReferralDateTime ) DESC
;



/* Supposedly shows longest wait times in days for real clinican allocation

name: qsel_zTop_Waiting_RealClinician_PD_exp
status: Visible



*/