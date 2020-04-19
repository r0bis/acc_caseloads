Option Compare Database
Option Explicit

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
