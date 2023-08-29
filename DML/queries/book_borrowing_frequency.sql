IF NOT EXISTS
    (SELECT 1
     FROM sys.parameters
     WHERE object_id = OBJECT_ID('dbo.fn_BookBorrowingFrequency'))
    BEGIN
        EXEC ('CREATE FUNCTION fn_BookBorrowingFrequency(
                    @book_id INT
                )
                    RETURNS INT AS
                BEGIN
                    DECLARE @borrowing_frequency INT;
                    SET @borrowing_frequency = (SELECT COUNT(book_id) AS BookCount
                                                FROM loan
                                                WHERE book_id = @book_id);

                    RETURN @borrowing_frequency;
                END;');
    END;

SELECT dbo.fn_BookBorrowingFrequency(5);
