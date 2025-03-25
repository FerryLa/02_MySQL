-- =============================
-- DDL
-- =============================
-- 데이터 정의 언어 Data Definition Language
-- 데이터베이스 객체(Object)를 만들고(CREATE), 수정하고(ALTER), 삭제(DROP)하는 구문
-- ROLLBACK, COMMIT등 TCL을 사용하지 않고, 자동커밋된다. DML(INSERT, UPDATE, DELETE)과 혼용시 주의해야 한다.

show variables like 'autocommit';
set autocommit = off;
-- ===============================
-- CREATE
-- ===============================
-- 테이블 생성을 위한 구문
-- IF NOT EXISTS를 적용하면 기존에 존재하는 테이블이라도 에러가 발생하지 않는다.

-- 테이블의 컬럼 설정
-- column_name data_type(length) [NOT NULL] [DEFAULT value] [AUTO_INCREMENT] column_constraint;
use basicdb;

-- https://dev.mysql.com/doc/refman/8.3/en/innodb-introduction.html


create  table product1 ( id int comment  '상품 아이디',
                         name varchar(100) comment '상품명',
                         create_at datetime comment '등록일'

)engine = innodb comment '상품테이블';
rollback;
-- 테이블별 스토라자 엔진 확인
show table status  like 'prpduct1';

-- 테이블 구조 확인
describe  product1;
desc product1;


-- ===============================
-- COMMENT
-- ===============================
# 테이블 comment 설정
-- CREATE TABLE 테이블명 (
--     ...
-- ) COMMENT = 'table comment';

-- ALTER TABLE 테이블명 COMMENT = 'table comment';

# 컬럼 comment 설정
-- CREATE TABLE 테이블명 (
--  컬럼명 INT COMMENT 'column1 comment',
-- );

-- ALTER TABLE 테이블명
-- MODIFY [컬럼명] [데이터타입] [제약조건] COMMENT 'column1 comment';

# DEFAULT
-- 컬럼에 null 대신 기본값 적용
-- 컬럼 타입이 DATE일 시 current_date만 가능
-- 컬럼 타입이 DATETIME일 시 current_time과 current_timestamp, now() 모두 사용가능

create  table  if not exists tbl_rent(
    rent_id int auto_increment primary key ,
    contractor_name varchar(255) default  '익명',
    car_name varchar(255) default  '람보르기니',
    rent_date date default  (current_date),
    rent_time time default  (current_time),
    creadted_at datetime default (current_timestamp)
) engine =innodb;

insert into tbl_rent values (null,default,default
                            ,default,default,default);
select  * from tbl_rent;

insert into  tbl_rent(contractor_name) values ('me');
# auto_increment
-- insert 시에 pk 컬럼에 자동으로 번호를 발생(중복되지 않게)시켜 저장 가능
-- pk 컬럼이 아닌 컬럼은 사용 불가
create  table if not exists  product2 (
    id int primary key  auto_increment comment '상품id',
    name varchar(255) comment  '상품명',
    create_at datetime default  now() comment  '등록일'
) engine = innodb comment '상품테이블';

-- alter
-- 테이블에 추가/변경/수정/삭제하는 모든 것은 ALTER 명령어를 사용해서 적용한다.


# 변경항목
-- ADD    : 컬럼 추가, 제약조건추가
-- MODIFY : 컬럼 자료형 변경, 컬럼 DEFAULT값 변경
-- RENAME : 컬럼명 변경, 제약조건 이름변경
-- DROP   : 컬럼 삭제, 제약조건 삭제

desc product2;
-- add 컬럼명 자료형의 제약조건 alter 기존 컬럼
alter table product2 add price int not null after name;
-- dorp 컬럼명 삭제
alter table  product2 drop column price;

-- 컬럼명 변경
-- change 이전 컬럼명 새컬럼명 자료형 제약조건
alter table product2 change column name prod_name char(100) not null;
-- 컬럼 순서 변경
-- modify 컬렴명 자료형 alter 기존 컬럼(자료형 필수)
alter table  product2 modify column prod_name char(100) after create_at;

-- 컬럼 디폴트값 변경
-- alter table alter column 컬럼명 set default 디폴트 값;
alter table product2 alter  column  prod_name set default  '무명';

-- 컬럼 자료형 변경
-- alter table 테이블명 modify 컬럼명 새자료형
alter table product2 modify prod_name varchar(100);

-- 열에 제약조건 추가 및 삭제
alter table product1
drop primary key ;

alter table  product1 add primary key(id) ;

-- =================================================
-- drop
-- 테이블을 삭제하기 위한 구문
-- 테이블 삭제
drop table product2;

drop table  if exists  product1;
-- 한번에 여러게 삭제
drop table if exists encore_bank, kb_bank;
























