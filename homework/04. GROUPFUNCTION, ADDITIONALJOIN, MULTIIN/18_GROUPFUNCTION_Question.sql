--1) 화학과를 제외하고 학과별로 학생들의 평점 평균을 검색하세요
SELECT MAJOR 
	 , ROUND(AVG(AVR), 2)
FROM STUDENT 
WHERE MAJOR != '화학'
GROUP BY MAJOR;

--2) 화학과를 제외한 각 학과별 평균 평점 중에 평점이 2.0 이상인 정보를 검색하세요

SELECT MAJOR 
	 , ROUND(AVG(AVR), 2)
FROM STUDENT 
WHERE MAJOR != '화학'
GROUP BY MAJOR 
HAVING AVG(AVR) >= 2;

--3) 기말고사 평균이 60점 이상인 학생의 정보를 검색하세요

SELECT S.SNAME 
	 , ROUND(AVG("RESULT"), 2)
FROM STUDENT S
JOIN SCORE SC
ON S.SNO = SC.SNO
GROUP BY S.SNO, S.SNAME
HAVING AVG("RESULT") >= 60;


--4) 강의 학점이 3학점 이상인 교수의 정보를 검색하세요

SELECT P.PNAME 
	 , SUM(C.ST_NUM)
FROM PROFESSOR P
JOIN COURSE C
ON P.PNO = C.PNO 
GROUP BY P.PNO, P.PNAME 
HAVING SUM(C.ST_NUM) >= 3;


--5) 기말고사 평균 성적이 핵 화학과목보다 우수한 과목의 과목명과 담당 교수명을 검색하세요

SELECT C.CNAME 
	 , P.PNAME 
	 , AVG(SC."RESULT")
FROM PROFESSOR P
JOIN COURSE C
ON P.PNO = C.PNO
JOIN SCORE SC
ON SC.CNO = C.CNO 
GROUP BY C.CNO, C.CNAME, P.PNO, P.PNAME
HAVING AVG(SC."RESULT") >=
	(	SELECT AVG(SSC."RESULT")
			FROM SCORE SSC
			JOIN COURSE CC
			ON SSC.CNO = CC.CNO
			WHERE CC.CNAME = '핵화학'
			GROUP BY CC.CNO, CC.CNAME
	  );

--6) 근무 중인 직원이 4명 이상인 부서를 검색하세요(부서번호, 부서명, 인원수)
SELECT E.DNO
	 , D.DNAME 
	 , COUNT(*)
FROM EMP E
JOIN DEPT D
ON E.DNO = D.DNO 
GROUP BY E.DNO, D.DNAME
HAVING COUNT(*) >= 4;
	 

--7) 업무별 평균 연봉이 3000 이상인 업무를 검색하세요

SELECT E.JOB 
	 , ROUND(AVG(E.SAL), 2)
FROM EMP E
GROUP BY E.JOB 
HAVING AVG(E.SAL) >= 3000;

--8) 각 학과의 학년별 인원중 인원이 5명 이상인 학년을 검색하세요

SELECT S.MAJOR 
	 , S.SYEAR 
	 , COUNT(*)
FROM STUDENT S
GROUP BY S.MAJOR, S.SYEAR 
HAVING COUNT(*) >= 5;










