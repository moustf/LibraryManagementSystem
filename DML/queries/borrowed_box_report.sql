IF NOT EXISTS
    (SELECT 1
     FROM sys.procedures
     WHERE name = 'sp_BorrowedBooksReport')
    BEGIN
        EXEC('CREATE PROCEDURE sp_BorrowedBooksReport(
            @start_date NVARCHAR(10), @end_date NVARCHAR(10)
        )
        AS
        BEGIN
            SELECT b.borrower_id                         AS [Borrower Id],
                   first_name                            AS [First Name],
                   last_name                             AS [Last Name],
                   membership_date                          [Membership Date],
                   CONVERT(NVARCHAR, date_borrowed, 101) AS [Date Borrowed],
                   date_returned                         AS [Date Returned]
            FROM borrower AS b
                     INNER JOIN
                 loan AS l
                 ON b.borrower_id = l.borrower_id
            WHERE l.date_borrowed >= @start_date
              AND l.date_borrowed < @end_date;
        END;');
    END;

EXEC sp_BorrowedBooksReport '7/12/2023', '10/12/2023';
