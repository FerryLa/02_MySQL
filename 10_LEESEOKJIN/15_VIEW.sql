
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

INSERT INTO hansik VALUES (null, '식혜맛국밥', 5500, 4, 'Y');    -- 에러 발생
INSERT INTO hansik VALUES (99, '수정과맛국밥', 5500, 4, 'Y');
SELECT * FROM hansik;
SELECT * FROM tbl_menu;
