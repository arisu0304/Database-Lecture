create or replace PROCEDURE PRO_NOPARAM
IS 
	ENO VARCHAR2(8);
	ENAME VARCHAR2(20);

BEGIN 
	ENO := '1111';
	ENAME := '�̼���';

	INSERT INTO EMP(ENO, ENAME)
	VALUES (ENO, ENAME);
	COMMIT;
END;
/

EXEC PRO_NOPARAM;

SELECT ENO
FROM EMP
WHERE ENO = '1111';

CREATE TABLE T_ST_SC1
AS SELECT SC.CNO
        , SC.SNO
        , ST.SNAME
        , SC.RESULT
       FROM SCORE SC
       JOIN STUDENT ST
         ON SC.SNO = ST.SNO;
        
SELECT *
    FROM T_ST_SC1;

-- �л��� �⸻��� ������ ����� �����ϴ� ���̺�
CREATE TABLE T_ST_AVG_RES1(
    SNO VARCHAR2(8),
    SNAME VARCHAR2(20),
    AVG_RES NUMBER(5,2)
);

-- T_ST_SC1 ���̺��� �����͸� �����ؼ� T_ST_AVG_RES1 ���̺� �����͸� �����ϴ�
-- ���ν��� P_ST_AVG_RES�� �����ϼ���. (Ŀ�����)

CREATE OR REPLACE PROCEDURE P_ST_AVG_RES
IS 
CURSOR CUT_ST_AVG_RES IS
		SELECT SNO
			 , SNAME
			 , AVG(RESULT) as "AVG_RES"
			 FROM T_ST_SC1
             GROUP BY SNO, SNAME;
             
BEGIN 
    DELETE FROM T_ST_AVG_RES1;
    FOR ST_AVG_RES_ROW IN CUT_ST_AVG_RES LOOP
    INSERT INTO T_ST_AVG_RES1
    VALUES ST_AVG_RES_ROW;
    COMMIT;
    END LOOP;
END;
/

EXEC P_ST_AVG_RES;

select*
    FROM T_ST_AVG_RES1;

INSERT INTO T_ST_SC1
VALUES ('1211', '999999', '���õ', 100);
INSERT INTO T_ST_SC1
VALUES ('1213', '999999', '���õ', 30);
INSERT INTO T_ST_SC1
VALUES ('1214', '999999', '���õ', 70);
COMMIT;

        
SELECT *
    FROM T_ST_SC1;

CREATE TABLE ST_SC_GRADE(
    SNO VARCHAR2(8),
    SNAME VARCHAR2(20),
    CNO VARCHAR2(8),
    CNAME VARCHAR2(20),
    SCORE NUMBER(3,0),
    GRADE VARCHAR2(1)
);

-- ST_SC_GRADE ���̺� �л� ���� �⸻��� ���� ��ޱ��� �����ϴ�
-- ���ν��� P_ST_SC_GRADE ����

create or replace PROCEDURE P_ST_SC_GRADE
IS 
    CURSOR CUR_ST_SCG IS
		SELECT ST.SNO
			 , ST.SNAME
             , C.CNO
             , C.CNAME
			 , SC.RESULT
             , SCG.GRADE
			 FROM STUDENT ST
             JOIN SCORE SC
               ON ST.SNO = SC.SNO
             JOIN COURSE C
               ON C.CNO = SC.CNO
             JOIN SCGRADE SCG
               ON SC.RESULT BETWEEN SCG.LOSCORE AND SCG.HISCORE;

BEGIN 
    FOR ST_SCG_ROW IN CUR_ST_SCG LOOP
    INSERT INTO ST_SC_GRADE
    VALUES ST_SCG_ROW;
    COMMIT;
    END LOOP;
END;
/

EXEC P_ST_SC_GRADE;

SELECT *
FROM ST_SC_GRADE;

-- 1-2. �Ķ���Ͱ� �ִ� ���ν���
-- ���ν����� ������ () ��� �Ķ���͵��� ������ �� �ְ�
-- ���ν����� ȣ���� �� ������ �Ķ���� ������ �����Ѵ�.

CREATE OR REPLACE PROCEDURE P_NEW_DEPT(
    DNO VARCHAR2,
    DNAME IN VARCHAR2,
    LOC VARCHAR2 DEFAULT '����',
    DIRECTOR VARCHAR2 DEFAULT '0001'
)
IS 
BEGIN 
    INSERT INTO DEPT(DNO, DNAME, LOC, DIRECTOR)
    VALUES (DNO, DNAME, LOC, DIRECTOR);
    COMMIT;
END;
/

-- �Ķ���Ͱ� �ִ� ���ν����� ������ �� �Ķ���� ������ �����Ѵ�.
-- �⺻���� �ִ� �Ķ���ʹ� ���� ����

EXEC P_NEW_DEPT('80', '�׽�Ʈ');

SELECT * FROM DEPT;

-- 1-3. Stored Function : ����Ŭ ����� ���� �Լ�. ���ν����� ������ ������
-- ������ ���ν����� �ٸ��� ���� ���� �����ؼ� EXEC ��ɾ�� �ܵ� ���൵ �ǰ�
-- �Ϲ� ���������� ȣ�⵵ �����ϴ�.

-- �޿����� ������ ������ִ� �Լ� F_GET_TAX
CREATE OR REPLACE FUNCTION F_GET_TAX
(
    SAL NUMBER
)
-- �Լ��� ����� ������Ÿ�� ����
RETURN NUMBER
IS
    TAX NUMBER;
BEGIN

    IF SAL >= 7000 THEN TAX := 0.5;
    ELSIF SAL >= 6000 THEN TAX := 0.4;
    ELSIF SAL >= 5000 THEN TAX := 0.3;
    ELSE TAX := 0.3;
    END IF;
    
    -- ������ ������ �Լ� ����� ������ Ÿ���� ���� RETURN ������ ����ؼ� ����
    RETURN ROUND(SAL * TAX);
END;
/

-- ������ �Լ� ���������� ���
SELECT F_GET_TAX(3000)
    FROM DUAL;
    
-- ���� ���̺��� �����Ϳ� ȥ���ؼ� ���
SELECT E.ENO
     , E.ENAME
     , E.SAL
     , F_GET_TAX (E.SAL) AS TAX
     FROM EMP E;
    
-- ������ �Ķ���ͷ� �޾Ƽ� 4.5 ������ �������� ȯ���ϴ� F_CONVERT_AVR

CREATE OR REPLACE FUNCTION F_CONVERT_AVR(
    AVR NUMBER
)
RETURN NUMBER
IS
BEGIN
    RETURN ROUND((AVR * 4.5 / 4.0), 2);
END;
/

SELECT SNO
     , SNAME
     , AVR
     , F_CONVERT_AVR(AVR) AS CONVERT_AVR
     FROM STUDENT
     WHERE F_CONVERT_AVR(AVR) >= 4.2;

-- ��¥�� �Ķ���ͷ� �޾Ƽ� 10��� ��¥�� �����ϴ� �Լ� F_PLUS_10YEARS
CREATE OR REPLACE FUNCTION F_PLUS_10YEARS(
    PARAM_DATE DATE
)
RETURN DATE
IS
BEGIN
    RETURN ADD_MONTHS(PARAM_DATE, 120);
END;
/

SELECT PNO
     , PNAME
     , HIREDATE
     , F_PLUS_10YEARS(HIREDATE) AS "������ 10���"
     FROM PROFESSOR;

-- �� ��¥�� �Ķ���ͷ� �޾Ƽ� �� ��¥�� ���̸� ���ڷ� �����ϴ� F_DIFF_DATES

SELECT ROUND(SYSDATE - HIREDATE)
    FROM PROFESSOR;

CREATE OR REPLACE FUNCTION F_DIFF_DATES(
    DT1 DATE, DT2 DATE
)
RETURN NUMBER
IS
BEGIN
    RETURN ABS(TRUNC(DT1 - DT2)); 
END;
/

SELECT F_DIFF_DATES( 
TO_DATE('2000/01/01 10:10:10', 'YYYY/MM/DD HH:MI:SS'), 
TO_DATE('2010/10/10 12:15:30', 'YYYY/MM/DD HH:MI:SS')) as "���̳�¥"
FROM DUAL;

SELECT ENO
     , ENAME
     , HDATE
     , F_DIFF_DATES(SYSDATE, HDATE) "�Ի��� ��������"
     FROM EMP;

-- 1-4. TRIGGER : Ư�� ���̺��� ������ ������ ���� �� ������ PL/SQL ������ ����
-- �ϴ� SUB PROGRAM

-- BEFORE TRIGGER
-- �޿��� 3000�̸����� �Էµǰų� �������� �� ������ ǥ���ϴ� Ʈ����
CREATE OR REPLACE TRIGGER TR_EMP_SAL
-- EMP ���̺��� SAL �÷��� ���� ����ǰų� �߰��Ǳ� ���� �����ϴ� Ʈ����
BEFORE
INSERT OR UPDATE OF SAL ON EMP
-- ���ο� �����͸� �޾ƿ��� ���� ����
REFERENCING NEW AS NEW
-- ��� �࿡ ���ؼ�
FOR EACH ROW 
BEGIN 
    IF :NEW.SAL < 3000 THEN 
        -- �����Ͱ� �߰��� ��
        IF INSERTING THEN
            RAISE_APPLICATION_ERROR
            (-20001, '���� �ñ޺��� ���� �޿��� �߰��� �� �����ϴ�.');
        -- �����Ͱ� ����� ��
        ELSIF UPDATING THEN
            RAISE_APPLICATION_ERROR
            (-20002, '���� �ñ޺��� ���� �޿��� �����͸� ������ �� �����ϴ�.');
        ELSE
            RAISE_APPLICATION_ERROR
            (-20003, '���� �ñ޺��� ����');
        END IF;
    END IF;
END;
/

INSERT INTO EMP
VALUES ('8001', 'ȫ�浿', '�׽�Ʈ', NULL, SYSDATE, 3100, 100, '01'); 
COMMIT;

INSERT INTO EMP
VALUES ('8002', '������', '�׽�Ʈ', NULL, SYSDATE, 2800, 100, '01'); 
COMMIT;

UPDATE EMP
    SET
        SAL = 2900
    WHERE ENO = '9999';

-- AFTER TRIGGER
-- SCORE ���̺��� �����Ͱ� �߰��ǰų� ������� �� ST_SC_GRADE ���̺�
-- �����͸� �߰��ϰų� �����ϴ� Ʈ����
CREATE OR REPLACE TRIGGER TR_ST_SC_GRADE
AFTER
INSERT OR UPDATE ON SCORE
REFERENCING NEW AS NEW
FOR EACH ROW
DECLARE
         ST_SC_GRADE_ROW ST_SC_GRADE%ROWTYPE;
BEGIN 
    SELECT SNAME INTO ST_SC_GRADE_ROW.SNAME
        FROM STUDENT
        WHERE SNO = :NEW.SNO;
    
    SELECT CNAME INTO ST_SC_GRADE_ROW.CNAME
        FROM COURSE
        WHERE CNO = :NEW.CNO;
    
    SELECT GRADE INTO ST_SC_GRADE_ROW.GRADE
        FROM SCGRADE
        WHERE :NEW.RESULT BETWEEN LOSCORE AND HISCORE;
    
    MERGE INTO ST_SC_GRADE A
    USING DUAL
    ON (A.SNO = :NEW.SNO AND A.CNO = :NEW.CNO)
    WHEN MATCHED THEN
        UPDATE
            SET
                SCORE = :NEW.RESULT,
                GRADE = ST_SC_GRADE_ROW.GRADE
    WHEN NOT MATCHED THEN
        INSERT(SNO, SNAME, CNO, CNAME, SCORE, GRADE)
        VALUES(:NEW.SNO, ST_SC_GRADE_ROW.SNAME, :NEW.CNO,
                ST_SC_GRADE_ROW.CNAME, :NEW.RESULT, ST_SC_GRADE_ROW.GRADE);
END;
/

SELECT *
FROM ST_SC_GRADE
WHERE SNO = '999999'
AND CNO = '1212';

UPDATE SCORE
SET RESULT = 100
WHERE SNO = '915301'
AND CNO = '1212';

INSERT INTO SCORE
VALUES ('999999', '1212', 85);

