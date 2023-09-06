USE library_management_system;
GO

-- Creating a clustered index for the book id foreign key in the loan table.
IF NOT EXISTS (
		SELECT 1
		FROM sys.indexes AS i
		INNER JOIN sys.objects AS o ON i.object_id = o.object_id
		WHERE o.name = 'loan'
			AND i.name = 'ix_FKBookId'
		)
BEGIN
	CREATE NONCLUSTERED INDEX ix_FKBookId ON loan (book_id);
END;


-- Creating a clustered index ofr the borrower id foreign key in teh loan table.
IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes AS i
    INNER JOIN sys.objects AS o ON i.object_id = O.object_id
    WHERE o.name = 'loan'
        AND i.name = 'ix_FKBorrowerId'
)
BEGIN
    CREATE NONCLUSTERED INDEX ix_FKBorrowerId
    ON loan (borrower_id);
END;


-- Creating a clustered index for the date the book returned on in the loan table.
IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes AS i
    INNER JOIN sys.objects AS o ON i.object_id = O.object_id
    WHERE o.name = 'loan'
        AND i.name = 'ix_BookDateReturned'
)
BEGIN
    CREATE NONCLUSTERED INDEX ix_BookDateReturned
        ON loan (date_returned);
END;


-- Creating a clustered index for the date the book borrowed on in the loan table.
IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes AS i
    INNER JOIN sys.objects AS o ON i.object_id = O.object_id
    WHERE o.name = 'loan'
        AND i.name = 'ix_BookDateBorrowed'
)
BEGIN
    CREATE NONCLUSTERED INDEX ix_BookDateBorrowed
        ON loan (date_borrowed);
END;


-- Creating a clustered index for the due date of the book in the loan table.
IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes AS i
    INNER JOIN sys.objects AS o ON i.object_id = O.object_id
    WHERE o.name = 'loan'
        AND i.name = 'ix_BookDueDate'
)
BEGIN
    CREATE NONCLUSTERED INDEX ix_BookDueDate
        ON loan (due_date);
END;
