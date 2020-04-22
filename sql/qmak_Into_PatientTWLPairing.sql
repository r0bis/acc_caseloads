SELECT DISTINCT 
    main.ClientID, 
    main.ClientName, 
    main.AllocatedHCPName 
INTO tbl_PatientTWLPairing
FROM tbl_Clinician INNER JOIN main 
    ON tbl_Clinician.AllocatedHCPName = main.AllocatedHCPName
WHERE (((tbl_Clinician.isTWL)=True))
;





/* Recreates Patient TWList pairing

name:   qmak_Into_PatientTWLPairing
status: Hidden


Inner Join filters TWL clinicians. There are 2 TWL fields in 
the clinicans table. 
1st is for any TW-list and 
2nd is for PD TW-lists. 

Query creates DISTINCT patient -- TWL pairings. 
It is called from VBA and the receiving table is deleted before this query is called.

*/