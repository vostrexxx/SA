USE [MYDB]
GO

-- Создание триггера для таблицы Students
CREATE TRIGGER trg_UpdateIsEnrollmentClosed
ON dbo.Students
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Обновление столбца IsEnrollmentClosed в таблице Directions
    UPDATE D
    SET D.IsEnrollmentClosed = CASE 
        WHEN (SELECT COUNT(*) 
              FROM dbo.Students S 
              WHERE S.Direction = D.DirectionName 
              AND S.[Exam Score] >= D.MinScore) >= D.TotalSeats
        THEN CAST(1 AS BIT)
            ELSE CAST(0 AS BIT)
    END
    FROM dbo.Directions D
    WHERE D.DirectionName IN (SELECT DISTINCT Direction FROM inserted);
END
GO