-- ������� �������� sp
CREATE PROCEDURE SendAccountSession
    @account_id INT,
    @session_id INT,
    @status INT OUTPUT
AS
BEGIN
    -- ����� �������� �����-������ ������
    
    SET @status = 0;
END;
GO

-- ������ ���������
DECLARE @status INT;
EXEC SendAccountSession @account_id = 1, @session_id = 123, @status = @status OUTPUT;
SELECT @status AS Status;