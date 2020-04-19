# SQL queries used in the project

Access query interface is quite difficult for readability, therefore all the main queries are stored here as separate `.sql` files. There are a few SQL statements that are written directly in VBA modules.

**NB!** There are a few queries in the database that are not described in the `SQL` files. They are all quite important though and I will describe each one of them in their SQL file. Queries that are of dubious use and probably could be deleted I have hidden.


## List of visible Queries

|                  Name                  | Type | Flags |
|----------------------------------------|------|-------|
| qAlloc001                              |    5 |     0 |
| qAlloc002                              |    5 |     0 |
| qapp_Into_ClinicianIfNotExist          |    5 |    64 |
| qapp_Into_ClinicianPDIfNotExist        |    5 |    64 |
| qapp_Into_ConsultantCaseloadIfNotExist |    5 |    72 |
| qapp_Into_main                         |    5 |    64 |
| qapp_Into_PatientIfNotExist            |    5 |    64 |
| qapp_Into_TWListPDIfNotExist           |    5 |    64 |
| qapp_NewPatientPDClinPairing           |    5 |    64 |
| qapp_NewPatientPDTWLPairing            |    5 |    64 |
| qapp_NewPDClinicianIfNotExist          |    5 |    64 |
| qddl_Create_ConsultantCaseload         |    5 |    96 |
| qddl_Create_main                       |    5 |    96 |
| qddl_Drop_ConsultantCaseload           |    5 |   104 |
| qddl_Drop_PatientPDClinicianPairing    |    5 |   104 |
| qddl_Drop_PatientPDTWLPairing          |    5 |   104 |
| qddl_Drop_PatientTWLPairing            |    5 |   104 |
| qddl_Drop_SomeTables                   |    5 |   104 |
| qdel_OldPatientPDClinicianPairing      |    5 |    32 |
| qdel_OldPatientPDTWLPairing            |    5 |    32 |
| qdel_OldPDClinician                    |    5 |    32 |
| qdel_OldPDTWList                       |    5 |    32 |
| qmak_Into_ConsultantCaseload           |    5 |    64 |
| qmak_Into_PatientPDClinicianPairing    |    5 |    88 |
| qmak_Into_PatientPDTWLPairing          |    5 |    88 |
| qmak_Into_PatientTWLPairing            |    5 |    88 |
| qsel_Clinicians4PatientsRPTMain        |    5 |     0 |
| qsel_CliniciansPatientsTWListsPD       |    5 |     0 |
| qsel_Count_TWLCaseloads                |    5 |     0 |
| qsel_Patient2Allocate4PDAssessment     |    5 |     0 |
| qsel_PatientPDClinician4Notes          |    5 |     0 |
| qsel_PatientsInPDAssessment            |    5 |     0 |
| qsel_PatientUnderConsultant            |    5 |     0 |
| qsel_PatientWaiting4PDAssessment       |    5 |     0 |
| qupd_ConsCaseload_isRealCons           |    5 |    48 |
