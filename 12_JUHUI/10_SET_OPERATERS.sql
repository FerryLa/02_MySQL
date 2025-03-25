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

SELECT
    menu_code, menu_name, menu_price, category_code, orderable_status
    FROM tbl_menu
WHERE
    category_code = 10
AND
    menu_code IN (SELECT  menu_code FROM menu_price < 9000);

-- ============================
-- MINUS
-- ============================
SELECT
    *
    FROM(
        SELECT
            MENU_CODE, MENU_NAME, MENU_PRICE
             , CATEGORY_CODE, ORDERABLE_STATUS
            FROM tbl_menu
            WHERE category_code < 10
        ) a
LEFT JOIN ( SELECT MENU_CODE, MENU_NAME, MENU_PRICE, CATEGORY_CODE, ORDERABLE_STATUS
                FROM tbl_menu
                WHERE menu_price = 9000

    
    )b ON a.menu_code = b.menu_code
WHERE a.menu_code;

-- ===============
-- UPDATE
-- ===============
SELECT
    menu_code
    , menu_name
    , category_code
    FROM
            tbl_menu;

    UPDATE
        tbl_menu -- 수정할 대상 테이블
    SET
        category_code = 7
    WHERE
        menu_code = 27;

SELECT
    menu_code
     , menu_name
     , category_code
FROM
    tbl_menu;

UPDATE
    tbl_menu -- 수정할 대상 테이블
SET
     category_code = 10
    , menu_name = '매생이쉐이크'
WHERE
    menu_code = 25;

-- SUBQUERY를 활용할 수도 있다.
-- 다만 MySQL은 Oracle과 달리 update나 delete시 자기 자신 테이블의 데이터를 사용할 시 1093 에러가 난다.
UPDATE
    tbl_menu
SET
    category_code = (SELECT menu_code
                     FROM tbl_menu
                     WHERE menu_name = '우럭스무디')
WHERE
    menu_code = 25;

UPDATE
    tbl_menu
SET
    category_code = (SELECT menu_code
                     FROM (SELECT menu_code
                           FROM tbl_menu
                           WHERE menu_name = '우럭스무디')
WHERE
    menu_code = 25;


 WHERE menu_code = 25;

-- ======================
-- DELETE
-- ======================
-- 테이블의 행을 삭제하는 구문이다.
-- 테이블의 행의 갯수가 줄어든다.
DELETE
FROM tbl_menu
WHERE menu_code = 25;

SELECT * FROM tbl_menu ORDER BY menu_price;

DELETE
FROM tbl_menu
WHERE menu_code = 25;

SELECT * FROM tbl_menu WHERE tbl_menu.menu_code =

-- LIMIT를 활용한 행삭제(offset 지정은 안된다)
DELETE
    FROM ;

-- 테이블 전체 행 삭제
DELETE  FROM tbl_menu;

-- TRUNCATE를 실행하면 ROLLBACK을 할 수 없다.


-- ==============================
-- REPLACE
-- ==============================
-- INSERT시 PRIMARY KEY 또는 UNIQUE KEY가 충돌이 발생할 수 있다면
-- REPLACE를 통해 중복된 데이터를 덮어쓸 수 있다.
INSERT INTO (MENU_NAME) 17