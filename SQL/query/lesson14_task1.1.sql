BEGIN TRY
    -- Проверка наличия таблиц Students и Directions
    IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Students') 
       AND EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Directions')
    BEGIN
        -- Запрос для отображения данных экзаменационного листа с добавлением столбца "Зачислен"
        SELECT 
			E.StudentID AS [Номер студента],
			E.Name AS [Имя],
			E.Surname AS [Фамилия],
			E.ExamScore AS [Балл],
			E.Direction AS [Направление],
			CASE 
				WHEN E.ExamScore > D.MinScore THEN 'Да'
				WHEN E.ExamScore < D.MinScore THEN 'Нет'
				ELSE NULL
			END AS [Зачислен]
		FROM ExamSheet E
		LEFT JOIN dbo.Directions D
			ON E.Direction = D.DirectionName;

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
