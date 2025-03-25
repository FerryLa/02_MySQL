
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
     WHERE menu_name = '열무김치라떼';


-- 2. tbl_category에서 해당 카테고리 번호의 카테고리명을 조회(메인쿼리)
    SELECT
            category_code
      FROM tbl_category
     WHERE category_code = 8;

-- --------------------------
    SELECT -- 메인 쿼리
            category_name
      FROM tbl_category
     WHERE category_code = (SELECT category_code        -- 서브쿼리
                              FROM tbl_menu
                             WHERE menu_name = '열무김치라떼'
         );
-- 민트미역국과 같은 카데고리의 메뉴 조회(메뉴코드, 메뉴명, 가격, 주문가능여부)
SELECT
        menu_code 메뉴코드
      , menu_name 메뉴명
      , menu_price 가격
      , orderable_status 주문가능여부
  FROM
        tbl_menu
 WHERE
        category_code = (SELECT category_code
                          FROM tbl_menu
                         WHERE menu_name = '민트미역국'
                        );

-- b. 다중행 서브쿼리
-- 식사류 메뉴 모두 조회
SELECT category_code FROM tbl_category WHERE ref_category_code = 1;

-- 서브쿼리가 다중행을 반환하는 경우 = 연산자를 사용할 수 없다.
SELECT
        *
  FROM
        tbl_menu
 WHERE category_code IN (SELECT category_code
                         FROM tbl_menu
                         WHERE menu_name = '민트미역국');

# all 연산자
-- 서브 쿼리의 결과 모두에 대해 연산결과가 참이면 참을 반환한다.
-- x > ALL(..)  : 모든 값보다 크면 참. 최대값보다 크면 참
-- x >= ALL(..) : 모든 값보다 크거나 같으면 참. 최대값보다 크거나 같으면 참.
-- x < ALL(..)  : 모든 값보다 작으면 참. 최소값보다 작으면 참
-- x <= ALL(..) : 모든 값보다 작거나 같으면 참. 최소값보다 작거나 같으면 참.
-- x = ALL(..)  : 모든 값과 같으면 참.
-- x != ALL(..) : 모든 값과 다르면 참. NOT IN과 동일

-- 가장 비싼 메뉴 조회
-- MAX함수로 최대값만 조회
SELECT
        MAX(menu_price)
  FROM tbl_menu;

SELECT
        *
  FROM
        tbl_menu
 WHERE
        menu_price >= ALL(SELECT menu_price FROM tbl_menu);

-- 한식보다 비싼 양식/중식이 존재하는 지 궁금함...
SELECT
        *
  FROM
        tbl_menu
 WHERE
        category_code IN (5, 6)
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
        category_code, MAX(menu_price)
  FROM
        tbl_menu
 GROUP BY category_code;

SELECT
        menu_code
      , menu_name
      , menu_price
      , category_code
      , orderable_status
  FROM
        tbl_menu a
 WHERE
        menu_price = (SELECT MAX(menu_price)
                        FROM tbl_menu b
                       WHERE b.category_code = a.category_code
                      );

-- 카테고리별 평균 가격보다 높은 가격의 메뉴 조회
SELECT
        menu_code
      , menu_name
      , menu_price
      , category_code
      , orderable_status
  FROM
        tbl_menu a
 WHERE
        menu_price = (SELECT AVG(b.menu_price)
                        FROM tbl_menu b
                       WHERE b.category_code = a.category_code
                      );

-- =========================
-- 스칼라 서브쿼리
-- =========================
-- 결과값이 1개인 상관서브쿼리, 주로 SELECT문에서사용된다.
-- (단일값을 스칼라값이라고 한다.)

-- 메뉴명, 카테고리명을 조회
SELECT
        a.menu_name
      , b.category_name
  FROM
        tbl_menu a
  LEFT JOIN
            tbl_category b ON a.category_code = b.category_code

SELECT
        a.menu_name
      , (SELECT category_name
           FROM tbl_category b
          WHERE b.category_code = a.category_code
         ) category_name
  FROM
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

SELECT -- 인라인 뷰에 존쟇나느 컬럼만 참조할 수 있다.
        v.menu_name
      , v.category_name
      , v.menu_price
  FROM (SELECT menu_name
             , (SELECT category_name
                    FROM tbl_category b
                    WHERE b.category_code = a.category_code
               ) category_name
            , menu_price
        FROM tbl_menu a

       ) v


-- ============= 문제 EMPDB
-- 1. 재직 중이고 휴대폰 마지막 자리가 2인 직원 중 입사일이 가장 최근인 직원 3명의 사원번호,
-- 사원명, 전화번호, 입사일, 퇴직여부를 출력하세요.
-- 참고. 퇴사한 직원은 퇴직여부 컬럼값이 ‘Y’이고, 재직 중인 직원의 퇴직여부 컬럼값은 ‘N’ (JOIN은 아님)
SELECT
       EMP_ID 사원번호
     , EMP_NAME 사원명
     , PHONE 전화번호
     , HIRE_DATE 입사일
     , QUIT_YN 퇴직여부
  FROM employee
 WHERE QUIT_YN = 'N'
   AND PHONE LIKE '%2'
 ORDER BY HIRE_DATE DESC
 LIMIT 3;


/*
    -------------------- 출력 예시 ----------------------------
    사원번호    사원명     전화번호        입사일     퇴직여부
    -----------------------------------------------------------
    216         차태연     01064643212     2013-03-01 00:00:00,N
    211         전형돈     01044432222     2012-12-12 00:00:00,N
    206         박나라     01096935222     2008-04-02 00:00:00,N
*/


-- 2. 재직 중인 ‘대리’들의 직원명, 직급명, 급여, 주민번호, 이메일, 전화번호, 입사일을 출력하세요.
-- 단, 급여를 기준으로 내림차순 출력하세요.
SELECT
        a.EMP_NAME 직원명
      , b.JOB_CODE 직급명
      , a.SALARY 급여
      , a.EMP_NO 주민번호
      , a.EMAIL 이메일
      , a.PHONE 전화번호
      , a.HIRE_DATE 입사일
  FROM employee a
  JOIN job b ON a.JOB_CODE = b.JOB_CODE
 WHERE a.QUIT_YN = 'N'
   AND b.JOB_NAME = '대리'
 ORDER BY a.SALARY DESC;

/*
    ---------------------------------- 출력 예시 ------------------------------------------------
    사원명     직급명     급여       주민번호        이메일                    입사일
    ----------------------------------------------------------------------------------------------
    전지연     대리      3660000     770808-2665412  jun_jy@ohgiraffers.com    2007-03-20 00:00:00
    차태연     대리      2780000     000704-3364897  cha_ty@ohgiraffers.com    2013-03-01 00:00:00
    장쯔위     대리      2550000     780923-2234542  jang_zw@ohgiraffers.com   2015-06-17 00:00:00
    하동운     대리      2320000     621111-1785463  ha_dh@ohgiraffers.com     1999-12-31 00:00:00
    전형돈     대리      2000000     830807-1121321  jun_hd@ohgiraffers.com    2012-12-12 00:00:00

*/



-- 3. 재직 중인 직원들을 대상으로 부서별 인원, 급여 합계, 급여 평균을 출력하고,
--    마지막에는 전체 인원과 전체 직원의 급여 합계 및 평균이 출력되도록 하세요.
--    단, 출력되는 데이터의 헤더는 컬럼명이 아닌 ‘부서명’, ‘인원’, ‘급여합계’, ‘급여평균’으로 출력되도록 하세요. (ROLLUP사용)

/*
    -------------------------- 출력 예시 -----------------------------
    부서명         인원      급여합계            급여평균
    ---------------------------------------------------------------
    기술지원부       2       4550000             2275000
    인사관리부       3       7820000             2606666.6666666665
    총무부           3       17700000            5900000
    해외영업1부      6       15760000            2626666.6666666665
    해외영업2부      3       10100000            3366666.6666666665
    회계관리부       4       11000000            2750000
    <null>          21       66930000            3187142.8571428573

*/


-- 4. 전체 직원의 사원명, 주민등록번호, 전화번호, 부서명, 직급명을 출력하세요.
--    단, 입사일을 기준으로 오름차순 정렬되도록 출력하세요.


/*
    ------------------- 출력 예시 ---------------------------------
    사원명     주민등록번호          전화번호        부서명     직급명
    선동일     621225-1985634        01099546325     총무부      대표
    고두밋     470808-2123341                        회계관리부  부사장
    유하진     800808-1123341                        회계관리부  차장
    하이유     690402-2040612        01036654488     해외영업1부 과장
    송은희     070910-4653546        01077607879     해외영업2부 차장
    이태림     760918-2854697        01033000002     기술지원부  대리
    정중하     770102-1357951        01036654875     해외영업2부 부장
    임시환     660712-1212123                        회계관리부  차장
    ...
    총 row 수는 24
*/

-- 5. 2020년 12월 25일이 무슨 요일인지 조회하시오.(Join아님)

/*
    -------- 출력예시 ---------
    요일
    ---------------------------
    Friday
*/

-- 6. 주민번호가 70년대 생이면서 성별이 여자이고,
--    성이 전씨인 직원들의 사원명, 주민번호, 부서명, 직급명을 조회하시오.

/*
    -------------------- 출력 예시 -------------------------
    사원명         주민번호            부서명         직급명
    ---------------------------------------------------------
    전지연         770808-2665412       인사관리부    대리
*/


-- 7. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 직급명을 조회하시오.

/*
    ------------------- 출력 예시 -----------------------
    사번      사원명    직급명
    -----------------------------------------------------
    211        전형돈    대리
*/

-- 8. 해외영업팀에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.
/*
    ------------------- 출력 예시 ---------------------------
    사원명     직급명     부서코드        부서명
    ----------------------------------------------------------
    박나라     사원        D5             해외영업1부
    하이유     과장        D5             해외영업1부
    김해술     과장        D5             해외영업1부
    심봉선     부장        D5             해외영업1부
    윤은해     사원        D5             해외영업1부
    대북혼     과장        D5             해외영업1부
    송은희     차장        D6             해외영업2부
    유재식     부장        D6             해외영업2부
    정중하     부장        D6             해외영업2부

*/














