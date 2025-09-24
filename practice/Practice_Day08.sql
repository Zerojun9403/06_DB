CREATE DATABASE practice_db;
USE practice_db;


CREATE TABLE department (
    dept_id VARCHAR(10),
    dept_title VARCHAR(35),
    location_id VARCHAR(10)
);

CREATE TABLE employee (
    emp_id INT,
    emp_name VARCHAR(30),
    emp_no VARCHAR(14),
    email VARCHAR(30),
    phone VARCHAR(12),
    dept_code VARCHAR(10),
    salary INT,
    hire_date DATE
);

CREATE TABLE product (
    product_id INT,
    product_name VARCHAR(50),
    price INT,
    category VARCHAR(20)
);

INSERT INTO department VALUES 
('D1', '인사관리부', 'L1'),
('D2', '회계관리부', 'L2'),
('D3', '마케팅부', 'L3');

INSERT INTO employee VALUES 
(100, '홍길동', '901010-1234567', 'hong@company.com', '010-1234-5678', 'D1', 3000000, '2020-01-01'),
(200, '김영희', '951015-2345678', 'kim@company.com', '010-2345-6789', 'D2', 3500000, '2021-03-15');

INSERT INTO product VALUES 
(1, '노트북', 1200000, 'IT'), 
(2, '마우스', 50000, 'IT'),
(3, '책상', 300000, '가구');

SELECT * FROM product;

-- 문제 1: employee 테이블의 emp_id 컬럼을 PRIMARY KEY로 설정
ALTER TABLE employee
ADD CONSTRAINT pk_employee PRIMARY KEY (emp_id);

-- 문제 2: employee 테이블의 email 컬럼에 NOT NULL 제약조건 추가
ALTER TABLE employee
MODIFY email VARCHAR(100) NOT NULL;

-- 문제 3: product 테이블의 product_name 컬럼에 NOT NULL 제약조건 추가
ALTER TABLE product
MODIFY product_name VARCHAR(100) NOT NULL;

-- 문제 4: employee 테이블에 bonus 컬럼을 DECIMAL(3,2) 타입으로 추가
ALTER TABLE employee
ADD bonus DECIMAL(3,2);

-- 문제 5: product 테이블에 stock_quantity 컬럼을 INT 타입으로 추가, 기본값 0
ALTER TABLE product
ADD stock_quantity INT DEFAULT 0;

-- 문제 6: employee 테이블의 phone 컬럼을 VARCHAR(15) 타입으로 수정
ALTER TABLE employee
MODIFY phone VARCHAR(15);

-- 문제 7: employee 테이블의 salary 컬럼을 BIGINT 타입으로 수정
ALTER TABLE employee
MODIFY salary BIGINT;

-- 문제 8: product 테이블의 price 컬럼을 DECIMAL(10,2) 타입으로 수정
ALTER TABLE product
MODIFY price DECIMAL(10,2);

-- 문제 9: employee 테이블의 emp_no 컬럼명을 social_no로 변경
ALTER TABLE employee
CHANGE emp_no social_no VARCHAR(20);

-- 문제 10: product 테이블에서 stock_quantity 컬럼 삭제
ALTER TABLE product
DROP COLUMN stock_quantity;

-- 문제 11: product 테이블의 product_id를 PRIMARY KEY로 설정
ALTER TABLE product
ADD CONSTRAINT pk_product PRIMARY KEY (product_id);

-- 문제 12: category 컬럼에 CHECK 제약조건 추가
ALTER TABLE product
ADD CONSTRAINT chk_category CHECK (category IN ('IT', 'LIFE', 'ETC'));

-- 문제 13: description 컬럼을 TEXT 타입으로 추가
ALTER TABLE product
ADD description TEXT;

select  * from employee;

