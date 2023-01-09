-- Redwood Demo
-- <theadamwright>
DROP USER janebar CASCADE; 
DROP PROFILE prfname;

CREATE PROFILE prfname LIMIT failed_login_attempts 3 password_lock_time 1;
ALTER PROFILE prfname LIMIT password_life_time 7 password_grace_time 3;

CREATE USER janebar IDENTIFIED BY jane PROFILE prfname;

SELECT username, profile, account_status, lock_date, expiry_date FROM
dba_users WHERE username = 'JANEBAR';

\connect dbfoo janebar
\connect dbfoo janebar
\connect dbfoo janebar
-- psql -h 127.0.0.1 dbfoo janebar --password 

SELECT username, profile, account_status, lock_date, expiry_date FROM
dba_users WHERE username = 'UNAME';
