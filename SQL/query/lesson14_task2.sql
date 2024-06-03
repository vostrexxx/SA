BEGIN TRY
    -- Проверка наличия таблиц Students и Directions
    IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Students') 
       AND EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Directions')
    BEGIN
        -- Запрос для вывода строки с перечислением фамилий студентов, зачисленных на направление "История"
        SELECT STRING_AGG(S.Surname, ', ') AS [Список студентов, зачисленных на направление "История"]
        FROM dbo.Students S
        INNER JOIN dbo.Directions D
            ON S.Direction = D.DirectionName
        WHERE S.Direction = 'История' 
          AND S.[Exam Score] >= D.MinScore;
    END
    ELSE
    BEGIN
        RAISERROR ('One or both of the tables "Students" or "Directions" do not exist.', 16, 1);
    END
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
END CATCH;