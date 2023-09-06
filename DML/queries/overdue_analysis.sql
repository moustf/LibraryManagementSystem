USE library_management_system;
GO

SELECT bo.book_id,
	bo.title,
	bo.author,
	bo.isbn,
	bo.genre,
	bo.is_available,
	br.borrower_id,
	br.first_name,
	br.last_name,
	br.email,
	br.membership_date,
	DATEDIFF(DAY, due_date, GETDATE()) AS overdue_days
FROM loan AS l
INNER JOIN book AS bo ON l.book_id = bo.book_id
INNER JOIN borrower AS br ON l.borrower_id = br.borrower_id
WHERE DATEDIFF(DAY, due_date, GETDATE()) > 30;
