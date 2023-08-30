IF NOT EXISTS
    (SELECT 1
     FROM sys.procedures
     WHERE name = 'sp_BorrowersWithOverdueBooks')
    BEGIN
        EXEC ('CREATE PROCEDURE sp_BorrowersWithOverdueBooks
              AS
              BEGIN
                  SELECT loan_id,
                         b.borrower_id,
                         first_name,
                         last_name,
                         email,
                         membership_date
                  INTO #overdue_borrower_books
                  FROM borrower AS b
                           INNER JOIN
                       loan AS l
                       ON b.borrower_id = l.borrower_id
                  WHERE DATEPART(DAY, GETDATE()) - DATEPART(DAY, l.due_date) > 0;

                  SELECT CONCAT(obb.first_name, SPACE(1), obb.last_name) AS [Borrower Name],
                         obb.email,
                         obb.membership_date                        AS [Membership Date],
                         b.title                                    AS Title,
                         b.author                                   AS Author,
                         b.isbn                                     AS ISBN,
                         b.genre                                    AS Genre,
                         b.is_available                             AS [Is Available]
                  FROM #overdue_borrower_books AS obb
                           INNER JOIN
                       loan AS l
                       ON obb.loan_id = l.loan_id
                           INNER JOIN
                       book AS b
                       ON l.book_id = b.book_id;
              END;');
    END;

EXEC sp_BorrowersWithOverdueBooks;
