SELECT  
      MSysObjects.type, 
      MSysObjects.Flags, 
      Count(*) AS ObjCount
FROM MSysObjects
GROUP BY MSysObjects.type, MSysObjects.Flags
ORDER BY  Count(*) DESC , 
          MSysObjects.type, 
          MSysObjects.Flags
;

-- When pasting in Access, paste only the query; pasting also comments will generate errors

/* List database Objects by count descending 

name = qsel_CountAccessObjects
is Hidden
Service query

We find the most used objects with their flags
Typically your tables and queries will top the list
Not very useful, but good to have access to


*/
