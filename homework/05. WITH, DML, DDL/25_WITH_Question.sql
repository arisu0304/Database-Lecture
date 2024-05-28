--1) WITH 절을 이용하여 정교수만 모여있는 가상테이블 하나와 일반과목(과목명에 일반이 포함되는)들이 모여있는 가상테이블 하나를 생성하여 
--   일반과목들을 강의하는 교수의 정보 조회하세요.(과목번호, 과목명, 교수번호, 교수이름)
WITH 
	P1 AS (
		SELECT *
		FROM PROFESSOR
		WHERE ORDERS = '정교수'
	),
	C1 AS(
		SELECT *
		FROM COURSE 
		WHERE CNAME LIKE '%일반%'
	)
	SELECT C1.CNO
		 , C1.CNAME
		 , P1.PNO
		 , P1.PNAME
	FROM P1
	JOIN C1
	ON P1.PNO = C1.PNO
	

--2) WITH 절을 이용하여 급여가 3000이상인 사원정보를 갖는 가상테이블 하나와 보너스가 500이상인 사원정보를 갖는 가상테이블 하나를 생성하여
--   두 테이블에 모두 속해있는 사원의 정보를 모두 조회하세요.
	
	WITH 
	E AS (
		SELECT *
		FROM EMP
		WHERE SAL >= 3000
	),
	EE AS(
		SELECT *
		FROM EMP
		WHERE COMM >= 500
	)
	SELECT *
	FROM E
	JOIN EE
	ON E.ENO = EE.ENO
	
	

--3) WITH 절을 이용하여 평점이 3.3이상인 학생의 목록을 갖는 가상테이블 하나와 학생별 기말고사 평균점수를 갖는 가상테이블 하나를 생성하여
--   평점이 3.3이상인 학생의 기말고사 평균 점수를 조회하세요.

	WITH 
	SSS AS (
		SELECT *
		FROM STUDENT
		WHERE AVR >= 3.3
	),
	SSC AS(
		SELECT ST.SNO
			 , ROUND(AVG(SC."RESULT"), 2) AS AVG_RESULT
		FROM STUDENT ST
		JOIN SCORE SC
		ON SC.SNO = ST.SNO
		GROUP BY ST.SNO
	)
	SELECT *
	FROM SSS
	JOIN SSC
	ON SSS.SNO = SSC.SNO
	
	
--4) WITH 절을 이용하여 부임일자가 25년이상된 교수정보를 갖는 가상테이블 하나와 과목번호, 과목명, 학생번호, 학생이름, 교수번호, 기말고사성적을
--   갖는 가상테이블 하나를 생성하여 기말고사 성적이 90이상인 과목번호, 과목명, 학생번호, 학생이름, 교수번호, 교수이름, 기말고사성적을 조회하세요.
	
	
	WITH 
	PP AS (
		SELECT *
		FROM PROFESSOR 
		WHERE MONTHS_BETWEEN(SYSDATE, HIREDATE) >= 12 * 25
	),
	SS AS(
		SELECT P.PNO
		FROM COURSE C
		JOIN PROFESSOR P
		ON C.PNO = P.PNO
		JOIN SCORE SC
		ON SC.CNO = C.CNO
		JOIN STUDENT ST
		ON ST.SNO = SC.SNO
	)
	SELECT *
	FROM PP
	JOIN SS
	ON PP.PNO = SS.PNO;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	