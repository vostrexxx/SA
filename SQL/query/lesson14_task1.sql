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
FROM #ExamSheet E
LEFT JOIN dbo.Directions D
    ON E.Direction = D.DirectionName;

-- Удаление временной таблицы
DROP TABLE #ExamSheet;

