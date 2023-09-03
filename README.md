# Library Management System

A database for managing library business created using Microsoft SQL Server.

## Problem

A local library library wishes to transition their traditional book-keeping to a a more robust digital system.

## Solution

Building a robust, performant, and maintainable database to efficiently track books, borrowers, loans, returns, and offer insights into borrowing trends.

## Entity Relations Diagram

The database schema includes three table for managing the business logic behind the library management system.
The tables are: Books table, Borrowers table, and Loan table.

1- **Books table:**
  Books table aims to store the books' information like the book title and the author who wrote the book.

2- **Borrowers table:**
  Borrowers table aims to store the borrowers' information like the borrower name and membership date.

3- **Loans table:**
  Loans table is the relationship table between the books and borrowers table that represents the many-too-many relationship which in a nutshell says borrowers can borrow more than one book, and books can be borrowed by more than one person one after another. The relationship also holds some data needed for the loan operation to be run successfully like the date of borrowing and the due date.

---

<img src="https://github.com/moustf/LibraryManagementSystem/assets/77394697/e85d2fac-df73-46a5-8799-2100310d8fd7" alt="library management system erd1" width="1200" height="600" />

---

<img src="https://github.com/moustf/LibraryManagementSystem/assets/77394697/c8a01346-199b-462b-90f2-cb36ba32354b" alt="library management system erd2" width="1200" height="600" />

## Queries - Procedures Description

Now with the most fun part of the documentation: the rationale behind each query/function/procedure/trigger.

- **List of Borrowed Books:**
  - Description: Create the query that retrieves all the borrowed books including the unreturned ones.
  - Path: `LibraryManagementSystem/DML/queries/borrowed_books_list.sql`

- **Active Borrowers with CTEs:**
  - Description: Create a common table expression to return the borrowers who borrowed more than one book but have not returned any.
  - Path: `LibraryManagementSystem/DML/queries/active_borrowers.sql`

- **Borrowing Frequency using Window Functions:**
  - Description: Create a query to rank the borrowers depending on the borrowing frequency of the books.
  - Path: `LibraryManagementSystem/DML/queries/borrowing_frequency.sql`

- **Popular Genre Analysis using Joins and Window Functions:**
  - Description: Create a script to return the most popular genre for a given month and the number of occurrences.
  - Path: `LibraryManagementSystem/DML/queries/popular_genre.sql`

- **Stored Procedure - Add New Borrowers:**
  - Description: Add a new borrower using a stored procedure syntax.
  - Path: `LibraryManagementSystem/DML/queries/add_new_borrower.sql`

- **Database Function - Calculate Overdue Fees:**
  - Description: Create a function to calculate the overdue fees for the delay of returning the book.
  - Path: `LibraryManagementSystem/DML/queries/overdue_fees.sql`

- **Database Function - Book Borrowing Frequency:**
  - Description: Create the function for counting the frequency of borrowing a book.
  - Path: `LibraryManagementSystem/DML/queries/book_borrowing_frequency.sql`

- **Overdue Analysis:**
  - Description: Create a query for retrieving all the books with an overdue period of more than 30 days with the borrowers.
  - Path: `LibraryManagementSystem/DML/queries/overdue_analysis.sql`

- **Author Popularity using Aggregation:**
  - Description: Create a query for adding ranking authors depending on their popularity.
  - Path: `LibraryManagementSystem/DML/queries/author_popularity.sql`

- **Genre Preference by Age using Group By and Having:**
  - Description: Create the query for the genre preferences by age.
  - Path: `LibraryManagementSystem/DML/queries/genere_preferrence.sql`

- **Stored Procedure - Borrowed Books Report:**
  - Description: Create the query for reporting the borrowed books in a period of time.
  - Path: `LibraryManagementSystem/DML/queries/borrowed_box_report.sql`

- **Trigger Implementation:**
  - Description: Create the table schema for the audit log table and create a trigger for adding new data to the audit log table.
  - Path: `LibraryManagementSystem/DML/queries/log_status_changed.sql`

- **SQL Stored Procedure with Temp Table:**
  - Description: Create a stored procedure for retrieving all the borrowers who have overdue books with the book information.
  - Path: `LibraryManagementSystem/DML/queries/borrowers_with_overdue_books.sql`
