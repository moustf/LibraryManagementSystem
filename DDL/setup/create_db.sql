IF NOT EXISTS
    (SELECT name
     FROM sys.sysdatabases
     WHERE name = 'library_management_system')
    BEGIN
        CREATE DATABASE library_management_system
    END;
