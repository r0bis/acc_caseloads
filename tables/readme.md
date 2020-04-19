# List of tables in the database

|              Name             |        notes        | persist |
|-------------------------------|---------------------|---------|
| main                          | main data,          | N       |
| tbl_Clinician                 | uniq clinicians     | Y       |
| tbl_ClinicianPD               | uniq PD clinicans   | Y       |
| tbl_ConsultantCaseload        | pts `with` Cons     | N       |
| tbl_DataDate                  | last import file dt | Y       |
| tbl_Patient                   | uniq patients       | Y       |
| tbl_PatientPDClinicianPairing | pts-PDClinicians    | N       |
| tbl_PatientPDTWLPairing       | pts-PDTW-Lists      | N       |
| tbl_PatientTWLPairing         | pts-AllTW-Lists     | N       |
| tbl_TWListPD                  | TW-Lists for PD     | Y       |


# Some incomplete notes regarding tables in the database

To clear the tables of any potentially sensitive information use routine `Public Sub deleteAllFromSensitiveTables()` in `bas_Main` module. You should run it from code editor. 

## Table: main

**Transient:** This is where newly imported data end up in. At the start of import the table is deleted and created anew with specification as in the query `qddl_Create_main`. Initially all the imported data were in this table _as-is_. That however bloated the database too much. This table also gets indexes (one of the few places where SQL is written in VBA) after the data import has happened in the main routine `mainPrepRun()`.

### Temporary table: main_new_import 

This is the table created in import specification `main_new_importing` - it exists for a very short while, but for that short while it initially exists alongside the `main` table from the previous data cycle. Then `main` is deleted and created anew, the necessary data selected into the new `main` and then `main_new_import` is deleted. This system decreased the database size from 20 MB to 3.6 MB.

## Table: tbl_Clinician (and it's Flags)

**Persistent:** Master list of all clinicians, including Treatment Waiting Lists (aka. Dummy clinicians). Allows to mark who is real clinician and what is TWL. Updated if new entries found in each import (watch for message). No deletions - except if one decides to delete manually from the table.

### Boolean Flags 

The form `Relevant Clinicians` is key in deciding who is in the team - real clinicians and treatment-waiting lists. The check-boxes allow to select PD pathway real clinicians (`isRealPD`) and treatment-waiting lists (`isTWLPD`). Similar check-boxes exist for more general usage if necessary (`isReal` and `isTWL`) but their functionality is not implemented at the moment. Those are here in case another team might want to implement this system. 

Upon closing this form there are 8 queries run to delete and insert changed records in PD clinician and TWL tables and to update relevant pairings as well. However this form - the check-boxes do not need to be used often - it is quite rare that a clinician leaves or enters the team and even more rare that a T-W List (a _dummy_ clinician) is created. During everyday work this form does not need to be touched at all.  

The `isCons` check-box field is important, because the consultant caseload is all the team patients, therefore processing consultant's patients is a bit different. This check-box allows to manage this. There should not be many - probably only one in the team who has this status and the key reason for it is that all patients are under consultant caseload - this is not the case with any other clinician.  

## Table: tbl_ClinicianPD

**Persistent:** Only real clinicians with PD pathway. Initially dubious if this was needed - the information already exists in tbl_Clinician. But it serves as basis for some reports. Needs to be updated every time when `Relevant Clinicians` check-boxes form is closed (_on-close-form_). Generated from check marks `isRealPD` field in Clinicians table `(tbl_Clinican.isRealPD = TRUE)`. 


## Table: tbl_ConsultantCaseload

**Transient:** On every import it is deleted and recreated anew. It contains data from the new import file where AllocatedHCP is the consultant (i.e. has been marked with check-box `isCons` clinicians table `tbl_Clinican`). However reality is that the consultant has not seen all people that are formally put under their caseload and in addition some patients that the consultant sees are not marked as such on RiO. Therefore the actual consultant caseload is managed through a check-box in the persistent `tbl_Patient`. Having the transient `tbl_ConsultantCaseload` is useful however - it can show the difference between the imaginary and the actual caseload, if we put these together e.g. via LEFT JOIN.

## Table: tbl_DataDate

**Persistent:** Contains the latest import date. Could also be hidden, if need be. It contains one record with ID of `1` and that record is updated every time the data import process is run. The date is taken from the createdDate of the csv file - usually that would be when the SSRS export happens. Of course - if that file is copied elsewhere then that will be the date, so there are no guarantees this date will be correct, however this is a reasonable way of dating the report without user intervention. 

It is necessary to instruct users to always save the SSRS report to where they know it is and then use that particular file for import. If the csv file is not in the default place (`..\data\caseload_data.csv`), then user is presented with the file browsing dialog box so that they can select the correct file.

## Table: tbl_Patient

**Persistent:** Master list of unique patients accumulated with each import. Place for marking those really on consultant caseload with check mark `isRealCons`. Only consultant is supposed to access to the form for editing with that check-box enabled (it is achieved via a transparent button on the main form right below `your z:`). 

Place for `notes` for RAG reports (MAX: 255 char). That is accessed either via `Clinician RAG-ing` button - where one selects their name in the combo box and enters RAG text, or in the case of Consultant clicking a secret button under the word `"data"`. 

## Table: tbl_PatientPDClinicianPairing

**Transient:** For real PD clinicians: contains DISTINCT `ClientID`, `ClientName`, `AllocatedHCPName` - the table is always emptied at each import and then populated by calling the query `qmak_PatientPDClinicianPairing`. 


## Table: tbl_PatientPDTWLPairing

**Transient:** For Treatment-Waiting List (TWL) 'clinicians': contains DISTINCT `ClientID`, `ClientName`, `AllocatedHCPName` - the table is always emptied at each import and then populated by calling the query `qmak_PatientPDTWLPairing`. 


## Table: tbl_PatientTWLPairing   

**Transient:** Contains DISTINCT `ClientID`, `ClientName`, `AllocatedHCPName` - the table is always emptied at each import and then populated by calling the query `qmak_PatientTWLPairing`. It is meant for general use - in case one wanted to know all patients under all fake/TWL clinicians that have been marked in `tbl_Clinican` via `isTWL`.

## Table: tbl_TWListPD

**Persistent:** Contains the master list of TW Lists (aka Dummy Clinicians) specific for PD pathway. Generated from check marks `isTWLPD` field in Clinicians table `(tbl_Clinican.isTWLPD = TRUE)`. It contains very useful descriptions of what the TWL/dummy entries mean in the notes. Because these entities change very rarely, update to notes is performed by directly editing the table.