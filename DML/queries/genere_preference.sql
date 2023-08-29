WITH AgeGenre AS (SELECT CASE
                             WHEN DATEDIFF(YEAR, date_of_birth, GETDATE()) BETWEEN 0 AND 10 THEN '0 - 10'
                             WHEN DATEDIFF(YEAR, date_of_birth, GETDATE()) BETWEEN 11 AND 20 THEN '11 - 20'
                             WHEN DATEDIFF(YEAR, date_of_birth, GETDATE()) BETWEEN 21 AND 30 THEN '21 - 30'
                             WHEN DATEDIFF(YEAR, date_of_birth, GETDATE()) BETWEEN 31 AND 40 THEN '31 - 40'
                             WHEN DATEDIFF(YEAR, date_of_birth, GETDATE()) BETWEEN 41 AND 50 THEN '41 - 50'
                             ELSE 'Over 50'
                             END  AS Age,
                         genre    AS Genre,
                         COUNT(*) AS GenreCount
                  FROM borrower
                           INNER JOIN loan
                                      ON borrower.borrower_id = loan.borrower_id
                           INNER JOIN book
                                      ON loan.book_id = book.book_id
                  GROUP BY date_of_birth, genre),
     RankedAgeGenre AS (SELECT Age                                                           AS AgeRange,
                               Genre                                                         AS PreferredGenre,
                               GenreCount,
                               ROW_NUMBER() OVER (PARTITION BY Age ORDER BY GenreCount DESC) AS RowNum
                        FROM AgeGenre)
SELECT AgeRange,
       PreferredGenre,
       GenreCount,
       RowNum
FROM RankedAgeGenre
WHERE RowNum = 1
ORDER BY AgeRange;
