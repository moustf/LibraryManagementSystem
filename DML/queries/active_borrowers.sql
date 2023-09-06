USE library_management_system;
GO

WITH active_borrowers_with_unreturned_books
AS (
	SELECT b.borrower_id,
		b.first_name,
		b.last_name,
		b.email,
		b.membership_date,
		SUM(IIF(l.date_returned IS NULL, 1, 0)) AS books_borrowed
	FROM borrower AS b
	INNER JOIN loan AS l ON b.borrower_id = l.borrower_id
	WHERE l.date_returned IS NULL
	GROUP BY b.borrower_id,
		b.first_name,
		b.last_name,
		b.email,
		b.membership_date
	HAVING SUM(IIF(l.date_returned IS NULL, 1, 0)) > 2
	)
SELECT borrower_id,
	first_name,
	last_name,
	email,
	membership_date,
	books_borrowed
FROM active_borrowers_with_unreturned_books;
