-- �������� ��������� ������� #ExamSheet
CREATE TABLE ExamSheet (
    StudentID INT,
    Name NVARCHAR(100),
    Surname NVARCHAR(100),
    ExamScore INT,
    Direction NVARCHAR(100)
);

-- ���������� ��������� ������� �������
INSERT INTO ExamSheet (StudentID, Name, Surname, ExamScore, Direction)
VALUES 
    (1, '����', '�����', 220, '�������'),
    (2, '�����', '������', 170, '�����'),
    (3, '���������', '��������', 300, '������');
