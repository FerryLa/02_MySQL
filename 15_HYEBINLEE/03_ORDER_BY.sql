-- ------------------------------------------
-- ORDER BY
-- ------------------------------------------
-- RESULTSET 행에 대해 정렬을 할 때 사용하는 구문
-- SELECT 구문의 가장 마지막에 작성하며, 실행순서도 가장 마지막에 수행된다.

# SELECT
#     컬럼1,컬럼2,컬럼3...
# FROM
#     테이블명
# WHERE
#     조건절
# ORDER BY
#     컬럼명|별칭|컬럼순서 정렬방식[NULLS FIRST | LAST] -- LAST 기본값

# 데이터 정렬 방법
# ---------------------------------------------------------------------------------------------------------
#         NUMBER              CHARACTER            DATE                      NULL
# ---------------------------------------------------------------------------------------------------------
# ASC    작은수 -> 큰수        사전수        빠른날 -> 늦은날                     맨아래 행
#                                                            (NULL 값이 맨 아래로감)
#
# DESC    큰수 -> 작은수        사전역순     늦은날 -> 빠른날                      맨 위 행
#                                                            (NULL 값이 맨 위로감)
#
# -----------------------------------------------------------------------------------------------------------

SELECT
       menu_code
     , menu_name
     , menu_price
  FROM
       tbl_menu
 ORDER BY
       menu_price DESC; # DESC는 내림차순


-- 정렬조건 여러개 -> ORDER BY절 안에 콤마(,)로 연결하여 결과집합을 여러 열로 정렬

SELECT
       menu_code
     , menu_name
     , menu_price
  FROM
       tbl_menu
 ORDER BY
    menu_price DESC, menu_name;
-- 일단 가격순으로 내림차순으로 지정하고, 가격이 같으면 메뉴이름의 오름차순으로 정렬한다.


-- 컬럼순서로 지정해서 정렬
SELECT
       menu_code
     , menu_name
     , menu_price
  FROM
       tbl_menu
 ORDER BY
       menu_price DESC;
-- 위와 같은 코드
SELECT
       menu_code
     , menu_name
     , menu_price
FROM
       tbl_menu
ORDER BY
       3 DESC;


-- 별칭 정렬 가능
SELECT
       menu_code AS "메뉴 코드"
     , menu_name "메뉴명"
     , menu_price 메뉴가격
  FROM
       tbl_menu
 ORDER BY
       메뉴가격 DESC;


-- ORDER BY절을 사용하여 연산결과로 결과집합 정렬
-- 컬럼명이 없을 때, 3 숫자 정렬 유용
SELECT
    menu_code 메뉴코드
  , menu_name 메뉴명
  , menu_code * menu_price
  FROM
      tbl_menu
 ORDER BY
     3 DESC;


-- ORDER BY 절을 사용하여 사용자 지정 목록을 사용하여 데이터 정렬
-- FILED(검색할문자열, targer1, target2, ....) 검색할 문자열과 일치하는 첫번째 타겟의 인덱스를 반환
SELECT FIELD('A', 'A', 'A', 'B', 'C'); # 1
SELECT FIELD('B', 'A', 'B', 'C'); # 2
SELECT FIELD(orderable_status, 'Y', 'N') FROM tbl_menu;


# FIELD를 정렬에도 사용 가능
SELECT
       menu_name
     , orderable_status
  FROM tbl_menu
 ORDER BY
    FIELD(orderable_status, 'Y', 'N') ;

-- NULL은 0보다 작다.
-- 오름차순 시 맨 위에 온다(DEFAULT)
-- 내림차순 시 맨 밑에 온다(DEFAULT)
SELECT
       category_code
     , category_name
     , ref_category_code
  FROM
       tbl_category
 ORDER BY
#        ref_category_code;
       ref_category_code DESC;

-- 오름차순 시 NULL 마지막
SELECT
       category_code
     , category_name
     , ref_category_code
  FROM
    tbl_category
 ORDER BY
#    ref_category_code IS NULL ASC;
    ref_category_code IS NULL;

-- 내림차순 시 NULL 마지막
SELECT
       category_code
     , category_name
     , ref_category_code
  FROM
       tbl_category
 ORDER BY
     ref_category_code DESC;


-- 내림차순 시 NULL 처음으로
SELECT
    category_code
     , category_name
     , ref_category_code
FROM
    tbl_category
ORDER BY
    ref_category_code IS NULL DESC, ref_category_code DESC;
# null이면 1을 반환하는데, DESC이니까 1 다음 0.
# 그래서 null을 먼저 앞으로 빼고, 그 다음 카테고리 코드를 내림차순 정렬