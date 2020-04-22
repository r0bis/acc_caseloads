SELECT  
  MSysObjects.Type, 
  MSysObjects.Flags, 
  MSysObjects.Name
FROM MSysObjects
WHERE 1 = 1
  AND (((MSysObjects.Type) = 5) 
  AND ((MSysObjects.Flags) IN (72,64,24,16,96,104, 40, 32, 80, 88, 112,120, 8, 0128, 136, 56, 48)))
;

-- When pasting in Access, paste only the query; pasting also comments will generate errors

/* List QUERIES that are used in database 

name:   qsel_ListAccessQueries
status: Hidden


Types of objects:

|     Type    |           TypeDesc           |
|-------------|------------------------------|
| -2147352256 | Contains Attachment Data     |
|      -32768 | Form                         |
|      -32766 | Macro                        |
|      -32764 | Reports                      |
|      -32761 | Module                       |
|      -32758 | Users                        |
|      -32757 | Database Document            |
|      -32756 | Data Access Pages            |
|           0 | Select                       |
|           1 | Tables - Local Tables        |
|           2 | Access Object - Database     |
|           3 | Embedded Select Queries      |
|           4 | Table - Linked ODBC Tables   |
|           5 | Queries                      |
|           6 | Table - Linked Access Tables |
|           8 | SubDataSheets                |
|          16 | Crosstab                     |
|          32 | Delete                       |
|          48 | Update                       |
|          64 | Append                       |
|          80 | Make Table                   |
|         112 | Pass-Through                 |
|         128 | Union                        |
|         144 | DDL & SubDataSheets          |

*/

