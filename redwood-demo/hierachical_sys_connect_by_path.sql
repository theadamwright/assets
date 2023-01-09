-- Redwood Demo 
-- <theadamwright>

SELECT level, ename , SYS_CONNECT_BY_PATH(ename, '/') managers
FROM emp
CONNECT BY PRIOR empno = mgr
START WITH mgr IS NULL
ORDER BY level, ename, managers;
