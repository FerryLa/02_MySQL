-- ===================================
-- 집합 연산자 (Set Operator)
-- ===================================
# 여러 개의 질의의 결과를 컬럼끼리 연결하여 하나의 결과집합을 만드는 방식

# 조건
-- SELECT 절의 "컬럼 수가 동일" 해야 한다.
-- ORDER BY 절은 마지막 결과집합에 딱 한번 사용가능하다.
-- 컬럼명이 다른 경우, 첫번째 ENTITY의 컬럼명을 결과집합에 반영한다.
-- (MYSQL) SELECT 절의 동일 위치에 타입이 다른 경우, 해당 컬럼은 오류없이 문자열 컬럼으로 변환처리된다.
-- (ORACLE) SELECT 절의 동일 위치에 존재하는 컬럼의 "데이터 타입이 상호 호환 가능" 해야한다.

# 종류
-- 1. UNION 합집합(중복제거)
-- 2. UNION ALL 합집합(중복허용)
-- 3. INTERSECT 교집합
-- 4. MINUS 차집합

-- ===============================================================================
-- union all
-- ===============================================================================
-- 카테고리 10번 메뉴 조회
select
    menu_code, menu_name, menu_price,
    category_code, orderable_status
from
    tbl_menu
where
    category_code = 10; -- 결과 6행
-- 메뉴 가격이 9천원 미만 조회
select
    menu_code, menu_name, menu_price,
    category_code, orderable_status
from
    tbl_menu
where
    menu_price < 9000; -- 결과 10행

-- union all 사용해 합치기
select
    menu_code, menu_name, menu_price,
    category_code, orderable_status
from
    tbl_menu
where
  category_code = 10 union all
 select
      menu_code, menu_name, menu_price,
      category_code, orderable_status
from
     tbl_menu
where
    menu_price < 9000;
-- union 으로 합치기
select
    menu_code, menu_name, menu_price,
    category_code, orderable_status
from
    tbl_menu
where
    category_code = 10 union
select
    menu_code, menu_name, menu_price,
    category_code, orderable_status
from
    tbl_menu
where
    menu_price < 9000;


-- 교집합 (inersect)

-- 1) inner 조인을 활용
select
a.menu_code, a.menu_name, a.menu_price,
a.category_code, a.orderable_status
from
    tbl_menu a
inner join (select menu_code, menu_name, menu_price,
                   category_code, orderable_status
            from tbl_menu
            where menu_price < 9000) b
on a.menu_code =b.menu_code
where  a.category_code =10;

-- 2)
(select
    menu_code, menu_name, menu_price,
    category_code, orderable_status
    from tbl_menu
where category_code =10) a
intersect
left join (select
       menu_code, menu_name, menu_price,
    category_code, orderable_status
from tbl_menu
)
-- ==================================
-- MINUS
-- ==================================
SELECT *
FROM (SELECT
          menu_code, menu_name, menu_price,
          category_code, orderable_status
      FROM
          tbl_menu
      WHERE
          category_code = 10) a
         LEFT JOIN (SELECT
                        menu_code, menu_name, menu_price,
                        category_code, orderable_status
                    FROM
                        tbl_menu
                    WHERE
                        menu_price < 9000) b
                   ON a.menu_code = b.menu_code
WHERE
    b.menu_code IS NULL;












