--1) 송강 교수가 강의하는 과목을 검색한다
SELECT C.CNAME 
	 , P.PNAME 
	 , P."SECTION" 
	 , P.ORDERS 
	FROM COURSE C
	JOIN PROFESSOR P
	  ON C.PNO = P.PNO 
	WHERE P.PNAME = '송강';

--2) 화학 관련 과목을 강의하는 교수의 명단을 검색한다
SELECT P.PNAME 
	 , P."SECTION" 
	 , P.ORDERS 
	 , C.CNAME 
	FROM PROFESSOR P
	JOIN COURSE C
	  ON C.PNO = P.PNO
	WHERE C.CNAME LIKE '%화학%';

--3) 학점이 2학점인 과목과 이를 강의하는 교수를 검색한다
SELECT C.CNAME 
	 , C.ST_NUM 
	 , P.PNAME 
	 , P."SECTION" 
	 , P.ORDERS 
	FROM PROFESSOR P
	JOIN COURSE C
	  ON C.PNO = P.PNO 
	WHERE C.ST_NUM = 2;

--4) 화학과 교수가 강의하는 과목을 검색한다
SELECT P.PNAME 
	 , P."SECTION" 
	 , P.ORDERS
	 , C.CNAME 
	FROM COURSE C
	JOIN PROFESSOR P
	  ON C.PNO = P.PNO 
	WHERE P."SECTION" = '화학';

--5) 화학과 1학년 학생의 기말고사 성적을 검색한다

SELECT S.SNO
	 , S.SNAME 
	 , S.MAJOR 
	 , S.SYEAR 
	 , SC."RESULT" 
	FROM SCORE SC
	JOIN STUDENT S
	  ON SC.SNO = S.SNO 
	WHERE S.SYEAR = 1
	AND S.MAJOR = '화학';

--6) 일반화학 과목의 기말고사 점수를 검색한다

SELECT C.CNAME 
	 , SC."RESULT" 
	FROM SCORE SC
	JOIN COURSE C
	  ON C.CNO = SC.CNO
	WHERE C.CNAME = '일반화학';

--7) 화학과 1학년 학생의 일반화학 기말고사 점수를 검색한다

SELECT S.SNO 
	 , S.SNAME 
	 , C.CNAME 
	 , SC."RESULT" 
	FROM SCORE SC
	JOIN COURSE C
	  ON C.CNO = SC.CNO
	JOIN STUDENT S
	  ON S.SNO = SC.SNO 
	WHERE S.MAJOR = '화학' AND S.SYEAR = 1 AND C.CNAME = '일반화학';
	

--8) 화학과 1학년 학생이 수강하는 과목을 검색한다

SELECT S.SNO 
	 , S.SNAME 
	 , S.MAJOR 
	 , S.SYEAR 
	 , C.CNAME 
	FROM COURSE C
	JOIN SCORE SC
	  ON C.CNO = SC.CNO 
	JOIN STUDENT S
	  ON S.SNO = SC.SNO
	WHERE S.SYEAR  = 1 AND S.MAJOR = '화학';

--9) 유기화학 과목의 평가점수가 F인 학생의 명단을 검색한다

SELECT S.SNO 
	 , S.SNAME
	 , S.MAJOR 
	 , S.SYEAR
	 , SC."RESULT" 
	 , C.CNAME 
	 , GR.GRADE 
	FROM STUDENT S
	JOIN SCORE SC
	  ON S.SNO = SC.SNO
	JOIN SCGRADE GR
	  ON SC."RESULT" BETWEEN  GR.LOSCORE  AND GR.HISCORE
	JOIN COURSE C
	  ON C.CNO = SC.CNO 
	WHERE C.CNAME = '유기화학' AND GR.GRADE = 'F'; 










