CREATE DATABASE sht;
USE sht;

CREATE TABLE IF NOT EXISTS shop_items (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    stock INT NOT NULL,
    price INT NOT NULL
);

SELECT * FROM shop_items;


CREATE TABLE IF NOT EXISTS customer_points (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    points INT DEFAULT 0
);

CREATE TABLE  IF NOT EXISTS order_history (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id VARCHAR(50) NOT NULL,
    item_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO shop_items (item_id, item_name, stock, price) VALUES
(101, '키보드', 10, 30000),
(102, '마우스', 5, 25000),
(103, '모니터', 0, 150000);

INSERT INTO customer_points (customer_id, customer_name, points) VALUES
('user01', '홍길동', 1000);



-- **상황**: 홍길동(user01) 고객이 키보드(101) 1개를 성공적으로 주문했습니다. 모든과정이 정상 처리되었으므로, 거래를 **확정**하세요.

-- 현재 재고 확인
SELECT item_id, item_name, stock FROM shop_items;

-- 트랜잭션 시작
START TRANSACTION;

-- 1) 주문 대상 아이템(키보드: 101) 재고 행 잠금 + 확인
SELECT stock 
FROM shop_items 
WHERE item_id = 101
FOR UPDATE;

-- 2) 재고 차감 (재고가 1 이상일 때만 차감)
UPDATE shop_items
SET stock = stock - 1
WHERE item_id = 101
  AND stock >= 1;

-- 3) 직전 UPDATE 적용 여부 확인
SELECT ROW_COUNT() AS affected_rows;  -- 1 이면 성공, 0 이면 재고 부족/조건 불일치

-- 4) 성공 시 주문 이력 기록
INSERT INTO order_history (customer_id, item_id)
VALUES ('user01', 101);

SELECT * FROM shop_items;
-- 5) 확정
COMMIT;
-- 키보드 재고가 9개, 홍길동 포인트가 1300점이 되었는지 확인
SELECT * FROM shop_items WHERE item_id = 101;
SELECT * FROM customer_points WHERE customer_id = 'user01';
SELECT * FROM order_history;
