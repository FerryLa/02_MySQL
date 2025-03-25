🐒유승제 강사🐒 — 오후 4:27
-- ==============================
-- WHERE
-- ==============================

WHERE 비교 연산자
-- 표현식 사이의 관계를 비교하기 위해 사용하고, 비교 결과는 논리 결과 중에 하나 (TRUE/FALSE/NULL)가 된다.
-- 단, 비교하는 두 컬럼 값/표현식은 서로 동일한 데이터 타입이어야 한다.

연산자                    설명
--------------------------------------------------------------------------------
=                        같다
>,<                        크다/작다
>=,<=                    크거나 같다/작거나 같다
<>,!=                    같지 않다 (^= 없음)
BETWEEN AND                특정 범위에 포함되는지 비교
LIKE / NOT LIKE            문자 패턴 비교
IS NULL / IS NOT NULL    NULL 여부 비교
IN / NOT IN                비교 값 목록에 포함/미포함 되는지 여부 비교
WHERE 논리 연산자
-- 여러 개의 제한 조건 결과를 하나의 논리결과로 만들어 줌 (&&, 사용불가)
-- AND &&    여러 조건이 동시에 TRUE일 경우에만 TRUE 값 반환
-- OR     여러 조건들 중에 어느 하나의 조건만 TRUE이면 TRUE값 반환
-- NOT !    조건에 대한 반대값으로 반환(NULL은 예외)
-- XOR        두 값이 같으면 거짓, 두 값이 다르면 참
 -- 1 비교 연산자
select
    menu_name
,   menu_price
,   orderable_status
from
        tbl_menu
where
    orderable_status = 'N';
 -- tbl_menu 테이블에서 가격이 만3천원인 메뉴 이름 ,가격, 주문 여부 출력
 select
     menu_name,
     menu_price,
     orderable_status
    from tbl_menu where menu_price = 13000;
-- 같지 않은 연산자와 함께 where문 사용
select
    menu_name,
    menu_price,
    orderable_status
 from
     tbl_menu
where
    orderable_status ='N'; -- mysql은 비교나 검색을 수행할 때 기본적으로 대소문자 구분없이 사용가능
 --  orderable_status <> 'Y';
 -- orderable_status != 'Y';
 -- 대소비교 연산자와 함께 where문 사용
select
    menu_name,
    menu_price,
    orderable_status
from
    tbl_menu
where
    menu_price > 20000;

 --
select
    menu_name,
    menu_price,
    orderable_status
from
    tbl_menu
where
    menu_price <= 20000;
 -- 2. and 연산자와 함께 where문 사용
 -- 0은 FALSE, 0외의 숫자는 true로 암사적으로 형변환 후 평가
 -- 문자열은 0으로 반환, FALSE로 평가
 -- NULL과의 연산 결과는 null이다 (0 && null제외)
 select 1 and 1, 2 && 2, -1 && 1 , 1 && 'abc';
 select 1 and 0, 0 and 1, 0 and 0, 0 and null;
 select 1 and null, null and null;
 select 1 + null, 1 - null,1 * null,1 / null;
 -- 메뉴에서 주문 여부가 y이면서, 카테고리가 10인 메뉴 목록 조회
 select
     menu_code,
     menu_price,
     category_code,
     orderable_status
     from tbl_menu
 where
     orderable_status = 'Y'
   and
     category_code = 10;

 -- 메뉴에서 메뉴가격이 5000원보다 크고, 카테고리 코드가 10인 메뉴를 구하라
 -- 단, 출력 메뉴코드, 메뉴이름, 메뉴가격,카테고리코드, 주문여부만 출력
select
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from tbl_menu
where
    menu_price > 5000
   and
    category_code = 10 ;
 -- 3. or연산자와 함께 where 문 사용
 select 1 or 1, 1 or 0 , 0 or 1;
 select 0 or 0;
 select 1 or null, 0 or null, null or null;
-- 메뉴에서 주문 여부가 y이거나, 카테고리가 10인 메뉴 목록 조회
select
    menu_code,
    menu_price,
    category_code,
    orderable_status
from tbl_menu
where
    orderable_status = 'Y'
   or
    category_code = 10;
 -- 우선 순위
 -- and랑 or 중에 and가 더 우선순위가 높다
 select 1 or 0 and 0;
 select (1 or 0) and 0;
 -- 카테고리 번호가 4 또는 가격이 9천원이면서 메뉴번호가 10보다 큰 메뉴를 조회
 -- 모든 컬럼 조회
select
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
    from tbl_menu
 where
     category_code =4
or
     menu_price = 9000
and
     menu_code > 10;

-- test
 -- 5. between 연산자
 -- 숫자, 문자열, 날짜/시간 값의 범위 안에 있다면 참값을 반환하는 연산자
 select
    menu_name,
    menu_price,
    category_code
  from tbl_menu
 where
    menu_price >= 10000
 and
    menu_price <= 25000;
 --
select
    menu_name,
    menu_price,
    category_code
from tbl_menu
where
    menu_price between  10000 and 25000;
 -- 사전등재순으로 문자열 범위 비교
select
    menu_name,
    menu_price,
    category_code
from tbl_menu
where
    menu_name between '가' and '마'
order by
    menu_price;
 -- 부정문
select
    menu_name,
    menu_price,
    category_code
from tbl_menu
where
    menu_price not between  10000 and 25000;
 -- 6. like 연산자
 -- %이 : 이로 시작되는 것 , %이% : 이가 들어가는 것 , 이% : 이로 끝나는 것
 -- S___ :s를 포함한 4의 단어로 구성된 문장 LIKE %이 / LIKE S___
 -- 비교하려는 값이 지정한 특정 패턴을 만족시키면 TRUE를 리턴하는 연산자로 '%', ''를 와일드카드로 사용할 수있다.

-- 와일드카드란? 다른 문자로 대체가능한 특수한 의미를 가진 문자
-- 1. '%' 글자가 없든지, 글자가 1개 이상 여러개를 의미한다.
-- 2. 개수에 따라 문자 1개를 의미한다 _가 3개라면 문자 3개를 의미한다.

-- %의 위치에 따라서 검색
-- %문자     : 문자로 끝나는 내용만
-- 문자%     : 문자로 시작하는 내용만
-- %문자%    : 문자가 포함되어 있는 내용만
select
    menu_name,
    menu_price
from tbl_menu
where
    menu_NAME LIKE '%마늘%' ;


select
    menu_name,
    menu_price
from tbl_menu
where
    menu_NAME LIKE '마%' ;

select
    menu_name,
    menu_price
from tbl_menu
where
    menu_NAME LIKE '%밥' ;

-- 주스 앞글자가 세글자인 문자 조회
select
    menu_name,
    menu_price
from tbl_menu
where
    menu_NAME LIKE '______쥬스%' ;
 --
select
    menu_name,
    menu_price
from tbl_menu
where
    menu_NAME NOT LIKE '%갈치%' ;
-- IN 연산자 (OR가 있지만 IN이 더 편리함)
-- 카테고리 코드가 4,5,6 인 메뉴를 조회하세요.
SELECT
    menu_name,
    category_code
FROM
    tbl_menu
WHERE
    category_code = 4
   OR
    category_code = 5
   OR
    category_code = 6;

-- 부정표현
SELECT
    menu_name,
    category_code
FROM
    tbl_menu
WHERE
    category_code IN (4, 5, 6);
 --
SELECT
    menu_name,
    category_code
FROM
    tbl_menu
WHERE
    category_code NOT IN (4, 5, 6);

-- IS NULL
SELECT
    category_code,
    category_name,
    ref_category_code
FROM
    tbl_category
WHERE
    ref_category_code IS NULL;

-- null처리함수를 통해 찾을 수 있다.
SELECT
    category_code,
    category_name,
    ref_category_code
FROM
    tbl_category
WHERE
    IFNULL(ref_category_code, 0) = 0;
 --
SELECT
    category_code,
    category_name,
    ref_category_code,
    IFNULL(ref_category_code,0)
FROM
    tbl_category
WHERE
    IFNULL(ref_category_code, 0) = 0;
 --
SELECT
    category_code,
    category_name,
    ref_category_code
FROM
    tbl_category
WHERE
   # IFNULL(ref_category_code, 0) = 0
   COALESCE(ref_category_code,0) =0; -- 모든 dbms에서 사용 가능
 -- 부정 표현
SELECT
    category_code,
    category_name,
    ref_category_code
FROM
    tbl_category
WHERE
    ref_category_code IS NOT NULL;
 --
create table tb_escape_watch(
    watchname varchar(40),
    description varchar(200)
);
insert into tb_escape_watch values('금시계', '순금 99.99% 함유 고급시계');
insert into tb_escape_watch values('은시계', '고객 만족도 99.99점를 획득한 고급시계');
 -- escape 문자 : \% -> 99.99\% (99.99% 인거 찾기)
SELECT * FROM tb_escape_watch
    where
    description like '%99.99\% %'; -- *******************************888
 --
















