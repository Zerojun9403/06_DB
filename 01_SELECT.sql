use employee_employeesmanagement;

SELECT emp_id, full_name, email
FROM employees;

# departments 테이블 모든 데이터 조회
SELECT *
FROM departments;

#departments 테이블에서 부서코드, 부서명조회(dept_code, dept_name)
SELECT dept_code, dept_name
FROM departments;

# employees 테이블에서 (emp_id, full_name, salary )사번, 이름 급여조회
SELECT emp_id, full_name, salary 
FROM employees;

# training_programs 테이블에서 모든 데이터 조회
SELECT *
FROM training_programs;

# training_programs 테이블에서 (program_name,duration_hours) 프로그램명, 교육시간 조회
SELECT program_name,duration_hours
FROM training_programs;


/**************************
 컬럼 값 산술 연산자
 - 컬럼 값 : 행과 열이 교차되는 테이블의 한 칸에 작성된 값
 
 
 SELECT 문 작성시 컬럼명에 산술 연산을 직접 작성하면
 조회결과(RESULT SET)에 연산 결과 반영되어 조회된다!
***************************/

-- 1. employees 테이블에서 모든 사원의 이름,급여, 급여+500만원을 했을 때 인상결과 조회
SELECT full_name, salary, salary+500000
FROM employees;

-- 2. employees 테이블에서 모든 사원의 이름,연봉(급여*12)조회
SELECT emp_id, full_name, salary*12
FROM employees;


-- 3. training_programs 테이블에서 프로그램명, 교육시간, 하루당 8시간 기준 교육일수 조회
 SELECT program_name,duration_hours / 8
 FROM training_programs;

-- employees 테이블에서  이름, 급여, 급여*0.8 조회(세후 급여)
SELECT full_name, salary, salary * 0.8
FROM employees;


-- POSITIONS 테이블 전체 조회
SELECT *
FROM positions;

-- POSITIONS 테이블에서 직급명, 최소 급여, 최대 급여, 급여차이(최대급여-최소급여) 조회
SELECT position_name, min_salary, max_salary, max_salary - min_salary
FROM positions;

-- departments 테이블에서 부서명, 예산(budget),예산 *1.1 예산의 +10%(예산*1.1) 의 총액 

SELECT dept_name,budget,budget*1.1
FROM departments;

-- 모든 SQL 에서는 DUAL 기상 테이블이 존재함. 
-- Mysql에서는 FROM 을 생략할 경우 자동으로 DUAL 가상테이블 사용
-- 현재 날짜 확인하기(가상 테이블 필요없음) 
SELECT NOW(), current_timestamp;
SELECT NOW(), current_timestamp
from dual;

CREATE DATABASE IF NOT EXISTS 네이버;
CREATE DATABASE IF NOT EXISTS 라인;
CREATE DATABASE IF NOT EXISTS 스노우;

use 네이버;
use 라인;
use 스노우;



-- 날짜 데이터 연산하기 (+,- 만 가능)
-- > +1 ==  1일 추가
-- > -1 ==  1일 감소

SELECT NOW() + interval 1 DAY , now() - interval 1 DAY;

-- 날짜 연산 (시간, 분, 초 단위)

SELECT NOW(),
	   NOW() + interval 1 hour,
	   NOW() + interval 1 minute,
	   NOW() + interval 1 second;



-- 어제, 현재 시간, 내일, 모래 조회
SELECT '2025-09-15', STR_TO_DATE('2025-09-15','%Y-%m-%d');

SELECT DATEDIFF('2025-09-15' , '2025-09-14');

SELECT full_name, hire_date, datediff(curdate(),hire_date)
FROM employees;

-- employees 테이블에서 존재하는 position_id 코드의 종류 조회 중복없이 조회
SELECT distinct dept_id
FROM employees;

SELECT DISTINCT position_id
FROM employees;

/* ******************************
    WHERE 절 
    테이블에서 조건을 충족하는 행을 조회할 떄 사용 
    WHERE 절에는 조건식(ture/false)만 작성
    비교 연산자  : <, >, >=, <= , =(같다) !=(같지않다), <>(같지않다)
    논리 연산자  : AND, OR, NOT
    
    SELECT 컬럼명, 컬럼명,...
    FROM 테이블명
    WHRER 조건식; 
****************************** */
-- employees 테이블에서 급여기준 300만원 초과하는 사원의
-- 사번, 이름, 급여, 부서코드 조회

/*3*/ SELECT emp_id, full_name, salary, dept_id
/*1*/ FROM employees
/*2*/ WHERE salary > 3000000;
/* FROM 절에서 지정된 테이블에서 
** WHERE 절로 행을 먼저 추려내고, 추려진 결과 해들 중에서 
 * SELECT 절에 원하는 컬럼만 조회*/


-- employees 테이블에서 연봉이 5천만원 이하인 사원의 사번, 이름, 연봉조회
SELECT emp_id, full_name, salary*12 AS`연봉`
FROM employees
WHERE salary*12 >= 50000000;


-- employees 테이블에서 부서코드가2번이 아닌 사원의 이름,부서코드,전화번호 조회
SELECT full_name,dept_id,phone
FROM employees
WHERE dept_id != 2;


/* 연결 연산자 CONCAT() */

SELECT CONCAT(emp_id,full_name) as`사번이름연결`
FROM employees;

USE employee_employeesmanagement;

/* ************
    LIKE 절
************ */
-- EMPLOYEES 테이블에서 성이 '김' 씨인 사원의 사번, 이름조회
SELECT emp_id,full_name
FROM employees
WHERE first_name LIKE '김%';

-- employees 테이블에서  full_name 이름에 '민'이 포함되는 사원 의 사번, 이름조회

SELECT emp_id,full_name
FROM employees
WHERE full_name LIKE '%민%';

SELECT * FROM employees;

-- employees 테이블에서 전화번호가 
-- 02 으로 시작하는 사원의 이름, 전화번호 조회
SELECT full_name, phone
FROM employees
WHERE phone LIKE '02%';

-- employees 테이블에서 EMAIL 의 아이디가 (@) 
-- 기준 3글자인 사원의 이름, 이메일 조회
SELECT full_name, email
FROM employees
WHERE email LIKE '___@%';

-- employees 테이블에서 사원코드가 EMP 로 시작하고
-- EMP  포함해서 총 6자리인 사원 조회
SELECT emp_code, full_name, email
FROM employees
WHERE emp_code LIKE 'EMP___';


/* ***********
WHERE 절
AND OR BETWEEN IN()
 *********** */

-- employees 테이블
-- 급여가 4000만 이상, 7000만 이하인 사원의 사번, 이름, 급여 조회
-- emp_id, full_name, salary
-- AND BETWEEN 구문 이용한 두가지 SQL 문작성하기

SELECT emp_id, full_name, salary
FROM employees
WHERE salary BETWEEN 40000000 AND 70000000;

SELECT emp_id, full_name, salary
FROM employees
WHERE salary >= 40000000
  AND salary <= 70000000;

-- employees 테이블
-- 급여가 4000만 미만 또는 8000만 초과인 사원의 사번, 이름, 급여 조회
-- emp_id, full_name, salary
-- OR  NOT BETWEEN 구문 이용한 두가지 SQL 문작성하기
SELECT emp_id, full_name, salary
FROM employees
WHERE salary < 40000000
   OR salary > 80000000;
   
SELECT emp_id, full_name, salary
FROM employees
WHERE salary NOT BETWEEN 40000000 AND 80000000;


-- BETWEEN 구문 이용해서 
-- employees 테이블에서 입사일이 
-- 2020-01-01 부터 2020-12-31 사이인 사원의 이름,입사일 조회
-- full_namem hire_date
SELECT emp_id, full_name, salary
FROM employees
WHERE salary < 40000000
   OR salary > 80000000;
   
SELECT emp_id, full_name, salary
FROM employees
WHERE salary NOT BETWEEN 40000000 AND 80000000;

-- BETWEEN 구문 이용해서 
-- employees 테이블에서 
-- 생년월일이 1980년대인 사원조회
-- emp_id, full_name, date_of_birth

SELECT emp_id, full_name, date_of_birth
FROM employees
WHERE date_of_birth BETWEEN '1980-01-01' AND '1989-12-31';



-- employees 테이블
-- 부서 ID 가 4인 사원중
-- 급여가 4000만 이상, 7000만 이하인 사원의 사번, 이름, 급여 조회
-- emp_id, full_name, salary
-- AND BETWEEN 구문 이용한 두가지 SQL 문작성하기
SELECT emp_id, full_name, salary, DEPT_ID
FROM employees
WHERE  DEPT_ID = 4 AND  ( salary  BETWEEN  40000000 AND 70000000 )  ;
 
-- ORDER 절 WHERE 응용 IN()절  JOIN 절

-- employees 테이블에서 
-- 부서코드가 2,4,5 인 사원의 
-- 이름, 부서코드, 급여 조회
SELECT full_name, dept_id, salary
FROM employees
WHERE dept_id = 2
OR dept_id =4
OR dept_id =5;


-- 컬럼의 값이() 내 값과 일치하면 true
SELECT full_name, dept_id, salary
FROM employees
WHERE dept_id IN(2,4,5);

-- employees 테이블에서 
-- 부서코드가 2,4,5 인 사원을 재외하고 
-- 이름, 부서코드, 급여 조회
SELECT full_name, dept_id, salary
FROM employees
WHERE dept_id NOT IN(2,4,5);

-- --> dept_id 가 NULL 인 사람들 또한 제외된 후 조회
-- NULL 값을 가지면서, 부서코드가 2,4,5 를 제외한 모든 사원들을 결과에 추가하는 구문
SELECT full_name, dept_id, salary
FROM employees
WHERE dept_id NOT IN(2,4,5)
OR dept_id IS NULL;



SELECT *
FROM employees;


/*************** 
	ORDER BY 절
    - SELECT 문의 조회 결과(RESULT SET)를 정렬할 때 사용하는 구문
    
    SELECT 구문에서 가장 마지막에 해석됨.
    [작성법]
    3:SELECT 컬럼명 AS 별치으 컬럼명, 컬럼명, ...
    1:FROM 테이블명
    2:WHERE 조건식
    4:ORDER BY  컬럼명 | 명칭 | 컬럼 순서[오름/내림 차순]
		 * 컬럼이 오름차순인지 내림차순인지 작성되지 않았을 때는 기본으로 오름차순 정렬
		 * ASC  : 오름차순( = ascending)
		 * DESC : 내림차순( = descending)

***************/



-- employees 테이블에서 모든 사원의 이름, 급여 조회
-- 단, 급여 오름차순으로 정렬
/*2*/ SELECT full_name, salary 
/*1*/ FROM employees
/*3*/ order by salary; -- ASC 기본 값

/*2*/ SELECT full_name, salary 
/*1*/ FROM employees
/*3*/ order by salary ASC; 

SELECT full_name, salary 
FROM employees
order by salary DESC; 

-- employees 테이블에서 
-- 급여가 300만원이상, 600만원 이하인 사람의 
-- 사번, 이름, 급여를 이름 내림차순으로 조회 
SELECT emp_id, full_name, salary
FROM employees
WHERE salary BETWEEN 4000000 AND 100000000 
ORDER BY full_name DESC;

SELECT emp_id, full_name, salary
FROM employees
WHERE salary BETWEEN 4000000 AND 100000000 
ORDER BY 2 DESC; -- 2번째 컬럼(full_name)으로 정렬 


/* ODER BY 절 수식 적용 해서 정렬 가능 */
-- employees 테이블에서 이름, 연봉을 연봉 내림차순으로 조회

SELECT full_name, salary*12
FROM employees
ORDER BY salary*12 DESC;

SELECT full_name, salary*12 AS 연봉
FROM employees
ORDER BY 연봉 * 12 DESC;

SELECT full_name, salary*12 AS 연봉
FROM employees
ORDER BY salary * 12 DESC;

/* NULL 값 정렬 처리  */
-- 기본적으로 NULL 값은 가장 작은 값으로 처리됨
-- ASC : NULL 최상위 존재
-- DESC : NULL 최하위 존재 
 
/*3*/SELECT full_name, dept_id AS 부서코드
/*1*/FROM employees
/*2*/WHERE dept_id = 4
/*4*/ORDER BY 부서코드 DESC;


--  모든 사원의 이름 전화번호를 phone 기준으로 오름차순 조회
SELECT full_name, phone 
FROM employees
WHERE phone 
ORDER BY phone DESC;


-- employees 테이블에서 
-- 이름, 부서ID 급여를 
-- 급여 내림차순 정렬
SELECT full_name, emp_code,salary 
FROM employees
WHERE salary 
ORDER BY salary;


/*****************
수업용_SCRIPT_2 를 활용하여 GROP BY HAVING 실습하기 
기본 문법 순서
SELECT 컬럼명, 집계함수()
FORM 테이블 이름
WHERE 조건 -- 개별 향 하나씩 에 대한 조건
GROUP BY 컬럼명 -- 그룹 만들기(SELECT ORDER 에서 집계함수로 작성되지 않은 컬럼명칭 모두 작성)
HAVING 집계조건 -- 조회할 그룹에 대한 조건
ORDER BY -- 정렬 기준
* 주의할 점 : 숫자값에 NULL 이 존재한다면 WHERE 로 NULL 을 먼저 필더링 처리
WHERE 컬럼 이름이 IS NOT NULL 
과 같이 NULL 이 존재하지 않는 데이터들을 통해서 조회
---------------------------------------------------------
집계함수
COUNT(*) : 개수 세기
AVG()    : 합계에 대한 평균
MAX()    : 최고로 높은 숫값
MIN()    : 최저로 낮은 숫값

테이블 구조 
store(가게테이블)
번호, 가게명, 카테고리, 평점, 배달비
id, name, category, rating deliver_fee


menus(메뉴 테이블)
메뉴번호, 가게번호, 메뉴명, 가격, 인기메뉴여부
id, store_id, name, price, is_popular
*****************/

USE delivery_app;
-- 각 카테고리 별로 가게가 몇개 씩 존재하는지 확인하기 
-- select category as 가게수
SELECT category, COUNT(*) AS 가게수
FROM stores
GROUP BY category
ORDER BY COUNT(*) DESC;


-- store 테이블애서 
-- 각 카테코리 별 평균 배달비 구하기 
-- null 존재하는지 확인학고, null 이 아닌 배달비 만 조회
SELECT category, AVG(delivery_fee) 
FROM stores
WHERE delivery_fee IS NOT NULL
GROUP BY category;





