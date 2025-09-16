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

/*
WHERE DEPT_ID = 4
  AND salary BETWEEN 40000000 AND 70000000;

*/


