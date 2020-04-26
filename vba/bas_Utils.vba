Option Compare Database
Option Explicit

Public Sub deleteAllFromSensitiveTables()
'use WITH GREAT CARE
' REMOVES ALL INFO FROM MOST TABLES

Dim var As Variant
Dim sql As String

' lets export the persistent table information first

Call persistentTBLexport



For Each var In Array( _
                        "main", _
                        "Name AutoCorrect Log", _
                        "tbl_Clinician", _
                        "tbl_ClinicianPD", _
                        "tbl_Patient", _
                        "tbl_PatientPDClinicianPairing", _
                        "tbl_PatientPDTWLPairing", _
                        "tbl_PatientTWLPairing", _
                        "tbl_ConsultantCaseload" _
                        )

    '"ptsUnderPDUnderRKnotOtherClin", "ptsUnderPDRK",
    '"tbl_TWListPD" (WL-Names), "cnameID", "cases-test-2_ImportErrors",
   sql = "DELETE * FROM [" & var & "];"
   CurrentDb.Execute sql, dbFailOnError
   Debug.Print "Deleted from " & var
Next var

End Sub

Public Function exportTable(tName As String, Optional xSpec As String = "", Optional oPath As String = "") As Boolean

' function for exporting persistent tables
    exportTable = False
    Dim oFile As String
    
    If Len(xSpec) = 0 Then
        xSpec = "export_" & tName
        'MsgBox "No import specification. Check your code!"
        'Exit Function
    End If
    
    If Len(oPath) = 0 Then
        oPath = CurrentProject.Path & "\"
    End If
    
    oFile = oPath & tName & ".csv"
    
    DoCmd.TransferText acExportDelim, xSpec, tName, oFile, True
    exportTable = True
    
End Function
Public Function importTable(tName As String, Optional xSpec As String = "", Optional iPath As String = "") As Boolean

' function for importing a persistent tables
    importTable = False
    Dim iFile As String
    
    If Len(xSpec) = 0 Then
        xSpec = "import_" & tName
        'MsgBox "No import specification. Check your code!"
        'Exit Function
    End If
    
    
    If Len(iPath) = 0 Then
        iPath = CurrentProject.Path & "\"
    End If
    
    iFile = iPath & tName & ".csv"
    
    DoCmd.TransferText acImportDelim, xSpec, tName, iFile, True
    importTable = True
    
End Function



Sub runthis()
'just to run enumeration of controls
Dim srvar As String
srvar = "frm_Main"
    Call fEnumControls(srvar)
End Sub

Public Function fEnumControls(ByVal strfrmToEnum As String)
'prints out control's Type and Name
'will NOT enumerate controls within an embedded subform
Dim astrCtlName() As String
Dim i As Integer, intCnt As Integer
Dim frm As Form
'Un-Comment the next two lines for Access 95
'Const acPage = 124
'Const acTabCtl = 123
    'if form is closed, exit function
    If Not IsLoaded(strfrmToEnum) Then
        MsgBox "Form " & strfrmToEnum & " is probably closed!! " & _
            vbCrLf & "Please open it & try again.", vbCritical
        Exit Function
    End If

    Set frm = Forms(strfrmToEnum)
    'Count the number of controls
    intCnt = frm.Count
    
    'Initialize the array to hold control names
    ReDim astrCtlName(0 To intCnt - 1, 0 To 1)

    For i = 0 To intCnt - 1
        astrCtlName(i, 0) = frm(i).Name
        'Use ControlType to determine the Type of Control
        Select Case frm(i).ControlType
            Case acLabel: astrCtlName(i, 1) = "Label"
            Case acRectangle: astrCtlName(i, 1) = "Rectangle"
            Case acLine: astrCtlName(i, 1) = "Line"
            Case acImage: astrCtlName(i, 1) = "Image"
            Case acCommandButton: astrCtlName(i, 1) = "Command Button"
            Case acOptionButton: astrCtlName(i, 1) = "Option button"
            Case acCheckBox: astrCtlName(i, 1) = "Check box"
            Case acOptionGroup: astrCtlName(i, 1) = "Option group"
            Case acBoundObjectFrame: astrCtlName(i, 1) = "Bound object frame"
            Case acTextBox: astrCtlName(i, 1) = "Text Box"
            Case acListBox: astrCtlName(i, 1) = "List box"
            Case acComboBox: astrCtlName(i, 1) = "Combo box"
            Case acSubform: astrCtlName(i, 1) = "SubForm"
            Case acObjectFrame: astrCtlName(i, 1) = "Unbound object frame or chart"
            Case acPageBreak: astrCtlName(i, 1) = "Page break"
            Case acPage: astrCtlName(i, 1) = "Page"
            Case acCustomControl: astrCtlName(i, 1) = "ActiveX (custom) control"
            Case acToggleButton: astrCtlName(i, 1) = "Toggle Button"
            Case acTabCtl: astrCtlName(i, 1) = "Tab Control"
        End Select
    Next i
    
    'Print out the array in an orderly fashion
    Debug.Print "Control Name,", "Control Type"
    'Debug.Print "------------", "------------"
    For i = 0 To intCnt - 1
        Debug.Print astrCtlName(i, 0), ",", astrCtlName(i, 1)
    Next i
    Erase astrCtlName
End Function

Public Function IsLoaded(ByVal strName As String) As Boolean
    Dim oAccessObject As AccessObject
    On Error Resume Next
    Set oAccessObject = CurrentProject.AllForms(strName)
    If oAccessObject Is Nothing Then Exit Function
    If oAccessObject.IsLoaded Then
        If oAccessObject.CurrentView <> acCurViewDesign Then
            IsLoaded = True
        End If
    End If
End Function


Public Sub ShowTableFields()

Dim db As Database
Dim tdf As TableDef
Dim x As Integer

Set db = CurrentDb

For Each tdf In db.TableDefs
   If Left(tdf.Name, 4) <> "MSys" Then ' Don't enumerate the system tables
      For x = 0 To tdf.Fields.Count - 1
      Debug.Print tdf.Name & "','" & tdf.Fields(x).Name
      Next x
   End If
Next tdf
End Sub


Public Sub ShowUserRosterMultipleUsers()
    Dim cn As New ADODB.Connection
    Dim rs As New ADODB.Recordset
    Dim i, j As Long

Set cn = CurrentProject.Connection

' The user roster is exposed as a provider-specific schema rowset
    ' in the Jet 4.0 OLE DB provider.  You have to use a GUID to
    ' reference the schema, as provider-specific schemas are not
    ' listed in ADO's type library for schema rowsets

Set rs = cn.OpenSchema(adSchemaProviderSpecific, _
    , "{947bb102-5d43-11d1-bdbf-00c04fb92675}")

'Output the list of all users in the current database.

Debug.Print rs.Fields(0).Name, "", rs.Fields(1).Name, _
    "", rs.Fields(2).Name, rs.Fields(3).Name

While Not rs.EOF
        Debug.Print rs.Fields(0), rs.Fields(1), _
        rs.Fields(2), rs.Fields(3)
        rs.MoveNext
    Wend

End Sub

