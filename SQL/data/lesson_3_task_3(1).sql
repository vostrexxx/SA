BEGIN TRY
    -- �������� ������� ������� dbo.Students
    IF OBJECT_ID('dbo.Students', 'U') IS NOT NULL
    BEGIN
        -- �������� ������� �������� � ������� dbo.Students
        IF COL_LENGTH('dbo.Students', 'ID') IS NOT NULL AND 
           COL_LENGTH('dbo.Students', 'DirectionCode') IS NOT NULL
        BEGIN
            -- �������� ������� ������� dbo.Directions
            IF OBJECT_ID('dbo.Directions', 'U') IS NOT NULL
            BEGIN
                -- �������� ������� �������� � ������� dbo.Directions
                IF COL_LENGTH('dbo.Directions', 'DirectionCode') IS NOT NULL AND 
                   COL_LENGTH('dbo.Directions', 'DirectionName') IS NOT NULL AND
                   COL_LENGTH('dbo.Directions', 'MinScore') IS NOT NULL
                BEGIN
                    -- �������� ��������� ������� #ExamSheet
                    CREATE TABLE #ExamSheet (
                        StudentID INT,
                        Name NVARCHAR(100),
                        Surname NVARCHAR(100),
                        ExamScore INT,
                        Direction NVARCHAR(100)
                    );

                    -- ���������� ��������� ������� �������
                    INSERT INTO #ExamSheet (StudentID, Name, Surname, ExamScore, Direction)
                    VALUES 
                        (1, '����', '�����', 220, '�������'),
                        (2, '�����', '������', 170, '�����'),
                        (3, '���������', '��������', 300, '������');

                    -- ���������� DirectionCode � ������� Students �� ������ ������ �� ��������� ������� #ExamSheet � ������������ ����� �� dbo.Directions
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

                    -- �������� ��������� �������
                    DROP TABLE #ExamSheet;
                END
            END
        END
    END
END TRY
BEGIN CATCH
    -- ��������� ������: � ������ ������������� ������ ������ �� ������
END CATCH;

-- ������� ������ �� ������� Students ��� �������� ����������
SELECT * FROM dbo.Students;
SELECT * FROM dbo.Directions;
