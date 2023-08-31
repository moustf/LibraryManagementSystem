USE library_management_system;

GO

WITH active_borrowers_with_unreturned_books AS (
     SELECT
        b.borrower_id,
        first_name,
        last_name,
        email,
        CONVERT(NVARCHAR, membership_date, 9) AS membership_date,
        SUM(IIF(l.date_returned IS NULL, 1, 0)) AS books_borrowed
    FROM
        borrower AS b
    INNER JOIN
        loan AS l
    ON b.borrower_id = l.borrower_id
    WHERE
        l.date_returned IS null
    GROUP BY
        b.borrower_id, first_name, last_name, email, membership_date
    HAVING
        SUM(IIF(l.date_returned IS NULL, 1, 0)) > 2
)

SELECT
    borrower_id,
    first_name,
    last_name,
    email,
    membership_date,
    books_borrowed
FROM
    active_borrowers_with_unreturned_books;
