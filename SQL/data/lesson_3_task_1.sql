BEGIN TRY
    -- Check if the "Students" table exists
    IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Students')
    BEGIN
        -- Check if the "Exam Score" column exists in the "Students" table
        IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS
                   WHERE TABLE_NAME = 'Students' AND COLUMN_NAME = 'Exam Score')
        BEGIN
            -- Enable IDENTITY_INSERT
            SET IDENTITY_INSERT Students ON;

            -- Insert data into the "Students" table
            INSERT INTO Students (ID, Name, Surname, [Exam Score])
            VALUES 
            (1, 'Иван', 'Бунша', 220),
            (2, 'Остап', 'Бендер', 170),
            (3, 'Александр', 'Тимофеев', 300);

            -- Output message about successful insertion
            PRINT 'Data from the exam sheet was successfully inserted into the "Students" table.';
        END
        ELSE
        BEGIN
            RAISERROR ('Cannot insert data: The column "Exam Score" does not exist in the "Students" table.', 16, 1);
        END;
    END
    ELSE
    BEGIN
        RAISERROR ('The table "Students" does not exist.', 16, 1);
    END;
END TRY
BEGIN CATCH
    -- Empty output error message

END CATCH;

-- Ensure IDENTITY_INSERT is turned off in case of error
IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Students')
BEGIN
    SET IDENTITY_INSERT Students OFF;
END