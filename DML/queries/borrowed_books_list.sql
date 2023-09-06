USE library_management_system;
GO

SELECT b.book_id,
	b.title,
	b.author,
	b.isbn,
	b.genre,
	b.shelf_location,
	b.is_available,
	b.created_on,
	b.updated_on
FROM loan AS l
INNER JOIN book AS b ON l.book_id = b.book_id;
