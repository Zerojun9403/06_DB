use delivery_app;
/*
LIBRARY_MEMBER 테이블을 생성하세요.
제약조건명 규칙:
- PK: PK_테이블명_컬럼명
- UK: UK_테이블명_컬럼명  
- CK: CK_테이블명_컬럼명
컬럼 정보:
- MEMBER_NO: 회원번호 (숫자, 기본키)
- MEMBER_NAME: 회원이름 (최대 20자, 필수입력)
- EMAIL: 이메일 (최대 50자, 중복불가)
- PHONE: 전화번호 (최대 15자)
- AGE: 나이 (숫자, 7세 이상 100세 이하만 가능)
- JOIN_DATE: 가입일 (날짜시간, 기본값은 현재시간)
*/
CREATE TABLE LIBRARY_MEMBER(
-- 다른 SQL 에서는 컬럼레벨로 제약조건을 작성할 때 CONSTRAINT 를 이용해서
-- 제약조건의 명칭을 설정할 수 있지만
-- MYSQL 은 제약조건 명칭을 MYSQL 자체에서 자동생성 해주기 때문에 명칭 작성을 컬럼레벨에서 할 수 없음
-- 컬럼명칭  자료형(자료형크기)  제약조건          제약조건명칭            제약조건들설정
-- MEMBER_NO   INT               CONSTRAINT    PK_LIBRARY_MEMBER_MEMBER_NO PRIMARY KEY,
MEMBER_NO INT PRIMARY KEY, -- CONSTRAINT    PK_LIBRARY_MEMBER_MEMBER_NO  와 같은 명칭 자동생성됨
MEMBER_NAME VARCHAR(20) NOT NULL,
EMAIL VARCHAR(5)  UNIQUE, -- CONSTRAINT  UK_LIBRARY_MEMBER_EMAIL   와 같은 제약조건 명칭 자동 생성되고 관리
PHONE VARCHAR(15),
AGE INT CONSTRAINT CK_LIBRARY_AGE CHECK(AGE >=7 AND AGE <= 100),

JOIN_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/*
MEMBER_NO ,EMAIL 에는 제약조건 명칭 설정이 안되지만 
단순히 PK, UNIQUE, FK, NOT NULL 과 같이 한 단어로 키 형태를 작성하는 경우 제약조건 명칭 설정 불가능

AGE 에서는 제약조건 명칭이 설정되는 이유
CHECK 처럼 제약조건이 상세할 경우에는 제약조건 명칭 설정 가능
CHECK 만 개발자가 지정한 제약조건 명칭 설정 가능
*/
-- 우리회사는 이메일을 최대 20글자 작성으로 설정 -> 21글자 유저가 회원가입이 안된다!!!! 연락
INSERT INTO LIBRARY_MEMBER (MEMBER_NO, MEMBER_NAME, EMAIL, PHONE, AGE)
VALUES (1, '김독서', 'kim@email.library_memberEMAIL_2EMAIL_2EMAIL_2MEMBER_NOcom', '010-1234-5678', 25);


-- Error Code: 1406. Data too long for column 'EMAIL' at row 1	0.016 sec
-- 컬럼에서 넣을 수 있는 크기에 비해 데이터양이 많을 때 발생하는 문제

-- 방법 1번 : DROP 해서 테이블 새로 생성한다. -> 기존 데이터는.. ? 회사 폐업 엔딩..

-- 방법 2번 : EMAIL 컬럼의 크기 변경 ALTER 수정 사용
-- 1. EMAIL 컬럼을 5자에서 50자로 변경
ALTER TABLE LIBRARY_MEMBER
MODIFY EMAIL VARCHAR(50) UNIQUE;
-- ALTER 로 컬럼 속성을 변경할 경우 컬럼명칭에 해당하는 정보를 하나 더 만들어놓은 후 해당하는 제약조건 동작
-- ALTER 에서 자세한 설명 진행..
/*
ALTER 로 컬럼에 해당하는 조건을 수정할 경우
Indexs 에 컬럼명_1 컬럼명_2 컬럼명_3 ... 과 같은 형식으로 추가가됨


Indexes
EMAIL
EAMIL_2 와 같은 형태로 존재

EMAIL   의 경우 제약조건 VARCHAR(5)  UNIQUE,
EMAIL_2 의 경우 제약조건 VARCHAR(50)  UNIQUE,

컬럼이름    인덱스들
EAMIL        EMAIL, EMAIL_2 중에서 가장 최근에 생성된 명칭으로 연결
			  하지만 새로 생성된 조건들이 마음에 들지 않아 되돌리고 싶은 경우에는
              EMAIL 과 같이 기존에 생성한 조건을 인덱스 명칭을 통해 되돌아 설정할 수 있음
              인덱스 = 제약조건명칭 동일
*/

select * from LIBRARY_MEMBER;


-- 제약조건 위반 테스트 (에러가 발생해야 정상)
INSERT INTO LIBRARY_MEMBER VALUES (1, '박중복', 'park@email.com', '010-9999-8888', 30, DEFAULT); -- PK 중복
INSERT INTO LIBRARY_MEMBER VALUES (6, '이나이', 'lee@email.com', '010-7777-6666', 5, DEFAULT); -- 나이 제한 위반
-- rror Code: 3819. Check constraint 'CK_LIBRARY_AGE' is violated.	0.000 sec

INSERT INTO LIBRARY_MEMBER VALUES (2, '박중복', 'park@email.com', '010-9999-8888', 30, DEFAULT); -- PK 중복






CREATE TABLE PRODUCT (
PRODUCT_ID VARCHAR(10) PRIMARY KEY,
PRODUCT_NAME VARCHAR(100) NOT NULL,
PRICE INT constraint CH_PRODUCT_PRICE CHECK(PRICE >0),
STOCK INT DEFAULT 0 CHECK(STOCK>=0), 
STATUS VARCHAR(20) DEFAULT '판매중' CCHECK(STATUS IN ('판매중', '품절', '단종'))
);

CREATE TABLE ORDER_ITEM(
ORDER_NO varchar(20),
PRODUCT_ID VARCHAR(10),
QUANTITY INT CHECK(QUANTITY >= 1),
ORDER_DATE DATETIME DEFAULT current_timestamp
);


INSERT INTO PRODUCT VALUES ('P001', '노트북', 1200000, 10, '판매중');
INSERT INTO PRODUCT VALUES ('P002', '마우스', 25000, 50, '판매중');
INSERT INTO PRODUCT VALUES ('P003', '키보드', 80000, 0, '품절');

INSERT INTO ORDER_ITEM VALUES ('ORD001', 'P001', 2, DEFAULT);
INSERT INTO ORDER_ITEM VALUES ('ORD001', 'P002', 1, DEFAULT);
INSERT INTO ORDER_ITEM VALUES ('ORD002', 'P002', 3, '2024-03-06 14:30:00');

-- CREATE TABLE 할 때 FK(FOREIGN KEY) 를 작성하지 않아
-- 존재하지 않는 제품번호의 주문이 들어오는 문제가 발생
-- 제품이 존재하고, 제품번호에 따른 주문
INSERT INTO ORDER_ITEM VALUES ('ORD003', 'P999', 1, DEFAULT);



-- 테이블 다시 생성
-- 테이블이 존재하는게 맞다면 삭제하겠어
-- 왜래키가 설정되었을 경우 메인 테이블은 
-- 메인을 기준으로 연결된 데이터가 자식테이블에 존재할 경우
-- 자식 테이블을 삭제한 후 메인 테이블을 삭제할 수 있다.
-- > ORDER_ITEM 삭제한 후 PRODUCT 테이블을 삭제할 수 있다.
-- 배달의 민족 - 가게 - 상품 - 주문
DROP TABLE IF EXISTS PRODUCT;
DROP TABLE IF EXISTS ORDER_ITEM;

-- 메인이 되는 테이블 생성
CREATE TABLE PRODUCT (
PRODUCT_ID VARCHAR(10) PRIMARY KEY, -- AUTO_INCREMENT 정수만 가능 VARCHAR 사용 불가
PRODUCT_NAME VARCHAR(100) NOT NULL,
PRICE INT constraint CH_PRODUCT_PRICE CHECK(PRICE >0),
STOCK INT DEFAULT 0 CHECK(STOCK>=0), --  constraint 제약조건 제약조건명칭은 필수가 아님 작성안했을 경우 자동완성
STATUS VARCHAR(20) DEFAULT '판매중' CONSTRAINT CK_PRODUCT_STATUS CHECK(STATUS IN ('판매중', '품절', '단종'))
);
-- ORDER_ITEM 에서 
-- CONSTRAINT ABC FOREIGN KEY  (PRODUCT_ID)   references PRODUCT(PRODUCT_ID) 테이블 레벨로 존재하는 외래키를
-- 위 내용 참조하여 컬럼 레벨로 설정해서   ORDER_ITEM  테이블 생성
-- 상품이 있어야 주문 가능
-- mysql 에서   FOREIGN KEY  또한 테이블 컬럼 형태로 작성
CREATE TABLE ORDER_ITEM(
ORDER_NO varchar(20),
PRODUCT_ID VARCHAR(10) CONSTRAINT  abc FOREIGN KEY  references PRODUCT(PRODUCT_ID), 
QUANTITY INT CHECK(QUANTITY >= 1),
ORDER_DATE DATETIME DEFAULT current_timestamp
);

INSERT INTO PRODUCT VALUES ('P001', '노트북', 1200000, 10, '판매중');
INSERT INTO PRODUCT VALUES ('P002', '마우스', 25000, 50, '판매중');
INSERT INTO PRODUCT VALUES ('P003', '키보드', 80000, 0, '품절');

INSERT INTO ORDER_ITEM VALUES ('ORD001', 'P001', 2, DEFAULT);
INSERT INTO ORDER_ITEM VALUES ('ORD001', 'P002', 1, DEFAULT);
INSERT INTO ORDER_ITEM VALUES ('ORD002', 'P002', 3, '2024-03-06 14:30:00');

-- CREATE TABLE 할 때 FK(FOREIGN KEY) 를 작성하지 않아
-- 존재하지 않는 제품번호의 주문이 들어오는 문제가 발생
-- 제품이 존재하고, 제품번호에 따른 주문

INSERT INTO ORDER_ITEM VALUES ('ORD003', 'P999', 1, DEFAULT);
-- PRODUCT 테이블에 존재하지 않은 상품번호로 주문이 들어와 외래키 조건에 위배되는 현상 발생 으로 주문 받지 않음
-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`delivery_app`.`order_item`, CONSTRAINT `ABC` FOREIGN KEY (`PRODUCT_ID`) REFERENCES `product` (`PRODUCT_ID`))	0.016 sec

-- YEAR 과 같이 sql 에서 사용하는 예약어를 SQL 에서는 컬럼명칭으로 사용 가능하나
-- 예약어는 되도록이면 컬럼명칭 사용 지양
CREATE TABLE STUDENT(
STUDENT_ID VARCHAR(10) PRIMARY KEY,
STUDENT_NAME VARCHAR(20) NOT NULL,
MAJOR VARCHAR(50),
YEAR INT CHECK(YEAR >= 1 AND YEAR <= 4),  --   CHECK 내에 존재하는 YEAR     컬럼명 YEAR 값 제한
EMAIL VARCHAR(100) NOT NULL
);
CREATE TABLE SUBJECT(
SUBJECT_ID VARCHAR(10) PRIMARY KEY,
SUBJECT_NAME VARCHAR(100) NOT NULL,
CREDIT INT CHECK(CREDIT >= 1 AND CREDIT <= 4)
);

CREATE TABLE SCORE(
STUDENT_ID  VARCHAR(10) PRIMARY KEY,
SUBJECT_ID VARCHAR(10) ,
SCORE INT CHECK(SCORE >= 0 AND SCORE <= 100),
SEMESTER VARCHAR(100) NOT NULL,
SCORE_DATE timestamp DEFAULT current_timestamp,

-- 외래키  
-- 기본 문법
-- 제약조건시작  제약조건명칭 왜래키(제약조건을 걸 현재 테이블의 컬럼명칭)  참조하다       메인테이블(내에 존재하는 컬럼명칭)
-- CONSTRAINT      명칭       FOREIGN KEY(컬럼명칭)                         REFERENCES     다른테이블명칭(다른테이블내에 존재하는 컬럼명칭)

-- STUDENT 테이블과 SUBJECT 테이블 은 SCORE 테이블과 SCORE 테이블 내 데이터가 사라지기 전까지
-- 연결되어 있는 STUDENT 테이블과 SUBJECT 테이블 은 삭제할 수 없다.
CONSTRAINT FK_SCORE_STUDENT_ID FOREIGN KEY(STUDENT_ID)  REFERENCES  STUDENT(STUDENT_ID),
CONSTRAINT FK_SCORE_SUBJECT_ID FOREIGN KEY(SUBJECT_ID)  REFERENCES  SUBJECT(SUBJECT_ID)

);

-- Error Code: 3813. Column check constraint 'score_chk_1' references other column.	0.016 sec
-- SCORE INT CHECK(CREDIT >= 0 AND CREDIT <= 100), --> SCORE 컬럼명 제약조건에서 관련없는 CREDIT명칭을 작성했기 때문
-- > 같이 수정하면 에러 문제 해결 : SCORE INT CHECK(SCORE >= 0 AND SCORE <= 100),










INSERT INTO STUDENT VALUES ('2024001', '김대학', '컴퓨터공학과', 2, 'kim2024@univ.ac.kr');
INSERT INTO STUDENT VALUES ('2024002', '이공부', '경영학과', 1, 'lee2024@univ.ac.kr');

INSERT INTO SUBJECT VALUES ('CS101', '프로그래밍기초', 3);
INSERT INTO SUBJECT VALUES ('BM201', '경영학원론', 3);
INSERT INTO SUBJECT VALUES ('EN101', '대학영어', 2);

INSERT INTO SCORE VALUES ('2024001', 'CS101', 95, '2024-1학기', DEFAULT);
INSERT INTO SCORE VALUES ('2024001', 'EN101', 88, '2024-1학기', DEFAULT);
-- Error Code: 1062. Duplicate entry '2024001' for key 'score.PRIMARY'	0.000 sec 에러로 데이터 삽입 불가
INSERT INTO SCORE VALUES ('2024002', 'BM201', 92, '2024-1학기', DEFAULT);






-- 제약조건 위반 테스트
INSERT INTO STUDENT VALUES ('2024003', '박중복', '수학과', 2, 'kim2024@univ.ac.kr');
-- 무엇이 위배되었는지 찾아보기 : 정상 -> 이메일은 보통 중복 불가!
INSERT INTO SCORE VALUES ('2024001', 'CS101', 150, '2024-1학기', DEFAULT);
-- 무엇이 위배되었는지 찾아보기 : Error Code: 3819. Check constraint 'score_chk_1' is violated.	0.000 sec
-- SCORE 제약조건 0 ~ 100 점수로, 150점이 들어가려 했기 때문에 문제 발생
INSERT INTO SCORE VALUES ('2024001', 'CS101', 90, '2024-1학기', DEFAULT);
-- 무엇이 위배되었는지 찾아보기 : Error Code: 1062. Duplicate entry '2024001' for key 'score.PRIMARY'	0.000 sec 
-- 프라이머리키 중복 에러


-- STUDENT 테이블에서 이메일에 해당하는 컬럼을 중복 불가하도록 설정  빈칸허용 금지 자료형 100까지 제한

-- ALTER MODIFY
ALTER TABLE STUDENT
MODIFY EMAIL VARCHAR(100) NOT NULL UNIQUE;

-- 중복된 데이터가 존재하는 상황에서 UNIQUE 를 사용할 경우 중복되는 데이터가 존재하기 때문에 컬럼 제약조건을 수정할 수 없다 거부
-- 기존 데이터가 제약조건에 부합하지 않을 경우 발생

-- 데이터를 수정한 다음에 제약조건을 다시 설정

-- 중복된 데이터 SELECT 확인
SELECT EMAIL, COUNT(*)
FROM STUDENT
WHERE EMAIL IS NOT NULL
GROUP BY EMAIL
HAVING COUNT(*) > 1;

-- 중복된 이메일 에서 둘 중 한명의 이메일을 수정하거나

-- 모두 삭제

-- 데이터가 키 형태가 아닐 경우에는 안전모드 해지 후 가능

SET SQL_SAFE_UPDATES = 0;
-- Error Code: 1175. You are usin g safe update mode and you tried to update a table without a WHERE that uses a KEY column.
DELETE 
FROM STUDENT
WHERE EMAIL = 'kim2024@univ.ac.kr';
--  Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`delivery_app`.`score`, CONSTRAINT `FK_SCORE_STUDENT_ID` FOREIGN KEY (`STUDENT_ID`) REFERENCES `student` (`STUDENT_ID`))	0.016 sec
-- 특정학생을 삭제하려 했지만 SCORE 테이블에 외래키를 참조하고 있어 함부로 삭제할 수 없다.

-- 두가지방법 
-- 1. 삭제하고자하는 데이터의 하위 데이터에 존재하는 데이터 먼저 삭제 후
--    부모 데이터 삭제

-- 2. 외래키 제약 조건을 잠시 종료하고 삭제 (추천하지 않음)
-- 데이터 무결성 조건을 해지할 수 있으므로 실제 DB 서비스에서는 사용 금지
SET FOREIGN_KEY_CHECKS  = 0;

-- 3. ON DELETE CASCADE
-- 부모 테이블 에 존재하는 데이터 삭제시 자식 테이블 또한 자동적으로 삭제될 수 있도록 설정 조건
-- 예를 들어, 배달 어플 - 더조은카페 - 조은카페메뉴
-- 더조은카페 폐업 카페메뉴까지 모두 없애야 하는 상황
--  ON DELETE CASCADE가 만약에 걸려있다면 더조은카페 폐업과 동시에 메뉴까지 모두 삭제하는 설정




