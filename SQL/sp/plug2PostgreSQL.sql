CREATE OR REPLACE FUNCTION send_account_session_and_product(
    p_account_id INT,
    p_session_id INT,
    p_product_name VARCHAR
) RETURNS TABLE (
    user_id INT,
    product_type VARCHAR,
    user_type VARCHAR,
    session_id INT,
    status INT
) AS $$
BEGIN

    RETURN QUERY 
    SELECT 
        1 AS user_id, 
        'TypeA' AS product_type, 
        'Type1' AS user_type, 
        p_session_id AS session_id, 
        0 AS status
    UNION ALL
    SELECT 
        2 AS user_id, 
        'TypeB' AS product_type, 
        'Type2' AS user_type, 
        p_session_id AS session_id, 
        0 AS status;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM send_account_session_and_product(1, 123, 'ProductX');
