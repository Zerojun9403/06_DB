-- Q1. 문제: STUDENT 테이블에서 학생 이름의 길이가 3글자인 학생의 학번, 이름을 조회하시오.
SELECT
    STUDENT_NO,
    STUDENT_NAME
FROM STUDENT
WHERE LENGTH(STUDENT_NAME) = 3;


-- Q2. 문제: STUDENT 테이블에서 주민등록번호 앞 6자리를 생년월일로 하여
-- 학번, 이름, 생년월일을 조회하시오. (별칭: 생년월일)
SELECT
    STUDENT_NO,
    STUDENT_NAME,
    SUBSTRING(STUDENT_SSN, 1, 6) AS 생년월일
FROM STUDENT;

-- Q3. 문제: DEPARTMENT 테이블에서 학과명에 '학과'를 '전공'으로 바꾼 결과를
-- 학과번호, 기존학과명, 변경학과명으로 조회하시오
SELECT
    DEPARTMENT_NO,
    DEPARTMENT_NAME AS 기존학과명,
    REPLACE(DEPARTMENT_NAME, '학과', '전공') AS 변경학과명
FROM DEPARTMENT;

-- Q4. 문제: STUDENT 테이블에서 주민등록번호에서 '-' 문자의 위치를 찾아
-- 성별구분번호(주민등록번호 뒷자리 첫 번째 숫자)를 추출하여
-- 학번, 이름, 성별구분번호를 조회하시오.
SELECT
    STUDENT_NO,
    STUDENT_NAME,
    SUBSTRING(STUDENT_SSN, LOCATE('-', STUDENT_SSN) + 1, 1) AS 성별구분번호  -- '-' 다음 첫번째 문자 추출
FROM STUDENT;

-- Q5. 문제: GRADE 테이블에서 모든 학점을 소수점 첫째자리까지 반올림하여
-- 학기번호, 과목번호, 학번, 반올림학점으로 조회하시오.
SELECT
    TERM_NO,
    CLASS_NO,
    STUDENT_NO,
    ROUND(POINT, 1) AS 반올림학점
FROM GRADE;

-- Q6. 문제: STUDENT 테이블에서 학번의 마지막 숫자가 짝수인 학생들의 학번, 이름을 조회하시오.
SELECT
    STUDENT_NO,
    STUDENT_NAME
FROM STUDENT
WHERE MOD(SUBSTRING(STUDENT_NO, -1, 1), 2) = 0;

-- Q7. 문제: PROFESSOR 테이블에서 교수 이름의 성(첫 글자)과 이름 길이를 조회하시오.
-- 출력 형태: 교수번호, 교수명, 성, 이름길이
SELECT
    PROFESSOR_NO,
    PROFESSOR_NAME,
    SUBSTRING(PROFESSOR_NAME, 1, 1) AS 성,
    LENGTH(PROFESSOR_NAME) AS 이름길이
FROM PROFESSOR;

-- Q8. 문제: STUDENT 테이블에서 주민등록번호를 이용해 성별을 구분하여
-- 학번, 이름, 성별(남/여)을 조회하시오.
SELECT
    STUDENT_NO, 
    STUDENT_NAME
    SUBSTRING(STUDENT_SSN, 8, 1) AS 성별구분번호
FROM STUDENT;

-- Q9. 문제: CLASS 테이블에서 과목번호 길이를 확인하고 현재 형태를 조회하시오.
-- 출력: 과목번호, 과목번호길이, 과목명
SELECT
    CLASS_NO,
    LENGTH(CLASS_NO) AS 과목번호길이,
    CLASS_NAME
FROM CLASS;

-- Q10. 문제: DEPARTMENT 테이블에서 학과명의 첫 두 글자를 추출하여 조회하시오.
-- 출력: 학과번호, 학과명, 첫두글자
SELECT
    DEPARTMENT_NO,
    DEPARTMENT_NAME,
    SUBSTRING(DEPARTMENT_NAME, 1, 2) AS 첫두글자
FROM DEPARTMENT;

-- Q11. 문제: 전체 학생 수를 조회하시오.
-- 출력: 전체학생수
SELECT
    COUNT(*) AS 전체학생수
FROM STUDENT;

-- Q12. 문제: 휴학생 수를 조회하시오.
-- 출력: 휴학생수
SELECT
    COUNT(*) AS 휴학생수
FROM STUDENT
WHERE ABSENCE_YN = 'Y';

-- Q13. 문제: 학과별 학생 수를 조회하시오.
-- 출력: 학과번호, 학과별학생수 (학생수 기준 내림차순 정렬)
SELECT
    DEPARTMENT_NO,
    COUNT(*) AS 학과별학생수
FROM STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY COUNT(*) DESC;

-- Q14. 문제: 전체 학생의 성적에서 최고점, 최저점, 평균점수를 조회하시오.
-- 출력: 최고점, 최저점, 평균점수(소수점 2자리까지
SELECT
    MAX(POINT) AS 최고점,
    MIN(POINT) AS 최저점,
    ROUND(AVG(POINT), 2) AS 평균점수
FROM GRADE;

-- Q15. 문제: 학과 분류(CATEGORY)별로 정원(CAPACITY)의 합계와 평균을 조회하시오.
-- 출력: 학과분류, 정원합계, 정원평균 (정원평균 기준 내림차순 정렬)
SELECT
    CATEGORY,
    SUM(CAPACITY) AS 정원합계,
    AVG(CAPACITY) AS 정원평균
FROM DEPARTMENT
GROUP BY CATEGORY
ORDER BY AVG(CAPACITY) DESC;

-- Q16. 문제: 2005년도에 입학한 학생들을 학과별로 그룹화하여 학과번호, 학생수를 조회하시오.
SELECT
    DEPARTMENT_NO,
    COUNT(*) AS 학생수
FROM STUDENT
WHERE YEAR(ENTRANCE_DATE) = 2005
GROUP BY DEPARTMENT_NO;

-- Q17. 문제: 과목별 평균 성적을 조회하시오.
-- 출력: 과목번호, 평균성적 (평균성적 기준 내림차순 정렬)
SELECT
    CLASS_NO,
    AVG(POINT) AS 평균성적
FROM GRADE
GROUP BY CLASS_NO
ORDER BY AVG(POINT) DESC;

-- Q18. 문제: 학기별, 과목별 수강 학생 수와 평균 성적을 조회하시오.
-- 출력: 학기번호, 과목번호, 수강학생수, 평균성적 (학기번호, 평균성적 기준 정렬)
SELECT
    TERM_NO,
    CLASS_NO,
    COUNT(*) AS 수강학생수,
    AVG(POINT) AS 평균성적
FROM GRADE
GROUP BY TERM_NO, CLASS_NO 
ORDER BY TERM_NO, AVG(POINT);

-- Q19. 문제: CLASS_PROFESSOR 테이블에서 전체 교수가 담당하는 서로 다른 과목의 수를 조회하시오.
SELECT
    COUNT(DISTINCT CLASS_NO) AS 담당과목수
FROM CLASS_PROFESSOR;

-- Q20. 문제: 교수별로 지도하는 학생 수를 조회하시오.
-- 출력: 교수번호, 지도학생수 (지도학생수 기준 내림차순 정렬)
SELECT
    COACH_PROFESSOR_NO AS 교수번호,
    COUNT(*) AS 지도학생
FROM STUDENT
WHERE COACH_PROFESSOR_NO IS NOT NULL
GROUP BY COACH_PROFESSOR_NO
ORDER BY COUNT(*) DESC;
