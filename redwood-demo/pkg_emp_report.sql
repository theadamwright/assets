-- Redwood Demo 
-- <theadamwright>

drop package emp_rpt; 

CREATE OR REPLACE PACKAGE emp_rpt
IS
TYPE emprec_typ IS RECORD (
empno       NUMBER(4),
ename       VARCHAR(10));

TYPE emp_refcur IS REF CURSOR;

FUNCTION get_dept_name (
p_deptno    IN NUMBER
) RETURN VARCHAR2;

FUNCTION open_emp_by_dept (
p_deptno    IN emp.deptno%TYPE
) RETURN EMP_REFCUR;

PROCEDURE fetch_emp (
p_refcur    IN OUT SYS_REFCURSOR
);

PROCEDURE close_refcur (
p_refcur    IN OUT SYS_REFCURSOR
);

END emp_rpt;



CREATE OR REPLACE PACKAGE BODY emp_rpt
IS
CURSOR dept_cur IS SELECT * FROM dept;
TYPE depttab_typ IS TABLE of dept%ROWTYPE INDEX BY BINARY_INTEGER;
t_dept          DEPTTAB_TYP;
t_dept_max      INTEGER := 1;
r_emp           EMPREC_TYP;

FUNCTION get_dept_name (
p_deptno    IN NUMBER
) RETURN VARCHAR2
IS
BEGIN
FOR i IN 1..t_dept_max LOOP
IF p_deptno = t_dept(i).deptno THEN
RETURN t_dept(i).dname;
END IF;
END LOOP;
RETURN 'Unknown';
END;

FUNCTION open_emp_by_dept(
p_deptno    IN emp.deptno%TYPE
) RETURN EMP_REFCUR
IS
emp_by_dept EMP_REFCUR;
BEGIN
OPEN emp_by_dept FOR SELECT empno, ename FROM emp
WHERE deptno = p_deptno;
RETURN emp_by_dept;
END;

PROCEDURE fetch_emp (
p_refcur    IN OUT SYS_REFCURSOR
)
IS 
BEGIN
DBMS_OUTPUT.PUT_LINE('EMPNO    ENAME');
DBMS_OUTPUT.PUT_LINE('-----    -------');
LOOP
FETCH p_refcur INTO r_emp;
EXIT WHEN p_refcur%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(r_emp.empno || '     ' || r_emp.ename);
END LOOP;
END;

PROCEDURE close_refcur (
p_refcur    IN OUT SYS_REFCURSOR
)
IS
BEGIN
CLOSE p_refcur;
END;
BEGIN
OPEN dept_cur;
LOOP
FETCH dept_cur INTO t_dept(t_dept_max); 
EXIT WHEN dept_cur%NOTFOUND;
t_dept_max := t_dept_max + 1;
END LOOP;
CLOSE dept_cur;
t_dept_max := t_dept_max -1;
END emp_rpt;
