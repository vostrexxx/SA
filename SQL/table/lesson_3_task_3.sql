IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Students')
BEGIN
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Students' AND COLUMN_NAME = 'DirectionCode')
    BEGIN
        ALTER TABLE Students ADD DirectionCode INT;
    END
END;
Select * from Students;
--Update Students set DirectionCode = Null;

-- ALTER TABLE dbo.Students
--          ADD Direction NVARCHAR(100)

UPDATE Students
SET Direction = 'Физика' where ID = 3;


Delete from Students where ID  = 31;
