USE library_management_system;
GO

WITH AgeGenre
AS (
	SELECT CASE
			WHEN DATEDIFF(YEAR, br.date_of_birth, GETDATE()) BETWEEN 0
					AND 10
				THEN '0 - 10'
			WHEN DATEDIFF(YEAR, br.date_of_birth, GETDATE()) BETWEEN 11
					AND 20
				THEN '11 - 20'
			WHEN DATEDIFF(YEAR, br.date_of_birth, GETDATE()) BETWEEN 21
					AND 30
				THEN '21 - 30'
			WHEN DATEDIFF(YEAR, br.date_of_birth, GETDATE()) BETWEEN 31
					AND 40
				THEN '31 - 40'
			WHEN DATEDIFF(YEAR, br.date_of_birth, GETDATE()) BETWEEN 41
					AND 50
				THEN '41 - 50'
			ELSE 'Over 50'
			END AS age,
		bo.genre,
		COUNT(*) AS genre_count
	FROM borrower AS br
	INNER JOIN loan AS l ON br.borrower_id = l.borrower_id
	INNER JOIN book AS bo ON l.book_id = bo.book_id
	GROUP BY br.date_of_birth,
		bo.genre
	),
RankedAgeGenre
AS (
	SELECT age AS age_range,
		genre AS preferred_genere,
		genre_count,
		ROW_NUMBER() OVER (
			PARTITION BY age ORDER BY genre_count DESC
			) AS row_num
	FROM AgeGenre
	)
SELECT age_range,
	preferred_genere,
	genre_count,
	row_num
FROM RankedAgeGenre
WHERE row_num = 1
ORDER BY age_range;
