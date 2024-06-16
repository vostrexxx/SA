CREATE PROCEDURE InsertAndFetchData 
    @account_id INT,
    @session_id INT,
    @product_name VARCHAR(255)
AS
BEGIN
    -- 1st dataset
    SELECT 
        t.user_id, 
        t.product_type, 
        t.user_type
    FROM 
    (
        VALUES
        (1, 'Electronics', 'Regular'),
        (2, 'Books', 'Premium')
    ) AS t (user_id, product_type, user_type);

    -- 2nd dataset
    SELECT 
        t.session_id, 
        t.status
    FROM 
    (
        VALUES
        (@session_id, 'Pending'),
        (@session_id + 1, 'Completed')
    ) AS t (session_id, status);
END;
