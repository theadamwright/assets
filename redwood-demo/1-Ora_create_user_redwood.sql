-- Redwood Demo by Adam Wright <theadamwright> 
-- Create Oracle user to own sample migrateable objects 
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
CREATE USER redwood IDENTIFIED BY r3dw00d; 
GRANT CONNECT, RESOURCE, DBA TO redwood;
GRANT CREATE SESSION TO redwood WITH ADMIN OPTION;
