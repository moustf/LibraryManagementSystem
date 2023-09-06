USE library_management_system;
GO

IF NOT EXISTS (
		SELECT 1
		FROM sys.procedures
		WHERE name = 'sp_BorrowersWithOverdueBooks'
		)
BEGIN
	DECLARE @dynamic_sql NVARCHAR(MAX);

	SET @dynamic_sql =
		'
            CREATE PROCEDURE sp_BorrowersWithOverdueBooks
            AS
            BEGIN
                BEGIN TRY
                    SELECT l.loan_id,
                        b.borrower_id,
                        b.first_name,
                        b.last_name,
                        b.email,
                        b.membership_date
                    INTO #overdue_borrower_books
                    FROM borrower AS b
                    INNER JOIN loan AS l ON b.borrower_id = l.borrower_id
                    WHERE DATEPART(DAY, GETDATE()) - DATEPART(DAY, l.due_date) > 0;

                    SELECT CONCAT (
                            obb.first_name,
                            SPACE(1),
                            obb.last_name
                            ) AS [Borrower Name],
                        obb.email,
                        obb.membership_date,
                        b.title,
                        b.author,
                        b.isbn,
                        b.genre,
                        b.is_available
                    FROM #overdue_borrower_books AS obb
                    INNER JOIN loan AS l ON obb.loan_id = l.loan_id
                    INNER JOIN book AS b ON l.book_id = b.book_id;

                    SELECT 1;
                END TRY

                BEGIN CATCH
                    DECLARE @error_message NVARCHAR(4000),
                        @error_severity INT,
                        @error_state INT;

                    SELECT @error_message = ERROR_MESSAGE(),
                        @error_severity = ERROR_SEVERITY(),
                        @error_state = ERROR_STATE();

                    INSERT INTO error_log (
                        message,
                        severity,
                        STATE,
                        logged_at
                        )
                    VALUES (
                        @error_message,
                        @error_severity,
                        @error_state,
                        GETDATE()
                        );

                    SELECT 0;
                END CATCH;
            END;
        '
		;

	EXEC sp_executesql @dynamic_sql;
END;
