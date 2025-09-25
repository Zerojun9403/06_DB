-- 10. TCL

-- ==============================
-- TCL(Transaction Control Language)
-- 트랜잭션 제어 언어 
-- Transaction : 업무, 처리 
-- 	 			데이터베이스의 논리적 연산단위 
-- Oracle 은 기본적으로 Auto Commit 이 비활성화 되어있어 COMMIT 을 명시적으로 실행해야 변경 상항이 영구 저장
-- MySQL 은  기본적으로  	Auto Commit 이 활성화되어있어 각 DML 구문이 실행될때 마다 자동으로 커밋된다.  
--            자동저장이 아닌 개발자가 제어하는 저장을 하고 싶다면 
--           START TRANSACTION; 또는 SET autocommit = 0; 을 먼저 실행해준다. 
--  자동저장 끄기 
/*

COMMIT : 메모리 버퍼(트랜잭션)에 임시 저장된 데이터 변경 사항을 DB에 반영
-- 메모장이나, 포토샵에서 이미지나 글자를 저장하기 전 단계
-- COMMIT 은 메모장이나, 포토샵에 작성한 이미지나 글자 데이터를 DB에 저장하는 역할

ROKKBACKL : 메모리 버퍼(트랜잭션)에 임시 저장된 데이터 변경 사항을 삭제하고 마지막 COMMIT 상태로 돌아감
			기존에 작업한 데이터를 지우고 마지막에 저장한 상태로 되돌아가기 
            
            
SAVEPOINT : 트랜잭션 내에 저장 지점을 정의하면, ROLLBACK 수행 시 전체 작업을 삭제하는 것이 아닌 
			지정한 SAVAPOINT 까지만 일부 되돌아가기 (임시저장상태로 돌아가기)
            SAVAPOINT 포인트이름 1;
            ...
            SAVAPOINT 포인트이름 2;
            ...
            SAVAPOINT 포인트이름 3;
            
ROKKBACKL TO SAVAPOINT 포인트이름2; -- 포인트2 지점까지 데이털 변경사항 삭제 
 포인트이름 3에 저장된 내역 또한 사라짐
 
 사용예시 
 계좌이체
	1번 A의 계좌에서 5만원을 차감한다(UPDATE)
	2번 A의 계좌에서 5만원을 차감한다(UPDATE)
    성공 시나리오 : 1번 과 2번 작업이 모두 성공적으로 끝나면, 이거래를 확정 -->COMMIT
    실패 시나리어 : 1번은 성공했지만 시스템 오류로 인해 2번 작업실패 (은행 점검시간걸림)
				    이 때, COMMIT 하지 않고 ROLLBACK 을 하면 1번작업(A계좌에서 5만원 차감)이 취소되어 
                    A계좌 에서 돈이 사라지는 현상을 막고 마치 계좌이체가 없던일 처럼 돌리는것
	온라인 쇼핑 주문 : 재고 감소 + 주문 내역생성 + 포인트 적립
    항공권 / 숙소 예약: 좌석 예약 + 결제 정보 기록 + 예약자 정보 생성 하나의 단위로 움직이는 것

복잡하고 긴 작업 중 일부만 되돌리고 싶을 때 SAVEPOINT 사용해서 중간지점까지 되돌리기

*/
-- ==============================

DROP TABLE if exists bookings;
DROP TABLE if exists events; -- 만드는것은 events 먼저 였으나 외래키로 인하여 bookings 먼저 삭제해주기
DROP TABLE if exists attendees;




 CREATE TABLE events (
     event_id INT PRIMARY KEY AUTO_INCREMENT,
     event_name VARCHAR(100) NOT NULL,
    total_seats INT NOT NULL,
    available_seats INT NOT NULL 
 );

 CREATE TABLE attendees (
     attendee_id INT PRIMARY KEY AUTO_INCREMENT,
     attendee_name VARCHAR(50) NOT NULL,
     email VARCHAR(100) UNIQUE NOT NULL
 );

 CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
     event_id INT NOT NULL,
     attendee_id INT NOT NULL,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
     FOREIGN KEY (event_id) REFERENCES events(event_id),
     FOREIGN KEY (attendee_id) REFERENCES attendees(attendee_id)
 );

-- INSERT INTO events (event_name, total_seats, available_seats) 
-- VALUES ('SQL 마스터 클래스', 100, 2); 


START transaction; -- 이제부터 수동저장

INSERT INTO attendees
VALUES (1,'김철수','culsoo@gmail.com');

-- -- SQL 마스터 클래스 이벤트의 남은 좌석 1개 줄이기 
-- -- 김철수씨가 예약
 update events 
 SET available_seats = available_seats - 1 -- available_seats 예약 가능좌석 1개 축소
WHERE event_id = 1;


-- -- 주의 : select 에서 데이터가 제대로 보인다하여 commit 이 무조건 완성된 것은 아님 
-- -- SQL 에서 보이더라도 자동커밋이 아닐 때는 java 에서 데이터 불러오기를 했을때 
-- -- 저장된 데이터가 불러오지 않을 수 있음
-- -- 지금 database 자체가 아니라 database에 데이터를 명시하는 schenas 명세 상태임
-- -- java 는 schenas 가 아니라 data랑 상호소통한다.

 INSERT INTO bookings(event_id, attendee_id)
VALUE(1,1);

commit; -- 철수씨 예약 확정

-- select * from attendees;
-- select * from events;
-- select * from bookings;

-- -- 박영희 씨가 클래스 예약을 시도했지만 좌석이 없어서 실패한 시나리오 
-- -- ROLLBACK
-- -- START transaction;  commit 하기 전까지 유효 어디서부터 어디까지 흐름 추적하고 
-- -- commit 저장 완료되면 추적을 중단하겠다.
-- -- Ctrl + S 는 저장하기와 동시에 COMMIT 상태로 저장됨
START transaction; 
INSERT INTO attendees VALUES (3,'박영희','hee_park@gmail.com');
SELECT * from attendees;
rollback;


-- 일부만 성공 savepoint 



START transaction; 
INSERT INTO attendees VALUES (4,'이민준','joon@gmail.com');
SELECT * from attendees;
-- 예약하고자 하는 클래스는 동일하므로 수정안함 
update events 
SET available_seats = available_seats - 1 
WHERE event_id = 1;

-- 예약자 id만 수정
INSERT INTO bookings(event_id, attendee_id)
VALUE(1,3);
savepoint booking_joon_ok;
commit;

INSERT INTO attendees VALUES (5,'최지아','jia@gmail.com');
rollback to savepoint booking_joon_ok;
SELECT * from attendees;
