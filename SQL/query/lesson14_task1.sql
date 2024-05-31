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
FROM #ExamSheet E
LEFT JOIN dbo.Directions D
    ON E.Direction = D.DirectionName;

-- �������� ��������� �������
DROP TABLE #ExamSheet;

