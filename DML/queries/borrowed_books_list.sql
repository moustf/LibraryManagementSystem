USE library_management_system;

GO

SELECT b.book_id                          AS Id,
       b.title                            AS Title,
       b.author                           AS Author,
       b.isbn                             AS ISBN,
       b.genre                            AS [Genre Type],
       b.shelf_location                   AS [Shelf Location],
       b.is_available                     AS [Is Available],
       CONVERT(NVARCHAR, b.created_at, 9) AS [Creation Date],
       CONVERT(NVARCHAR, b.updated_at, 9) AS [Updating Date]
FROM loan AS l
         INNER JOIN
     book AS b
     ON l.book_id = b.book_id;
