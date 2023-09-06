USE library_management_system;
GO

IF NOT EXISTS(SELECT 1
              FROM sys.procedures
              WHERE name = 'sp_AddNewBorrower')
    BEGIN
        DECLARE @dynamic_sql NVARCHAR(MAX);
        SET @dynamic_sql = '
            CREATE PROCEDURE sp_AddNewBorrower(
                @first_name NVARCHAR(20),
                @last_name NVARCHAR(20),
                @email NVARCHAR(319),
                @date_of_birth DATETIME,
                @membership_date DATETIME
            )
            AS
            BEGIN
                BEGIN TRY
                    IF EXISTS(SELECT 1
                              FROM dbo.borrower
                              WHERE email = @email)
                        BEGIN
                            THROW 51000, N''The email already exists'', 1;
                        END;

                    INSERT INTO borrower (first_name, last_name, email, date_of_birth, membership_date)
                    VALUES (@first_name, @last_name, @email, @date_of_birth, @membership_date);

                    SELECT borrower_id FROM borrower WHERE email = @email;
                END TRY
                BEGIN CATCH
                    DECLARE @error_message NVARCHAR(4000),
                        @error_severity INT,
                        @error_state INT;
                    SELECT @error_message = ERROR_MESSAGE(),
                           @error_severity = ERROR_SEVERITY(),
                           @error_state = ERROR_STATE();

                    INSERT INTO error_log (error_message, error_severity, error_state, logged_at)
                    VALUES (@error_message, @error_severity, @error_state, GETDATE());

                    THROW;
                END CATCH;
            END;
        ';

        EXEC sp_executesql @dynamic_sql;
    END;

GO
