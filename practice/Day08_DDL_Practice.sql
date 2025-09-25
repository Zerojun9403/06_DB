-- 1. 데이터베이스 생성 및 사용
CREATE DATABASE BOOK;
USE BOOK;


-- 2. BOOK 테이블 생성
CREATE TABLE BOOK(
	BOOK_ID VARCHAR(10) PRIMARY KEY,
    TITLE VARCHAR(100) NOT NULL,
    AUTHOR VARCHAR(50),
    PRICE INT CHECK (PRICE >= 1),
    STOCK INT DEFAULT 0 CHECK (STOCK >= 0)
);

-- 3. 데이터 삽입 (3권의 책)
INSERT INTO BOOK VALUES ('B001', '데이터베이스 입문', '홍길동', 15000, 10,'IT도서');
INSERT INTO BOOK VALUES ('B002', '자바 프로그래밍', '이몽룡', 20000, 5,'IT도서');
INSERT INTO BOOK VALUES ('B003', '파이썬 따라하기', '성춘향', 300000, 0,'기타');

-- 4. 컬럼 추가 (DEFAULT 문자열은 따옴표 필요)
ALTER TABLE BOOK ADD CATEGORY VARCH0AR(30) DEFAULT '기타';

-- 5. 데이터 수정
UPDATE BOOK
SET CATEGORY = 'IT도서'
WHERE BOOK_ID = 'B001';

-- 6. CUSTOMER 테이블 생성
-- CUSTOMER_ID(PK), NAME(필수), EMAIL(중복불가)
CREATE TABLE CUSTOMER(
    CUSTOMER_ID VARCHAR(10) PRIMARY KEY,
    NAME VARCHAR(20) NOT NULL,
    EMAIL VARCHAR(50) UNIQUE
);

-- 7. ORDER_DETAIL 테이블 생성 (복합키, 외래키 2개)
CREATE TABLE ORDER_DETAIL(
    ORDER_ID VARCHAR(20),
    CUSTOMER_ID VARCHAR(10),-- 외래키 설정하지 않으면, 참조하지 않으면 참조하는 부모테이블 데이터느 사라지고 자식 테이블 데이터만 남는다
    BOOK_ID VARCHAR(10),-- 외래키 설정하지 않으면, 참조하지는 부모테이블의 데이터는 사라지고 자식테 테이블 데이터만 남는다
    QUANTITY INT, 
    -- 예를 들어, 고객은 탈퇴해서 사라졌는데, 주문에는 고객 데이터 존재
    -- 1. 주문 받고, 문제없는지 확인하고 고객은 탈퇴를 하거나, 주문내역에만 남기거나
    -- 2. 고객에게 주문한 모든 데이터를 삭제할 것이고, 이에 대해서 상품을 받지 못하거나 문제생겼을때 
    -- 이의 제기를 하지 않는다는 서명 후 탈퇴 -> 모든 내역삭제
    -- 외래키를 설정할 때는 제약조건 제약조건이름 외래키(현재테이블에서 컬럼명) 참조 참조할 테이블(참조할테이블 컬럼명(
    
    PRIMARY KEY (ORDER_ID, BOOK_ID),
    CONSTRAINT FK_ORDER_CUSTOMER FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID),
    CONSTRAINT FK_ORDER_BOOK     FOREIGN KEY (BOOK_ID)     REFERENCES BOOK(BOOK_ID)
);

-- 8. SELECT
-- 전체 조회
SELECT * FROM BOOK;

-- 조건 조회 (가격 25000원 이상)
SELECT * FROM BOOK WHERE PRICE >= 25000;

-- 특정 컬럼만 조회 (제목, 가격)
SELECT TITLE, PRICE FROM BOOK;

-- 9. 집계 함수
-- 최대 가격
SELECT MAX(PRICE) FROM BOOK;

-- 평균 가격
SELECT AVG(PRICE) FROM BOOK;

-- 총 도서 수
SELECT COUNT(*) FROM BOOK;

-- 10. 샘플 주문/고객 데이터
INSERT INTO CUSTOMER VALUES ('C001', '김고객', 'kim@email.com');
INSERT INTO ORDER_DETAIL VALUES ('O001', 'C001', 'B001', 2);

-- 11. 데이터 삭제가 안되는 문제 해결 (참조 무결성)
-- BOOK(B001) 삭제 전에 참조 레코드부터 삭제
DELETE FROM ORDER_DETAIL WHERE BOOK_ID = 'B001';
DELETE FROM BOOK WHERE BOOK_ID = 'B001';

-- 12. 외래키 옵션 설정 후 삭제 진행 (CASCADE)
DROP TABLE ORDER_DETAIL;

CREATE TABLE ORDER_DETAIL(
    ORDER_ID VARCHAR(20) PRIMARY KEY,
    CUSTOMER_ID VARCHAR(10),
    BOOK_ID VARCHAR(10),
    QUANTITY INT,
    
    CONSTRAINT FK_ORDER_CUSTOMER 
    FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    
    CONSTRAINT FK_ORDER_BOOK 
    FOREIGN KEY (BOOK_ID) REFERENCES BOOK(BOOK_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 14. CASCADE 정상 작동확인
-- 데이터 다시 입력
INSERT INTO ORDER_DETAIL VALUES ('O002', 'C001', 'B002', 1);

-- 테스트: BOOK(B002) 삭제 시 ORDER_DETAIL의 참조 행도 함께 삭제되어야 함
DELETE FROM BOOK WHERE BOOK_ID = 'B002';

SELECT * FROM ORDER_DETAIL;

-- 15. 제약조건 위반 (존재하지 않는 고객/도서 참조 → FK 에러)
INSERT INTO ORDER_DETAIL VALUES ('O003', 'C999', 'B001', 1);
-- 1452 : 참조되는 데이터가 존재하지 않아서 발생하는 문제