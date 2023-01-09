-- Redwood Demo 
-- <theadamwright>

CREATE OR REPLACE FUNCTION sys.fn_user_profile1(username varchar2, new_password varchar2, old_password varchar2) RETURN bool IS
BEGIN
 IF username = new_password THEN
  raise ‘Password should not be same as the username.';
 END IF;

 IF length(new_password) < 8 THEN
  raise ‘Password should be at least eight characters long.';
 END IF;
 return true;
END;

ALTER PROFILE user_profile1 LIMIT PASSWORD_VERIFY_FUNCTION fn_user_profile1;
