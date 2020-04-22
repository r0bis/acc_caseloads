Option Compare Database 'Use database order for string comparisons.
Option Explicit

Public Function mainPrepRun()
  Dim lngRowsAffectedImport As Long, lngRowsAffectedDate As Long
  Dim dbs As DAO.Database
  Dim sql As String, strClinCheckTroubleMessage As String
  Dim csvNewPath As String
  Dim tpath As String
  Dim csvPath As String
  Dim fCTime As Date
  Dim rst As DAO.Recordset, rstClinStatus As Recordset
  Dim testBool As Boolean, clinUpdOK As Boolean, patUpdOK As Boolean
  Dim PDTWLists As Integer, RealClinPD As Integer, TWLists As Integer, RealClin As Integer

  'csvPath = "Z:\data\caseload_data.csv" ' inital default path
  csvPath = CurrentProject.Path & "\..\data\caseload_data.csv"
  'csvPath = CurrentProject.Path & "\acc_caseloads\data\caseload_data.csv"
  Debug.Print TypeName(csvPath)
  tpath = Left(csvPath, 3)
  testBool = FolderExists(tpath)


  Set dbs = CurrentDb



  ' later store in separate table for latest import data
  'fCTime = GetCreateDate(csvPath)
  'sql = "UPDATE tbl_dataDate SET dataDate = # " & Format(fCTime, "dd/mm/yyyy hh:mm:ss") & " # WHERE id = 1;"
  'Debug.Print (sql)

  If FolderExists(Left(csvPath, 3)) Then
      If Not FileExists(csvPath) Then
          MsgBox "Default  data file not in place - that means non-existent " _
                  & csvPath & " )" & vbCrLf _
                  & "You should save the SSRS export file either on your peronal network drive Z: " _
                  & "in a folder named data. The filename should be caseload_data.csv" & vbCrLf _
                  & "Alternatively you can save the file in the data directory just above the access database file." & vbCrLf & vbCrLf _
                  & "You will now be able to choose where you saved the SSRS export file in CSV format."
          csvNewPath = getImportFilePath()
          If Len(csvNewPath) <= 1 Then
              MsgBox "No data file path selected, try clicking Prepare Data button again, selecting the correct file."
              Exit Function
          End If
          MsgBox "New file path is " & csvNewPath
          
          If (GetFileExt(csvNewPath) <> "csv") Then
              'Debug.Print (GetFileExt(csvNewPath))
              MsgBox "You need to select a CSV file"
              Exit Function
          End If
                  
              
          DoCmd.TransferText acImportDelim, "main_new_importing_dtime", "main_new_import", csvNewPath
          ' set time import happened
          fCTime = GetCreateDate(csvNewPath)
          sql = "UPDATE tbl_dataDate SET dataDate = # " & Format(fCTime, "dd/mm/yyyy hh:mm:ss") & " # WHERE id = 1;"
          dbs.Execute sql, dbFailOnError
          lngRowsAffectedDate = dbs.RecordsAffected
          ' MsgBox "Updated " & lngRowsAffectedDate & " DATE rows to " & fCTime
      Else
          ' create temporary table for new data import
          DoCmd.TransferText acImportDelim, "main_new_importing_dtime", "main_new_import", csvPath
          'DoCmd.RunSavedImportExport ("main_new_import")
          ' set time import happened
          fCTime = GetCreateDate(csvPath)
          Debug.Print (fCTime)
          sql = "UPDATE tbl_dataDate SET dataDate = # " & Format(fCTime, "dd/mm/yyyy hh:mm:ss") & " # WHERE id = 1;"
          dbs.Execute sql, dbFailOnError
          lngRowsAffectedDate = dbs.RecordsAffected
          ' MsgBox "Updated " & lngRowsAffectedDate & " DATE rows to " & fCTime
      End If
  Else
      
  MsgBox "No default data drive " & Left(csvPath, 3) & " "
  csvNewPath = getImportFilePath()
  If Len(csvNewPath) <= 1 Then
      MsgBox "No file path selected, try again, selecting the correct CSV file."
      Exit Function
  End If
  MsgBox "New path is " & csvNewPath
      
  If (GetFileExt(csvNewPath) <> "csv") Then
      'Debug.Print (GetFileExt(csvNewPath))
      MsgBox "You need to select a CSV file"
      Exit Function
  End If
      
  ' create temporary table for new data import
  DoCmd.TransferText acImportDelim, "main_new_importing_dtime", "main_new_import", csvNewPath

  ' set time the import happened - to be reset every time
  fCTime = GetCreateDate(csvNewPath)
  sql = "UPDATE tbl_DataDate SET dataDate = # " & Format(fCTime, "dd/mm/yyyy hh:mm:ss") & " # WHERE id = 1;"
  dbs.Execute sql, dbFailOnError
  lngRowsAffectedDate = dbs.RecordsAffected
  ' MsgBox "Updated " & lngRowsAffectedDate & " DATE rows to " & fCTime

  End If


  Set rst = dbs.OpenRecordset("main_new_import", dbOpenTable)
  lngRowsAffectedImport = rst.RecordCount
  If lngRowsAffectedImport <= 0 Then
      MsgBox "Because no data rows were imported, we know something went wrong with data format!" _
          & vbCrLf & "Therefore database has not been updated. Check your CSV file and try importing again!"
      Exit Function
  End If
  MsgBox "Imported " & lngRowsAffectedImport & " rows of data that were exported from " _
          & " SSRS system on " & Format(fCTime, "dd/mm/yyyy") & " ."
  Set rst = Nothing

  DeleteTableVBA ("main")

  If Not IsNull(DLookup("Name", "MSysObjects", "Name='main_new_import' And Type In (1,4,6)")) Then
      ' MsgBox "Table Exists - so new import table has been created"
      ' create main table with few fields and smaller field sizes
      dbs.Execute "qddl_Create_main", dbFailOnError
      ' populate main table from main_new_import
      dbs.Execute "qapp_Into_main", dbFailOnError
      ' cannot do simple indexes from create table in access, therefore do it now
      dbs.Execute "CREATE INDEX ClientIDIdx ON main (ClientID);", dbFailOnError
      dbs.Execute "CREATE INDEX ClientNameIdx ON main (ClientName);", dbFailOnError
      dbs.Execute "CREATE INDEX AllocatedHCPNameIdx ON main (AllocatedHCPName);", dbFailOnError
      dbs.Execute "CREATE INDEX NHSNumberIdx ON main (NHSNumber);", dbFailOnError

      ' delete import to save space; however if we switch off this line we can use all import data
      DeleteTableVBA ("main_new_import")
      'dbs.TableDefs("main_new_import").Name = "main"
      'MsgBox "Renamed imported table to main."
      'therefore "main_new_import" has disappeared - until next import is run
  End If

  ' now the main data are imported, time to update patients and clinicians
  clinUpdOK = appendInto("qapp_Into_ClinicianIfNotExist", "tbl_Clinician")
  patUpdOK = appendInto("qapp_Into_PatientIfNotExist", "tbl_Patient")
  ' next bit would be to update consultant caseload table - when


  ' before recreating TW-List pairing tables we need to make sure clinicians are
  ' properly classified - at least one checkbox in each PD boolean column
  ' field order in returnet 1 row recordset (according to the passed query) is:
  ' PDTWLists, RealClinPD, TWLists,  RealClin
  Set rstClinStatus = checkClinicianStatus("qsel_CheckClinicianStatus")
  If rstClinStatus.RecordCount = 1 Then
      PDTWLists = rstClinStatus.Fields(0).Value
      RealClinPD = rstClinStatus.Fields(1).Value
      TWLists = rstClinStatus.Fields(2).Value
  Else
      MsgBox "Problem with clinican status summary - check clinicians table"
      Exit Function
  End If

  Set rstClinStatus = Nothing

  If PDTWLists <= 0 Then strClinCheckTroubleMessage = "PD Treatment-Waiting Lists have no chekboxes isTWLPD marking" _
                                  & " those pseudo-clinicans (a.k.a. Dummies). " & vbCrLf
  If RealClinPD <= 0 Then strClinCheckTroubleMessage = strClinCheckTroubleMessage _
                                  & "PD Clinicans have no chekboxes isRealPD marking" _
                                  & " them to separate out from other clinicans. " & vbCrLf
  If TWLists <= 0 Then strClinCheckTroubleMessage = strClinCheckTroubleMessage _
                                  & "Other waiting lists have no chekboxes isTWL marking" _
                                  & " them to separate out from other clinicans. " & vbCrLf
  strClinCheckTroubleMessage = strClinCheckTroubleMessage & "Please check in the following table " _
                                  & "that pops up. Please check at least one in each relevant category."
  If PDTWLists = 0 Or TWLists = 0 Or RealClinPD = 0 Then
      DoCmd.OpenForm FormName:="frm_RelevantClinicianSelection", view:=acNormal, Datamode:=acFormEdit, windowmode:=acDialog
      'DoCmd.OpenForm "frm_RelevantClinicianSelection", , , , , acDialog
  End If

  Set rstClinStatus = checkClinicianStatus("qsel_CheckClinicianStatus")
  If rstClinStatus.RecordCount = 1 Then
      PDTWLists = rstClinStatus.Fields(0).Value
      RealClinPD = rstClinStatus.Fields(1).Value
      TWLists = rstClinStatus.Fields(2).Value
  Else
      MsgBox "Problem with clinican status summary even after you checked the boxes! " _
      & " check clinicians table again, the application will not work without this done properly!"
      Exit Function
  End If

  MsgBox "PD Clinican status: checked " & RealClinPD & vbCrLf & _
  "PD TW-List status: checked " & PDTWLists & vbCrLf & _
  "General TW-List status: checked " & TWLists

  ' AND to delete and repopulate Treatment / Waiting List tables
  recreateTWLTables
  ' AND updating newly imported ConsultantCaseload
  listConsUpdate

  MsgBox "New data import process completed successfully."


  Set dbs = Nothing

End Function

Public Function checkClinicianStatus(queryName As String) As Recordset

  Dim dbs As DAO.Database
  Dim rst As DAO.Recordset
  Dim i As Integer

  Set dbs = CurrentDb
  Set rst = dbs.OpenRecordset(queryName)

  Set checkClinicianStatus = rst

  Set rst = Nothing
  Set dbs = Nothing


End Function

Public Function getDataDate() As Date

  Dim dbs As DAO.Database
  Dim sql As String
  Dim rst As DAO.Recordset

  Set dbs = CurrentDb
  sql = "SELECT dataDate FROM tbl_dataDate WHERE id = 1"
  Set rst = dbs.OpenRecordset(sql)

  If Not (rst.EOF And rst.BOF) Then
    rst.MoveFirst
    Debug.Print rst(0).Name
    Debug.Print rst(0).Value
    getDataDate = rst(0).Value
    rst.MoveNext
    'get results using rs.Fields()
  Else
  End If
  Debug.Print getDataDate
  'Format (#17/04/2004#, "Long Date")
  'Result: 'April 17, 2004'

  Set rst = Nothing
  Set dbs = Nothing

End Function

Public Function GetFileExt(ByVal strFileWPath As String)

  On Error GoTo Error_Handler
   
      GetFileExt = Right(strFileWPath, Len(strFileWPath) - InStrRev(strFileWPath, "."))
   
Error_Handler_Exit:
      On Error Resume Next
      Exit Function
   
Error_Handler:
      MsgBox "The following error has occurred." & vbCrLf & vbCrLf & _
              "Error Number: " & Err.Number & vbCrLf & _
              "Error Source: GetFileExt" & vbCrLf & _
              "Error Description: " & Err.Description, _
              vbCritical, "An Error has Occurred!"
      Resume Error_Handler_Exit
End Function


Public Function renameMainTable()

  Dim dbs As DAO.Database
  Set dbs = CurrentDb

  DeleteTableVBA ("main")
  dbs.TableDefs("main_new_import").Name = "main"

  Set dbs = Nothing

End Function

Public Function FolderExists(strPath As String) As Boolean

    On Error Resume Next
    FolderExists = ((GetAttr(strPath) And vbDirectory) = vbDirectory)

End Function

Public Function FileExists(ByVal path_ As String) As Boolean
    FileExists = (Len(Dir(path_)) > 0)
End Function


Public Sub listConsUpdate()

    Dim lngRowsAffected As Long
    Dim db As Database
    Set db = CurrentDb
    
     With db
    
    ' update tbl_ConsultantCaseload from tbl_Patients - after setting patient
    ' status isRealCons in the form for Consultant Data editing
    
        db.Execute "qupd_ConsCaseload_isRealCons", dbFailOnError
        lngRowsAffected = db.RecordsAffected
        Debug.Print "Updated  " & lngRowsAffected & " in tbl_ConsultantCaseload"
    ' how about where status is set to false?
    ' OK the query sets status to whatever it is on Patient
    
    End With
End Sub


Public Sub listUpdate()
' update relevant tables after clinican checks have been done

    'each time you use CurrentDb it is a new instance!
    ' that is why you better declare it and use then
    Dim lngRowsAffected As Long
    Dim db As Database
    Set db = CurrentDb
    
    With db
    
    ' update tbl_ClinicianPD
        db.Execute "qdel_OldPDClinician", dbFailOnError
        lngRowsAffected = db.RecordsAffected
        Debug.Print "Deleted  " & lngRowsAffected & " from tbl_ClinicianPD"
        db.Execute "qapp_Into_ClinicianPDIfNotExist", dbFailOnError
        lngRowsAffected = db.RecordsAffected
        Debug.Print "Inserted  " & lngRowsAffected & " into tbl_ClinicianPD"
    ' update tbl_TWListPD
        db.Execute "qdel_OldPDTWList", dbFailOnError
        lngRowsAffected = db.RecordsAffected
        Debug.Print "Deleted  " & lngRowsAffected & " from tbl_TWLPD"
        db.Execute "qapp_Into_TWListPDIfNotExist", dbFailOnError
        lngRowsAffected = db.RecordsAffected
        Debug.Print "Inserted  " & lngRowsAffected & " into tbl_TWListPD"
    ' update tbl_PatientPDClinicianPairing
        db.Execute "qdel_OldPatientPDClinicianPairing", dbFailOnError
        lngRowsAffected = db.RecordsAffected
        Debug.Print "Deleted  " & lngRowsAffected & " from tbl_PatientPDClinicianPairing"
        db.Execute "qapp_NewPatientPDClinPairing", dbFailOnError
        lngRowsAffected = db.RecordsAffected
        Debug.Print "Inserted  " & lngRowsAffected & " into tbl_PatientPDClincianPairing"
    ' update tbl_PatientPDTWLPairing
        db.Execute "qdel_OldPatientPDTWLPairing", dbFailOnError
        lngRowsAffected = db.RecordsAffected
        Debug.Print "Deleted  " & lngRowsAffected & " from tbl_PatientPDTWLPairing"
        db.Execute "qapp_NewPatientPDTWLPairing", dbFailOnError
        lngRowsAffected = db.RecordsAffected
        Debug.Print "Inserted  " & lngRowsAffected & " into tbl_PatientPDTWLPairing"

                
    End With
    
    Set db = Nothing

End Sub

Public Sub persistentTBLimport()

' imports relevant tables from the access file directory
Dim var As Variant
Dim tName As String

For Each var In Array( _
                        "tbl_Clinician", _
                        "tbl_ClinicianPD", _
                        "tbl_Patient", _
                        "tbl_TWListPD" _
                        )
    tName = var
    Call importTable(tName)
    Debug.Print "Imported table " & var
Next var

End Sub

Public Sub persistentTBLexport()
' exports relevant tables in the access file directory
Dim var As Variant
Dim tName As String

For Each var In Array( _
                        "tbl_Clinician", _
                        "tbl_ClinicianPD", _
                        "tbl_Patient", _
                        "tbl_TWListPD" _
                        )
    tName = var
    Call exportTable(tName)
    'Debug.Print "Exported table " & var
Next var

End Sub



Public Function GetCreateDate(Path As String) As Date
  'Path = "D:\src\access\caseload_data.csv"
  Dim fso As Scripting.FileSystemObject
  Dim fsoFile As Scripting.File
  Set fso = New Scripting.FileSystemObject
  Set fsoFile = fso.GetFile(Path)
  GetCreateDate = fsoFile.DateCreated
  Debug.Print (GetCreateDate)
End Function


Public Function getImportFilePath()

  Dim f    As Object
  Dim chosenPath As String

  Set f = FileDialog(3)
  f.InitialFileName = "C:\"
  f.Filters.Add "text", "*.csv"

  If f.Show Then
     chosenPath = f.SelectedItems(1)
     'MsgBox "Chosen Path is  " & chosenPath
  End If

  getImportFilePath = chosenPath
  Set f = Nothing

End Function


Public Function recreateTWLTables()

  Dim dbs As DAO.Database
  Dim lngRowsAffectedTWL As Long, lngRowsAffectedPDTWL As Long
  Dim lngRowsAffectedPtClinPairing As Long, lngRowsAffectedConsCload As Long
  Dim lngRowsDeleted As Long

  Set dbs = CurrentDb

  ' Execute runs both saved queries and SQL strings
  ' quotes denote a saved query
  ' string you would have put in a variable

  dbs.Execute "qddl_Drop_PatientPDTWLPairing", dbFailOnError
  dbs.Execute "qddl_Drop_PatientTWLPairing", dbFailOnError
  dbs.Execute "qddl_Drop_PatientPDClinicianPairing", dbFailOnError
  dbs.Execute "qddl_Drop_ConsultantCaseload", dbFailOnError
  dbs.Execute "qddl_Create_ConsultantCaseload", dbFailOnError
  'MsgBox "Dropped and created"

  dbs.Execute "qmak_Into_PatientPDTWLPairing", dbFailOnError
  lngRowsAffectedPDTWL = dbs.RecordsAffected
  dbs.Execute "qmak_Into_PatientTWLPairing", dbFailOnError
  lngRowsAffectedTWL = dbs.RecordsAffected
  dbs.Execute "qmak_Into_PatientPDClinicianPairing", dbFailOnError
  lngRowsAffectedPtClinPairing = dbs.RecordsAffected
  dbs.Execute "qmak_Into_ConsultantCaseload", dbFailOnError
  lngRowsAffectedConsCload = dbs.RecordsAffected
  dbs.Execute "qupd_ConsCaseload_isRealCons", dbFailOnError
  'MsgBox "Created"

  If (lngRowsAffectedPDTWL + lngRowsAffectedPtClinPairing + lngRowsAffectedTWL) <= 0 Then
      MsgBox "Because no data rows were imported into clinican caseload tables, we know something went wrong with data file!" _
          & vbCrLf & "Check your CSV file and try importing again!"
      Exit Function
  End If

  MsgBox "PD TW-List table had " & lngRowsAffectedPDTWL & ", All TW-List table had " & lngRowsAffectedTWL _
      & " Consultant Caseload table had " & lngRowsAffectedConsCload _
      & " and PD CLinician Patient List table had " & lngRowsAffectedPtClinPairing & " rows written to them. "

  ' Get the number of rows affected by the Action query.
  ' You can display this to the user, store it in a table, or trigger an action
  ' if an unexpected number (e.g. 0 rows when you expect > 0).
  'lngRowsAffected = dbs.RecordsAffected
    
  'dbs.Execute "DELETE FROM tblMyTable WHERE Bad", dbFailOnError
  'lngRowsDeleted = dbs.RecordsAffected

End Function




Public Function fReturnRecordset() As DAO.Recordset
Dim MyDB As DAO.Database
Dim MyRS As DAO.Recordset
Dim strSQL As String
 
'From the Employees Table in the Northwind Database
strSQL = "Select * From Employees Order by Employees.LastName;"
 
Set MyDB = CurrentDb
Set MyRS = MyDB.OpenRecordset(strSQL, dbOpenSnapshot)
 
'Set the return value of the Function = a DAO Recordset
Set fReturnRecordset = MyRS

End Function


Function DeleteTableVBA(pMyTable As String)
' This procedure deletes specified tables and any
' existing relationships the tables are participating
' in.
' Used inappropriately, it will have a devastating
' effect on an application.
' For safety's sake, I've commented-out the actual
' commands (they follow debug.print in every case).
' Once you've examined the code and are ready to go,
' remove the comments.

Dim db      As Database
Dim td      As TableDef
Dim Test    As String
Dim tName   As String
Dim thisrel As Relation

    Set db = CurrentDb
    
    On Error Resume Next
    
    tName = pMyTable
    '**********
    'Does table tName exist?
    'If true, delete it;
    '**********
    
      Test = db.TableDefs(tName).Name
      If Err <> 3265 Then
         '**********
         ' Since the delete action will fail if the
         ' table is participating in any relation, first
         ' find and delete existing relations for table.
         '**********
         For Each thisrel In db.Relations
            If thisrel.Table = tName Or thisrel.ForeignTable = tName Then
               Debug.Print tName & " | " & thisrel.Name
               'db.Relations.Delete thisrel.Name
            End If
         Next thisrel
         '**********
         ' Now, we're ready to delete the table.
         '**********
         Debug.Print tName & " will be deleted"
         DoCmd.SetWarnings False
         DoCmd.DeleteObject acTable, tName
         DoCmd.SetWarnings True
      End If
    'End If
    db.Close
    Set db = Nothing
End Function

Public Function appendInto(qry2Run As String, tbl2Append As String) As Boolean

Dim dbs As DAO.Database
Dim lngRowsAffected As Long

Set dbs = CurrentDb

' Execute runs both saved queries and SQL strings
' quotes denote a saved query
' string you would have put in a variable?

dbs.Execute qry2Run, dbFailOnError
lngRowsAffected = dbs.RecordsAffected

If lngRowsAffected <= 0 Then
    MsgBox "No updates for " & tbl2Append & " were needed" _
        & vbCrLf & "All is well unless you expected import to happen!"
    appendInto = False
    Exit Function
End If

MsgBox tbl2Append & " table had " & lngRowsAffected & " new records appended."
appendInto = True


' Get the number of rows affected by the Action query.
' You can display this to the user, store it in a table, or trigger an action
' if an unexpected number (e.g. 0 rows when you expect > 0).
'lngRowsAffected = dbs.RecordsAffected
  
'dbs.Execute "DELETE FROM tblMyTable WHERE Bad", dbFailOnError
'lngRowsDeleted = dbs.RecordsAffected

End Function


Function ShowTableAttribs()
   Dim db As DAO.Database
   Dim T As DAO.TableDef
   Dim TType As String
   Dim tName As String
   Dim Attrib As String
   Dim i As Integer

Set db = CurrentDb()

For i = 0 To db.TableDefs.Count - 1
      Set T = db.TableDefs(i)
      tName = T.Name
      Attrib = (T.Attributes And dbSystemObject)
      MsgBox tName & IIf(Attrib, ": System Table", ": Not System" & _
        "Table")
   Next i

End Function


Public Function createTables()

    Dim db As DAO.Database
    Dim tdf As DAO.TableDef
    Dim rst As DAO.Recordset
    Dim fld As DAO.Field
    Dim strSQL As String

    strSQL = "Select SKUS from SKUS"
    Set db = CurrentDb()
    Set rst = db.OpenRecordset(strSQL)
    Set fld = rst.Fields("SKUS")

    'MsgBox fld.Value

    rst.MoveFirst
    Do While Not rst.EOF
        Set tdf = db.CreateTableDef(fld.Value)

        Set fld = tdf.CreateField("SKUS", dbText, 30)
        tdf.Fields.Append fld

        Set fld = tdf.CreateField("Count", dbInteger)
        tdf.Fields.Append fld

        db.TableDefs.Append tdf

        rst.MoveNext
    Loop

End Function

Public Function TableExists(TabName As String) As Boolean

    Dim db As DAO.Database
    Dim Sdummy As String

    Set db = CurrentDb()

    On Error Resume Next
    Sdummy = db.TableDefs(TabName).Name
    TableExists = (Err.Number = 0)

End Function








