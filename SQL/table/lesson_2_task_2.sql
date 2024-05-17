-- Check if the table "Students" exists
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Students')
BEGIN
    -- Check if the column "Exam Score" exists in the "Students" table
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS
                   WHERE TABLE_NAME = 'Students' AND COLUMN_NAME = 'Exam Score')
    BEGIN
        -- Add the column "Exam Score" to the "Students" table
        ALTER TABLE Students
        ADD [Exam Score] INT;
        
        PRINT 'The column "Exam Score" was successfully added to the "Students" table.';
    END
    ELSE
    BEGIN
        PRINT 'The column "Exam Score" already exists in the "Students" table.';
    END;
END
ELSE
BEGIN
    PRINT 'The table "Students" does not exist.';
END;
