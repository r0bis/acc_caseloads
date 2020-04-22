INSERT INTO main (
                  TeamName,
                  CareCoordinator,
                  CPALevel,
                  AllocatedHCPName,
                  ClientID,
                  ClientName,
                  NHSNumber,
                  DateOfBirth,
                  Age,
                  Gender,
                  Practice_Name,
                  ReferralDateTime,
                  AllocatedHCPStartDate,
                  CarePlan_Date,
                  RiskAssessmentDate,
                  ProgNoteDate,
                  MostRecentContact,
                  ClusterAssessmentDate,
                  Crisis_Relapse_and_Contingency_Plan_Date,
                  CarePlan_Distributed_to_Client,
                  ClusterName,
                  Diagnosis1,
                  Diagnosis1Desc,
                  RAG_Rating
                  )
SELECT DISTINCT 
                  Team_Name AS TeamName,
                  CareCoordinator,
                  CPALevel,
                  AllocatedHCPName,
                  ClientID,
                  ClientName,
                  NHSNumber,
                  DateOfBirth,
                  Age,
                  Gender,
                  Practice_Name,
                  ReferralDateTime,
                  AllocatedHCPStartDate,
                  CarePlan_Date,
                  RiskAssessmentDate,
                  ProgNoteDate,
                  MostRecentContact,
                  ClusterAssessmentDate,
                  Crisis_Relapse_and_Contingency_Plan_Date,
                  CarePlan_Distributed_to_Client,
                  ClusterName,
                  Diagnosis1,
                  Diagnosis1Desc,
                  RAG_Rating 
FROM main_new_import
      WHERE ClientID IS NOT NULL
      AND ClientName IS NOT NULL
;

-- When pasting in Access, paste only the query; pasting also comments will generate errors


/* This makes main table compact 

name:    qapp_Into_main
status:  Hidden

previously in VBA we have created the main table and the next 
step will be to create indexes on fields

when this will be used for other tasks - such as auditing waiting times
we will need to alter main table definition and select more columns 
from the temporary table main_new_import

main_new_import is quickly dropped to keep database size low

ANOTHER VERSION:       WHERE ClientID & ClientName IS NOT NULL


*/