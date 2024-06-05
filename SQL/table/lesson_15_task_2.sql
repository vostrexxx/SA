USE [MYDB]
GO

BEGIN TRY
    -- �������� ������� ������� Directions
    IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Directions')
    BEGIN
        -- ���������� ������ ���� "IsEnrollmentClosed" � ������� Directions, ���� ��� ��� ���
        IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.Directions') AND name = 'IsEnrollmentClosed')
        BEGIN
            ALTER TABLE dbo.Directions
            ADD IsEnrollmentClosed BIT DEFAULT 0;
        END

        -- ���������� ������ ���� "TotalSeats" � ������� Directions, ���� ��� ��� ���
        IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'dbo.Directions') AND name = 'TotalSeats')
        BEGIN
            ALTER TABLE dbo.Directions
            ADD TotalSeats INT;
        END

		-- ���������� ���� "����� ����"
        UPDATE dbo.Directions
        SET TotalSeats = CASE 
            WHEN DirectionCode = 1 THEN 2
            WHEN DirectionCode = 2 THEN 2
            WHEN DirectionCode = 3 THEN 1
            ELSE TotalSeats
        END;
		
		UPDATE dbo.Directions
        SET IsEnrollmentClosed = CASE 
            WHEN (SELECT COUNT(*) FROM dbo.Students S 
			WHERE S.Direction = dbo.Directions.DirectionName AND
			S.[Exam Score] >= dbo.Directions.MinScore) >= TotalSeats
            
			THEN CAST(1 AS BIT)
            ELSE CAST(0 AS BIT)
        END;

    END
    ELSE
    BEGIN
        RAISERROR ('Table "Directions" does not exist.', 16, 1);
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
GO
select * from Directions;