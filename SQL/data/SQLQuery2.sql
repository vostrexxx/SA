
-- Создание таблицы направлений, если она еще не существует
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Directions')
BEGIN
    CREATE TABLE Directions (
        DirectionID INT PRIMARY KEY,
        Name NVARCHAR(100),
        MinimumScore INT
    );
END;
DELETE FROM Directions;
-- Вставка данных о направлениях
INSERT INTO Directions (DirectionCode, DirectionName, MinScore)
VALUES 
    (4, 'История', 160),
    (2, 'Право', 180),
    (3, 'Физика', 200);

