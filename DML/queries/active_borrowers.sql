WITH active_borrowers (borrower_id, first_name, last_name, email, membership_date, books_borrowed)
         AS (SELECT b.borrower_id,
                    first_name,
                    last_name,
                    email,
                    membership_date,
                    COUNT(l.borrower_id) AS books_no
             FROM borrower AS b
                      INNER JOIN loan AS l
                                 ON b.borrower_id = l.book_id
             WHERE l.date_returned IS null
             GROUP BY b.borrower_id, first_name, last_name, email, membership_date
             HAVING COUNT(l.borrower_id) > 2)

SELECT *
FROM active_borrowers;
