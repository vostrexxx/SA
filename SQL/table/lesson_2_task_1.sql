IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '��������')
BEGIN
    CREATE TABLE �������� (
        ������������� INT PRIMARY KEY IDENTITY(1,1),
        ��� NVARCHAR(100),
        ������� NVARCHAR(100)
    );
    PRINT '������� "��������" ���� ������� �������.';
END
ELSE
BEGIN
    PRINT '������� "��������" ��� ����������.';
END;
