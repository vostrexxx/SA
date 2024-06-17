CREATE OR REPLACE FUNCTION InsertAndFetchData(
    _account_id INT,
    _session_id INT,
    _product_name VARCHAR
) RETURNS SETOF RECORD AS $$
DECLARE
    first_dataset RECORD;
    second_dataset RECORD;
BEGIN
    -- 1st dataset
    FOR first_dataset IN
        SELECT 
            t.user_id, 
            t.product_type, 
            t.user_type
        FROM 
        (
            VALUES
            (1, 'Electronics', 'Regular'),
            (2, 'Books', 'Premium')
        ) AS t (user_id, product_type, user_type)
    LOOP
        RETURN NEXT first_dataset;
    END LOOP;

    -- 2nd dataset
    FOR second_dataset IN
        SELECT 
            t.session_id, 
            t.status
        FROM 
        (
            VALUES
            (_session_id, 'Pending'),
            (_session_id + 1, 'Completed')
        ) AS t (session_id, status)
    LOOP
        RETURN NEXT second_dataset;
    END LOOP;
END;
$$ LANGUAGE plpgsql;
