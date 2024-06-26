--1) 과목번호, 과목이름, 교수번호, 교수이름을 담을 수 있는 변수들을 선언하고 
--   유기화학 과목의 과목번호, 과목이름, 교수번호, 교수이름을 출력하세요.

DECLARE
		CNO_INFO COURSE.CNO%TYPE;
		CNAME_INFO COURSE.CNAME%TYPE;
		PNO_INFO PROFESSOR.PNO%TYPE;
		PNAME_INFO PROFESSOR.PNAME%TYPE;
BEGIN
		SELECT C.CNO, C.CNAME , P.PNO , P.PNAME
			INTO CNO_INFO, CNAME_INFO, PNO_INFO, PNAME_INFO
			FROM PROFESSOR P
			JOIN COURSE C
			  ON P.PNO = C.PNO
			WHERE C.CNAME = '유기화학';
		
	DBMS_OUTPUT.PUT_LINE(CNO_INFO);
	DBMS_OUTPUT.PUT_LINE(CNAME_INFO);
	DBMS_OUTPUT.PUT_LINE(PNO_INFO);
	DBMS_OUTPUT.PUT_LINE(PNAME_INFO);
	
END;

--2) 위 데이터들을 레코드로 선언하고 출력하세요.

DECLARE
	TYPE COURSE_PROFESSOR_REC IS RECORD(
		CNO COURSE.CNO%TYPE,
		CNAME COURSE.CNAME%TYPE,
		PNO PROFESSOR.PNO%TYPE,
		PNAME PROFESSOR.PNAME%TYPE
	);

	COURSEPROFESSORREC COURSE_PROFESSOR_REC;

BEGIN
	
	SELECT C.CNO
		 , C.CNAME
		 , P.PNO
		 , P.PNAME
		INTO COURSEPROFESSORREC
		FROM PROFESSOR P
		JOIN COURSE C
		  ON P.PNO = C.PNO
		WHERE C.CNAME = '유기화학';
		
	DBMS_OUTPUT.PUT_LINE(COURSEPROFESSORREC.CNO);
	DBMS_OUTPUT.PUT_LINE(COURSEPROFESSORREC.CNAME);
	DBMS_OUTPUT.PUT_LINE(COURSEPROFESSORREC.PNO);
	DBMS_OUTPUT.PUT_LINE(COURSEPROFESSORREC.PNAME);

END;