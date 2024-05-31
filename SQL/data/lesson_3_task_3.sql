BEGIN TRY
    -- �������� ������� ������� dbo.Students
    IF OBJECT_ID('dbo.Students', 'U') IS NOT NULL
    BEGIN
        -- �������� ������� �������� � ������� dbo.Students
        IF COL_LENGTH('dbo.Students', 'ID') IS NOT NULL AND 
           COL_LENGTH('dbo.Students', 'Direction') IS NOT NULL AND 
           COL_LENGTH('dbo.Students', 'DirectionCode') IS NOT NULL
        BEGIN
            -- �������� ������� ������� dbo.Directions
            IF OBJECT_ID('dbo.Directions', 'U') IS NOT NULL
            BEGIN
                -- �������� ������� �������� � ������� dbo.Directions
                IF COL_LENGTH('dbo.Directions', 'DirectionCode') IS NOT NULL AND 
                   COL_LENGTH('dbo.Directions', 'DirectionName') IS NOT NULL
                BEGIN
                    -- ���������� DirectionCode � ������� Students �� ������ ������ �� ������� Direction
                    UPDATE S
                    SET S.DirectionCode = D.DirectionCode
                    FROM dbo.Students S
                    INNER JOIN dbo.Directions D
                        ON S.Direction = D.DirectionName;
                END
            END
        END
    END
END TRY
BEGIN CATCH
    -- ��������� ������: � ������ ������������� ������ ������ �� ������
END CATCH;
select * from Students;
