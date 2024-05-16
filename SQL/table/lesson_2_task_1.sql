IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Students')
BEGIN
    CREATE TABLE Students (
        ID INT PRIMARY KEY IDENTITY(1,1),
        Name NVARCHAR(100),
        Surname NVARCHAR(100)
    );
    PRINT 'The "Students" table has been successfully created.';
END
ELSE
BEGIN
    PRINT 'The "Students" table already exists.';
END;
