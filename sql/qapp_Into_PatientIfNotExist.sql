INSERT INTO tbl_Patient ( ClientID, ClientName, NHSNumber )
  SELECT DISTINCT main.ClientID, main.ClientName, main.NHSNumber
  FROM main
    WHERE 1 = 1
    AND main.ClientID NOT IN (SELECT ClientID FROM tbl_Patient)
;


-- When pasting in Access, paste only the query; pasting also comments will generate errors


/* Appends rows to tbl_patient if they did not have such patients before

Only trouble may be if there are patients with the same RiO number and different NHS number and name
Theoretically it should not happen because presumably RiO ID is checked thoroughly

*/