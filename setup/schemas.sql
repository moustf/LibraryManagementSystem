CREATE TABLE book (
    book_id INT PRIMARY KEY IDENTITY (1, 1),
    title NVARCHAR(100) NOT NULL,
    author NVARCHAR(100) NOT NULL,
    isbn NVARCHAR(17) NOT NULL,
    genre NVARCHAR(50),
    shelf_location NVARCHAR(100) NOT NULL,
    status NVARCHAR(10) DEFAULT 'available',
    CONSTRAINT CHK_BookStatus CHECK (status IN ('available', 'borrowed')),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
);

GO

CREATE TABLE borrower (
  borrower_id INT PRIMARY KEY IDENTITY (1, 1),
  first_name NVARCHAR(20) NOT NULL,
  last_name NVARCHAR(20) NOT NULL,
  email NVARCHAR(319) NOT NULL UNIQUE,
  date_of_birth DATETIME,
  membership_date DATETIME DEFAULT GETDATE(),
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE(),
);

GO

CREATE TABLE loan (
  loan_id INT PRIMARY KEY IDENTITY (1, 1),
  book_id INT NOT NULL,
  borrower_id INT NOT NULL,
  date_borrowed DATETIME DEFAULT GETDate(),
  due_date DATETIME,
  date_returned DATETIME DEFAULT null,
  created_at DATETIME DEFAULT GETDATE(),
  updated_at DATETIME DEFAULT GETDATE(),
  CONSTRAINT book_id_fk FOREIGN KEY (book_id) REFERENCES book (book_id),
  CONSTRAINT borrower_id_fk FOREIGN KEY (borrower_id) REFERENCES borrower (borrower_id),
);

GO
