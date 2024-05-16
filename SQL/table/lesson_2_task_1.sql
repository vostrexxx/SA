IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Студенты')
BEGIN
    CREATE TABLE Студенты (
        Идентификатор INT PRIMARY KEY IDENTITY(1,1),
        Имя NVARCHAR(100),
        Фамилия NVARCHAR(100)
    );
    PRINT 'Таблица "Студенты" была успешно создана.';
END
ELSE
BEGIN
    PRINT 'Таблица "Студенты" уже существует.';
END;
