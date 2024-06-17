CREATE OR REPLACE FUNCTION InsertAndFetchData(
    _account_id INT,
    _session_id INT,
    _product_name VARCHAR
)
RETURNS SETOF refcursor AS $$
DECLARE
    first_ref refcursor;
    second_ref refcursor;
BEGIN
    -- 1st cursor
    OPEN first_ref FOR SELECT * FROM (VALUES
        (1, 'Electronics', 'Regular'),
        (2, 'Books', 'Premium')
    ) AS t(user_id, product_type, user_type);

    -- 2nd cursor
	OPEN second_ref FOR SELECT * FROM (VALUES
        (_session_id, 'Pending'),
        (_session_id + 1, 'Completed')
    ) AS t(session_id, status);

    RETURN NEXT first_ref;
    RETURN NEXT second_ref;
END;
$$ LANGUAGE plpgsql;
