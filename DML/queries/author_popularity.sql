SELECT
    author AS Author,
    loan.book_id AS [Book Id],
    COUNT(loan.book_id) AS [Borrowing Count],
    DENSE_RANK() OVER(ORDER BY COUNT(loan.book_id) DESC) AS Rank
FROM
    book
INNER JOIN
    loan
ON book.book_id = loan.book_id
GROUP BY loan.book_id, author;
