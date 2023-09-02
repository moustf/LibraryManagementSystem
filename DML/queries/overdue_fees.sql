USE library_management_system;

GO

IF NOT EXISTS(SELECT 1
              FROM sys.parameters
              WHERE object_id = OBJECT_ID('dbo.fn_CalculateOverdueFees'))
    BEGIN
        DECLARE @dynamic_sql NVARCHAR(MAX);
        SET @dynamic_sql = '
            CREATE FUNCTION fn_CalculateOverdueFees(
                @loan_id INT
            )
                RETURNS DECIMAL AS
            BEGIN
                DECLARE @overdue_fees DECIMAL;
                DECLARE @current_date DATETIME = GETDATE();
                DECLARE @due_date DATETIME;
                DECLARE @date_returned DATETIME;
                DECLARE @difference_in_days INT;

                SET @due_date = (SELECT due_date FROM loan WHERE loan_id = @loan_id);

                IF EXISTS
                    (SELECT 1
                     FROM loan
                     WHERE loan_id = @loan_id
                       AND date_returned IS NULL)
                    BEGIN
                        SET @difference_in_days = DATEDIFF(DAY, @due_date, @current_date);
                    END;
                ELSE
                    BEGIN
                        SET @date_returned = (SELECT date_returned FROM loan WHERE loan_id = @loan_id);
                        SET @difference_in_days = DATEDIFF(DAY, @due_date, @date_returned);
                    END;

                SET @overdue_fees = IIF(@difference_in_days > 30, 30 + ((@difference_in_days - 30) * 2), @difference_in_days);

                RETURN @overdue_fees;
            END;
        ';

        EXEC sp_executesql @dynamic_sql;
    END;
