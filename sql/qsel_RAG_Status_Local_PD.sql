SELECT  tbl_Patient.ClientID, 
        tbl_Patient.ClientName, 
        IIF(tbl_Patient.notes Like 'red*',"1-RED", 
          IIF(tbl_Patient.notes Like 'gree*',"3-GREEN",
            IIF(tbl_Patient.notes Like 'amb*',"2-AMBER","no status"))) AS RAGStatus
FROM tbl_Patient
WHERE (((tbl_Patient.notes) Like 'red*' 
        OR (tbl_Patient.notes) Like 'amb*' 
        OR (tbl_Patient.notes) Like 'gree*'))
ORDER BY IIF(tbl_Patient.notes Like 'red*',"1-RED", 
            IIF(tbl_Patient.notes Like 'gree*',"3-GREEN", 
              IIF(tbl_Patient.notes Like 'amb*',"2-AMBER","no status")))
;



/* This is the same as similar series, but only gives RAG status

name: qsel_RAG_Status_Local_PD
status: Visible


*/