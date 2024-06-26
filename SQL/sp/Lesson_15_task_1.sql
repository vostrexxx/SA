USE [MYDB]
GO
/****** Object:  StoredProcedure [dbo].[GetEnrolledStudentsByDirection]    Script Date: 04.06.2024 15:32:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[GetListEnrolledStudents]
    @DirectionCode INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Проверка наличия таблицы Directions
        IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Directions')
        BEGIN
            PRINT 'Table "Directions" does not exist.';
            RETURN;
        END

        -- Проверка наличия таблицы Students
        IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Students')
        BEGIN
            PRINT 'Table "Students" does not exist.';
            RETURN;
        END

        -- Проверка корректности кода направления
        DECLARE @DirectionName NVARCHAR(100);
        SELECT @DirectionName = DirectionName
        FROM dbo.Directions
        WHERE DirectionCode = @DirectionCode;

        IF @DirectionName IS NULL
        BEGIN
            PRINT 'Некорректный код направления';
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
                WHERE S.Direction = @DirectionName 
                  AND S.[Exam Score] >= D.MinScore
                FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)'), 1, 2, ''), '') AS [Список фамилий]
        ;
    END TRY
BEGIN CATCH
    -- Вывод сообщения об ошибке
    PRINT 'An error occurred while processing the request.';
    RETURN;
END CATCH;
END
