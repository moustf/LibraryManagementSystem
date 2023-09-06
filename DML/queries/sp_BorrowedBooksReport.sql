USE library_management_system;
GO

IF NOT EXISTS (
		SELECT 1
		FROM sys.procedures
		WHERE name = 'sp_BorrowedBooksReport'
		)
BEGIN
	DECLARE @dynamic_sql NVARCHAR(MAX);

	SET @dynamic_sql =
		'
        CREATE PROCEDURE sp_BorrowedBooksReport (
            @start_date DATETIME,
            @end_date DATETIME
            )
        AS
        BEGIN
            BEGIN TRY
                SELECT b.borrower_id,
                    b.first_name,
                    b.last_name,
                    b.membership_date,
                    date_borrowed,
                    date_returned
                FROM borrower AS b
                INNER JOIN loan AS l ON b.borrower_id = l.borrower_id
                WHERE l.date_borrowed >= @start_date
                    AND l.date_borrowed < @end_date;

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
