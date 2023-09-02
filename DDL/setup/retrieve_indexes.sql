Use library_management_system;
GO

SELECT CONCAT(SCHEMA_NAME(o.schema_id), '.', o.name)                                   AS [Table/View Name],
       i.name                                                                          AS [Index Name],
       SUBSTRING(key_column_names, 1, LEN(key_column_names) - 1)                       AS [Index Key Columns],
       ISNULL(SUBSTRING(included_column_names, 1, LEN(included_column_names) - 1), '') AS [Included Columns],
       CASE
           WHEN i.type = 1 THEN 'Clustered Index'
           WHEN i.type = 2 THEN 'Non-Clustered Index'
           WHEN i.type = 3 THEN 'XML Index'
           WHEN i.type = 4 THEN 'Spatial Index'
           WHEN i.type = 5 THEN 'Clustered Columnstore Index'
           WHEN i.type = 6 THEN 'Non-Clustered Columnstore Index'
           WHEN i.type = 7 THEN 'Non-Clustered Hash Index'
           END                                                                         AS [Index Type],
       IIF(i.is_unique = 1, 'Yes', 'No')                                               AS [Unique],
       CASE
           WHEN o.type = 'U' THEN 'Table'
           WHEN o.type = 'V' THEN 'View'
           END                                                                         AS [Object Type]
FROM sys.objects AS o
         INNER JOIN sys.indexes AS i
                    ON o.object_id = i.object_id
         CROSS APPLY (SELECT CONCAT(c.name, ', ')
                      FROM sys.index_columns AS ic
                               INNER JOIN sys.columns AS c
                                          ON ic.object_id = c.object_id AND ic.column_id = c.column_id
                      WHERE ic.object_id = o.object_id
                        AND ic.index_id = i.index_id
                        AND ic.is_included_column = 0
                      ORDER BY key_ordinal
                      FOR XML PATH ('')) AS A (key_column_names)
         CROSS APPLY (SELECT CONCAT(c.name, ', ')
                      FROM sys.index_columns AS ic
                               INNER JOIN sys.columns AS c
                                          ON ic.object_id = c.object_id AND ic.column_id = c.column_id
                      WHERE ic.object_id = o.object_id
                        AND ic.index_id = i.index_id
                        AND ic.is_included_column = 1
                      ORDER BY index_column_id
                      FOR XML PATH ('')) AS B (included_column_names)
WHERE o.is_ms_shipped <> 1
  AND i.index_id > 0
ORDER BY o.name, i.name;
