Function FileExists(FileFullPath As String) As Boolean
  Dim value As Boolean
  value = False
  If Dir(FileFullPath) <> "" Then
    value = True
  End If
  FileExist = value
End Function

Public Sub cmd_exportPDF_Click()
 
  Dim fileName As String, fldrPath As String, filePath As String, dateTime As String
  Dim answer As Integer

  dateTime = format(now(),"yyyy-mm-dd_hh-nn-ss",2)
  fileName = "PDTeam_Caseloads" & dateTime 'filename for PDF file*
  fldrPath = CurrentProject.Path & "reports" 'folder path where pdf file will be saved *
  MkDirIfNotExists(CurrentProject.Path,"reports")	
  filePath = fldrPath & "\" & fileName & ".pdf"
 
  'check if file already exists
  If FileExists(filePath) Then
    answer = MsgBox(prompt:="PDF file already exists: " & vbNewLine & filePath & vbNewLine & vbNewLine & _
      "Would you like to replace existing file?", buttons:=vbYesNo, Title:="Existing PDF File")
    If answer = vbNo Then Exit Sub
  End If
 
  On Error GoTo invalidFolderPath
  DoCmd.OutputTo objecttype:=acOutputReport, objectName:=Me.Name, outputformat:=acFormatPDF, outputFile:=filePath
 
  MsgBox prompt:="PDF File exported to: " & vbNewLine & filePath, buttons:=vbInformation, Title:="Report Exported as PDF"
  Exit Sub
 
  invalidFolderPath:
  MsgBox prompt:="Error: Invalid folder path. Please update code.", buttons:=vbCritical
 
End Sub


Public Function MkDirIfNotExists(strDir As String, strPath As String)

Dim fso As New FileSystemObject
Dim path As String

'examples for what are the input arguments
'strDir = "Folder"
'strPath = "C:\"

path = strPath & strDir

If Not fso.FolderExists(path) Then

' doesn't exist, so create the folder
          fso.CreateFolder path

End If

End Function