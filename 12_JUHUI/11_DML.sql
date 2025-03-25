-- ======================
-- DML
-- ======================
-- DML(Data Manipulation Language)
-- Data를 조작(삽입, 수정, 삭제, 조회)하기 위해 사용하는 언어
-- Data를 이용하려는 사용자와 DB사이의 인터페이스를 직접적으로 제공하는 언어로써 가장 많이 사용된다.
-- INSERT, UPDATE, DELETE, SELECT(DQL)


-- =====================================
-- INSERT
-- =====================================
-- 새로운 행을 추가하는 구문이다.
-- 테이블의 행의 수가 증가한다.

# 문법
-- 1. INSERT INTO <테이블명> VALUES(입력데이터1, 입력데이터2,.....);
-- 2. INSERT INTO <테이블명>(컬럼명1, 컬럼명2,...) VALUES(입력데이터1, 입력데이터2,...);
--     ㄴ> null을 허용하는 컬럼은 생략가능하다(생략되면 null값이 대입)
--     ㄴ> not null인 컬럼은 생략할 수 없다.(단, default값이 지정되면 생략가능)

  -- 문법1. 테이블의 선언된 컬럼 순서 그대로 모두 값을 전달해야 한다.
  INSERT INTO tbl_menu VALUES (menu_code null, menu_name '바나나맛해장국', mmany_price 8500, category_code 4, orderable_status);

INSERT INTO TBL_MENU

-- 컬럼을 명시하던 INSERT시 데이터의 순서를 바꾸는 것도 가능하다
INSERT INTO tbl_menu(orderable_status,menu_price, menu_name, category_code)
VALUES (orderable_status 'Y', menu_price 25000 menu_name'매생이케잌', category_code = 20);

-- UPDATE
SELECT
