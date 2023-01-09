-- Redwood Demo 
-- <theadamwright>

DECLARE
v_req           UTL_HTTP.REQ;
v_resp          UTL_HTTP.RESP;
v_name          VARCHAR2(30);
v_value         VARCHAR2(200);
v_header_cnt    INTEGER;
BEGIN
v_req := UTL_HTTP.BEGIN_REQUEST('www.postgresql.org');
v_resp := UTL_HTTP.GET_RESPONSE(v_req);
v_header_cnt := UTL_HTTP.GET_HEADER_COUNT(v_resp);
DBMS_OUTPUT.PUT_LINE('Header Count: ' || v_header_cnt);
FOR i IN 1 .. v_header_cnt LOOP
UTL_HTTP.GET_HEADER(v_resp, i, v_name, v_value);
DBMS_OUTPUT.PUT_LINE(v_name || ': ' || v_value);
END LOOP;
UTL_HTTP.END_RESPONSE(v_resp);
END;
