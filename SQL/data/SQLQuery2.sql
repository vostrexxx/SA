
-- �������� ������� �����������, ���� ��� ��� �� ����������
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Directions')
BEGIN
    CREATE TABLE Directions (
        DirectionID INT PRIMARY KEY,
        Name NVARCHAR(100),
        MinimumScore INT
    );
END;
DELETE FROM Directions;
-- ������� ������ � ������������
INSERT INTO Directions (DirectionCode, DirectionName, MinScore)
VALUES 
    (4, '�������', 160),
    (2, '�����', 180),
    (3, '������', 200);

