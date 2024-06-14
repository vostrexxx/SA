CREATE PROCEDURE SendAccountSessionAndProduct
    @account_id INT,
    @session_id INT,
    @product_name VARCHAR(255)
AS
BEGIN

    SELECT 
        user_id = 1, 
        product_type = 'TypeA', 
        user_type = 'Type1', 
        session_id = @session_id, 
        status = 0
    UNION ALL
    SELECT 
        user_id = 2, 
        product_type = 'TypeB', 
        user_type = 'Type2', 
        session_id = @session_id, 
        status = 0;
END;
GO

EXEC SendAccountSessionAndProduct @account_id = 1, @session_id = 123, @product_name = 'ProductX';
