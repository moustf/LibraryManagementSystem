IF NOT EXISTS (SELECT 1
               FROM sys.triggers
               WHERE name = 'audit_log_status_changed'
                 AND parent_id = OBJECT_ID('dbo.book'))
    BEGIN
        DECLARE @dynamic_sql NVARCHAR(MAX);
        SET @dynamic_sql = 'CREATE TRIGGER audit_log_status_changed
                                ON
                                    book
                                AFTER UPDATE
                                AS
                            BEGIN
                                INSERT INTO audit_log (book_id, status_changed_to, change_date)
                                SELECT i.book_id,
                                       i.is_available,
                                       GETDATE()
                                FROM inserted AS i
                                         INNER JOIN deleted AS d
                                                    ON i.book_id = d.book_id;
                            END;
        ';

        EXEC sp_executesql @dynamic_sql;
    END;
