Option Compare Database


Private Sub cmd_CheckClinicians_Click()
    DoCmd.OpenForm "frm_RelevantClinicianSelection", acNormal
End Sub

Private Sub cmd_OpenConsultantSelection_Click()
    DoCmd.OpenForm "frm_RelevantClinicianSelectionCons", acNormal
End Sub

Private Sub cmd_OpenReportAssmts_Click()
    DoCmd.OpenReport "rpt_AssessmentsOverview", acViewPreview
End Sub

Private Sub cmd_OpenReportClinRAGs_Click()
    DoCmd.OpenReport "rpt_ClinicianCaseloadsPDNotes", acViewPreview
End Sub

Private Sub cmd_openReportClinsTWLs_Click()
    DoCmd.OpenReport "rpt_ClinicianTWListCaseloads", acViewPreview
End Sub

Private Sub cmd_PrepData_Click()
    Call mainPrepRun
End Sub

Private Sub cmd_Quit_Click()
    DoCmd.Quit
End Sub

Private Sub cmd_RAGging_Click()
    DoCmd.OpenForm "frm_ClinPatients4Notes"
End Sub

Private Sub cmd_RunImport_Click()
    DoCmd.RunSavedImportExport ("main_new_import")
    
End Sub
