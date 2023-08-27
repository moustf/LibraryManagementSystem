-- Creating a trigger to update the updated_At field in the book table automatically.
CREATE TRIGGER update_book_updated_at
ON book
AFTER UPDATE
AS
BEGIN
    UPDATE book
    SET updated_at = GETDATE()
    FROM book AS b
    INNER JOIN inserted AS i ON b.book_id = i.book_id
END;

-- Creating a trigger to update the updated_At field in the borrower table automatically.
CREATE TRIGGER update_borrower_updated_at
ON borrower
AFTER UPDATE
AS
BEGIN
    UPDATE borrower
    SET updated_at = GETDATE()
    FROM borrower AS b
    INNER JOIN inserted AS i On b.borrower_id = i.borrower_id
END;

-- Creating a trigger to update the updated_At field in the borrower table automatically.
CREATE TRIGGER update_loan_updated_at
ON loan
AFTER UPDATE
AS
BEGIN
    UPDATE loan
    SET updated_at = GETDATE()
    FROM loan AS l
    INNER JOIN inserted AS i On l.loan_id = i.loan_id
END;
