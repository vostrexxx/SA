BEGIN TRY
    -- �������� ������� ������ Students � Directions
    IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Students') 
       AND EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Directions')
    BEGIN
        -- ������ ��� ����������� ������ ���������������� ����� � ����������� ������� "��������"
        SELECT 
			E.StudentID AS [����� ��������],
			E.Name AS [���],
			E.Surname AS [�������],
			E.ExamScore AS [����],
			E.Direction AS [�����������],
			CASE 
				WHEN E.ExamScore > D.MinScore THEN '��'
				WHEN E.ExamScore < D.MinScore THEN '���'
				ELSE NULL
			END AS [��������]
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
    -- ����� ��������� �� ������
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH;
