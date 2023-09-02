USE library_management_system;

GO

WITH borrowers_to_rank AS (SELECT b.borrower_id,
                                  first_name,
                                  last_name,
                                  email,
                                  membership_date,
                                  COUNT(l.borrower_id) AS borrwoing_frequency
                           FROM borrower AS b
                                    INNER JOIN
                                loan AS l
                                ON b.borrower_id = l.borrower_id
                           GROUP BY b.borrower_id, first_name, last_name, email, membership_date)

SELECT borrower_id,
       first_name,
       last_name,
       email,
       membership_date,
       borrwoing_frequency,
       DENSE_RANK() OVER (ORDER BY borrwoing_frequency DESC) AS rank
FROM borrowers_to_rank;
