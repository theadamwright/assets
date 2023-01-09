-- Redwood Demo 
-- <theadamwright>

drop function hire_salesman;

drop package mailbox;

drop procedure close_refcur;

drop procedure


create or replace PROCEDURE         p_customer_list IS  
   CURSOR c_customers is 
      select name from customers; 

   TYPE c_list IS TABLE of redwood.customers.Name%type INDEX BY binary_integer; 
   name_list c_list; 
   counter integer :=0; 
BEGIN 
   FOR n IN c_customers LOOP 
      counter := counter +1; 
      name_list(counter) := n.name; 
      dbms_output.put_line('Customer('||counter||'):'||name_list(counter)); 
   END LOOP; 
END;

drop table redwood.customers;

create table redwood.customers (ID NUMBER, NAME VARCHAR2(20),AGE NUMBER,ADDRESS VARCHAR2(1024),SALARY NUMBER(8,2));

update redwood.customers set name = 'Ramesh' where ID = 1; 

INSERT INTO redwood.customers VALUES (1, 'RAMESH', 32, 'Ahmedabad',2000.00);
INSERT INTO redwood.customers VALUES (2,'khilan',25,'Ahmedabad',1500.00); 
INSERT INTO redwood.customers VALUES (3,'kaushik',23,'Kota',2000.00);
INSERT INTO redwood.customers VALUES (4,'Chaitali',25,'Mumbai',6500.00);
INSERT INTO redwood.customers VALUES (5,'Hardik',27,'Bhopal',8500.00);
INSERT INTO redwood.customers VALUES (6,'Komal',22,'MP',4500.00);

set serveroutput on; 

CREATE OR REPLACE PROCEDURE p_student_list IS   
   TYPE names_table IS TABLE OF VARCHAR2(10); 
   TYPE grades IS TABLE OF INTEGER;  
   names names_table; 
   marks grades; 
   total integer; 
BEGIN 
   names := names_table('Kavita', 'Pritam', 'Ayan', 'Rishav', 'Aziz'); 
   marks:= grades(98, 97, 78, 87, 92); 
   total := names.count; 
   dbms_output.put_line('Total '|| total || ' Students'); 
   FOR i IN 1 .. total LOOP 
      dbms_output.put_line('Student:'||names(i)||', Marks:' || marks(i)); 
   end loop; 
END;  


create or replace PROCEDURE         p_emp_cursor 
IS
    v_emp_rec       redwood.emp%ROWTYPE;
    CURSOR emp_cur_1 IS SELECT * FROM redwood.emp;
BEGIN
    OPEN emp_cur_1;
    DBMS_OUTPUT.PUT_LINE('EMPNO    ENAME');
    DBMS_OUTPUT.PUT_LINE('-----    -------');
    LOOP
        FETCH emp_cur_1 INTO v_emp_rec;
        EXIT WHEN emp_cur_1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_emp_rec.empno || '' || v_emp_rec.ename);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('**********************');
    DBMS_OUTPUT.PUT_LINE(emp_cur_1%ROWCOUNT || ' rows were retrieved');
    CLOSE emp_cur_1;
END;



select * from redwood.emp; 

create or replace PROCEDURE send_mail (
p_sender VARCHAR2,
p_recipient VARCHAR2,
p_subj VARCHAR2,
p_msg VARCHAR2,
p_mailhost VARCHAR2)
 IS
v_conn UTL_SMTP.CONNECTION;
v_crlf CONSTANT VARCHAR2(2) := CHR(13) || CHR(10);
v_port CONSTANT PLS_INTEGER := 25;
BEGIN
    v_conn := UTL_SMTP.OPEN_CONNECTION(p_mailhost,v_port);
    UTL_SMTP.HELO(v_conn,p_mailhost);
    UTL_SMTP.MAIL(v_conn,p_sender);
    UTL_SMTP.RCPT(v_conn,p_recipient);
    UTL_SMTP.DATA(v_conn, SUBSTR(
        'Date: ' || TO_CHAR(SYSDATE,
        'Dy, DD Mon YYYY HH24:MI:SS') || v_crlf
        || 'From: ' || p_sender || v_crlf
        || 'To: ' || p_recipient || v_crlf
        || 'Subject: ' || p_subj || v_crlf
        || p_msg
        , 1, 32767);
    UTL_SMTP.QUIT(v_conn);
END;

select * from emp; 
