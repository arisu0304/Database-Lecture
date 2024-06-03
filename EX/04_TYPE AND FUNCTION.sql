-- 1. 단일행 함수
-- 단일행 함수는 하나의 데이터를 받아 하나의 결과값을 리턴
-- 단일행 함수에는 문자함수, 숫자함수, 날짜함수, 일반함수 등이
-- 존재
-- LOWER = 영문자를 소문자로 변환해서 리턴
-- UPPER = 영문자를 대문자로 변환
-- INITCAT = 영문자의 첫 글자만 대문자, 나머지는 소글자
SELECT  DNO
	  , LOWER(DNAME)
	  , UPPER(DNAME)
	  , INITCAP(DNAME)
	  FROM  DEPT ;
	  
	 
-- 부서이름이 대문자인지 소문자인지 알 수 없을때
-- LOWER를 이용해서 소문자로 비교
SELECT DNO
 	 , DNAME
 	 , LOC
 	 , DIRECTOR
 	 FROM DEPT
 WHERE LOWER(DNAME) = 'erp';
 	 
-- 1-2. 문자 연산 함수
-- CONCAT(데이터1, 데이터2) : 데이터1과 데이터2가 결합된
-- 새로운 데이터 리턴
SELECT CONCAT(SNAME, AVR)
	FROM STUDENT;

-- CONCAT 함수는 매개변수 2개만 받을 수 있어서
-- 여러 개의 데이터나 다른 표현을 넣고 싶을 때는 ||와 조합
SELECT CONCAT(SNAME, ':' || AVR)
	FROM STUDENT;

-- CONCAT을 이용해서 부서번호, 부서이름, 지역을
-- 부서번호 : 부서이름 : 지역 형태로 조회

SELECT CONCAT(DNO, ':'||DNAME||':'||LOC )
		AS "부서번호 : 부서이름: 지역"
	FROM DEPT;

-- SUBSTR (데이터, 시작인덱스, 개수) : 받아온 데이터에서
-- 시작 인덱스에서 개수만큼 데이터를 잘라서 리턴
-- 교수 중에 정교수인 교수의 교수번호, 교수이름, 직위 조회
SELECT PNO
	 , PNAME
	 , ORDERS
	 FROM PROFESSOR
	 WHERE SUBSTR(ORDERS, 1, 1) = '정';
	
SELECT ENAME
	 , SUBSTR(ENAME, 2) -- 2번째 글자부터 모두
	 , SUBSTR(ENAME, -2) -- 뒤에서 두번째 글자부터 모두
	 , SUBSTR(ENAME, 1, 2) -- 첫번째 글자부터 두글자
	 , SUBSTR(ENAME, -2, 2) -- 뒤에서 두번째 글자부터 두글자
	 FROM EMP;
	 
-- LENGTH : 데이터의 길이를 리턴
-- LENGTHB :	데이터의 길이를 BYTE 단위로 리턴
-- 오라클의 기본 문자셋은 AL32UTF8 => 영어를 제외한 다른 문자는
-- 3BYTE 씩 계산, 영어는 1BYTE
SELECT DNAME
	 , LENGTH(DNAME)
	 , LENGTHB(DNAME)
	 FROM DEPT;

-- INSTR(데이터, 문자) : 데이터에서 주어진 문자의 위치를 리턴
-- DUAL 테이블 : 오라클에서 제공하는 가상의 테이블 ,간단하게 날짜나 
-- 연산, 결과값을 보기위해서 사용
-- DUAL 테이블의 소유자는 SYS계정이지만 모든 사용자에서 사용가능
SELECT INSTR('DATABASE', 'A') -- 첫번째 A의 위치
     , INSTR('DATABASE', 'A', 3) -- 세번째 글자인 T 이후 첫번째 A의 위치
     , INSTR('DATABASE', 'A', 1, 3) -- 첫번째 글자인 D 다음의 세번째 A의 위치
     FROM DUAL ;

-- TRIM
-- TRIM(leading 접두어 FROM 데이터) : 
-- 데이터에서 접두어에 해당하는 값을 앞에서 제거
-- TRIM(trailing 접미어 FROM 데이터) : 
-- 데이터에서 접미어에 해당하는 값을 뒤에서 제거
-- TRIM(both 문자 FROM 데이터) : 
-- 데이터에서 문자에 해당하는 값을 앞뒤에서 제거
-- TRIM(데이터) : 
-- 데이터에서 공백을 앞뒤에서 제거
  
SELECT TRIM(LEADING '0' FROM '000123000')
	 , TRIM(TRAILING '0' FROM '000123000')
	 , TRIM(BOTH '0' FROM '000123000') -- BOTH는 생략가능
	 , TRIM('    0 0 0 1 2 3 0 0 0    ')
	 FROM DUAL;
	 
-- LPAD(데이터, 길이, 문자) : 지정한 길이에서 데이터의 길이를 뺀 
-- 나머지 길이만큼 문자로 앞에 채워주는 함수
-- RPAD(데이터, 길이, 문자) : 지정한 길이에서 데이터의 길이를 뺀 
-- 나머지 길이만큼 문자로 뒤에 채워주는 함수
-- LPAD, RPAD : 영어를 제외한 나머지 문자를 2BYTE 계산
SELECT LPAD(ENAME, 10, '*')
	 , RPAD(ENAME, 10, '*')
	 FROM EMP;

-- 지정한 길이가 데이터의 길이보다 작거나 같으면 문자를 붙이지 않는다.
SELECT LPAD(ENAME, 6, '*')
	 , RPAD(ENAME, 6, '*')
	 FROM EMP;

-- 사원의 사원번호, 사원이름을 조회하는데 사원이름에서 마지막 한 글자
-- 만 빼고 조회

SELECT ENO
	 , SUBSTR(ENAME, 1, LENGTH(ENAME) -1)
	 FROM EMP;

-- 1-3. 문자열 치환함수
-- TRANSLATE
-- 치환될 문자에 포함된 모든 문자를 치환한다.
-- W, o에 대한 번역이라고 생각
SELECT TRANSLATE('World of War', 'Wo', '--')
	FROM DUAL ;
	
-- REPLACE 
-- 치환될 문자열과 동일한 문자열만 치환한다.
-- 문자열 자체를 치환한다고 생각
SELECT REPLACE('World of War', 'Wo', '--')
	FROM DUAL ;
	
-- 1-4. 숫자함수
-- ROUND(데이터, 소수점 자리수): 지정된 자리수까지 반올림하여 반환
SELECT ROUND(123.45678, 3)
	FROM DUAL;

-- 학생의 학생번호, 학생이름, 전공, 학년, 4.5로 치환된 
-- 평점을 조회하는데 평점은 소수점 둘째자리 까지
-- (ROUND 함수 사용)

SELECT SNO 
	 , SNAME  
	 , MAJOR 
	 , SYEAR 
	 , ROUND(AVR * 4.5 / 4.0 , 2)
	FROM STUDENT;

-- TRUNC(데이터, 소수점 자리수): 지정된 자리수까지 내림하여 반환
SELECT TRUNC(123.45678, 3)
	FROM DUAL;

-- MOD(데이터1, 데이터2):데이터1에서 데이터2를 나눈 나머지 리턴
SELECT MOD(10, 4)
	FROM DUAL;

-- POWER(데이터1, 데이터2):데이터1의 데이터2승을 리턴
SELECT POWER(3,3)
	FROM DUAL;

-- CEIL(데이터):데이터보다 큰 가장 작은 정수 리턴
-- FLOOR(데이터):데이터보다 작은 가장 작은 정수 리턴

SELECT CEIL(2.59)
	 , FLOOR(2.59)
	 FROM DUAL;
	
-- SQRT(데이터) : 데이터의 제곱근 값을 리턴
SELECT SQRT(9)
	 , SQRT(25)
	 , SQRT(100)
	 FROM DUAL;

-- SIGN(데이터) : 데이터의 부호를 판별
-- 음수면 -1 ,양수면 1, 0이면 0
SELECT SIGN(-123)
	 , SIGN(0)
	 , SIGN(456)
	 FROM DUAL;

-- 1-5. 날짜연산
SELECT SYSDATE 
	 , SYSDATE +100 -- 현재부터 100일 뒤
	 , SYSDATE -100 -- 현재부터 100일 전
	 , SYSDATE + 3/24 -- 현재부터 3시간 뒤
	 , SYSDATE - 5/24 -- 현재부터 5시간 전
	 , SYSDATE - TO_DATE('20230523', 'YYYYMMDD')
	 	-- 두 날짜간의 차이
	 -- 날짜에 TRUNC 함수를 사용하면 시분초를 00:00:00으로 초기화
	 , TRUNC(SYSDATE) - TO_DATE('20230523', 'YYYYMMDD')
	 FROM DUAL;
	 
-- 1999년 1월 1일부터 100일 뒤 까지 부임한 교수의
-- 교수번호, 교수이름, 부임일자 조회
SELECT PNO
	 , PNAME
	 , HIREDATE
	FROM PROFESSOR
	WHERE HIREDATE BETWEEN TO_DATE('19990101', 'YYYYMMDD')
		AND TO_DATE('19990101', 'YYYYMMDD') + 100;

-- 1-6. 날짜 함수
-- ROUND(날짜, 날짜 단위) : 지정한 날짜 단위까지의 날짜는 빼오고
-- 나머지 날짜는 초기화, 날짜를 빼올 때 절반 이상 지났으면 올림

SELECT ROUND(SYSDATE, 'DD')
	FROM DUAL;

SELECT ROUND(TO_DATE('20241124', 'YYYYMMDD'), 'MM')
	FROM DUAL;

-- TRUNC(날짜, 날짜단위) : 지정한 날짜 단위까지의 날짜는 빼오고 나머지 날짜는 초기화.
-- 버려지는 날짜는 그냥 초기화

SELECT SYSDATE 
	 , TRUNC(SYSDATE, 'YYYY')
	 , TRUNC(SYSDATE, 'MM')
	 , TRUNC(SYSDATE, 'DD')
	 FROM DUAL;
	
-- MONTHS_BETWEEN(날짜1, 날짜2) : 날짜1에서 날짜2를 뺀 일자
-- 차이를 개월수로 치환해서 리턴
SELECT MONTHS_BETWEEN(TRUNC(SYSDATE, 'DD'), 
			TO_DATE('20230523', 'YYYYMMDD')) 	
	FROM DUAL;

-- ADD_MONTHS(날짜, 숫자) : 날짜에서 숫자만큼의 개월수를 더한 날짜 리턴
SELECT ADD_MONTHS(SYSDATE, 5)
	FROM DUAL;
	
-- NEXT_DAY(날짜, 요일):날짜 이후에 처음으로 만나는 요일의 날짜 리턴
SELECT NEXT_DAY(SYSDATE, '일요일')
	FROM DUAL;

-- LAST_DAY(날짜):날짜를 포함하고 있는 달의 마지막 날짜를 리턴
SELECT LAST_DAY(SYSDATE)
	FROM DUAL;

-- 사원의 사원번호, 사원이름, 입사일, 입사일 + 100일의 날짜
-- 입사일 + 10년의 날짜 조회

SELECT ENO 
	 , ENAME 
	 , HDATE 
	 , HDATE + 100
	 , ADD_MONTHS(HDATE , 120)
	FROM EMP;

-- 1-7. 변환함수
-- TO_CHAR(날짜나 숫자, 변환될 문자열의 형식지정자) : 매개변수로
-- 받은 날짜나 숫자데이터를 지정된 형식으로 변환한 문자열을 리턴

-- 숫자를 문자열로 변환
SELECT TO_CHAR(10000000, '999,999,999')
		-- 9자리까지 숫자를 표기하고 3자리마다 쉼표 표시
	 , TO_CHAR(1000000, '099,999,999')
	 	-- 9자리까지 숫자를 표기하고 3자리마다 쉼표 표시, 
	 	-- 0을 붙여서 표기
	 FROM DUAL;

-- 날짜를 문자열로 변환
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS')
	 , TO_CHAR(SYSDATE, 'YYYY/MM/DD DAY')
	 , TO_CHAR(SYSDATE, '"오늘은 " YYYY "년" MM "월" DD "일 입니다."')
	 , TO_CHAR(SYSDATE, 'DY"요일입니다."') 
	 FROM DUAL;

-- 문자열을 날짜로 변환하는 TO_DATE와의 차이점
SELECT TO_DATE('2024/05/24 15:18:00', 
				'YYYY/MM/DD HH24:MI:SS')
	FROM DUAL;

-- TO_DATE(문자열 데이터, 문자열 데이터의 날짜 형식) :
-- 매개변수로 지정된 날짜형식으로 되어있는 문자열을 DATE 타입
-- 으로 변환 후 리턴

SELECT TO_DATE('20240524154900', 
			'YYYYMMDDHH24MISS')
	 , TO_DATE('240524 15' , 'YYMMDD HH24')
	 , TO_DATE('24', 'YY')
	 , TO_DATE('24', 'RR')
	 , TO_DATE('99', 'YY')
	 , TO_DATE('99', 'RR')
	 , TO_DATE('2024/05', 'YYYY/MM') 
	FROM DUAL;

-- TO_NUMBER(문자열 데이터, 문자열 데이터의 숫자형식) :
-- 매개변수로 지정된 숫자형식으로 된 문자열을 NUMBER 타입으로
-- 변환 후 리턴

SELECT TO_NUMBER('-123.456', '999.999')
	 , TO_NUMBER('123', '999.99')
	 , TO_NUMBER('1234')
	 FROM DUAL;

-- ROUND(실수, 소수점), TRUNC(실수, 소수점)
-- ROUND(실수), TRUNC(실수) : 
-- 정수까지(소수점 첫째자리에서) 반올림, 정수까지 버림
SELECT ROUND(1.45, 0)
	 , ROUND(1.45)
	 FROM DUAL;
	
-- 1-8. NVL : NULL 처리 함수
-- 과목의 과목번호, 과목이름, 교수번호, 교수이름을 조회하는데
-- 담당교수가 배정되지 않은 과목과 과목을 배정받지 못한 교수의
-- 정보도 함께 조회
-- 담당교수가 NULL인 데이터는 교수 배정되지 않음이라고 조회하고
-- 과목이 없는 교수의 과목정보는 과목 배정받지 못함이라고 조회

SELECT NVL(C.CNO, '과목 배정되지 않음')
	 , NVL(C.CNAME, '과목 배정되지 않음')
	 , NVL(P.PNO, '교수 배정받지 못함')
	 , NVL(P.PNAME, '교수 배정받지 못함')
	FROM COURSE C
	FULL JOIN PROFESSOR P
	ON C.PNO = P.PNO; 
	
-- 1-9. DECODE (컬럼명이나 조회해온 데이터, 조건 값1, 
--				컬럼의 데이터나 조회해온 데이터가 조건 값1과
--				일치할 때 실행될 내용,
--				불일치시 실행될 내용)
-- DECODE는 조건문을 처리하는 구문오로 조건에는 값만 넣어서
-- 사용할 수 있다.

SELECT ENO
	 , ENAME
	 , DNO
	 , DECODE(DNO, '10', '인사팀', '다른 부서') AS "부서명"
	 FROM EMP
	 ORDER BY DNO;

-- 1-9. DECODE (컬럼명이나 조회해온 데이터, 조건 값1, 
--				컬럼의 데이터나 조회해온 데이터가 조건 값1과
--				일치할 때 실행될 내용,
--				조건값2,
--				조건값 2와 일치하는 내용,
--				조건값 3,
--				조건값 3과 일치하는 내용,
--				...
--				조건값 N, 
--				조건값 N과 일치하는 내용,
--				모두 불일치시 실행될 내용)
-- DECODE는 조건문을 처리하는 구문오로 조건에는 값만 넣어서
-- 사용할 수 있다.
	 
SELECT ENO
	 , ENAME
	 , DNO
	 , DECODE(DNO, 
	 		  '10', '인사팀',
	 		  '01', '경영팀',
	 		  '02', '부서팀',
	 		  '그외 부서') AS "부서명"
	 FROM EMP
	 ORDER BY DNO;

-- 사원의 사원번호, 사원이름, 업무, 급여, 인상급여 조회
-- 업무가 개발이면 50% 인상, 업무가 경영이면 30% 인상,
-- 지원이면 20% 인상, 그외 업무면 10% 인상된 인상급여 조회
	
SELECT ENO 
	 , ENAME 
	 , JOB 
	 , SAL 
	 , DECODE(JOB,
	 		  '개발', SAL*1.5, 
	 		  '경영', SAL*1.3,
	 		  '지원', SAL*1.2,
	 		  SAL*1.1
	 ) AS "인상급여"
	FROM EMP
	ORDER BY "인상급여" DESC ;
	
-- 1-10. CASE~WHEN~THEN~ELSE~ END
-- CASE (컬럼명)
-- 	WHEN 조건1
-- 	THEN 조건1이 TRUE 일때 처리할 내용
-- 	WHEN 조건2
-- 	THEN 조건2 TRUE
-- 	...
-- 	WHEN 조건N
-- 	THEN 조건N TRUE
-- 	ELSE
-- 	위 조건이 모두 FALSE 일때 처리할 내용
-- 	END AS 별칭
 	
SELECT ENO
	 , ENAME
	 , COMM
	 , CASE NVL(COMM, -1)
	 	WHEN 0
	 	THEN '보너스 없음'
	 	WHEN -1
	 	THEN '해당없음'
	   ELSE '보너스 : ' || COMM
	   END AS COMM_TXT
	   FROM EMP ;
	
-- 사원의 사원번호, 사원이름, 업무, 급여, 인상급여 조회
-- 업무가 개발이면 50% 인상, 업무가 경영이면 30% 인상,
-- 지원이면 20% 인상, 그외 업무면 10% 인상된 인상급여 조회
	
SELECT ENO
	 , ENAME
	 , JOB
	 , SAL
	 , CASE JOB
	 	WHEN '개발'
	 	THEN SAL * 1.5
	 	WHEN '경영'
	 	THEN SAL * 1.3
	 	WHEN '지원'
	 	THEN SAL * 1.2
	   ELSE SAL * 1.1
	   END AS "인상급여"
	   FROM EMP ;
	
	
	
	
	
	
	
	
	
















	
	
	
	
	
	
	
	
	
	
	
	
	 
	 














	
	
	
	
	
	
	
	
	
	
	
	
	


















	
	
	
	
	
	
	
	
	
	

	
	
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 






ㅇ


