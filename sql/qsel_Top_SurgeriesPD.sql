SELECT 
    COUNT(`ClientID` ) AS CNT, 
    `Practice_Name` AS Surgery
FROM (
    SELECT DISTINCT  
        `Practice_Name`, 
        `ClientID` 
    FROM `main` INNER JOIN `tbl_TWListPD` 
    ON main.`AllocatedHCPName` = tbl_TWListPD.`AllocatedHCPName`
    )  AS 'SQRY'
GROUP BY Practice_Name
ORDER BY COUNT(`ClientID` ) DESC;



/* Top surgeries for patient count

name: qsel_Top_SurgeriesPD
status: Visible

Note that Access does not allow ORDER By on Alias CNT

*/