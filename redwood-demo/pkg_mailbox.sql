-- Redwood Demo 
-- <theadamwright>

CREATE OR REPLACE PACKAGE mailbox
IS
    PROCEDURE create_mailbox;
    PROCEDURE add_message(
p_mailbox VARCHAR2,
p_item_1 VARCHAR2,
p_item_2 VARCHAR2 DEFAULT 'END',
p_item_3 VARCHAR2 DEFAULT 'END');
PROCEDURE empty_mailbox (
        p_mailbox   VARCHAR2,
        p_waittime  INTEGER DEFAULT 10
    );
END mailbox;


CREATE OR REPLACE PACKAGE BODY mailbox
IS
    PROCEDURE create_mailbox
    IS
        v_mailbox   VARCHAR2(30);
        v_status    INTEGER;
    BEGIN
        v_mailbox := DBMS_PIPE.UNIQUE_SESSION_NAME;
        v_status := DBMS_PIPE.CREATE_PIPE(v_mailbox,1000,FALSE);
        IF v_status = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Created mailbox: ' || v_mailbox);
        ELSE
            DBMS_OUTPUT.PUT_LINE('CREATE_PIPE failed - status: ' ||
                v_status);
        END IF;
    END create_mailbox;

PROCEDURE add_message (
p_mailbox VARCHAR2,
p_item_1 VARCHAR2,
p_item_2 VARCHAR2 DEFAULT 'END',
p_item_3 VARCHAR2 DEFAULT 'END'
) IS
    v_item_cnt  INTEGER := 0;
    v_status    INTEGER;
BEGIN
DBMS_PIPE.PACK_MESSAGE(p_item_1);
v_item_cnt := 1;
IF p_item_2 != 'END' THEN
    DBMS_PIPE.PACK_MESSAGE(p_item_2);
    v_item_cnt := v_item_cnt + 1;
END IF;
IF p_item_3 != 'END' THEN
    DBMS_PIPE.PACK_MESSAGE(p_item_3);
    v_item_cnt := v_item_cnt + 1;
END IF;
v_status := DBMS_PIPE.SEND_MESSAGE(p_mailbox);
IF v_status = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Added message with ' || v_item_cnt ||
            ' item(s) to mailbox ' || p_mailbox);
    ELSE
        DBMS_OUTPUT.PUT_LINE('SEND_MESSAGE in add_message failed - ' ||
            'status: ' || v_status);
    END IF;
END add_message;

PROCEDURE empty_mailbox (
    p_mailbox   VARCHAR2,
    p_waittime  INTEGER DEFAULT 10
) IS
v_msgno INTEGER DEFAULT 0;
v_itemno INTEGER DEFAULT 0;
v_item VARCHAR2(100);
v_status INTEGER;
BEGIN
v_status := DBMS_PIPE.RECEIVE_MESSAGE(p_mailbox,p_waittime);
        WHILE v_status = 0 LOOP
            v_msgno := v_msgno + 1;
            DBMS_OUTPUT.PUT_LINE('****** Start message #' || v_msgno ||
                ' ******');
            BEGIN
                LOOP
                    v_status := DBMS_PIPE.NEXT_ITEM_TYPE;
                    EXIT WHEN v_status = 0;
                    DBMS_PIPE.UNPACK_MESSAGE(v_item);
                    v_itemno := v_itemno + 1;
                    DBMS_OUTPUT.PUT_LINE('Item #' || v_itemno || ': ' ||
                        v_item);
                END LOOP;
                DBMS_OUTPUT.PUT_LINE('******* End message #' || v_msgno ||
                    ' *******');
                DBMS_OUTPUT.PUT_LINE('*');
                v_itemno := 0;
                v_status := DBMS_PIPE.RECEIVE_MESSAGE(p_mailbox,1);
            END;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('Number of messages received: ' || v_msgno);
        v_status := DBMS_PIPE.REMOVE_PIPE(p_mailbox);
        IF v_status = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Deleted mailbox ' || p_mailbox);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Could not delete mailbox - status: '
                || v_status);
        END IF;
    END empty_mailbox;
END mailbox;
