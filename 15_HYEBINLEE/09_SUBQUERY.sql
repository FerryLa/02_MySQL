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
    SELECT
           category_code
        FROM tbl_menu
     WHERE menu_name = '열무김치라떼'; -- 8


-- 2. tbl_category에서 해당 카테고리 번호의 카테고리명을 조회(메인쿼리)
    SELECT
           category_name
        FROM tbl_category
      WHERE category_code = 8;


-- ---------------------------------------------------------
    SELECT -- 메인쿼리
           category_name
      FROM tbl_category
     WHERE category_code = (SELECT category_code
                              FROM tbl_menu -- 서브쿼리
                            WHERE  menu_name = '열무김치라떼'
         );

-- 민트미역국과 같은 카테고리의 메뉴조회(메뉴코드, 메뉴명, 가격, 주문가능여부)
SELECT
       menu_code 메뉴코드
     , menu_name 메뉴명
     , menu_price 가격
     , orderable_status 주문가능여부
  FROM
       tbl_menu
 WHERE category_code = (SELECT category_code
                            FROM tbl_menu
                          WHERE menu_name = '민트미역국'
                        );


-- b. 다중행 서브쿼리
-- 식사류 메뉴 모두 조회
SELECT category_code FROM tbl_category WHERE ref_category_code = 1;

-- 서브쿼리가 다중행을 반한하는 경우, = 연산자를 사용할 수 없다.
SELECT
    *
FROM
    tbl_menu
WHERE category_code IN (
    SELECT category_code
    FROM tbl_category
    WHERE ref_category_code = 1
);

# all 연산자
-- 서브 쿼리의 결과 모두에 대해 연산결과가 참이면 참을 반환한다.
-- x > ALL(..)  : 모든 값보다 크면 참. 최대값보다 크면 참
-- x >= ALL(..) : 모든 값보다 크거나 같으면 참. 최대값보다 크거나 같으면 참.
-- x < ALL(..)  : 모든 값보다 작으면 참. 최소값보다 작으면 참
-- x <= ALL(..) : 모든 값보다 작거나 같으면 참. 최소값보다 작거나 같으면 참.
-- x = ALL(..)  : 모든 값과 같으면 참.
-- x != ALL(..) : 모든 값과 다르면 참. NOT IN과 동일

-- 가장 비싼 메뉴 조회
-- MAX 함수로 최대값만 조회
SELECT
    MAX(menu_price)
  FROM tbl_menu;

SELECT
       *
  FROM tbl_menu
 WHERE menu_price >= ALL(SELECT menu_price FROM tbl_menu);

-- 한식보다 비싼 양식/중식이 존재하는지 궁금함. . .
SELECT *
  FROM tbl_menu
 WHERE
       category_code IN (5,6)
 AND
       menu_price > ALL(SELECT menu_price
                          FROM tbl_menu
                         WHERE category_code = 4);

-- =============================
-- 상관 서브쿼리
-- =============================
-- 메인쿼리의 값을 서브쿼리에 주고 서브쿼리를 수행한 다음
-- 그 결과를 다시 메인쿼리로 반환하는 방식으로 수행되는 서브쿼리

-- 서브쿼리의 WHERE 절 수행을 위해서는 메인쿼리가 먼저 수행되는 구조
-- 메인쿼리 테이블의 레코드(행)에 따라 서브쿼리의 결과값도 바뀜
-- 메인 쿼리에서 처리되는 각 행의 컬럼값에 따라 응답이 달라져야 하는 경우에 유용


-- 카테고리별 가격이 가장 비싼 메뉴를 조회
SELECT
      category_code, MAX(menu_price) # MAX는 그룹함수(집계함수)
  FROM tbl_menu
 GROUP BY category_code;

SELECT
       menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
  FROM tbl_menu a
 WHERE # 서브쿼리
       menu_price = (SELECT MAX(menu_price)
                     FROM tbl_menu b
                     WHERE b.category_code = a.category_code);


-- 카테고리별로 평균 가겨보다 높은 가격의 메뉴 조회

SELECT
        menu_code
      , menu_name
      , menu_price
      , category_code
      , orderable_status
  FROM tbl_menu a
 WHERE # 서브쿼리
      menu_price = (SELECT AVG(menu_price)
                    FROM tbl_menu b
                    WHERE b.category_code = a.category_code);

-- =========================
-- 스칼라 서브쿼리
-- =========================
-- 결과값이 1개인 상관서브쿼리, 주로 SELECT문에서사용된다.
-- (단일값을 스칼라값이라고 한다.)


-- 메뉴명, 카테고리명을 조회
SELECT
    a.menu_name,
    b.category_name
    FROM tbl_menu a
    LEFT JOIN tbl_category b ON a.category_code = b.category_code;

# 스칼라 서브쿼리
# 조인 없이 특정값 한 개 들고와서 쓰고싶을 때
SELECT
       a.menu_name
     , (SELECT category_name
        FROM tbl_category b
        WHERE a.category_code = b.category_code
        ) category_name
  FROM tbl_menu a;

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

SELECT  -- 인라인뷰에 존재하는 컬럼만 참조할 수 있다.
        v.menu_name,
        v.category_name,
        v.menu_price
FROM (
         SELECT
             a.menu_name,
             (SELECT category_name
              FROM tbl_category AS b
              WHERE a.category_code = b.category_code
             ) AS category_name,
             a.menu_price
         FROM tbl_menu AS a
     ) v;



-- 1. 재직 중이고 휴대폰 마지막 자리가 2인 직원 중 입사일이 가장 최근인 직원 3명의 사원번호,
-- 사원명, 전화번호, 입사일, 퇴직여부를 출력하세요.
-- 참고. 퇴사한 직원은 퇴직여부 컬럼값이 ‘Y’이고, 재직 중인 직원의 퇴직여부 컬럼값은 ‘N’ (JOIN은 아님)


/*
-------------------- 출력 예시 ----------------------------
        사원번호    사원명     전화번호        입사일     퇴직여부
        -----------------------------------------------------------
        216         차태연     01064643212     2013-03-01 00:00:00,N
        211         전형돈     01044432222     2012-12-12 00:00:00,N
        206         박나라     01096935222     2008-04-02 00:00:00,N
    */


SELECT
       EMP_ID
     , EMP_NAME
     , PHONE
     , HIRE_DATE
     , QUIT_YN
  FROM employee a
 WHERE a.QUIT_YN = 'N' AND PHONE LIKE '%2' ORDER BY HIRE_DATE DESC LIMIT 3;


-- 2. 재직 중인 ‘대리’들의 직원명, 직급명, 급여, 주민번호, 이메일, 전화번호, 입사일을 출력하세요.
-- 단, 급여를 기준으로 내림차순 출력하세요.

SELECT
       EMP_NAME
     , b.JOB_NAME
     , SALARY
     , EMP_NO
     , EMAIL
     , PHONE
     , HIRE_DATE
     , QUIT_YN
FROM employee a
JOIN job b ON a.JOB_CODE = b.JOB_CODE
WHERE QUIT_YN = 'N' AND JOB_NAME='대리' ORDER BY SALARY DESC;


/*
    ---------------------------------- 출력 예시 ------------------------------------------------
    사원명     직급명     급여       사원번호        이메일                    입사일
    ----------------------------------------------------------------------------------------------
    전지연     대리      3660000     770808-2665412  jun_jy@ohgiraffers.com    2007-03-20 00:00:00
    차태연     대리      2780000     000704-3364897  cha_ty@ohgiraffers.com    2013-03-01 00:00:00
    장쯔위     대리      2550000     780923-2234542  jang_zw@ohgiraffers.com   2015-06-17 00:00:00
    하동운     대리      2320000     621111-1785463  ha_dh@ohgiraffers.com     1999-12-31 00:00:00
    전형돈     대리      2000000     830807-1121321  jun_hd@ohgiraffers.com    2012-12-12 00:00:00

*/

