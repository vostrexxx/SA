CREATE OR REPLACE FUNCTION FetchUserData(
    account_id INT,
    session_id INT,
    product_name VARCHAR(255)
)
RETURNS TABLE (
    user_id INT,
    product_type TEXT,
    user_type TEXT,
    session_status_id INT,
    status TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        t.user_id, 
        t.product_type, 
        t.user_type,
        NULL::INT as session_status_id,
        NULL::TEXT as status
    FROM 
    (
        VALUES
        (1, 'Electronics', 'Regular'),
        (2, 'Books', 'Premium')
    ) AS t(user_id, product_type, user_type)
    UNION ALL
    SELECT 
        NULL::INT as user_id,
        NULL::TEXT as product_type,
        NULL::TEXT as user_type,
        t.session_id, 
        t.status
    FROM 
    (
        VALUES
        (session_id, 'Pending'),
        (session_id + 1, 'Completed')
    ) AS t(session_id, status);
END;
$$ LANGUAGE plpgsql;
