-- =============================
-- GROUP BY
-- =============================
-- 별도의 그룹지정없이 사용한 그룹함수(SUM,AVG,COUNT,MIN,MAX)는 전체를 하나의 그룹으로 처리한다.
-- 세부적인 그룹지정을 위해서는 group by절을 이용한다.
-- 메뉴가 존재하는 카테고리 그룹 조회
-- 같은 카테고리_코드를 가진 메뉴끼리 하나의 그룹으로 처리된다.
-- 일반 컬럼을 조회해도 해당 그룹의 첫번째 컬럼값만 반환한다.
 -- count 함수 사용해서 메뉴 개수 조회
select
    category_code
    from tbl_menu
group by  category_code;
 --
select
    category_code,
    count(*) as '목록'
from tbl_menu
group by  category_code;

-- avg 함수 이용
-- 카테고리별 메뉴 가격 평균
select
    category_code,
    avg(menu_price)
from
    tbl_menu
group by
    category_code ;

-- 2개 이상의 그룹 생성

select
    category_code,
    menu_price,
    avg(menu_price)
from
    tbl_menu
group by
    category_code, menu_price ;

-- =========================
-- HAVING
-- =========================
-- group by로 정해진 그룹에 대해 조건을 설정할 때는 HAVING절에 기술한다.
-- 같은 조건절이지만 WHERE절에는 그룹함수 사용이 불가하다.
/* 그룹 함수는 where에서 호출이 불가
select
    category_code,
    count(*) as '코드'
    from
        tbl_menu
where
    count(*) > 1
group by
    category_code;
*/


-- ==============================
-- ROLLUP
-- ==============================
-- 컬럼 한 개를 활용한 ROLLUP(카테고리별 총합)

select
    category_code,
    sum(menu_price)
from
    tbl_menu
group by
    category_code
with rollup ;

--

select
    category_code,
    menu_price,
    sum(menu_price)
from
    tbl_menu
group by
    category_code,
    menu_price
with rollup ;




































