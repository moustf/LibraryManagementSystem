IF NOT EXISTS
    (SELECT 1
     FROM sys.triggers
     WHERE name = 'audit_log_status_changed'
       AND parent_id = OBJECT_ID('dbo.book'))
    BEGIN
        EXEC ('CREATE TRIGGER audit_log_status_changed
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
            END;');
    END;

UPDATE book
SET is_available = 0
WHERE book_id = 1;

SELECT *
FROM audit_log;
