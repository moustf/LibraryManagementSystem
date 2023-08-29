USE library_management_system;

IF NOT EXISTS
    (SELECT 1
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'dbo'
       AND TABLE_NAME = 'book')
    BEGIN
        CREATE TABLE book
        (
            book_id        INT PRIMARY KEY IDENTITY (1, 1),
            title          NVARCHAR(100)              NOT NULL,
            author         NVARCHAR(100)              NOT NULL,
            isbn           NVARCHAR(17)               NOT NULL,
            genre          NVARCHAR(50)               NOT NULL,
            shelf_location NVARCHAR(100)              NOT NULL,
            is_available   BIT      DEFAULT 1         NOT NULL,
            created_at     DATETIME DEFAULT GETDATE() NOT NULL,
            updated_at     DATETIME DEFAULT GETDATE() NOT NULL,
            CONSTRAINT CHK_GenreEnum CHECK (genre IN (
                                                      'Thriller', 'Documentary', 'Drama', 'Horror', 'Romance',
                                                      'Mystery', 'Crime', 'Comedy', 'Western', 'Children', 'Action',
                                                      'Science Fiction', 'Animation', 'Fantasy', 'Adventure'
                )),
        );
    END;

GO

IF NOT EXISTS
    (SELECT 1
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'dbo'
       AND TABLE_NAME = 'borrower')
    BEGIN
        CREATE TABLE borrower
        (
            borrower_id     INT PRIMARY KEY IDENTITY (1, 1),
            first_name      NVARCHAR(20)  NOT NULL,
            last_name       NVARCHAR(20)  NOT NULL,
            email           NVARCHAR(319) NOT NULL UNIQUE,
            date_of_birth   DATETIME      NOT NULL,
            membership_date DATETIME      NOT NULL DEFAULT GETDATE(),
            created_at      DATETIME      NOT NULL DEFAULT GETDATE(),
            updated_at      DATETIME      NOT NULL DEFAULT GETDATE(),
        );
    END;

GO

IF NOT EXISTS
    (SELECT 1
     FROM INFORMATION_SCHEMA.TABLES
     WHERE TABLE_SCHEMA = 'dbo'
       AND TABLE_NAME = 'loan')
    BEGIN
        CREATE TABLE loan
        (
            loan_id       INT PRIMARY KEY IDENTITY (1, 1),
            book_id       INT      NOT NULL,
            borrower_id   INT      NOT NULL,
            date_borrowed DATETIME NOT NULL DEFAULT GETDate(),
            due_date      DATETIME NOT NULL,
            date_returned DATETIME          DEFAULT null,
            created_at    DATETIME NOT NULL DEFAULT GETDATE(),
            updated_at    DATETIME NOT NULL DEFAULT GETDATE(),
            CONSTRAINT book_id_fk FOREIGN KEY (book_id) REFERENCES book (book_id),
            CONSTRAINT borrower_id_fk FOREIGN KEY (borrower_id) REFERENCES borrower (borrower_id),
        );
    END;

GO
