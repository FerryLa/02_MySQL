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

-- 문법1. 테이블의 선언된 컬럼 순서 그대로 모두 값을 전달
INSERT INTO tbl_menu
VALUES (null, '바나나맛해장국', 8500, 4, 'Y');

-- 문법2. NULLABLE 및 AUTO_INCREMENT를 제외한, 삽입하려는 데이터의 칼럼을 직접 지정
INSERT INTO tbl_menu(menu_name, menu_price, category_code, orderable_status)
VALUES ('초콜릿맛죽', 6500, 7, 'Y');

-- 컬럼을 명시하면 INSERT시 데이터의 순서를 바꾸는 것도 가능하다.
INSERT INTO tbl_menu(orderable_status, menu_price, menu_name, category_code)
VALUES ('Y', 25000, '매생이케이크', 10);

-- =====================================
-- UPDATE
-- =====================================
UPDATE tbl_menu
SET category_code = 10,
    menu_name     = '매생이쉐이크'
WHERE menu_code = 25;

-- SUBQUERY를 활용할 수도 있다.
-- 단, MySQL에서는 UPDATE/DELETE 문에서 같은 테이블을 FROM 서브쿼리에서 참조하면 1093 오류가 발생한다.
UPDATE tbl_menu
SET category_code = (SELECT category_code
                     FROM tbl_menu
                     WHERE menu_name = '우럭스무디')
WHERE menu_code = 25;

-- 해결 방법: 서브쿼리를 하나 더 사용하여 임시테이블 사용
UPDATE tbl_menu
SET category_code = (SELECT tmp.menu_code
                     FROM (SELECT menu_code
                           FROM tbl_menu
                           WHERE menu_name = '우럭스무디') tmp)
WHERE menu_code = 25;

-- =====================================
-- DELETE
-- =====================================
-- 테이블의 행을 삭제하는 구문
-- 테이블의 행의 개수가 줄어든다.

DELETE
FROM tbl_menu
WHERE menu_code = 25;

SELECT *
FROM tbl_menu
ORDER BY menu_price;

-- LIMIT을 활용한 행 삭제 (offset 지정은 안 됨)
DELETE
FROM tbl_menu
ORDER BY menu_price
LIMIT 2;

-- 테이블 전체 행 삭제
DELETE FROM tbl_menu;

-- TRUNCATE는 ROLLBACK할 수 없다
# TRUNCATE TABLE tb_escape_watch;

-- =====================================
-- REPLACE
-- =====================================
-- INSERT시 PRIMARY KEY 또는 UNIQUE KEY가 충돌이 발생할 수 있다면
-- REPLACE를 통해 중복되는 데이터를 덮어쓸 수 있다.

INSERT INTO tbl_menu
VALUES(17, '참기름맛소주', 7000, 10, 'Y');

REPLACE INTO tbl_menu
VALUES(17, '참기름맛소주', 7000, 10, 'Y');

REPLACE INTO tbl_menu
VALUES(17, '들기름맛소주', 7000, 10, 'Y');

SELECT * FROM tbl_menu WHERE menu_code = 17;
12