
/**************************
 SUBQUERY(서브쿼리)
 하나의 SQL 문 안에 포함된 또다른 SQL문
 메인쿼리(기존쿼리)를 위해 보조 역할을 하는 쿼리문
 - SELECT, FROM, WHERE, HAVING 절에서 사용가능

stores
id, name, category, address, phone, rating, delivery_fee

menus
id, store_id, name, description, price, is_popular
****************************/

USE delivery_app;
SELECT * FROM stores;
SELECT * FROM menus;

-- ============================
-- 1. 기본 서브쿼리 (단일행)
-- ============================
-- 가장 비싼 메뉴 찾기
-- 1단계 : 최고 가격 찾기
SELECT max(price) FROM menus; -- 38900원

-- 2단계 : 그 가격인 메뉴 찾기
SELECT name, price
FROM menus
WHERE price = 38900;

-- 1단계 2단계를 조합해서 한 번에 비싼메뉴찾기를 진행해보자
SELECT name, price
FROM menus
WHERE price = (SELECT max(price) FROM menus);


-- 1단계 : 평균 메뉴들의 가격 조회
SELECT avg(price) FROM    menus  ;
-- 2단계 : 메뉴들의 가격 조회
SELECT name, price
FROM menus
WHERE price > 15221.4286;
-- 1단계 2단계를 조합해서 평균보다 비싼 메뉴들만 조회
-- where 절에 price 를 기준으로 평균보다 비싼 메뉴들만 조회하는 조건
SELECT name, price
FROM menus
WHERE price > (SELECT avg(price) FROM    menus);


/*
stores = id, name, category, address, phone, rating, delivery_fee
menus  = id, store_id, name, description, price, is_popular
*/
-- 평점이 가장 높은 매장 찾기 menus
-- 1단계 : 최고 평점 찾기
select max(rating) from stores; -- 4.9
-- 2단계 : 최고 평점인 매장 찾기
select name 
from stores
where rating = 4.9;
-- 1단계 2단계를 조합하여 한 번에 평점 최고인 매장을 조회
select name, rating
from stores
where rating = (select max(rating) from stores);



-- 배달비가 가장 비싼 매장 찾기 stores
-- 1단계 : 가게에서 최고로 배싼 배달비 가격을 조회
select max(delivery_fee) from stores;

-- 2단계 : 가격이 최고로 비싼 배달비의 매장 명칭과 배달비, 카테고리 조회
select name, delivery_fee , category
from stores
where delivery_fee = 5500;
-- 1단계 2단계를 조합하여 한 번에 가장 비싼 배달비 가격을 조회하고, 매장의 명칭, 배달비, 카테고리 조회
select name, delivery_fee, category
from stores
where delivery_fee = (select max(delivery_fee) from stores);
/**********************************************************
           단일행 서브쿼리 실습문제 (1 ~ 10 문제)
***********************************************************/

-- 문제1: 가장 싼 메뉴 찾기
-- 1단계: 최저 가격 찾기
SELECT min(price) FROM menus;
-- 2단계: 그 가격인 메뉴 찾기 (메뉴명, 가격)
SELECT name, price
FROM menus
WHERE price = 1500;
-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name, price
FROM menus
WHERE price = (SELECT min(price) FROM menus);

-- 문제2: 평점이 가장 낮은 매장 찾기 (NULL 제외)
-- 1단계: 최저 평점 찾기
SELECT  min(rating) FROM stores;
/*
stores = id, name, category, address, phone, rating, delivery_fee
menus  = id, store_id, name, description, price, is_popular
*/
-- 2단계: 그 평점인 매장 찾기 (매장명, 평점, 카테고리)
SELECT name, rating, category
FROM stores
WHERE rating = 4.2;
-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name, rating, category
FROM stores
WHERE rating = (SELECT min(rating) FROM stores);

-- 문제3: 배달비가 가장 저렴한 매장 찾기 (NULL 제외)
-- 1단계: 최저 배달비 찾기
SELECT min(delivery_fee) FROM stores WHERE delivery_fee IS NOT NULL;
-- 2단계: 그 배달비인 매장들 찾기 (매장명, 배달비, 주소)
SELECT name, delivery_fee, address
FROM stores
WHERE delivery_fee = 2000;
-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name, delivery_fee, address
FROM stores
WHERE delivery_fee = (SELECT min(delivery_fee) FROM stores WHERE delivery_fee IS NOT NULL);

-- 문제4: 평균 평점보다 높은 매장들 찾기
-- 1단계: 전체 매장 평균 평점 구하기
SELECT avg(rating) FROM stores;
-- 2단계: 평균보다 높은 평점의 매장들 찾기 (매장명, 평점, 카테고리)
SELECT name, rating, category 
FROM stores
WHERE rating >4.66545;
-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name, rating, category 
FROM stores
WHERE rating >(SELECT avg(rating) FROM stores);

-- 문제5: 평균 배달비보다 저렴한 매장들 찾기 (NULL 제외)
-- 1단계: 전체 매장 평균 배달비 구하기
SELECT avg(delivery_fee)
FROM stores
WHERE delivery_fee IS NOT NULL;
-- 2단계: 평균보다 저렴한 배달비의 매장들 찾기 (매장명, 배달비, 카테고리)
SELECT name, delivery_fee, category
FROM stores
WHERE delivery_fee < 3179.2453;

-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name, delivery_fee, category
FROM stores
WHERE delivery_fee < (SELECT avg(delivery_fee) FROM stores);

-- 문제6: 치킨집 중에서 평점이 가장 높은 곳
-- 1단계: 치킨집들의 최고 평점 찾기
SELECT max(rating) FROM stores WHERE category = '치킨';

-- 2단계: 치킨집 중 그 평점인 매장 찾기 (매장명, 평점, 주소)
select name, rating, address
from stores
where category = '치킨' and rating = 4.9;
-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
select name, rating, address
from stores
where category = '치킨'
and rating = (SELECT max(rating) FROM stores WHERE category = '치킨');


-- 문제7: 치킨집 중에서 배달비가 가장 저렴한 곳 (NULL 제외)
-- 1단계: 치킨집들의 최저 배달비 찾기
select min(delivery_fee)
from stores
where category = '치킨';
-- 2단계: 치킨집 중 그 배달비인 매장 찾기 (매장명, 배달비)
select name, delivery_fee
from stores
where category = '치킨' and delivery_fee = 2000;
-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
select name, delivery_fee
from stores
where category = '치킨' and delivery_fee = (select min(delivery_fee) from stores where category = '치킨');

-- 문제8: 중식집 중에서 평점이 가장 높은 곳
-- 1단계: 중식집들의 최고 평점 찾기
select max(rating)
from stores
where category = '중식';
-- 2단계: 중식집 중 그 평점인 매장 찾기 (매장명, 평점, 주소)
select name, rating,address
from stores
where rating = 4.7 and category = '중식';
-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
select name, rating,address
from stores
where rating = (select max(rating) from stores where category = '중식') 
and category = '중식';
-- 문제9: 피자집들의 평균 평점보다 높은 치킨집들
-- 1단계: 피자집들의 평균 평점 구하기
select avg(rating)
from stores
where category = '피자';
-- 2단계: 그보다 높은 평점의 치킨집들 찾기 (매장명, 평점)
select name, rating
from stores
where category = '치킨'
and  rating > 4.7;
-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
select name, rating
from stores
where category = '치킨'
and  rating > (select avg(rating) from stores where category = '피자');
-- 문제10: 한식집들의 평균 배달비보다 저렴한 일식집들 (NULL 제외)
-- 1단계: 한식집들의 평균 배달비 구하기
select avg(delivery_fee)
from stores
where category = '한식';
-- 2단계: 그보다 저렴한 배달비의 일식집들 찾기 (매장명, 배달비)
select name, delivery_fee
from stores
where category = '일식'
and delivery_fee < 3200;
-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기

select name, delivery_fee
from stores
where category = '일식'
and delivery_fee < (select avg(delivery_fee)  from stores where category = '한식');

-- ============================
-- 2. 다중행 서브쿼리 (MULTI ROW SUBQUERY) N행 1열
-- IN / NOT IN, > ANY / <ANY, > ALL < ALL, EXISTS / NOT EXISTS 사용
-- 주요 연산자 : IN, NOT IN, ANY, ALL, EXISTS
-- ============================
/*
stores = id, name, category, address, phone, rating, delivery_fee
menus  = id, store_id, name, description, price, is_popular
*/
-- 1. IN 연산자 - 가장 많이 사용되는 다중행 서브쿼리

-- 인기 메뉴가 있는 매장들 조회
-- 1단계 : 인기 메뉴가 있는 매장 ID 들 확인
SELECT distinct store_id
FROM menus
WHERE is_popular = TRUE;
-- 2단계 : 인기있는 매장 id 들에 해당하는 매장 정보 찾기 
select  s.name, s.category, s.rating,  s.id, m.store_id
from stores s
join menus m  on s.id = m.store_id
where s.id in ( SELECT distinct store_id FROM menus WHERE is_popular = TRUE);

select  s.name, s.category, s.rating,  s.id, m.store_id
from stores s ,menus m  
where s.id = m.store_id
and s.id in ( SELECT distinct store_id FROM menus WHERE is_popular = TRUE);


-- 2. NOT IN 연산자
-- 인기 메뉴가 없는 매장들 조회
-- name, category, rating 
-- 1단계 인기 메뉴가 있는 매장들 id 확인
SELECT distinct store_id FROM menus WHERE is_popular = TRUE;
-- 2단계 1단계를 조합하여 그 id 들에 해당하지 않는 매장들 가져오기
SELECT  name, category, rating
FROM  stores
WHERE  id NOT IN ( SELECT distinct store_id FROM menus WHERE is_popular = TRUE);

-- 치킨, 피자, 카테고리 매장들만 조회
-- 1단계 : 치킨, 피자 카테고리 중복없이 확인
SELECT distinct name, category, rating
FROM stores
WHERE category in ('치킨','피자')
order by category;

-- 20000원 이상 메뉴를 파는 매장들 조회

-- 1단계 : 20000원 이상 메뉴를 가진 매장 id 들 확인

-- 2단계 : 1단계 결과를 조합하여 해당 매장들에 대한 정보 가져오기
--         name, category ,rating
-- name 순으로 오름차순 정렬


/**********************************************************
           다중행 서브쿼리 실습문제 (1 ~ 10 문제)
***********************************************************/
-- =========================
-- NOI    연산자 포함하고 싶을 때
-- NOI IN 연산자 제외하고 싶을 때
-- =========================


-- 문제 1: 카테고리별 최고 평점 매장들 조회
-- 1단계: 카테고리별 최고 평점들 확인
-- GROUP BY category
SELECT max(rating)
FROM stores
GROUP BY category; -- 카테고리별 가장 높은 평점만 조회

SELECT category
FROM stores
GROUP BY category; -- SUM 에 대한 결과인지, 평점인지, 가격을 합친건지, 나눈 것인지 카테고리별로 무엇을 했는지 알 수 없음
-- 문제에서 평점을 기준으로 가게 데이터를 조회하려 하기 때문에
-- 카테고리별로 그룹을 짓고, 그룹별로 최고 평점만 조회하여
-- 평점을 기준으로 가게 데이터 조회


-- 2단계: 1단계 결과를 조합하여 각 카테고리의 최고 평점 매장들 가져오기
SELECT *
FROM stores
WHERE RATING in (SELECT max(rating)
FROM stores
GROUP BY category);


-- 문제 2: 배달비가 가장 저렴한 매장들의 인기 메뉴들 조회
-- 1단계: 매장들 중에서 가장 저렴한 배달비확인 
SELECT min(delivery_fee) FROM stores; -- min() 함수에서 자동으로 null 값은 생략된다.
-- > 2000 원 나온 결과
-- WHERE 의 특성   Error Code: 1111. Invalid use of group function	0.000 sec
-- WHERE 절에는 MIN() MAX() AVG() 같은 함수를 직접적으로 사용할 수 없음
-- where 절은 테이블의 각 행을 하나씩 필터링하는 단계
-- MIN() 함수는 where절의 필터링이 끝난 다음에 데이터를 그룹화해서 최소값을 계산하는 함수
-- where 절이 실행되는 시점에는 아직  min(delivery_fee) 값이 무엇인지 알 수 없기때문에 문제가 발생
-- 1단계 : 매장 ID들 확인
SELECT id
FROM stores
WHERE delivery_fee = (SELECT min(delivery_fee) FROM stores);


select * from stores;
select * from menus;

-- 2단계: 1단계 결과를 조합하여 해당 매장들의 인기 메뉴들 가져오기
-- JOIN stores s ON m.store_id = s.id

SELECT *
FROM menus
WHERE store_id IN (SELECT id
FROM stores
WHERE delivery_fee = (SELECT min(delivery_fee) FROM stores));
/*
AND is_popular = true;
안써도 
20	8	맵슐랭	매콤달콤한 소스에 마요네즈가 더해진 치킨	19000	1
31	14	블랙타이거 슈림프 피자 (L)	통통한 블랙타이거 슈림프가 가득 올라간 피자	35900	1
32	14	포테이토 피자 (L)	고소한 감자와 부드러운 마요네즈의 조화	27900	1
33	14	치즈 볼로네제 스파게티	진한 볼로네제 소스와 치즈의 만남	9800	1
36	17	고구마 피자 (L)	달콤한 고구마 무스와 토핑이 듬뿍	28900	1
	
    출력결과로 is_popular 가 true 인 것들만 나오는 이유는
    현대 데이터가 모두 is_popular 만 존재하기 때문!
    데이터가 추가적으로 is_popular 가 false 인 데이터가 들어온다면
    AND is_popular = true; 필수로 작성해야 1인 데이터만 조회가 될 것
    true = 1
    false = 0
*/










-- 문제 4: 15000원 이상 메뉴가 없는 매장들 조회
-- 1단계: 15000원 이상 메뉴를 가진 매장 ID들 확인
SELECT distinct store_id
FROM menus
WHERE price >= 15000;
-- 2단계: 1단계 결과에 해당하지 않는 매장들 가져오기
SELECT ID, name
FROM stores
WHERE  id NOT IN (SELECT distinct store_id FROM menus WHERE price >= 15000);
-- 문제 5: 메뉴 설명이 있는 메뉴를 파는 매장들 조회
-- 1단계: 메뉴 설명이 있는 메뉴를 가진 매장 ID들 확인
select distinct store_id from  menus where description IS NOT NULL;

-- 2단계: 1단계 결과를 조합하여 해당 매장들 정보 가져오기
SELECT *
FROM stores
WHERE    id    IN ( select distinct store_id from  menus where description IS NOT NULL ); 
 

-- 문제 6: 메뉴 설명이 없는 메뉴만 있는 매장들 조회

-- 1단계: 메뉴 설명이 있는 메뉴를 가진 매장 ID들 확인
-- description IS NOT NULL : 설명 칸이 null 이 아닌 데이터만 조회하겠다. 조건
select distinct store_id from  menus where description IS NOT  NULL;


-- menus description
-- 2단계: 1단계 결과에 해당하지 않는 매장들 가져오기 (단, 메뉴가 있는 매장만)
 /*   가게이름을 바라보는 name, */
SELECT              stores.name,    menus.description
FROM stores, menus
WHERE  stores.id = menus.store_id
AND  stores.id NOT IN (select distinct store_id from  menus where description IS NOT  NULL);



SELECT * FROM STORES;
-- 문제 7: 치킨 카테고리 매장들의 메뉴들 조회
-- 1단계: 치킨 카테고리 매장 ID들 확인
SELECT id 
FROM stores
WHERE category = '치킨';

-- 2단계: 1단계 결과를 조합하여 해당 매장들의 메뉴들 가져오기
SELECT stores.category, menus.name, menus.price , menus.description
FROM menus, stores
where menus.store_id =  stores.id
and menus.store_id IN (SELECT id FROM stores WHERE category = '치킨');







-- 문제 8: 피자 매장이 아닌 곳의 메뉴들만 조회
-- 1단계: 피자 매장 ID들 확인
SELECT id 
FROM stores
WHERE category = '피자';

-- 2단계: 1단계 결과에 해당하지 않는 매장들의 메뉴들 가져오기
select  *
from menus
where store_id not in (SELECT id  FROM stores WHERE category = '피자');

-- 문제 9: 평균 가격보다 비싼 메뉴를 파는 매장들 조회
-- 0단계 : 메뉴들의 평균 가격 조회
SELECT AVG(price) FROM menus; -- 15221.4286
-- 1단계: 평균 가격보다 비싼 메뉴를 가진 매장 ID들 확인
SELECT distinct store_id
FROM menus
WHERE price > 15221.4286;


-- 2단계: 1단계 결과를 조합하여 해당 매장들 정보 가져오기
SELECT *
FROM stores
WHERE id IN (SELECT distinct store_id  FROM menus WHERE price > (SELECT AVG(price) FROM menus));







-- 문제 10: 가장 비싼 메뉴를 파는 매장들 조회
-- 1단계: 가장 비싼 메뉴를 가진 매장 ID들 확인
SELECT max(price) FROM menus; -- 38900
SELECT store_id
FROM menus
WHERE price = 38900;

SELECT store_id
FROM menus
WHERE price = (SELECT max(price) FROM menus);
-- 2단계: 1단계 결과를 조합하여 해당 매장과 메뉴 정보 가져오기
--      가게 아이디, 메뉴이름, 메뉴 가격
SELECT menus.store_id,stores.name, menus.name, menus.price
FROM menus , stores
WHERE  menus.store_id = stores.id
and menus.price = (SELECT max(price) FROM menus);


SELECT menus.store_id,stores.name, menus.name, menus.price
FROM menus , stores
WHERE  menus.store_id = stores.id
and s.id in (SELECT store_id 
			 FROM menus
			 WHERE price = (SELECT max(price) FROM menus));
             

-- =========================
-- ANY     연산자 하나라도 조건을 만족하면 참
-- 여러 값 중 하나라도 만족하면 TRUE
-- 치킨 카테고리에서 배달비가 어떤 기준보다 작으면 만족 어떤 기준보다 크면 만족
-- =========================

-- 치킨집 중 배달비가 3000이하로 저렴한 매장들 확인
-- 1단계 : 치킨집들의 배달비 확인
SELECT delivery_fee 
FROM stores
WHERE category = '치킨'
AND delivery_fee IS NOT NULL;

-- 2단계 : 특정 값보다 작으면 조건 만족
-- 배달비가 3000원 이하인 매장들 조회 
SELECT *
FROM stores
WHERE delivery_fee <= 3000
AND delivery_fee IS NOT NULL;

-- 3단계 ANY 로 조합하여 치킨 카테고리에서 배달비 중 최저값보다 작은 매장을 만족하는 가게들의 이름, 카테고리 배달비 조회
--    가게들의 이름, 카테고리 배달비 조회
SELECT name, category, delivery_fee
FROM stores
WHERE delivery_fee < ANY(
			SELECT delivery_fee 
			FROM stores
			WHERE category = '치킨'
			AND delivery_fee IS NOT NULL


)
AND delivery_fee IS NOT NULL
ORDER BY delivery_fee;


-- 문제 1 : 한식집들 중 어떤 매장보다 평점이 높은 매장들을 찾아주세요
SELECT * FROM stores 
WHERE category = '한식'
AND rating IS NOT NULL;
-- 1단계 : 한식집들의 평점 확인
SELECT * FROM stores 
WHERE rating > 4.2;
AND rating IS NOT NULL;
-- 2단계 : 한식집 중 어느 매장보다 높은 평점의 매장들(가장 작은 값 4.2보다 크면 ANY 조건 만족)
-- 3단계 : ANY로 조합
SELECT *
FROM stores
WHERE rating > ANY (
    SELECT rating
    FROM stores
    WHERE category = '한식'
    AND rating IS NOT NULL
)
AND rating IS NOT NULL 

AND category NOT IN('한식');-- 한식을 제외한 카테고리 조회 추가



-- 문제 2 : 일식집들 중 어떤 매장보다 배달비가 최고점을 기준으로매장들을 찾아주세요
SELECT * FROM stores WHERE category = '일식';

-- 1단계 : 일식집들의 배달비 확인
SELECT delivery_fee
FROM stores
WHERE category = '일식';
-- 4000 3000 3500 3000 40000

-- 2단계 : 일식집 중 어느 매장보다 저렴한 매장들(가장 큰 값 4000보다 작으면 ANY 조건 만족)
-- 3단계 : ANY로 조합
SELECT *
FROM stores
WHERE delivery_fee < ANY(
					SELECT delivery_fee
					FROM stores
					WHERE category = '일식'
)  
AND delivery_fee IS NOT NULL;





-- =========================
-- ALL     연산자 모든 조건을 만족해야 참
-- =========================

-- 모든 치킨집 보다 배달비가 저렴한 매장들
-- 1단계 : 치킨집들의 배달비 확인
 SELECT * FROM stores
 WHERE category = '치킨';
-- 2단계 : 모든 치킨집 중  배달비 가 가장 낮은 치킨집으로 기준으로 하여 
-- 		   타 카테고리 매장들 중에서 치킨 카테고리에서 최저 배달비 기준으로 낮은 매장 검색
SELECT * FROM stores
WHERE delivery_fee < 2000;

-- 가장 작은 치킨 카테고리 배달비 값보다 작은 데이터만 모두 만족

SELECT * FROM stores
WHERE delivery_fee < ALL(
		 SELECT delivery_fee 
         FROM stores
		 WHERE category = '치킨'
);


-- JAVA에서는 DB에서 전달 받은 데이터가 0개 일것이고, HTML 로 0개를 전달하고 
-- HTML 에서는 조회된 결과가 없습니다. 를 유저들에게 보여줌 
-- DB에서 OUTPUT 화면에 X가 안뜨면 조회된 결과가 없는 것!!!


-- =========================
-- EXISTS     연산자 존재하는 것을 찾기
-- EXISTS - TRUE / FALSE 만 봄 
-- 보통 TRUE = 1 FALSE = 0 
-- 존재하면 1 이라는 숫자가 몇 개 뜨는지만 조회할 떄 주로 사용
-- 컬럼내부값은 궁금하지 않고 , 단순히 존재유무에 대한 결과를 보고 싶을 때 사용하는 단순 숫자 표기 
-- 숫자값은 개발자가 넣고 싶은 숫자값을 마음껏 넣어도 되자만 보통 존재할 때는 1 존재하지 않을땐 0 사용
-- EXISTS 사용 방법
/*
	 WHERE EXISTS(
			SELECT 1
            FROM 다른테이블 별칭
            WHERE 별칭.외래키 = 현재테이블병칭.기본키 
            AND 추가조건들
     )
*/
-- =========================

-- 메뉴가 존재하는 매장들 찾기 
-- 1단계 : 각 매장별로 메뉴가 있는지 확인 
-- 예를 들어 매장 ID -1 인 매장에 메뉴가 존재하는지 확인
-- store_id = 1 인 매장들에 메뉴가 존재하는지 확인

-- store_id = 1 인 데ㅐ이터를 기준으로 조회했을 때 모든 컬럼에 대한 결과를 가져옴
SELECT * 
FROM menus
WHERE store_id = 1;

-- SELECT 1 은 내부의 컬럼 데이터가 궁금한 것이 아니라 데이터가 존재하는지 확인 유무
-- 보통 TRUE = 1 FALSE = 0 
-- 존재하면 1 이라는 숫자가 몇 개 뜨는지만 조회할 떄 주로 사용
-- 컬럼내부값은 궁금하지 않고 , 단순히 존재유무에 대한 결과를 보고 싶을 때 사용하는 단순 숫자 표기 
-- 숫자값은 개발자가 넣고 싶은 숫자값을 마음껏 넣어도 되자만 보통 존재할 때는 1 존재하지 않을땐 0 사용
SELECT 1
FROM menus
WHERE store_id = 1;

SELECT name, category
FROM stores s
WHERE EXISTS(
		SELECT 1
		FROM menus m
		WHERE m.store_id = s.id -- menus 에서 store_id 가 stores 와 같은 id 가 존재할 경우에만 출력 
								-- 모든 가게가 모든 메뉴를 가지고 있기 떄문에 모두 조회가 되지만
								-- 배달의민족에서 가게를 오픈하기만 하고 메뉴가 존재하지 않는 매장의 겨웅 출력 되지 않음
								-- 가게 & 메뉴가 존재하는 사업자들에게 메뉴마다 배민 자체에서 메뉴 10% 할인 이벤트 제공
								-- 모든 부담은 배달어플측에서 제공할 때  사용
                                -- 메뉴 가 없는 가게는 이벤트 제외
);


-- 설명(desctipyion)이 있는 메뉴를 파는 매장들을 찾아주세요 
-- 1단계 : 설명이 있는 메뉴를 가진 매장 ID들 확인
SELECT store_id
FROM menus
WHERE description is not null;

-- 2단계 : EXISTS 를 활용하여 조합
-- EXISTS - TRUE / FALSE 만 봄 
-- 존재 우무를 단순히 확인하기 때문에 1과 같은 숫자값으로 빠르게 데이터를 가져올 수 있도록 설정
-- store_id 연결 조건이 없기 떄문에 단순히 설명이 있는 메뉴가 전체에서 존재하나요? 만 확인하는 상태

-- 매장중에서 메뉴에 설명이 존재하는 데이터만 조회 
-- m.store_id =  s.id 
SELECT *
FROM  stores s
WHERE EXISTS (
    SELECT store_id
	FROM menus m
	AND m id = WHERE description is not null
); --  설명이 없는 메뉴까지 모두 합쳐져서 매장들 조회

-- =========================
-- NOT EXISTS     연산자 존재하지 않은 것을 찾기
-- =========================
