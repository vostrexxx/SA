BEGIN TRY
    -- Проверка наличия таблицы dbo.Students
    IF OBJECT_ID('dbo.Students', 'U') IS NOT NULL
    BEGIN
        -- Проверка наличия столбцов в таблице dbo.Students
        IF COL_LENGTH('dbo.Students', 'ID') IS NOT NULL AND 
           COL_LENGTH('dbo.Students', 'DirectionCode') IS NOT NULL
        BEGIN
            -- Проверка наличия таблицы dbo.Directions
            IF OBJECT_ID('dbo.Directions', 'U') IS NOT NULL
            BEGIN
                -- Проверка наличия столбцов в таблице dbo.Directions
                IF COL_LENGTH('dbo.Directions', 'DirectionCode') IS NOT NULL AND 
                   COL_LENGTH('dbo.Directions', 'DirectionName') IS NOT NULL AND
                   COL_LENGTH('dbo.Directions', 'MinScore') IS NOT NULL
                BEGIN
                    -- Создание временной таблицы #ExamSheet
                    CREATE TABLE #ExamSheet (
                        StudentID INT,
                        Name NVARCHAR(100),
                        Surname NVARCHAR(100),
                        ExamScore INT,
                        Direction NVARCHAR(100)
                    );

                    -- Заполнение временной таблицы данными
                    INSERT INTO #ExamSheet (StudentID, Name, Surname, ExamScore, Direction)
                    VALUES 
                        (1, 'Иван', 'Бунша', 220, 'История'),
                        (2, 'Остап', 'Бендер', 170, 'Право'),
                        (3, 'Александр', 'Тимофеев', 300, 'Физика');

                    -- Обновление DirectionCode в таблице Students на основе данных из временной таблицы #ExamSheet и минимального балла из dbo.Directions
                    UPDATE S
                    SET S.DirectionCode = CASE
                        WHEN E.ExamScore >= D.MinScore THEN D.DirectionCode
                        ELSE -D.DirectionCode
                    END
                    FROM dbo.Students S
                    INNER JOIN #ExamSheet E
                        ON S.ID = E.StudentID
                    INNER JOIN dbo.Directions D
                        ON E.Direction = D.DirectionName;

                    -- Удаление временной таблицы
                    DROP TABLE #ExamSheet;
                END
            END
        END
    END
END TRY
BEGIN CATCH
    -- Обработка ошибок: в случае возникновения ошибки ничего не делаем
END CATCH;

-- Выборка данных из таблицы Students для проверки результата
SELECT * FROM dbo.Students;
SELECT * FROM dbo.Directions;
