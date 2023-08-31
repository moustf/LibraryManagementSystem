USE library_management_system;

GO

IF NOT EXISTS(
    SELECT
        1
    FROM
        sys.parameters
    WHERE
        object_id = OBJECT_ID('dbo.fn_BookBorrowingFrequency')
)
BEGIN
    DECLARE @dynamic_sql NVARCHAR(MAX);
    SET @dynamic_sql = '
        CREATE FUNCTION fn_BookBorrowingFrequency(
            @book_id INT
        )
        RETURNS INT AS
        BEGIN
            DECLARE @borrowing_frequency INT;

            SET @borrowing_frequency = (
                SELECT
                    COUNT(book_id)
                FROM
                    loan
                WHERE
                    book_id = @book_id
            );

            RETURN @borrowing_frequency;
        END;
    ';

    EXEC sp_executesql @dynamic_sql;
END;
