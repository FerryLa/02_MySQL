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

-- 문법1. 테이블의 선언된 컬럼 순서 그대로 모두 값을 전달해야한다.
INSERT INTO tbl_menu VALUES (null, '바나나맛해장국', 8500, 4, 'Y');

-- 문법2. NULL 허용 가능한(NULLABLE) 컬럼이나 AUTO_INCREMENT가 있는 컬럼을 제외하고
-- INSERT하고 싶은 데이터 컬럼을 지정해서 INSERT 가능하다.
INSERT INTO tbl_menu(menu_name, menu_price, category_code, orderable_status)
VALUES ('초콜릿맛죽', 6500, 7, 'Y');

-- 컬럼을 명시하면 INSERT시 데이터의 순서를 바꾸는 것도 가능하다.
INSERT INTO tbl_menu(orderable_status, menu_price, menu_name, category_code)
VALUES('Y', 25000,'매생이케익', 10);

-- ====================================
-- UPDATE
-- ====================================
SELECT
      menu_code
    , menu_name
    , category_code
  FROM tbl_menu;

UPDATE
      tbl_menu -- 수정할 대상테이블
   SET
      category_code = (SELECT menu_code
                       FROM tbl_menu
                       WHERE menu_name = '우럭스무디')
#     , menu_name = '매생이케이크' -- 여러개의 값을 동시에 수정할 경우 콤마(,)을 사용한다.
  WHERE
      menu_code = 25;

-- 이때 SUBQUERY를 하나 더 사용하여 임시테이블로 사용하게하면 해결할 수 있다.
UPDATE
    tbl_menu -- 수정할 대상테이블
SET
    category_code = (SELECT menu_code
                     FROM (SELECT menu_code
                           FROM tbl_menu
                           WHERE menu_name = '우럭스무디') tno)
                     WHERE menu_name = '우럭스무디')
#     , menu_name = '매생이케이크' -- 여러개의 값을 동시에 수정할 경우 콤마(,)을 사용한다.
WHERE
    menu_code = 25;

SELECT * FROM tbl_menu WHERE menu_code = 25;

-- ====================================
-- DELETE
-- ====================================
DELETE
  FROM tbl_menu
 Where menu_code = 25;

SELECT * FROM tbl_menu ORDER BY MENU_price;

-- LIMIT를 활용한 행삭제(offset 지정은 안된다)
DELETE
  FROM tbl_menu
ORDER BY menu_price
LIMIT 2;

-- 테이블 전체 행 삭제
DELETE
  FROM tbl_menu;


-- 영구 삭제 - DELETE보다 빠름 (다른 데이터를 넣어줄 때 완전 삭제하는)
-- TRUNCATE를 실행하면 ROLLBACK을 할 수 없다.
# TRUNCATE table tbl_escape_watch;

INSERT INTO
    tbl_menu VALUES (17, '참기릇맛소주', 7000, 10, 'Y')

REPLACE INTO tbl_menu
VALUES(17, '참기릇맛소주', 7000, 10, 'Y');

-- INTO는 생략 가능
SELECT * FROM tbl_menu WHERE menu_code = 17;

SET autocommit = 1;
-- 커밋 상태갑 확인 쿼리
SHOW VARIABLES LIKE 'autocommit';

-- ===================================
-- TCL
-- ===================================
-- Transaction Control Language 트랜잭션 제어 언어
-- COMMI, ROLLBACK, SAVEPOINT 등이 있다.

# 트랜잭션이란
-- 한꺼번에 수행되어야 할 최소의 작업 단위를 말한다.
-- 논리적 작업 단위 (LUW, Logical Units of Work)
-- 하나의 트랜잭션으로 이루어진 작업들은 반드시 한꺼번에 완료가 되어야 하며,
-- 그렇지 않은 경우에는 한꺼번에 취소 되어야 한다.

# 트랜잭션 ACID 원칙
-- 1. Atomicity : 원자성.
--      - 트랜잭션과 관련된 일은 모두 실행되던지 모두 실행되지 않도록 하던지를 보장하는 특성이다.
-- 2. Consistency : 일관성.
--      - 트랜잭션이 성공했다면, 데이터베이스는 그 일관성을 유지해야 한다.
--      - 일관성은 특정한 조건을 두고, 그 조건을 만족하는지를 확인하는 방식으로 검사할 수 있다.
-- 3. Isolation : 독립성.
--      - 트랜잭션을 수행하는 도중에 다른 연산작업이 끼어들지 못하도록 한다.
--      - 임계영역을 두는 것으로 달성할 수 있다. 기본적으로 READ_COMMITED 방식을 적용한다.
-- 4. Durability : 지속성.
--      - 성공적으로 트랜잭션이 수행되었다면, 그 결과는 완전히 반영이 되어야 한다.
--      - 완전히 반영되면 로그를 남기게 되는데, 후에 이 로그를 이용해서 트랜잭션 수행전 상태로 되돌릴 수 있어야 한다.
--      - 때문에 트랜잭션은 로그저장이 완료된 시점에서 종료가 되어야 한다.


CREATE TABLE kb_bank (
                         id INT PRIMARY KEY ,
                         name VARCHAR(100) NOT NULL,
                         balance BIGINT CHECK(balance >= 0)
);

CREATE TABLE encore_bank (
                             id INT PRIMARY KEY ,
                             name VARCHAR(100) NOT NULL ,
                             balance BIGINT CHECK ( balance >= 0)
);

INSERT INTO kb_bank VALUES (1231, '홍길동', 1000000);
INSERT INTO encore_bank VALUES (456, '신사임당', 1000000);

SELECT * FROM kb_bank;
SELECT * FROM encore_bank;
ROLLBACK;

START TRANSACTION ;
UPDATE kb_bank SET balance = balance - 100000 WHERE id = 1231;
UPDATE encore_bank SET balance = balance - 100000 WHERE id = 456;
ROLLBACK;
COMMIT;

START TRANSACTION ;
SELECT menu_code, menu_name, menu_name, menu_price FROM tbl_menu;

INSERT INTO tbl_menu VALUES (null, '딸기맛감자탕', 9500, 4, 'Y');

INSERT INTO tbl_menu(menu_code, menu_name, menu_price, category_code, orderable_status)
VALUES (null, '생딸기한우국밥', 15000, 4, 'Y');

INSERT INTO tbl_menu(menu_name, menu_price, category_code, orderable_status)
VALUES ('민트초코맛파전', 10000, 4, 'Y');

SAVEPOINT strawberry;
UPDATE tbl_menu SET menu_name = '수정된메뉴' WHERE menu_code = 5;
DELETE FROM tbl_menu WHERE menu_code = 7;
