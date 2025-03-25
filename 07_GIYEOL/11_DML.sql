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
insert into tbl_menu values (menu_code null, menu_name '바나나해장국',menu_price 8500 , category_code 4, orderable_status'Y');
-- 문법2 null 허용 가능한 (nullvalues) 컬럼이나 auto_increment가 있는 컬럼을 제외하고
-- insert 하고 싶은 데이터 컬럼을 지정해서 insert 가능하다
insert into tbl_menu(menu_code, menu_name, menu_price, category_code, orderable_status)
values(menu_name '초콜릿맛죽',menu_price 6500, category_code 7, orderable_status 'Y' );
-- 컬럼을 명시하면 insert 시 데이터의 순서를 바꾸는 것도 가능하다
insert into tbl_menu( menu_name, menu_price, category_code, orderable_status)
values(orderable_status 'Y', menu_price 25000, menu_name '매생이케익2', 10);

-- update
select
    menu_code,
    menu_name,
    category_code
from tbl_menu;
update
tbl_menu -- 수정할 대상 테이블
    set
    category_code = 10,
    menu_name = '매생이쉐이크' -- 여러개를 동시에 수정할 경우 콤마(,)를 사용
where
    menu_code = 25;
-- subquery 를 활용할 수 있다
-- 다만, mysql은 oracle과 달리 update나 delete시 자기 자신의 테이블 데이터를 사용시 1093 에러가 발생함
UPDATE
    tbl_menu
SET
    category_code = (SELECT menu_code
                     FROM tbl_menu
                     WHERE menu_name = '우럭스무디')
WHERE
    menu_code = 25;
-- 이때 subquery를 하나 더 사용하면 임시 테이블로 사용하게하면 해결할 수 있다.



UPDATE
    tbl_menu
SET
    category_code = (SELECT tmp.menu_code
                     FROM ( SELECT menu_code
                     FROM tbl_menu
                     WHERE menu_name = '우럭스무디')
) tmp
WHERE
    menu_code = 25;
select * from tbl_menu where menu_code =25;


-- ========================================================
-- delete
-- 테이블 행 삭제하는 구문/ 테이블의 행의 수가 줄어듬
delete

from
    tbl_menu
where
    menu_code = 25;
--
select * from  tbl_menu order by  menu_price;
-- limit를 활용한 행삭제(offser 지정 안됨)
delete
from
    tbl_menu
order by
    menu_price
limit 2;
-- 테이블 전체 행 삭제
delete  from tbl_menu;
--
delete
from tbl_menu;
-- truncate 실핼시 rollback 불가
# truncate  table tb_escape_watch;

-- ==============================
-- REPLACE
-- ==============================
-- INSERT시 PRIMARY KEY 또는 UNIQUE KEY가 충돌이 발생할 수 있다면
-- REPLACE를 통해 중복된 데이터를 덮어쓸 수 있다.

insert into tbl_menu
values  (menu_code 17, menu_name '참기름맛소주',menu_price 7000, category_code 10, orderable_status 'Y');

replace into tbl_menu
values(menu_code 17, menu_name '참기름맛소주',menu_price 7000, category_code 10, orderable_status 'Y');
-- into 생략 가능
replace into tbl_menu
values(menu_code 17, menu_name '들기름맛소주',menu_price 7000, category_code 10, orderable_status 'Y');



















