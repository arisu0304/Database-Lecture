-- 1. SUB QUERY
-- 1-1. 단일 행 서브쿼리
-- SELECT, FROM, JOIN, WHERE 절에서 사용가능한 서브쿼리
SELECT PNO
	 , PNAME 
	FROM PROFESSOR 
	WHERE HIREDATE < (
					SELECT HIREDATE 
						FROM PROFESSOR
						WHERE PNAME = '송강'
					);

-- 손하늘 사원보다 급여(연봉)가 높은 사원의 사원번호, 사원이름, 급여 조회
SELECT E.ENO 
	 , E.ENAME 
	 , E.SAL 
	FROM EMP E
	WHERE SAL > (
				SELECT SAL 
					FROM EMP
					WHERE ENAME = '손하늘'
				);
			
-- 위 쿼리를 JOIN 절로 변경

SELECT E.ENO 
	 , E.ENAME 
	 , E.SAL 
	FROM EMP E
	JOIN(
				SELECT SAL 
					FROM EMP
					WHERE ENAME = '손하늘'
	) A
	ON E.SAL > A.SAL;		
			
-- 공융의 일반화학 기말고사 성적보다 높은 학생의 학생번호, 학생이름
-- 과목번호, 과목이름, 기말고사 성적 조회

-- 서브쿼리
SELECT SC."RESULT" 
	FROM SCORE SC
	JOIN COURSE C
	  ON C.CNO  = SC.CNO 
	JOIN STUDENT S
	  ON SC.SNO = S.SNO 
   WHERE S.SNAME = '공융'
	 AND C.CNAME = '일반화학'

SELECT SS.SNO 
	 , SS.SNAME 
	 , SC.CNO 
	 , SC.CNAME 
	 , SSC."RESULT" 
	FROM STUDENT SS
	JOIN SCORE SSC
	  ON SSC.SNO = SS.SNO 
	JOIN COURSE SC
	  ON SC.CNO = SSC.CNO
	 AND SC.CNAME = '일반화학'
	JOIN (SELECT SC."RESULT" 
			FROM SCORE SC
			JOIN COURSE C
			  ON C.CNO  = SC.CNO 
			JOIN STUDENT S
			  ON SC.SNO = S.SNO 
		   WHERE S.SNAME = '공융'
			 AND C.CNAME = '일반화학'
	) B
	ON  SSC."RESULT"  > B."RESULT"; 		
			
-- 1-2. 다중행 서브쿼리
-- 서브쿼리의 결과가 여러행인 서브쿼리
-- FROM, JOIN, WHERE 절에서 사용가능
-- 급여가 3000이상인 사원의 사원번호, 사원이름, 급여 조회

SELECT SAL
	FROM EMP
	WHERE SAL >= 3000;

-- FROM, JOIN 절에서 사용

SELECT E.ENO
	 , E.ENAME
	 , E.SAL
	 FROM EMP E
	 JOIN(
	 	SELECT ENO 
	 		FROM EMP
	 		WHERE SAL >= 3000
	 ) A
	   ON E.ENO = A.ENO;

-- WHERE 절에서 사용
	  
SELECT E.ENO
	 , E.ENAME
	 , E.SAL
	 FROM EMP E
	 WHERE E.ENO IN (
					 	SELECT ENO
					 		FROM EMP
					 		WHERE SAL >= 3000
					 );

-- 1-3. 다중열 서브쿼리
-- 서브쿼리의 결과가 다중행이면서 다중열인 서브쿼리
-- FROM, JOIN 절에서만 사용가능
-- 과목번호, 과목이름, 교수번호, 교수이름을 조회하는 서브쿼리를 작성 후
-- 기말고사 성적 테이블과 조인하여 과목번호, 과목이름, 교수번호,
-- 교수이름, 기말고사 성적을 조회

-- 서브쿼리 없이 (JOIN 횟수가 많아져 구조가 복잡해진다.)
SELECT C.CNO
	 , C.CNAME
	 , P.PNO
	 , P.PNAME
	 , SC."RESULT"
	FROM COURSE C
	JOIN SCORE SC
	  ON C.CNO = SC.CNO
	JOIN PROFESSOR P
      ON C.PNO = P.PNO;

-- 서브쿼리 사용시     
SELECT A.CNO
	 , A.CNAME
	 , A.PNO
	 , A.PNAME
	 , SC."RESULT"
	FROM (
	   SELECT C.CNO
	   		, C.CNAME
	   		, P.PNO
	   		, P.PNAME
		FROM COURSE C
		JOIN PROFESSOR P
		  ON C.PNO = P.PNO
	) A
	JOIN SCORE SC
	  ON A.CNO = SC.CNO;

-- 서브쿼리는 그룹함수와 주로 사용	 
SELECT ST.SNO
	, ST.SNAME
	, AVG(SC."RESULT")
	FROM STUDENT ST
	JOIN SCORE SC
	  ON SC.SNO = SC.SNO 
	GROUP BY ST.SNO , ST.SNAME;
	
-- 학생번호, 학생이름, 과목번호, 과목이름, 기말고사 성적, 기말고사 등급
-- 담당 교수번호, 담당 교수이름 조회하는데
-- STUDENT, SCORE, SCGRADE 테이블의 내용을 서브쿼리1

SELECT ST.SNO
	 , ST.SNAME
	 , SC."RESULT" 
	 , GR.GRADE 
	 , SC.CNO
	FROM STUDENT ST
	JOIN SCORE SC
	  ON ST.SNO = SC.SNO 
	JOIN SCGRADE GR
	  ON SC."RESULT" BETWEEN GR.LOSCORE 
	  		AND GR.HISCORE

-- COURSE, PROFESSOR 테이블의 내용을 서브쿼리2
			  		
SELECT C.CNO 
 	 , C.CNAME
 	 , P.PNO 
 	 , P.PNAME 
	FROM COURSE C
	JOIN PROFESSOR P
	  ON C.PNO  = P.PNO			  		

-- 두 서브쿼리를 JOIN	  

SELECT A.SNO
	 , A.SNAME
	 , B.CNO 
     , B.CNAME
     , A."RESULT"
	 , A.GRADE
     , B.PNO 
     , B.PNAME 
	FROM (
		SELECT ST.SNO
			 , ST.SNAME
			 , SC."RESULT" 
			 , GR.GRADE 
			 , SC.CNO
			FROM STUDENT ST
			JOIN SCORE SC
			  ON ST.SNO = SC.SNO 
			JOIN SCGRADE GR
			  ON SC."RESULT" BETWEEN GR.LOSCORE 
			  		AND GR.HISCORE
	)A
	JOIN (
		 SELECT C.CNO 
		 	  , C.CNAME
		 	  , P.PNO 
		 	  , P.PNAME 
			FROM COURSE C
			JOIN PROFESSOR P
			  ON C.PNO  = P.PNO 
	)B
	  ON A.CNO = B.CNO;


