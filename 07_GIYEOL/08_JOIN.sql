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
-- 1. INNER JOIN(내부 조인) : 교집합 (일반적으로 사용하는 JOIN)
-- 2. OUTER JOIN(외부 조인) : 합집합
-- LEFT (OUTER) JOIN (왼쪽 외부 조인)
-- RIGHT (OUTER) JOIN (오른쪽 외부 조인)
-- FULL (OUTER) JOIN (완전 외부 조인)
-- 3. CROSS JOIN
-- 4. SELF JOIN(자가 조인)
-- 5. MULTIPLE JOIN(다중 조인)

--
select
    *
from
    tbl_menu a
join menudb.tbl_category tc on a.category_code = tc.category_code;
# inner join tbl_category b on a.category_code = b.category_code;
-- using : 동일한 이름의 컬럼을 기준컬럼으로 사용
select
    a.menu_name
,   b.category_name
from
        tbl_menu a
join tbl_category b using(category_code);
-- ===============================
-- OUTER JOIN
-- ===============================
-- 좌/우측 테이블 기준으로 조인. 기준이 된 테이블은 누락되는 행이 없다.
-- INNER JOIN에서 해당 테이블의 누락된 행이 모두 추가된다.
-- left join -------------------------------------------------------------------------------
select
    a.menu_name
,   b.category_name
from
    tbl_menu a
left join tbl_category b using(category_code);
-- right join ---------------------------------------------------------------------------
select
    a.menu_name
,   b.category_name
from
    tbl_menu a
right  join tbl_category b using(category_code);
-- ====================
-- CROSS JOIN
-- ===================
# 카테이션곱(Cartesian Product)
-- 모든 경우의 수를 구하므로, 결과는 두 테이블의 컬럼 수를 곱한 개수가 나온다.
-- 한쪽 테이블의 모든 행과 다른쪽 테이블의 모든 행을 조인시킨다.
-- cross 조인은 조건절이 없다, 조인문의 on절이 없는 경우
select
    a.menu_name,
    b.category_name
    from
        tbl_menu a
cross join  tbl_category b;

-- ============================
-- SELF JOIN
-- ============================
-- 조인은 두 개 이상의 서로 다른 테이블을 연결하기도 하지만, 같은 테이블을 조인하는 경우가 있다.
-- 이러한 경우 자기 자신과 조인을 맺는 것이라하여 SELF JOIN이라고 한다.

select
    b.category_name, -- 상위 카테고리
    a.category_name -- 카테고리
from
     tbl_category a
join
     tbl_category b
 on a.ref_category_code = b.category_code;
--
select a.EMP_NAME, b.DEPT_TITLE, c.job_name , e.national_name
from employee a
left join department b on a.DEPT_CODE = b.DEPT_ID
left join job c on a.JOB_CODE = c.JOB_CODE
left join location d on b.LOCATION_ID = d.LOCAL_CODE
left join nation e on d.NATIONAL_CODE = e.NATIONAL_CODE;
 -- null 값 포함 inner join , join 값이 정해진 인원만 출력
select
    a.natuere;



















