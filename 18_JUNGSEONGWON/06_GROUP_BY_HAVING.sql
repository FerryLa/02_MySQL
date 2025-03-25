-- =============================
-- GROUP BY
-- =============================
-- 별도의 그룹지정없이 사용한 그룹함수(SUM,AVG,COUNT,MIN,MAX)는 전체를 하나의 그룹으로 처리한다.
-- 세부적인 그룹지정을 위해서는 group by절을 이용한다.
-- 메뉴가 존재하는 카테고리 그룹 조회
-- 같은 카테고리_코드를 가진 메뉴끼리 하나의 그룹으로 처리된다.
-- 일반 컬럼을 조회해도 해당 그룹의 첫번째 컬럼값만 반환한다.

SELECT
        category_code
    FROM tbl_menu
  GROUP BY  -- 카테고리 별로 메뉴가 몇 개 있는 지 알 수 있다.
         category_code;

-- COUNT 함수를 활용해서 카테고리별 메뉴 개수 조회

SELECT
         category_code
         ,COUNT(*) -- 카운터를 추가해서 동일한 카테고리가 몇 개가 있는 지 알려준다.
    FROM
         tbl_menu
    GROUP BY
          category_code;
-- AVG 함수 활용
-- 카테고리 별 메뉴 가격 평균

SELECT
        category_code
      , AVG(menu_price) -- 그룹함수와 단일 함수를 더 추가하고 싶은 경우 GROUP BY를 더 사용해서 묶어준다.
    FROM
        tbl_menu
    GROUP BY
        category_code;

SELECT
         category_code
        ,menu_price
        ,AVG(menu_price)
    FROM
         tbl_menu
    GROUP BY
          category_code, menu_price;

-- =========================
-- HAVING
-- =========================
-- group by로 정해진 그룹에 대해 조건을 설정할 때는 HAVING절에 기술한다.
-- 같은 조건절이지만 WHERE절에는 그룹함수 사용이 불가하다.

/*
SELECT
          category_code
        , COUNT(*)
    FROM
          tbl_menu
    WHERE
          COUNT(*) > 1 -- WHERE절은 하나하나 다 확인하지만 그룹화를 한 시점에서는 사용이 불가능하다.
    GROUP BY
          category_code
    HAVING              -- 그룹화를 했을 경우에 조건을 설정할 수 있게 해주는 것이다.
          COUNT(*) > 1;

 */

-- ==============================
-- ROLLUP
-- ==============================
-- 컬럼 한 개를 활용한 ROLLUP(카테고리별 총합)
-- WITH ROLLUP으로 사용

SELECT
        category_code
       ,SUM(menu_price)
    FROM
        tbl_menu
    GROUP BY
        category_code
    WITH ROLLUP;

SELECT
         category_code
        ,menu_price
        ,SUM(menu_price)
    FROM
         tbl_menu
    GROUP BY
         category_code
        ,menu_price
    WITH ROLLUP;







