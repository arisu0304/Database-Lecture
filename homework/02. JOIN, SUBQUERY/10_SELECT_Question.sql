--1) 학생중에 동명이인을 검색한다
SELECT DISTINCT S.SNO
	 , S.SNAME
	FROM STUDENT S
	JOIN STUDENT SS
	  ON S.SNO != SS.SNO AND S.SNAME = SS.SNAME;

--2) 전체 교수 명단과 교수가 담당하는 과목의 이름을 학과 순으로 검색한다
SELECT P.PNAME 
	 , P."SECTION" 
	 , P.ORDERS 
	 , NVL(C.CNAME, '담당 과목 없음') AS CNAME 
	FROM PROFESSOR P
	LEFT JOIN COURSE C
	  ON C.PNO = P.PNO
	ORDER BY P."SECTION" ; 
	
--3) 이번 학기 등록된 모든 과목과 담당 교수의 학과 순으로 검색한다

SELECT C.CNAME 
	 , NVL(P.PNAME, '담당 교수 미정') AS PNAME 
	 , NVL(P."SECTION", '담당 교수 미정') AS "SECTION" 
	 , NVL(P.ORDERS, '담당 교수 미정') AS ORDERS
	FROM PROFESSOR P
	RIGHT JOIN COURSE C
	  ON C.PNO = P.PNO
	ORDER BY P."SECTION" ; 
	
	



