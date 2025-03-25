-- =============================
-- JOIN
-- =============================
-- 두개 이상의 테이블의 레코드를 연결해서 가상테이블(relation) 생성
-- 연관성을 가지고 있는 컬럼을 기준(데이터)으로 조합

# relation을 생성하는 2가지 방법
-- 1. join :  특정컬럼 기준으로 행과 행을 연결한다. (가로)
-- 2. union : 컬럼과 컬럼을 연결한다.(세로)
-- join은 두 테이블의 행사이의 공통된 데이터를 기준으로 **선을 연결해서** 새로운 하나의 행을 만든다.

# JOIN 구분
-- 1. Equi JOIN : 일반적으로 사용하는 Equality Condition(=)에 의한 조인
-- 2. Non-Equi JOIN : 동등조건(=)이 아닌 BETWEEN AND, IS NULL, IS NOT NULL, IN, NOT IN, !=  등으로 사용.

# EQUI JOIN 구분
-- 1. INNER JOIN(내부 조인) : 교집합 (일반적으로 사용하는 JOIN) NULL값 포함 X
-- 2. OUTER JOIN(외부 조인) : 합집합    NULL값 포함
-- LEFT (OUTER) JOIN (왼쪽 외부 조인)
-- RIGHT (OUTER) JOIN (오른쪽 외부 조인)
-- FULL (OUTER) JOIN (완전 외부 조인)
-- 3. CROSS JOIN
-- 4. SELF JOIN(자가 조인)
-- 5. MULTIPLE JOIN(다중 조인)

SELECT
       *
  FROM
       tbl_menu A
#  INNER JOIN tbl_category B ON A.category_code = B.category_code;
   JOIN tbl_category B ON A.category_code = B.category_code;

-- USING
-- 동일한 이름의 컬럼을 기준컬럼으로 사용
SELECT
       A.menu_name
     , B.category_name
  FROM tbl_menu A
  JOIN tbl_category B USING(category_code);

-- ===============================
-- OUTER JOIN
-- ===============================
-- 좌/우측 테이블 기준으로 조인. 기준이 된 테이블은 누락되는 행이 없다. base 테이블을 어떤걸 사용하냐에 따라 행의 갯수 달라짐
-- INNER JOIN에서 해당 테이블의 누락된 행이 모두 추가된다.

-- ============ LEFT JOIN =================
SELECT
       A.menu_name
     , B.category_name
  FROM tbl_menu A
  LEFT JOIN tbl_category B USING(category_code);
-- ============ RIGHT JOIN ================
SELECT
       A.menu_name
     , B.category_name
  FROM tbl_menu A -- base table
  RIGHT JOIN tbl_category B USING(category_code);
-- ====================
-- CROSS JOIN
-- ===================
# 카테이션곱(Cartesian Product)
-- 모든 경우의 수를 구하므로, 결과는 두 테이블의 컬럼 수를 곱한 개수가 나온다.
-- 한쪽 테이블의 모든 행과 다른쪽 테이블의 모든 행을 조인시킨다.
-- CROSS JOIN은 조건절이 없다. 또는 JOIN문의 ON절이 없을 경우
SELECT
       A.menu_name
     , B.category_name
  FROM tbl_menu A
  CROSS JOIN tbl_category B;

-- ============================
-- SELF JOIN
-- ============================
-- 조인은 두 개 이상의 서로 다른 테이블을 연결하기도 하지만, 같은 테이블을 조인하는 경우가 있다.
-- 이러한 경우 자기 자신과 조인을 맺는 것이라하여 SELF JOIN이라고 한다.

SELECT
       B.category_name 상위카테고리
     , A.category_name 카테고리
  FROM tbl_category A
  JOIN tbl_category B
    ON A.ref_category_code = B.category_code;
-- INNER JOIN은 NULL값을 포함 안한다
SELECT
       A.EMP_NAME
     , B.DEPT_TITLE
     , C.JOB_NAME
     , E.NATIONAL_NAME
  FROM EMPLOYEE A
  LEFT JOIN DEPARTMENT B ON A.DEPT_CODE = B.DEPT_ID
  LEFT JOIN JOB C ON A.JOB_CODE = C.JOB_CODE
  LEFT JOIN LOCATION D ON B.LOCATION_ID=D.LOCAL_CODE
  LEFT JOIN NATION E ON D.NATIONAL_CODE= E.NATIONAL_CODE;
