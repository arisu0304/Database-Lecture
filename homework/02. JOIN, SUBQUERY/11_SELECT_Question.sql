--1) 각 과목의 과목명과 담당 교수의 교수명을 검색하라
SELECT C.CNAME 
	 , NVL(P.PNAME, '담당 교수 미정') AS PNAME 
	FROM COURSE C
	LEFT JOIN PROFESSOR P
	  ON C.PNO = P.PNO; 

--2) 화학과 학생의 기말고사 성적을 모두 검색하라
SELECT S.SNO 
	 , S.SNAME
	 , S.SYEAR 
	 , S.MAJOR 
	 , SC."RESULT" 
	FROM STUDENT S
	JOIN SCORE SC
	  ON S.SNO = SC.SNO 
	WHERE S.MAJOR = '화학'; 

	 
--3) 유기화학과목 수강생의 기말고사 시험점수를 검색하라
SELECT S.SNO 
	 , S.SNAME
	 , S.SYEAR 
	 , C.CNAME 
	 , SC."RESULT" 
	FROM STUDENT S
	JOIN SCORE SC
	  ON S.SNO = SC.SNO 
	JOIN COURSE C
	  ON C.CNO = SC.CNO 
	WHERE C.CNAME = '유기화학'; 

--4) 화학과 학생이 수강하는 과목을 담당하는 교수의 명단을 검색하라

SELECT S.SNAME 
	 , S.SYEAR 
	 , S.MAJOR 
	 , C.CNAME 
	 , P.PNAME 
	 , P."SECTION" 
	FROM STUDENT S
	JOIN SCORE SC
	  ON S.SNO = SC.SNO 
	JOIN COURSE C
	  ON C.CNO = SC.CNO 
	JOIN PROFESSOR P
	  ON P.PNO = C.PNO 
	WHERE S.MAJOR = '화학';

--5) 모든 교수의 명단과 담당 과목을 검색한다

SELECT P.PNAME 
	 , P."SECTION" 
	 , NVL(C.CNAME, '담당 과목 미정') AS CNAME
	FROM PROFESSOR P
	LEFT JOIN COURSE C
	  ON C.PNO  = P.PNO 

--6) 모든 교수의 명단과 담당 과목을 검색한다(단 모든 과목도 같이 검색한다)

SELECT NVL(P.PNAME, '담당 교수 미정') AS PNAME 
	 , NVL(P."SECTION" , '담당 교수 미정') AS "SECTION" 
	 , NVL(C.CNAME, '담당 과목 미정') AS CNAME  
	FROM PROFESSOR P
	FULL JOIN COURSE C
	  ON C.PNO  = P.PNO 
	  
	 
	  
	  
	  