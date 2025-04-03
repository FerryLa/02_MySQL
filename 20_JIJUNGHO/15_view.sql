-- =======================
-- VIEW
-- =======================
-- 💡 SELECT 쿼리문을 저장한 객체로 가상테이블이라고 불린다.
-- 실질적인 데이터를 물리적으로 저장하고 있지 않고 쿼리만 저장했지만 테이블을 사용하는 것과 동일하게 사용할 수 있다.
-- VIEW는 데이터를 쉽게 읽고 이해할 수 있도록 돕는 동시에, 원본 데이터의 보안을 유지하는데 도움이 된다.

SELECT *
  FROM
      tbl_menu;

-- VIEW 생성
CREATE VIEW hansik AS
SELECT
    menu_code
  , menu_name
  , menu_price
  , category_code
  , orderable_status
  FROM
      tbl_menu
 WHERE
     category_code = 4;

-- 생성된 VIEW 조회
SELECT *
  FROM
      hansik;

-- view 테이블 정보 조회
SELECT *
  FROM
      information_schema.views;


-- 가상 테이블이라도 제약조건에 위배되지 않으면,
-- 원본 테이블에도 데이터가 추가, 수정, 삭제가 된다
INSERT INTO
    tbl_menu
VALUES
    (NULL, '식혜맛국밥', 5500, 4, 'Y');
SELECT *
  FROM
      hansik;

# INSERT INTO hansik VALUES (null, '식혜맛국밥', 5500, 4, 'Y');    -- 에러 발생
INSERT INTO
    hansik
VALUES
    (99, '수정과맛국밥', 5500, 4, 'Y');
SELECT *
  FROM
      hansik;
SELECT *
  FROM
      tbl_menu;

UPDATE hansik
   SET
       menu_name  = '버터맛국밥'
     , menu_price = 5700
 WHERE
     menu_code = 99;
SELECT *
  FROM
      hansik;
SELECT *
  FROM
      tbl_menu;

DELETE
  FROM
      hansik
 WHERE
     menu_code = 99;
SELECT *
  FROM
      hansik;
SELECT *
  FROM
      tbl_menu;

-- view 삭제
DROP VIEW hansik;

CREATE OR REPLACE VIEW hansik AS
SELECT
    menu_code AS  '메뉴코드'
  , menu_name     '메뉴명'
  , category_name '카테고리명'
  FROM
      tbl_menu a
      JOIN tbl_category b ON a.category_code = b.category_code
 WHERE
     b.category_name = '한식';

SELECT *
  FROM
      hansik;