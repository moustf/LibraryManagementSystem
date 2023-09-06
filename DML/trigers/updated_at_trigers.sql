USE library_management_system;

-- Creating a trigger to update the updated onn field in the book table automatically.
IF NOT EXISTS (
		SELECT 1
		FROM sys.triggers
		WHERE name = 'update_book_updated_on'
			AND parent_id = OBJECT_ID('dbo.book')
		)
BEGIN
	DECLARE @dynamic_sql NVARCHAR(MAX);

	SET @dynamic_sql =
		'
            CREATE TRIGGER dbo.update_book_updated_on ON dbo.book
            AFTER UPDATE
            AS
            BEGIN
                UPDATE book
                SET updated_on = GETDATE()
                FROM book AS b
                INNER JOIN inserted AS i ON b.book_id = i.book_id
            END;
        '
		;

	EXEC sp_executesql @dynamic_sql;
END;

GO

-- Creating a trigger to update the updated on field in the borrower table automatically.
IF NOT EXISTS (
		SELECT 1
		FROM sys.triggers
		WHERE name = 'update_borrower_updated_on'
			AND parent_id = OBJECT_ID('dbo.borrower')
		)
BEGIN
	DECLARE @dynamic_sql NVARCHAR(MAX);

	SET @dynamic_sql =
		'
            CREATE TRIGGER update_borrower_updated_on ON borrower
            AFTER UPDATE
            AS
            BEGIN
                UPDATE borrower
                SET updated_on = GETDATE()
                FROM borrower AS b
                INNER JOIN inserted AS i ON b.borrower_id = i.borrower_id
            END;
        '
		;

	EXEC sp_executesql @dynamic_sql;
END;

GO

-- Creating a trigger to update the updated on field in the borrower table automatically.
IF NOT EXISTS (
		SELECT *
		FROM sys.triggers
		WHERE name = 'update_loan_updated_on'
			AND parent_id = OBJECT_ID('dbo.loan')
		)
BEGIN
	DECLARE @dynamic_sql NVARCHAR(MAX);

	SET @dynamic_sql =
		'
            CREATE TRIGGER update_loan_updated_on ON loan
            AFTER UPDATE
            AS
            BEGIN
                UPDATE loan
                SET updated_on = GETDATE()
                FROM loan AS l
                INNER JOIN inserted AS i ON l.loan_id = i.loan_id
            END;
        '
		;

	EXEC sp_executesql @dynamic_sql;
END;

GO
