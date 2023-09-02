USE library_management_system;
GO

-- Creating a clustered index for the book id foreign key in the loan table.
CREATE NONCLUSTERED INDEX ix_FKBookId
    ON loan (book_id);


-- Creating a clustered index ofr the borrower id foreign key in teh loan table.
CREATE NONCLUSTERED INDEX ix_FKBorrowerId
    ON loan (borrower_id);


-- Creating a clustered index for the date the book returned on in the loan table.
CREATE NONCLUSTERED INDEX ix_BookDateReturned
    ON loan (date_returned);


-- Creating a clustered index for the date the book borrowed on in the loan table.
CREATE NONCLUSTERED INDEX ix_BookDateBorrowed
    ON loan (date_borrowed);


-- Creating a clustered index for the due date of the book in the loan table.
CREATE NONCLUSTERED INDEX ix_BookDueDate
    ON loan (due_date);
