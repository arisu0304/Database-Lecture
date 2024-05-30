--1) 4.5 환산 평점이 가장 높은 3인의 학생을 검색하세요.

SELECT ROWNUM
	 , A.SNO
	 , A.SNAME
 	 , A.AVR_CONVERT
FROM (
	SELECT SNO
		 , SNAME
		 , ROUND(AVR * 4.5 / 4.0 , 2) AS AVR_CONVERT
	FROM STUDENT  
	ORDER BY AVR DESC
	) A
WHERE ROWNUM <= 3;

--2) 기말고사 과목별 평균이 높은 3과목을 검색하세요.

SELECT ROWNUM
	 , A.CNO
	 , A.CNAME
 	 , A.AVG_RES
FROM (
	SELECT C.CNO
		 , C.CNAME
		 , ROUND(AVG(SC.RESULT), 2) AS AVG_RES
	FROM COURSE C
	JOIN SCORE SC
	ON SC.CNO = C.CNO
	GROUP BY C.CNO , C.CNAME
	ORDER BY AVG_RES DESC
	) A
WHERE ROWNUM <= 3;

--3) 학과별, 학년별, 기말고사 평균이 순위 3까지를 검색하세요.(학과, 학년, 평균점수 검색)

SELECT ROWNUM
	 , A.MAJOR
	 , A.SYEAR
	 , A.AVG_RES
FROM (
	SELECT	ST.MAJOR
		 , ST.SYEAR
		 , ROUND(AVG(SC.RESULT), 2) AS AVG_RES
	FROM COURSE C
	JOIN SCORE SC
	ON SC.CNO = C.CNO
	JOIN STUDENT ST
	ON ST.SNO = SC.SNO
	GROUP BY ST.MAJOR, ST.SYEAR
	ORDER BY AVG_RES DESC
	) A
WHERE ROWNUM <= 3;

--4) 기말고사 성적이 높은 과목을 담당하는 교수 3인을 검색하세요.(교수이름, 과목명, 평균점수 검색)

SELECT ROWNUM
 	 , A.PNO
 	 , A.PNAME
 	 , A.CNO
 	 , A.CNAME
 	 , A.AVG_RES
FROM (
	SELECT P.PNO
		 , P.PNAME
		 , C.CNO
		 , C.CNAME
		 , ROUND (AVG(SC.RESULT), 2) AS AVG_RES 
	FROM PROFESSOR P
	JOIN COURSE C
	ON P.PNO = C.PNO
	JOIN SCORE SC
	ON SC.CNO = C.CNO
	GROUP BY P.PNO , P.PNAME, C.CNO , C.CNAME
	ORDER BY AVG_RES DESC
	) A
WHERE ROWNUM <= 3;

--5) 교수별로 현재 수강중인 학생의 수를 검색하세요.

SELECT P.PNO
	 , P.PNAME
	 , COUNT(*)
FROM PROFESSOR P
JOIN COURSE C
ON P.PNO = C.PNO
JOIN SCORE SC
ON SC.CNO = C.CNO 
JOIN STUDENT ST
ON ST.SNO = SC.SNO
GROUP BY P.PNO , P.PNAME


















