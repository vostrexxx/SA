CREATE OR REPLACE FUNCTION send_account_session(
    p_account_id INT,
    p_session_id INT
) RETURNS INT AS $$
DECLARE
    v_status INT;
BEGIN
    
    v_status = 0;
    RETURN v_status;
END;
$$ LANGUAGE plpgsql;

SELECT send_account_session(1, 123) AS Status;
