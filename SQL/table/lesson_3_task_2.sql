	IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Directions')
BEGIN
    CREATE TABLE Directions (
        DirectionCode INT PRIMARY KEY,
        DirectionName NVARCHAR(100) NOT NULL,
        MinScore INT NOT NULL
    );
    PRINT 'The "Directions" table has been successfully created.';
END
