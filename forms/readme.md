# List of active forms in the database

|               Name              |             Notes              |
|---------------------------------|--------------------------------|
| frm_ClinPatients4Notes          | Form to enter Clin RAG notes   |
| frm_ConsultantDataEntry         | To manage Consultant Caseload  |
| frm_main                        | Main form (startup)            |
| frm_RelevantClinicianSelection  | To check clinicians            |
| fsub_ClinPatientList4Notes      | subform 4 Clin RAG notes       |
| fsub_ConsultantPatientSelection | subform 2 manage Cons Caseload |

**NB!** Form modules are in vba section! Also this is the least updated readme file.


## Renaming database objects

Starting in Access 2000, Microsoft turned on a feature called Perform name AutoCorrect. This extremely handy little checkmark can automatically rename every instance and reference to your object in the database when you change the name in the Navigation Pane. Examples of supported objects include tables, queries, forms, reports, and fields.

Of course, there is a catch. The feature will NOT automatically change references to your object if it is in:

Visual Basic (VB) code
An SQL-specific query (a query written in SQL, like a UNION query)
In these situations you must manually rename the object again in your code. I find that the easiest way to check VB code is to open the editor (Alt+F11), initiate a Replace (Ctr+H), and set the find parameter to Current Project (all the code in the database). Search for the name of your old object and use Replace to change it to the new name.

## Dependency Checker

It doesn’t hurt to rename or even delete objects if you are sure that no other object is referencing them. But how can you tell? Access has a built-in feature called Object Dependencies.

Simply select the object that you want to change, then on the Database Tools tab click Object Dependencies. Now you can see if any objects will be affected if the current object is changed.

Again, the feature is not able to check VB code or SQL-only queries. Any objects of these type will be listed in the Checker under the **Ignored Objects** heading.

## Rename a Shortcut

Finally, if you can’t rename the object itself (specifically a table, query, form, or report), you can always create a shortcut and rename the shortcut to something that makes sense to you.

To create a shortcut, you need to setup custom grouping in the Navigation Pane, which I explain in this previous blog article. Then in your Custom Group if you right-click to rename an object you will see the option Rename Shortcut. Using this option will only rename the shortcut as it appears in your Custom Group, and the actual object name will remain the same.

Author: Ryan Donelan rdonelan@microknowledge.com

# Listings of controls on forms

Not up to date.  
Created using `fEnumControls()`

## Main Form

Name: frm_Main

|     Control Name     |  Control Type  |
|----------------------|----------------|
| cmd_openReportClins  | Command Button |
| cmd_btn_mkTables     | Command Button |
| cmd_renTables        | Command Button |
| cmd_RunImport        | Command Button |
| cmd_PrepData         | Command Button |
| Label6               | Label          |
| cmd_Quit             | Command Button |
| cmd_OpenReportAssmts | Command Button |

## Subform to Clinician caseload form

Name: qparametric_ptsUnderPDClin

|   Control Name   | Control Type |
|------------------|--------------|
| Auto_Logo0       | Image        |
| Auto_Header0     | Label        |
| ClientID         | Text Box     |
| Label0           | Label        |
| ClientName       | Text Box     |
| Label3           | Label        |
| AllocatedHCPName | Text Box     |
| Label6           | Label        |
| notes            | Text Box     |
| Label9           | Label        |

## Clinician caseload editing form

Name: frm_clinCloadPD01

|        Control Name        | Control Type |
|----------------------------|--------------|
| cbo_selPDClinName          | Combo box    |
| AllocatedHCPName_Label     | Label        |
| qparametric_ptsUnderPDClin | SubForm      |
| qparametric_ptsUnderPDClin | Label        |

