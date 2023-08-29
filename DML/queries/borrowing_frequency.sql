WITH borrowers_to_rank([Borrower Id], [First Name], [Last Name], [Email], [Membership Date], [Borrowing Frequency]) AS
         (SELECT b.borrower_id,
                 first_name,
                 last_name,
                 email,
                 membership_date,
                 COUNT(l.borrower_id) AS borrwoing_frequency
          FROM borrower AS b
                   INNER JOIN loan AS l
                              ON b.borrower_id = l.borrower_id
          GROUP BY b.borrower_id, first_name, last_name, email, membership_date)

SELECT *,
       DENSE_RANK() OVER (ORDER BY [Borrowing Frequency] DESC) AS Rank
FROM borrowers_to_rank;
