USE library_management_system;

IF NOT EXISTS(
    SELECT
        1
    FROM
        sys.procedures
    WHERE
        name = 'sp_PopularGenreForAGivenMonth'
)
BEGIN
    DECLARE @dynamic_sql NVARCHAR(MAX);
    SET @dynamic_sql = '
        CREATE PROCEDURE sp_PopularGenreForAGivenMonth(
            @month INT
        )
        AS
        BEGIN
            BEGIN TRY
                SELECT TOP 1
                    COUNT(genre) AS genre_count,
                    genre
                FROM
                    book AS b
                INNER JOIN
                    loan AS l
                ON b.book_id = l.book_id
                WHERE
                    DATEPART(MONTH, l.date_borrowed) = @month

                GROUP BY
                    genre
                ORDER BY
                    genre_count DESC;
            END TRY
            BEGIN CATCH
                DECLARE @error_message NVARCHAR(4000),
                        @error_severity INT,
                        @error_state INT;

                SELECT @error_message = ERROR_MESSAGE(),
                       @error_severity = ERROR_SEVERITY(),
                       @error_state = ERROR_STATE();

                INSERT INTO error_log (error_message, error_severity, error_state, logged_at)
                VALUES (@error_message, @error_severity, @error_state, GETDATE());
            END CATCH;
        END;
    ';

    EXEC sp_executesql @dynamic_sql;
END;
