-- Исправленная версия процедуры
CREATE PROCEDURE [dbo].[GetEnrolledStudentsByDirection1]
    @DirectionCode INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Проверка наличия таблиц Students и Directions
        IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Students') 
           OR NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Directions')
        BEGIN
            RAISERROR ('One or both of the tables "Students" or "Directions" do not exist.', 16, 1);
            RETURN;
        END

        PRINT 'Tables exist';

        -- Проверка корректности кода направления
        DECLARE @DirectionName NVARCHAR(100);
        SELECT @DirectionName = DirectionName
        FROM dbo.Directions
        WHERE DirectionCode = @DirectionCode;

        IF @DirectionName IS NULL
        BEGIN
            RAISERROR ('Некорректный код направления', 16, 1);
            RETURN;
        END

        PRINT 'Direction code is valid';
        PRINT 'Direction name: ' + @DirectionName;

        -- Основной запрос
        SELECT 
            @DirectionName AS [Название направления],
            ISNULL(STRING_AGG(S.Surname, ', '), '') AS [Список студентов, зачисленных на направление]
        FROM dbo.Students S
        INNER JOIN dbo.Directions D
            ON S.Direction = D.DirectionName
        WHERE D.DirectionCode = @DirectionCode
          AND S.[Exam Score] >= D.MinScore;

    END TRY
    BEGIN CATCH
        -- Вывод сообщения об ошибке
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);

        -- Добавляем RETURN, чтобы прервать выполнение процедуры
        RETURN;
    END CATCH;
END
GO
