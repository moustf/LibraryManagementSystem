USE library_management_system;

GO

SELECT b.book_id,
       b.title,
       b.author,
       b.isbn,
       b.genre,
       b.shelf_location,
       b.is_available,
       CONVERT(NVARCHAR, b.created_at, 9) AS creation_date,
       CONVERT(NVARCHAR, b.updated_at, 9) AS updating_date
FROM loan AS l
         INNER JOIN
     book AS b
     ON l.book_id = b.book_id;
