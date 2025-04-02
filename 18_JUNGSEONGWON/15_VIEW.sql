SELECT * FROM tbl_menu;

-- VIEW 생성
CREATE VIEW hansik AS
SELECT
    menu_code, menu_name, menu_price, category_code, orderable_status
FROM
    tbl_menu
WHERE
    category_code = 4;

-- 생성된 VIEW 조회
SELECT * FROM hansik;
SELECT * FROM information_schema.VIEWS;

INSERT INTO tbl_menu VALUES (null, '식혜맛국밥', 5500, 4, 'Y');
SELECT * FROM hansik;

INSERT INTO hansik VALUES (null, '식혜맛국밥', 5500, 4, 'Y');    -- 에러 발생
INSERT INTO hansik VALUES (99, '수정과맛국밥', 5500, 4, 'Y');
SELECT * FROM hansik;
SELECT * FROM tbl_menu;

UPDATE hansik SET menu_name = '버터맛국밥', menu_price = 5700 WHERE menu_code = 99;
SELECT * FROM hansik;
SELECT * FROM tbl_menu;

DELETE FROM hansik WHERE menu_code = 99;
SELECT * FROM hansik;
SELECT * FROM tbl_menu;

-- VIEW라고 하여 가상의 테이블이 아니라 쿼리를 입력하면 테이블에 간섭이 가능하다.
-- ========================================================
-- VIEW가 사용이 안되는 경우
-- ========================================================
-- 산술 표현식이 정의 된 경우
-- DISTINCT를 포함한 경우
-- 산술 표현식이 정의 된 경우
-- JOIN을 이용해 여러 테이블 연결한 경우
-- 그룹함수나 GROUP BY 절을 포함한 경우
-- 뷰에 포함되지 않은 컬럼 중에 베이스가 되는 테이블 컬럼이 NOT NULL 제약조건이 지정되 경우


DROP VIEW hansik;

CREATE OR REPLACE VIEW hansik AS
SELECT
    menu_code AS '메뉴코드', menu_name '메뉴명', category_name '카테고리명'
FROM
    tbl_menu a
        JOIN tbl_category b ON a.category_code = b.category_code
WHERE
    b.category_name = '한식';

SELECT * FROM hansik;