CREATE PROCEDURE sp_PopularGenreForAGivenMonth(
    @month INT
)
AS
BEGIN
    SELECT TOP 1 COUNT(genre) AS Count,
                 genre        AS Genre
    FROM book AS b
             INNER JOIN loan AS l
                        ON b.book_id = l.book_id
    WHERE DATEPART(MONTH, l.date_borrowed) = @month

    GROUP BY genre
    ORDER BY Count DESC;
END ;

    EXEC sp_PopularGenreForAGivenMonth 5;
