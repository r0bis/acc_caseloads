SELECT  tbl_Patient.ClientID, 
        tbl_Patient.ClientName, 
        tbl_Patient.notes
FROM tbl_Patient
WHERE (((tbl_Patient.notes) Like 'red*' 
          OR (tbl_Patient.notes) Like 'amb*' 
          OR (tbl_Patient.notes) Like 'gree*'))
ORDER BY 
  IIF(tbl_Patient.notes Like 'red*',"1", 
    IIF(tbl_Patient.notes Like 'gree*',"3",
      IIF(tbl_Patient.notes Like 'amb*',"2","no status")));


/* Select RAG ratings with full notes

name: qsel_RAG_notes_Local_PD
status: Visible

This is RAG rating from where clinicians have entered brief notes

*/