-- Check if the "Students" table exists
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Students')
BEGIN
    -- Delete all rows except the first three based on "Идентификатор"
    DELETE FROM Students
    WHERE ID NOT IN (
        SELECT TOP 3 ID
        FROM Students
        ORDER BY ID
    );

    PRINT 'All rows except the first three have been deleted from the "Students" table.';
END
ELSE
BEGIN
    PRINT 'The table "Students" does not exist.';
END;
