-- Check if the "Students" table exists
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Students')
BEGIN
    -- Check if the "Exam Score" column exists in the "Students" table
    IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS
               WHERE TABLE_NAME = 'Students' AND COLUMN_NAME = 'Exam Score')
    BEGIN
        -- Insert data into the "Students" table
        INSERT INTO Students (Name, Surname, [Exam Score])
        VALUES 
        ('Иван', 'Бунша', 220),
        ('Остап', 'Бендер', 170),
        ('Александр', 'Тимофеев', 300);

        PRINT 'Data from the exam sheet was successfully inserted into the "Students" table.';
    END
    ELSE
    BEGIN
        PRINT 'Cannot insert data: The column "Exam Score" does not exist in the "Students" table.';
    END;
END
ELSE
BEGIN
    PRINT 'The table "Students" does not exist.';
END;
