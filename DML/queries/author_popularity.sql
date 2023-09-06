USE library_management_system;
GO

SELECT b.author,
	l.book_id,
	COUNT(l.book_id) AS borrowing_count,
	DENSE_RANK() OVER (
		ORDER BY COUNT(l.book_id) DESC
		) AS rank
FROM book AS b
INNER JOIN loan AS l ON b.book_id = l.book_id
GROUP BY l.book_id,
	b.author
ORDER BY borrowing_count,
	rank DESC;
