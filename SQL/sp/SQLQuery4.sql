USE [MYDB]
GO
/****** Object:  StoredProcedure [dbo].[GetEnrolledStudentsByDirection]    Script Date: 04.06.2024 15:07:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GetEnrolledStudentsByDirection]
    @DirectionCode INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Проверка наличия таблицы Directions
        IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Directions')
        BEGIN
            RAISERROR ('Table "Directions" does not exist.', 16, 1);
            RETURN;
        END

        -- Проверка наличия таблицы Students
        IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Students')
        BEGIN
            RAISERROR ('Table "Students" does not exist.', 16, 1);
            RETURN;
        END

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

        -- Основной запрос
        SELECT 
    @DirectionName AS [Название направления],
    ISNULL(STUFF((
        SELECT ', ' + S.Surname
        FROM dbo.Students S
        INNER JOIN dbo.Directions D
            ON S.Direction = D.DirectionName
        WHERE D.DirectionCode = @DirectionCode  -- Изменение условия фильтрации
          AND S.[Exam Score] >= D.MinScore
        FOR XML PATH(''), TYPE
    ).value('.', 'NVARCHAR(MAX)'), 1, 2, ''), '') AS [Список фамилий]
;

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
