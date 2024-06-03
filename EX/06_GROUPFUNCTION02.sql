-- 1. 그룹화 관련 함수
-- 1-1. ROLLUP
-- 처음에는 GROUP BY에 지정된 모든 컬럼으로 그룹화된
-- 결과를 보여주고 다음부터는 마지막에 지정된 컬럼을 하나씩
-- 뺀 그룹화된 결과를 보여주다가 마지막에는 그룹화되지 않은
-- 전체 데이터에 대한 결과를 보여준다.
-- ROLLUP을 사용하지 않았을때
SELECT DNO 
	 , JOB 
	 , MAX(SAL)
	 , SUM(SAL)
	 , AVG(SAL)
	 , COUNT(*)
	FROM EMP
	GROUP BY DNO, JOB;
	
SELECT DNO 
	 , JOB 
	 , MAX(SAL)
	 , SUM(SAL)
	 , AVG(SAL)
	 , COUNT(*)
	FROM EMP
	GROUP BY ROLLUP(DNO, JOB);
	
SELECT DNO 
	 , JOB 
	 , MAX(SAL)
	 , SUM(SAL)
	 , AVG(SAL)
	 , COUNT(*)
	FROM EMP
	GROUP BY DNO, JOB;

SELECT DNO 
	 , MAX(SAL)
	 , SUM(SAL)
	 , AVG(SAL)
	 , COUNT(*)
	FROM EMP
	GROUP BY DNO;
	
SELECT MAX(SAL)
	 , SUM(SAL)
	 , AVG(SAL)
	 , COUNT(*)
	FROM EMP;

-- ROLLUP 함수를 이용해서 전공별 학년별 평균평점,
-- 평균의 총합, 최고 평점 조회
-- 전공별 평균평점, 평점의 총합, 최고 평점 조회
-- 전체 학생에 대한 평균평점, 평점의 총합, 최고 평점 조회

SELECT MAJOR
	 , SYEAR
	 , ROUND(AVG(AVR), 2)
	 , SUM(AVR)
	 , MAX(AVR)
	FROM STUDENT
	GROUP BY ROLLUP(MAJOR, SYEAR);

-- 1-2. CUBE
-- ROLLUP 함수와 지정방식은 동일하지만 동작 방식이 다르다.
-- ROLLUP 함수가 GROUP BY에 지정된 컬럼을 뒤에서부터
-- 하나씩 빼면서 그룹화를 진행한다면
-- CUBE 함수는 GROUP BY에 지정된 컬럼의 모든 조합에
-- 대한 그룹화를 진행한다.
-- ROLLUP 사용시
SELECT  MAJOR
	  , SYEAR
	  , SEX
	  , AVG(AVR)
	  , SUM(AVR)
	  , MAX(AVR)
	  , COUNT(*)
	  FROM STUDENT
	  GROUP BY ROLLUP(MAJOR, SYEAR, SEX);
	  
SELECT  MAJOR
	  , SYEAR
	  , SEX
	  , AVG(AVR)
	  , SUM(AVR)
	  , MAX(AVR)
	  , COUNT(*)
	  FROM STUDENT
	  GROUP BY CUBE(MAJOR, SYEAR, SEX);	  
	  
-- 1-3. GROUPING SETS : GROUP BY에 지정된 컬럼들의
-- 각각 그룹화된 결과를 보여준다.
	 
SELECT DNO
	 , MAX(SAL)
	 , SUM(SAL)
	 , AVG(SAL)
	 , COUNT(*)
	 FROM EMP
	 GROUP BY DNO
UNION	
SELECT JOB
	, MAX(SAL)
	, SUM(SAL)
	, AVG(SAL)
	, COUNT(*)
	FROM EMP
	GROUP BY JOB;
	 
SELECT DNO
	 , JOB
	 , MAX(SAL)
	 , SUM(SAL)
	 , AVG(SAL)
	 , COUNT(*)
	 FROM EMP
	 GROUP BY GROUPING SETS(DNO, JOB);
	 
-- 1-4. GROUPING, GROUPING_ID
-- 지정된 컬럼에 대한 그룹화 여부를 확인하는 함수
-- GROUPING 함수는 매개변수를 하나만 지정할 수 있고
-- GROUPING_ID 함수는 매개변수로 여러개의 컬럼을 지정 가능
-- GROUPING 함수는 그룹화가 진행됐으면 0, 아니면 1
-- GROUPIND_ID 함수는 지정된 컬럼들 각각에 대해 
-- 그룹화가 진행됐으면 0, 아니면 1 을 이진수로 조합하여	
-- 출력은 십진수로 변환해서 출력한다.
-- GROUPING(DNO), GROUPING(JOB), GROUPING_ID(DNO, JOB)
--       0             0          이진수:00 -> 십진수 0
--       1             0          이진수 10 -> 십진수 : 2	
--       0             1          이진수:01 -> 십진수 : 1
--       1 	           1          이진수:11 -> 십진수 :3
SELECT DNO
	 , JOB
	 , MAX(SAL)
	 , SUM(SAL)
	 , AVG(SAL)
	 , COUNT(*)
	 , GROUPING(DNO)
	 , GROUPING(JOB)
	 , GROUPING_ID(DNO, JOB)
	FROM EMP
	GROUP BY CUBE(DNO, JOB);

-- CUBE 함수를 이용해서
-- 전공별 학년별 성별별 최고 평점, 평점의 합계, 평점의 평균,
-- 학생 수 조회
-- 전공별 학년별 ...
-- 전공별 성별별 ...
-- 학년별 성별별 ...
-- 전공별 ...
-- 학년별 ...
-- 성별별 ...
-- 전체 데이터 ...
-- 조회하는데 각각의 전공, 학년, 성별 컬럼이 그룹화 됐는지 확인

SELECT MAJOR 
	 , SYEAR 
     , SEX 
 	 , MAX(AVR)
	 , SUM(AVR)
	 , ROUND(AVG(AVR), 2)
	 , COUNT(*)
	 , GROUPING (MAJOR)
	 , GROUPING (SYEAR)
	 , GROUPING (SEX)
	 , GROUPING_ID(MAJOR, SYEAR, SEX)
	FROM STUDENT
	GROUP BY CUBE(MAJOR, SYEAR, SEX);

-- 1-5. LISTAGG : 그룹화된 컬럼에 포함되는 데이터를 확인
-- 하고 싶을 때 사용하는 함수

SELECT DNO
	 , COUNT(*)
	 , LISTAGG(ENAME, ', ')
	   WITHIN GROUP(ORDER BY SAL DESC)
	 FROM EMP
	 GROUP BY DNO;
	
-- 전공별 학년별 학생수 조회(포함된 학생이름도 함께 조회)
-- LISTAGG 함수를 사용해서, 평점 높은 순으로 정리

SELECT MAJOR 
	 , SYEAR 
	 , COUNT(SNO)
	 , LISTAGG(SNAME, ', ')
	   WITHIN GROUP(ORDER BY AVR)
	FROM STUDENT 
	GROUP BY MAJOR, SYEAR; 

-- 1-6. PIVOT, UNPIVOT
-- PIVOT : 기존 행 데이터들을 컬럼으로 변경해주는 함수
-- UNPIVOT : 기존 컬럼들을 행 데이터로 변경해주는 함수
SELECT *
	FROM (
			SELECT JOB
				 , SAL
			 	FROM EMP
    	 )
    	 -- 통계함수를 사용하는데 GROUP BY를 사용하지 
    	 -- 않는 이유는 데이터들이 컬럼으로 변경되면서
    	 -- 컬럼은 중복되지 않기때문에
    	 -- 같은 값을 가지고 있는 데이터끼리 그룹화가
    	 -- 자동으로 일어난다.
    	 -- 아래 보면 알겠지만 우리가 남기고 싶은 데이터 값은 MAX, 그를 설명해주는 해당과는 그냥 열 이름으로 붙여도 무방
    	 -- MAX(SAL)을 JOB에 대응하여 나열한다고 해석
    	 PIVOT(
    	 	MAX(SAL)
    	 		FOR JOB IN(
    	 			'경영' AS "OPER",
    	 			'지원' AS "지원",
    	 			'회계' AS "ACCOUNT",
    	 			'개발' AS "DEVELOP",
    	 			'분석' AS "분석"
    	 		)
    	 );
-- PIVOT은 FROM 절에서 그룹화할 컬럼, 통계낼 컬럼만
-- 조회하는 서브쿼리를 사용해야한다.
 SELECT *
		FROM EMP
    	 PIVOT(
    	 	MAX(SAL)
    	 		FOR JOB IN(
    	 			'경영' AS "OPER",
    	 			'지원' AS "지원",
    	 			'회계' AS "ACCOUNT",
    	 			'개발' AS "DEVELOP",
    	 			'분석' AS "분석"
    	 		)
    	 );   	

-- PIVOT에서 생성한 컬럼들은 SELECT 문에서 바로 사용가능
SELECT OPER
	 , 지원
	 , ACCOUNT
	 , DEVELOP
	 , 분석
	FROM (
			SELECT JOB
				 , SAL
			 	FROM EMP
    	 )
    	 -- 통계함수를 사용하는데 GROUP BY를 사용하지 
    	 -- 않는 이유는 데이터들이 컬럼으로 변경되면서
    	 -- 컬럼은 중복되지 않기때문에
    	 -- 같은 값을 가지고 있는 데이터끼리 그룹화가
    	 -- 자동으로 일어난다.
    	 PIVOT(
    	 	MAX(SAL)
    	 		FOR JOB IN(
    	 			'경영' AS "OPER",
    	 			'지원' AS "지원",
    	 			'회계' AS "ACCOUNT",
    	 			'개발' AS "DEVELOP",
    	 			'분석' AS "분석"
    	 		)
    	 );

-- 전공별 학년별 최고 평점 조회하는데 PIVOT을 이용해서
-- 전공을 컬럼으로 조회
SELECT *	
	FROM (
				SELECT MAJOR
					 , SYEAR
					 , AVR
				 	FROM STUDENT
	      )    	
			PIVOT(
				MAX(AVR)
					FOR MAJOR IN(
						'화학' AS "화학",
						'생물' AS "생물",
						'물리' AS "물리",
						'유공' AS "유공",
						'식영' AS "식영",
						'컴공' AS "컴공"
					)
			)

-- 아래 나오는 테이블에서 MAJOR를 행으로 치환시킨다.
-- 컨트롤 쉬프트 F 로 자동정렬
SELECT
	MAJOR
	 ,
	SYEAR
	 ,
	MAX(AVR)
FROM
	STUDENT
GROUP BY
	MAJOR,
	SYEAR
ORDER BY
	SYEAR DESC;

-- UNPIVOT
SELECT *
	FROM (
		SELECT MAX(DECODE (JOB, '경영', SAL))
			AS "경영"
			, MAX(DECODE (JOB, '지원', SAL))
			AS "지원"
			, MAX(DECODE (JOB, '회계', SAL))
			AS "회계"
			, MAX(DECODE (JOB, '개발', SAL))
			AS "개발"
			, MAX(DECODE (JOB, '분석', SAL))
			AS "분석"
			FROM EMP
	);

SELECT *
	FROM (
		SELECT MAX(DECODE (JOB, '경영', SAL))
			AS "경영"
			, MAX(DECODE (JOB, '지원', SAL))
			AS "지원"
			, MAX(DECODE (JOB, '회계', SAL))
			AS "회계"
			, MAX(DECODE (JOB, '개발', SAL))
			AS "개발"
			, MAX(DECODE (JOB, '분석', SAL))
			AS "분석"
			FROM EMP
	)
	UNPIVOT(
		MAX_SAL FOR J IN(
			경영, 지원, 회계, 개발, 분석
		)
	);

-- 정역학, 일반화학, 양자물리학의 기말고사 성적의 평균을
-- 조회하는데 과목이름을 컬럼으로 조회
SELECT *
FROM(
	SELECT S."RESULT" 
	     , C.CNAME
	FROM SCORE S
	JOIN COURSE C
      ON C.CNO = S.CNO
)  
PIVOT(
	AVG(RESULT)
	FOR CNAME IN(
		'정역학' AS "정역학",
		'일반화학' AS "일반화학",
		'양자물리학' AS "양자물리학"
	)
);

-- 아래의 쿼리문을 UNPIVOT을 이용해서 각 과목이름을 행 데이터로 조회
-- 기말고사 평균성적 컬럼은 AVG_RESULT
-- 과목이름은 COURSE_NAME으로 지정

SELECT*
FROM(
	SELECT AVG(DECODE(C.CNAME, '정역학', SC.RESULT))
		   AS "정역학"
		 , AVG(DECODE(C.CNAME, '정역학', SC.RESULT))
		   AS "정역학"
		 , AVG(DECODE(C.CNAME, '정역학', SC.RESULT))
		   AS "정역학"
		   FROM COURSE C
		   JOIN SCORE SC
		   ON C.CNO = SC.CNO
);

SELECT *
FROM(
	SELECT AVG(DECODE(C.CNAME, '정역학', SC.RESULT))
		   AS "정역학"
		 , AVG(DECODE(C.CNAME, '일반화학', SC.RESULT))
		   AS "일반화학"
		 , AVG(DECODE(C.CNAME, '양자물리학', SC.RESULT))
		   AS "양자물리학"
		   FROM COURSE C
		   JOIN SCORE SC
		   ON C.CNO = SC.CNO
)
UNPIVOT(
	AVG_RESULT FOR COURSE_NAME IN(
			정역학, 일반화학, 양자물리학
		)
)







