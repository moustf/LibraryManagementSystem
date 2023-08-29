if NOT EXISTS(SELECT 1
              FROM sys.procedures
              WHERE name = 'sp_AddNewBorrower')
    BEGIN
        EXEC('CREATE PROCEDURE sp_AddNewBorrower(
            @first_name NVARCHAR(20), @last_name VARCHAR(20), @email NVARCHAR(319), @date_of_birth DATETIME,
            @membership_date DATETIME
        )
        AS
        BEGIN
            IF EXISTS(SELECT 1
                      FROM borrower
                      WHERE email = @email)
                BEGIN
                    THROW 50005, N''The email already exists'', 1;
                END;

            INSERT INTO borrower (FIRST_NAME, LAST_NAME, EMAIL, DATE_OF_BIRTH, membership_date)
            VALUES (@first_name, @last_name, @email, @date_of_birth, @membership_date);

            SELECT borrower_id FROM borrower WHERE email = @email;
        END;');
    END;

GO

EXEC sp_AddNewBorrower 'Mustafa', 'Salem', 'fdietfz0@yolasite.com', '1999/09/24', '2015/08/13';