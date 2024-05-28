-- 1. DDL(DATA DEFINITION LANGUAGE): 데이터 정의어
-- 데이터를 관리하기 위한 객체들을 조작하기 위한 명령어
-- 1-1. CREATE: 객체를 생성하기 위한 명령어
-- CREATE 객체명(TABLE, USER, INDEX, SEQUENCE....) 객체의별칭(테이블명, 유저명, 인덱스명, 시퀀스명....)
-- 다른 테이블을 참조하여 테이블 생성
CREATE TABLE STUDENT_COPY2
	AS SELECT * FROM STUDENT;
	
SELECT *
	FROM STUDENT_COPY2;
	
-- 원하는 대로 컬럼명과 개수를 지정할 수도 있다.
-- 컬럼의 타입은 SELECT 구문에서 조회해오는 데이터의 타입과 맞춰지기 때문에 바꿀 수 없다.
-- 과목의 과목번호, 과목이름, 담당교수번호, 담당교수이름, 과목별 기말고사 성적의 평균이 저장된 테이블 생성
CREATE TABLE COURSE_PROFESSOR_AVGRES(COURESE_NO, COURSE_NAME, PRO_NO, PRO_NAME, AVG_RESULT)
	AS SELECT SC.CNO
		  	, C.CNAME
		  	, C.PNO
		  	, P.PNAME
		  	, ROUND(AVG(SC.RESULT), 2)
		  FROM COURSE C
		  JOIN SCORE SC
		    ON C.CNO = SC.CNO
		  JOIN PROFESSOR P
		    ON C.PNO = P.PNO
		  GROUP BY SC.CNO, C.CNAME, C.PNO, P.PNAME;

SELECT *
	FROM COURSE_PROFESSOR_AVGRES;

-- 학생번호, 학생이름, 학생별 기말고사 성적의 평균점수(소수점 둘째자리), 학생별 기말고사의 평균점수의 등급을 가지는
-- 테이블 ST_AVGRES_GRADE를 생성하세요.
SELECT SC.SNO
	 , ST.SNAME 
	 , ROUND(AVG(SC.RESULT), 2) AS AVG_RES
	FROM SCORE SC
	JOIN STUDENT ST
	  ON SC.SNO = ST.SNO 
	GROUP BY SC.SNO, ST.SNAME;

SELECT A.SNO
	 , A.SNAME
	 , A.AVG_RES
	 , SCG.GRADE
	FROM (
		SELECT SC.SNO
			 , ST.SNAME 
			 , ROUND(AVG(SC.RESULT), 2) AS AVG_RES
			FROM SCORE SC
			JOIN STUDENT ST
			  ON SC.SNO = ST.SNO 
			GROUP BY SC.SNO, ST.SNAME
	) A
	JOIN SCGRADE SCG
	  ON A.AVG_RES BETWEEN SCG.LOSCORE AND SCG.HISCORE;
	 
CREATE TABLE ST_AVGRES_GRADE(STUDENT_NO, STUDENT_NAME, AVG_RESULT, RESULT_GRADE)
	AS SELECT A.SNO
			 , A.SNAME
			 , A.AVG_RES
			 , SCG.GRADE
			FROM (
				SELECT SC.SNO
					 , ST.SNAME 
					 , ROUND(AVG(SC.RESULT), 2) AS AVG_RES
					FROM SCORE SC
					JOIN STUDENT ST
					  ON SC.SNO = ST.SNO 
					GROUP BY SC.SNO, ST.SNAME
			) A
			JOIN SCGRADE SCG
			  ON A.AVG_RES BETWEEN SCG.LOSCORE AND SCG.HISCORE;

SELECT *
	FROM ST_AVGRES_GRADE;

-- 1-2 ALTER: 객체를 변경하거나 수정할 때 사용하는 명령어
-- ALTER 객체명(TABLE, USER, SESSION, INDEX, SEQUENCE,....) 객체의별칭(테이블명, 인덱스명, 유저명,...)
--	 작업내용(SET, ADD, MODIFY, DROP,....)
-- ADD: 테이블에 컬럼추가
-- ADD '추가할 컬럼의 이름' '컬럼의 데이터 타입'
ALTER TABLE EMP_DNO30 ADD ADDR VARCHAR2(1000);

-- RENAME: 테이블 컬럼의 이름의 변경
-- RENAME COLUMN '현재 사용중인 컬럼명' TO '변경할 컬럼명'
ALTER TABLE EMP_DNO30 RENAME COLUMN ADDR TO ADDRESS;

-- MODIFY: 테이블 컬럼의 데이터타입을 변경
-- MODIFY '데이터 타입을 변경할 컬럼명' '변경할 데이터 타입'
-- 데이터 타입을 변경할 컬럼은 데이터가 비어있어야 한다.
ALTER TABLE EMP_DNO30 MODIFY COMM VARCHAR2(10);

ALTER TABLE EMP_DNO30 MODIFY ADDRESS NUMBER(10);

-- DROP: 테이블 컬럼을 삭제
-- DROP COLUMN '삭제할 컬럼명'
-- 컬럼에 저장되어 있던 데이터들도 함께 삭제된다.
ALTER TABLE EMP_DNO30 DROP COLUMN ADDRESS;













