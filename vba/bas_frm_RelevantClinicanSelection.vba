Option Compare Database

Private Sub Form_Close()
    'each time you use CurrentDb it is a new instance!
    Dim lngRowsAffected As Long
    Dim db As Database
    Set db = CurrentDb
    
    With db
        db.Execute "qdel_OldPDClinician", dbFailOnError
        lngRowsAffected = db.RecordsAffected
        Debug.Print "Deleted  " & lngRowsAffected & " from tbl_ClinicianPD"
        db.Execute "qapp_Into_ClinicianPDIfNotExist", dbFailOnError
        lngRowsAffected = db.RecordsAffected
        Debug.Print "Inserted  " & lngRowsAffected & " into tbl_ClinicianPD"
        
        db.Execute "qdel_OldPDTWList", dbFailOnError
        lngRowsAffected = db.RecordsAffected
        Debug.Print "Deleted  " & lngRowsAffected & " from tbl_TWLPD"
        db.Execute "qapp_Into_TWListPDIfNotExist", dbFailOnError
        lngRowsAffected = db.RecordsAffected
        Debug.Print "Inserted  " & lngRowsAffected & " into tbl_TWListPD"
        
        db.Execute "qdel_OldPatientPDClinicianPairing", dbFailOnError
        lngRowsAffected = db.RecordsAffected
        Debug.Print "Deleted  " & lngRowsAffected & " from tbl_PatientPDClinicianPairing"
        db.Execute "qapp_NewPatientPDClinPairing", dbFailOnError
        lngRowsAffected = db.RecordsAffected
        Debug.Print "Inserted  " & lngRowsAffected & " into tbl_PatientPDClincianPairing"
        
        db.Execute "qdel_OldPatientPDTWLPairing", dbFailOnError
        lngRowsAffected = db.RecordsAffected
        Debug.Print "Deleted  " & lngRowsAffected & " from tbl_PatientPDTWLPairing"
        db.Execute "qapp_NewPatientPDTWLPairing", dbFailOnError
        lngRowsAffected = db.RecordsAffected
        Debug.Print "Inserted  " & lngRowsAffected & " into tbl_PatientPDTWLPairing"
        
        
    End With
    
    Set db = Nothing
End Sub
