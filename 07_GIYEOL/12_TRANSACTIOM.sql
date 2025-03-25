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
set autocommit = 1;
-- 커밋 상태값 확인 쿼리
show variables  like 'autocommit';

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
--
select * from kb_bank;
select * from  encore_bank;
rollback ;
--

start transaction ;
update kb_bank set balance =balance - 100000 where id = 1231;
update encore_bank set balance =balance - 100000 where id = 456;
rollback;
commit ;
--
start transaction ;
select menu_name,menu_price
from
    tbl_menu
insert into tbl_menu values  (null,  '딸기맛감자탕',  4000, 4,'Y')
insert into tbl_menu(menu_code, menu_name, menu_price, category_code, orderable_status)
values (null,'생딸기한우국밥',15000,4,'Y');

insert into tbl_menu(menu_name, menu_price, category_code, orderable_status)
VALUES ('민트초코파전',10000,4,'Y');

savepoint  strawberry;
update tbl_menu set menu_name = '수정된 메뉴' where menu_code = 5;
delete  from tbl_menu where  menu_code = 7;

rollback to strawberry;
rollback ;





































