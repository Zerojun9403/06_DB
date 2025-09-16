-- 문제 1
-- chun_university 데이터베이스의 STUDENT 테이블에서 
-- 모든 학생의 학번(STUDENT_NO), 이름(STUDENT_NAME), 주소(STUDENT_ADDRESS)를 조회하시오.
SELECT STUDENT_NO,STUDENT_NAME,STUDENT_ADDRESS
FROM STUDENT
;

-- 문제 2
-- PROFESSOR 테이블의 모든 데이터를 조회하시오.
SELECT *
FROM PROFESSOR;

-- 문제 3
-- DEPARTMENT 테이블에서 학과번호(DEPARTMENT_NO)와 학과명(DEPARTMENT_NAME)을 조회하시오.
SELECT DEPARTMENT_NO,DEPARTMENT_NAME
FROM DEPARTMENT;

-- 문제 4
-- STUDENT 테이블에서 모든 학생의 이름, 입학일, 입학일로부터 현재까지의 일수를 조회하시오.
-- (컬럼명은 각각 '학생이름', '입학일', '재학일수'로 별칭 지정)
-- 			MYSQL 자체적으로 개발자를 위해 만든 기능 DATEDIFF() : 현재날짜와  입학일 을 계산해서 재학일자를 알려줌
SELECT STUDENT_NAME  AS  학생이름 , ENTRANCE_DATE AS `입학일`, DATEDIFF(NOW(), ENTRANCE_DATE) AS "재학일수"
FROM STUDENT;

-- 문제 5
-- 현재 시간과 어제, 내일을 조회하시오.
-- (컬럼명은 각각 '현재시간', '어제', '내일'로 별칭 지정)
-- 가상테이블 : DUAL  DUmmy tAbLe
-- DUMMY : 인간이나 실제 데이터 대신 사용되는 모형

SELECT NOW() 현재시간, NOW() - interval 1 DAY AS "어제", NOW() + interval 1 DAY AS "내일";

USE chun_university;
-- 문제 6
-- STUDENT 테이블에서 학번과 이름을 연결하여 하나의 컬럼으로 조회하시오.
-- (컬럼명은 '학번_이름'으로 별칭 지정)
SELECT * FROM STUDENT;

SELECT CONCAT( STUDENT_NO,'_',STUDENT_NAME) AS "학번_이름"
FROM STUDENT;

-- 문제 7
-- STUDENT 테이블에서 존재하는 학과번호의 종류만 중복 없이 조회하시오.
SELECT distinct department_NO
FROM STUDENT;

-- 문제 8
-- GRADE 테이블에서 중복 없이 존재하는 학기번호(TERM_NO) 종류를 조회하시오.
SELECT distinct  TERM_NO
FROM GRADE;

-- 문제 9
-- STUDENT 테이블에서 휴학여부(ABSENCE_YN)가 'Y'인 학생의 
-- 학번, 이름, 학과번호를 조회하시오.
SELECT STUDENT_NO, STUDENT_NAME, department_NO, ABSENCE_YN
FROM STUDENT
WHERE ABSENCE_YN = Y;

-- 문제 10
-- DEPARTMENT 테이블에서 정원(CAPACITY)이 25명 이상인 학과의 
-- 학과명, 분류, 정원을 조회하시오.
SELECT  DEPARTMENT_NAME, CATEGORY, CAPACITY
FROM DEPARTMENT
WHERE CAPACITY >= 25;

-- 문제 11
-- STUDENT 테이블에서 학과번호가 '001'이 아닌 학생의 
-- 이름, 학과번호, 주소를 조회하시오.
SELECT  student_NAME, DEPARTMENT_NO, STUDENT_ADDRESS
FROM STUDENT
WHERE DEPARTMENT_NO != 001;

-- 문제 12
-- GRADE 테이블에서 성적(POINT)이 4.0 이상인 성적 데이터의 
-- 학기번호, 과목번호, 학번, 성적을 조회하시오.
SELECT *
FROM GRADE
WHERE POINT >= 4.0;

-- 문제 13
-- STUDENT 테이블에서 2005년에 입학한 학생의 
-- 학번, 이름, 입학일을 조회하시오.
SELECT student_no, student_name, entrance_date FROM STUDENT
WHERE entrance_date 
LIKE '2005%';

-- 문제 14 (보기만하기)
-- WHERE DEPARTMENT_NO IS NOT NULL;
-- PROFESSOR 테이블에서 소속 학과번호(DEPARTMENT_NO)가 NULL이 아닌 교수의 
-- 교수번호, 이름, 학과번호를 조회하시오.
SELECT  PROFESSOR_NO, PROFESSOR_NAME,  DEPARTMENT_NO
FROM PROFESSOR
WHERE DEPARTMENT_NO != NULL;

-- 문제 15
-- CLASS 테이블에서 과목유형(CLASS_TYPE)이 '전공필수'인 과목의 
-- 과목번호, 과목명, 과목유형을 조회하시오.
SELECT class_no, class_name, CLASS_TYPE
FROM CLASS
WHERE CLASS_TYPE = '전공필수';

-- 문제 16 (보기만하기)
-- WHERE STUDENT_ADDRESS LIKE '서울시%';
-- STUDENT 테이블에서 주소가 '서울시'로 시작하는 학생의 
-- 이름, 주소, 입학일을 조회하시오.
select STUDENT_name, STUDENT_address, entrance_date 
from STUDENT
WHERE STUDENT_ADDRESS LIKE '서울시%';

-- 문제 17
-- GRADE 테이블에서 성적이 3.0 이상 4.0 미만인 성적 데이터의 
-- 학번, 과목번호, 성적을 조회하시오.
SELECT student_no, class_no, point
FROM GRADE
WHERE point >= 3.0
OR    point < 4.0;

-- 문제 18
-- STUDENT 테이블에서 지도교수번호(COACH_PROFESSOR_NO)가 'P001'인 학생의 
-- 학번, 이름, 학과번호를 조회하시오.
select student_no, student_name, department_no
from STUDENT
where COACH_PROFESSOR_NO = 'P001';

-- 문제 19
-- DEPARTMENT 테이블에서 분류(CATEGORY)가 '인문사회'인 학과의 
-- 학과명, 분류, 개설여부를 조회하시오.
select department_name, category, open_yn
from department
where CATEGORY='인문사회';

-- 문제 20 (보기만하기)
-- WHERE STUDENT_NO LIKE '%A%';
-- STUDENT 테이블에서 학번에 'A'가 포함된 학생의 
-- 학번, 이름, 입학일을 조회하시오.
select STUDENT_NO, student_name, entrance_date
from STUDENT
WHERE STUDENT_NO LIKE '%A%';