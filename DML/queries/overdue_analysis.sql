USE library_management_system;

GO

SELECT bo.book_id,
       title,
       author,
       isbn,
       genre,
       is_available,
       br.borrower_id,
       first_name,
       last_name,
       email,
       CONVERT(VARCHAR, membership_date, 101) AS membership_date,
       DATEDIFF(DAY, due_date, GETDATE())     AS overdue_days
FROM loan AS l
         INNER JOIN
     book AS bo
     ON l.book_id = bo.book_id
         INNER JOIN
     borrower AS br
     ON l.borrower_id = br.borrower_id
WHERE DATEDIFF(DAY, due_date, GETDATE()) > 30;
