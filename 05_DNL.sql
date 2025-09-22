-- DML (Data Manipulation Language) : 데이터 조작 언어

-- 데이터에 값을 삽입하거나, 수정하거나, 삭제하는 구문

-- 주의 : COMMIT, ROLLBACK 을 실무에서 혼자서 하지 말 것!!!!!!!!!!!!!

CREATE TABLE member (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    birth_date DATE,
    gender ENUM('M', 'F', 'Other'),
    address TEXT,
    join_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('ACTIVE', 'INACTIVE', 'SUSPENDED') DEFAULT 'ACTIVE'
);

SELECT * FROM member;
-- ================================================
-- INSERT 구문
-- INSERT INTO 테이블이름 
--        VALUES (데이터, 데이터, 데이터,...)
-- 모든 컬럼에 대한 값을 넣을 때는 컬럼명칭은 생략하고 순서대로 VALUES 에 추가할 데이터 작성
-- ================================================

-- 모든 컬럼에 대한 값 저강 (AUTO_INCREMENT 제외)
INSERT INTO member
	   VALUES (
       NULL,			       -- member_id   (AUTO_INCREMENT 이므로 NULL)
       'hong1234',  	       -- username    닉네임
       'pass1234',  	       -- password    비밀번호
       'hong@gamil.com',       -- emaill      유저 이메일
       '홍길동',	           -- name        이름
       '010-1234-5678',        -- phone       핸드폰 번호
       '2000-01-01',     	   -- birth_date  생년월일
       'M',              	   -- gender      성별
       '서울시 종로구 관철동', -- address     주소
       NOW(),				   -- join_date   가입일자 현재시간기준
       'ACTIVE'				   -- status      탈퇴, 휴명계정 여부
       );

SELECT * FROM MEMBER;



-- =============================================
-- 실습 문제 1: 기본 INSERT 구문
-- =============================================
-- 문제: 다음 회원 정보들을 한 번에 INSERT하세요.
/*
회원1: jane_smith, password456, jane@example.com, 김영희, 010-9876-5432, 1992-08-20, F, 부산시 해운대구, 현재시간, ACTIVE
회원2: mike_wilson, password789, mike@example.com, 이철수, 010-5555-7777, 1988-12-03, M, 대구시 중구, 현재시간, ACTIVE  
회원3: sarah_lee, passwordabc, sarah@example.com, 박미영, 010-3333-9999, 1995-03-10, F, 광주시 서구, 현재시간, INACTIVE
*/
INSERT INTO member
	   VALUES (
      null, 'jane_smith', 'password456', 'jane@example.com', '김영희', '010-9876-5432', '1992-08-20', 'F', '부산시 해운대구', now(), 'ACTIVE'
       );

INSERT INTO member
	   VALUES (
      null, 'mike_wilson', 'password789', 'mike@example.com', '이철수', '010-5555-7777', '1988-12-03', 'm', '대구시 중구', now(), 'ACTIVE'
       );

INSERT INTO member
	   VALUES (
      null, 'sarah_lee', 'passwordabc', 'sarah@example.com', '박미영', '010-3333-9999', '1995-03-10', 'f', '광주시 서구', now(), 'INACTIVE'
       );



-- ================================================
-- INSERT 구문 여러 행을 한 번에 입력
-- INSERT INTO 테이블이름 
--        VALUES (데이터1, 데이터1, 데이터1, ...),
--        VALUES (데이터2, 데이터2, 데이터2, ...),
--        VALUES (데이터3, 데이터3, 데이터3, ...);
-- , 로 구분하여 여러 행을 한 번에 입력 후, 데이터를 저장할 수 있다.
-- ================================================

INSERT INTO member
	   VALUES 
       (NULL, 'mini1004', 'pass5678', 'mini1004@gamil.com', '김미니', '010-6666-7777', '2001-02-02', 'F', '서울시 강남구 역삼동', NOW(), 'ACTIVE'),
       (NULL, 'soo5678', 'pass9999', 'soo1004@gamil.com', '한철수', '010-8888-9999', '2002-03-03', 'M', '서울시 동작구 흑석동', NOW(), 'ACTIVE');


-- =============================================
-- 실습 문제 1: 필수 컬럼만 INSERT
-- =============================================
-- 문제: 다음 회원들을 필수 컬럼(username, password, email, name)만으로 INSERT하세요.
-- 나머지 컬럼들은 기본값 또는 NULL이 됩니다.

/*
회원1: user_basic1, basicpass123, basic1@email.com, 기본유저1
회원2: user_basic2, basicpass456, basic2@email.com, 기본유저2  
회원3: user_basic3, basicpass789, basic3@email.com, 기본유저3
*/


INSERT INTO member(username,password,email,name)
			VALUES('user_basic1','basicpass123','basic1@email.com','기본유저1');
INSERT INTO member(username,password,email,name)
			VALUES('user_basic2,','basicpass456','basic2@email.com','기본유저2'),
				('user_basic3','basicpass789','basic3@email.com','기본유저3');
                    
SELECT * FROM member;


























