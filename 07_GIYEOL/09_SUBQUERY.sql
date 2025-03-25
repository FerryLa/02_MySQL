-- ===================================
-- SUBQUERY
-- ===================================
-- 하나의 SQL문(main-query) 안에 포함되어 있는 또 다른 SQL문(sub-query)
-- 존재하지 않는 조건에 근거한 값들을 검색하고자 할때 사용.
-- 메인 쿼리가 서브 쿼리를 포함하는 종속적인 관계이다.
-- 메인 쿼리 실행중에 서브 쿼리를 실행해서 그 결과값을 다시 메인쿼리에 전달하는 방식이다.

# 서브쿼리(SUBQUERY) 유형
-- 1. 일반 서브쿼리
--  1-a. 단일행 일반 서브쿼리
--  1-b. 다중행 일반 서브쿼리
-- 2. 상관 서브쿼리
--  2-a. 스칼라 서브쿼리
-- 3. 인라인뷰(파생테이블)

# 규칙
-- 서브쿼리는 반드시 소괄호로 묶어야 함 - (SELECT ... ) 형태
-- 서브쿼리는 연산자의 오른쪽에 위치 해야 함
-- 서브쿼리 내에서 order by 문법은 지원 안됨

-- ==================================
-- 일반 서브쿼리
-- ==================================

# a. 단일행 서브쿼리
-- 열무김치라떼의 카테고리명을 조회
-- 1. tbl_menu에서 열무김치라떼의 카테고리 번호 조회(서브쿼리)
select
    category_code
from

    tbl_menu
where menu_name = '열무김치라떼'; -- 8
-- 2. tbl_category에서 해당 카테고리 번호의 카테고리명을 조회(메인쿼리)
select
    category_code
    from
    tbl_category
where
    category_code ='8';

-- -------------------------------------------------------------

select -- 메인쿼리

    category_code
from
    tbl_category
where
    category_code = (select category_code from tbl_menu where menu_name ='열무김치리떼'); -- 서브쿼리

-- 민트 미역국과 같은 카테고리이 메뉴조히(메뉴코드, 메뉴명, 가격, 주문가능여부)
select
    menu_code 메뉴코드,
    menu_name 메뉴명,
    menu_price 가격,
    orderable_status 주문가능여부
from
    tbl_menu
where
    category_code = (select
                        category_code
                     from tbl_menu
                    where menu_name = '민트미역국');
-- b. 다중행 서브쿼리
-- 식사류 메뉴 모두 조회
select
    category_code
from
    tbl_category
where ref_category_code = 1;
-- 서브 쿼리가 다중 값을 반환할 때 = 연산자를 사용할 수 없다
# all 연산자
-- 서브 쿼리의 결과 모두에 대해 연산결과가 참이면 참을 반환한다.
-- x > ALL(..)  : 모든 값보다 크면 참. 최대값보다 크면 참
-- x >= ALL(..) : 모든 값보다 크거나 같으면 참. 최대값보다 크거나 같으면 참.
-- x < ALL(..)  : 모든 값보다 작으면 참. 최소값보다 작으면 참
-- x <= ALL(..) : 모든 값보다 작거나 같으면 참. 최소값보다 작거나 같으면 참.
-- x = ALL(..)  : 모든 값과 같으면 참.
-- x != ALL(..) : 모든 값과 다르면 참. NOT IN과 동일

-- 가장 비싼 메뉴 조회
-- max 최대값 , min 최소값
select
    max(menu_price)
from
    tbl_menu;

select
    min(menu_price)
from
    tbl_menu;

select
    *
from
        tbl_menu
where menu_price >= all(select  menu_price from tbl_menu);
-- 한식 보다 비싼 양식/중식이 존재하는지 궁금함
select
    *
from
    tbl_menu
where
    category_code in (5,6)
and
    menu_price > all(select menu_price
                     from tbl_menu
                     where category_code =4);
-- =============================
-- 상관 서브쿼리
-- =============================
-- 메인쿼리의 값을 서브쿼리에 주고 서브쿼리를 수행한 다음
-- 그 결과를 다시 메인쿼리로 반환하는 방식으로 수행되는 서브쿼리

-- 서브쿼리의 WHERE 절 수행을 위해서는 메인쿼리가 먼저 수행되는 구조
-- 메인쿼리 테이블의 레코드(행)에 따라 서브쿼리의 결과값도 바뀜
-- 메인 쿼리에서 처리되는 각 행의 컬럼값에 따라 응답이 달라져야 하는 경우에 유용


-- 카테고리 별로 가격이 가장 비싼 메뉴를 알고 싶다
select
    category_code,
    max(menu_price)
from tbl_menu
group by category_code ;

--
select
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from tbl_menu a
where menu_price = (select  max(menu_price)
                     from tbl_menu b
                     where b.category_code = a.category_code) ;
-- 카테고리별 평균 가격보다 높은 가격의 메뉴 조회

select
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from tbl_menu a
where menu_price > (select  avg(b.menu_price)
                    from tbl_menu b
                    where b.category_code = a.category_code) ;
--
-- =========================
-- 스칼라 서브쿼리
-- =========================
-- 결과값이 1개인 상관서브쿼리, 주로 SELECT문에서사용된다.
-- (단일값을 스칼라값이라고 한다.)

-- 메뉴명, 카테고리명을 조회
select
    a.menu_name,
    b.category_name
    from tbl_menu a
left join tbl_category b on a.menu_code = b.category_name;

--
select
    a.menu_name,
    (select category_name
     from tbl_category b
     where b.category_code = a.category_code)
    category_name
from
    tbl_menu a;


-- ===========================
-- 인라인뷰(INLINE-VIEW)
-- ===========================
-- FROM절에 서브쿼리를 사용한 것을 인라인뷰(INLINE-VIEW)라고한다.

# VIEW란
-- 실제테이블을 주어진 뷰('보다'라는 의미를 가짐)를 통해 제한적으로 사용가능함.
-- 실제테이블에 근거한 논리적인 가상테이블(사용자에게 하나의 테이블처럼 사용가능)이다.
-- view 를 사용하면 복잡한 쿼리문을 간단하게 만듦으로써 가독성이 좋으므로 편리하게 쿼리문을 만들수 있다.

-- view에는 stored view와 inline view가 있다.
-- 1. inline view : from절에 사용하는 서브쿼리, 1회용
-- 2. stored view : 영구적으로 사용가능. 재활용가능한 가상테이블


select -- 인라인뷰에 존재하는 컬럼만 참조 가능
    v.menu_name,
    v.category_name,
    v.menu_price
from (select menu_name,
      (select category_name
      from tbl_category b
      where b.category_code = a.category_code)category_name,
          menu_price
      from tbl_menu a) v
-- -문제 1








