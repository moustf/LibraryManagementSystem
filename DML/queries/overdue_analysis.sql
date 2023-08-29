SELECT
    book.book_id AS [Book ID],
    title AS Title,
    author AS Author,
    isbn AS ISBN,
    genre AS Genre,
    is_available AS [Is Available],
    borrower.borrower_id AS [Borrower Id],
    first_name AS [First Name],
    last_name AS [Last Name],
    email AS Email,
    CONVERT(VARCHAR, membership_date, 101) AS [Membership Date],
    DATEDIFF(DAY, due_date, GETDATE()) AS OverdueDays
FROM
    loan
INNER JOIN book
ON loan.book_id = book.book_id
INNER JOIN borrower
ON loan.borrower_id = borrower.borrower_id
WHERE
    DATEDIFF(DAY, due_date, GETDATE()) > 30;
