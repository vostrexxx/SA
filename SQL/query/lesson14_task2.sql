BEGIN TRY
    -- �������� ������� ������ Students � Directions
    IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Students') 
       AND EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Directions')
    BEGIN
        -- ������ ��� ������ ������ � ������������� ������� ���������, ����������� �� ����������� "�������"
        SELECT STRING_AGG(S.Surname, ', ') AS [������ ���������, ����������� �� ����������� "�������"]
        FROM dbo.Students S
        INNER JOIN dbo.Directions D
            ON S.Direction = D.DirectionName
        WHERE S.Direction = '�������' 
          AND S.[Exam Score] >= D.MinScore;
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