-- =====================
-- CONSTRAINTS
-- =====================
-- 제약조건
-- 테이블 작성 시 각 컬럼에 값 기록에 대한 제약조건을 설정할 수 있다.
-- 데이터 무결성 보장 목적으로 한다.
-- 입력/수정하는 데이터에 문제가 없는지 자동으로 검사해 주게 하기 위한 목적
-- PRIMARY KEY, NOT NULL, UNIQUE, CHECK, FOREIGN KEY

# 제약조건 조회
SELECT *
FROM information_schema.TABLE_CONSTRAINTS
WHERE CONSTRAINT_SCHEMA = 'menudb'
  AND table_name = 'tbl_menu';


-- ===============================
# NOT NULL 제약조건: NULL 값을 허용하지 않는다'
-- ===============================
DROP TABLE IF EXISTS user_notnull;
CREATE TABLE IF NOT EXISTS user_notnull (
                                            user_no INT NOT NULL,     # 컬럼 레벨로 적용
                                            user_id VARCHAR(255) NOT NULL,
                                            user_pwd VARCHAR(255) NOT NULL,
                                            user_name VARCHAR(255) NOT NULL,
                                            gender VARCHAR(3),
                                            phone VARCHAR(255) NOT NULL,
                                            email VARCHAR(255)
) ENGINE=INNODB;

INSERT INTO user_notnull
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
    (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
    (2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

SELECT * FROM user_notnull; -- 위의 방식처럼 한 번에 여러 행 입력 가능함



-- ===============================
# UNIQUE : 중복값 허용하지 않음
-- ===============================
DROP TABLE IF EXISTS user_unique;
CREATE TABLE IF NOT EXISTS user_unique (
                                           user_no INT NOT NULL UNIQUE ,   # 컬럼 레벨로 적용
                                           user_id VARCHAR(255) NOT NULL,
                                           user_pwd VARCHAR(255) NOT NULL,
                                           user_name VARCHAR(255) NOT NULL,
                                           gender VARCHAR(3),
                                           phone VARCHAR(255) NOT NULL UNIQUE,   # NOT NULL이 있으면 UNIQUE도 그 뒤에 작성
                                           email VARCHAR(255),
                                           UNIQUE (phone)     # 테이블 레벨로 적용 // # UNIQUE는 일반적으로 이런 방식으로 씀
                                           -- ex) UNIQUE(email, username) : email과 username을 조합했을 때 유일해야 함
) ENGINE=INNODB;

INSERT INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
    (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
    (2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

SELECT * FROM user_unique;

INSERT INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
    (3, 'user01', 'pass01', '홍길동', '남', '010-1234-5679', 'hong123@gmail.com');
-- 컬럼 레벨 UNIQUE: 하나의 컬럼에 대해서만 중복을 허용하지 않음. (email UNIQUE)
-- 테이블 레벨 UNIQUE: 두 개 이상의 컬럼 조합이 유니크하도록 설정 가능.



-- ===============================
-- PRIMARY KEY
-- ===============================
-- 테이블에서 정확히 한 행을 식별하기 위해 사용할 컬럼을 의미한다.
-- 테이블에 대한 식별자 역할을 한다.(한 행씩 구분하는 역할을 한다.)
-- NOT NULL + UNIQUE 제약조건의 의미
-- 한 테이블 당 한 개만 설정할 수 있음
-- 컬럼 레벨, 테이블 레벨 둘 다 설정 가능하다.
-- 한 개 컬럼에 설정할 수도 있고, 여러 개의 컬럼을 묶어서 설정할 수도 있다.(복합키)
DROP TABLE IF EXISTS user_primarykey;
CREATE TABLE IF NOT EXISTS user_primarykey (
--     user_no INT PRIMARY KEY,
                                               user_no INT,
                                               user_id VARCHAR(255) NOT NULL,
                                               user_pwd VARCHAR(255) NOT NULL,
                                               user_name VARCHAR(255) NOT NULL,
                                               gender VARCHAR(3),
                                               phone VARCHAR(255) NOT NULL,
                                               email VARCHAR(255),
                                               PRIMARY KEY (user_no)   # 여기서 PRI (기본키) 지정
) ENGINE=INNODB;   # 이 경우 auto increment가 없기 때문에  primary key에 null이 들어갈 수 없음

INSERT INTO user_primarykey
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
    (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
    (2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

SELECT * FROM user_primarykey;
DESC user_primarykey;