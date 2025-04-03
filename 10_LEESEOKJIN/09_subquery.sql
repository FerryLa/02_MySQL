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

SELECT menu_code, menu_name, menu_price, category_code, orderable_status
FROM tbl_menu a
WHERE menu_price > (SELECT AVG(b.menu_price) FROM tbl_menu b WHERE b.category_code = a.category_code);

