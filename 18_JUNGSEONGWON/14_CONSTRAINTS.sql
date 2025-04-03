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



-- ================================
-- FOREIGN KEY
-- ================================
-- 참조(REFERENCES)된 다른 테이블에서 제공하는 값만 사용할 수 있다.
-- 참조무결성을 위배하지 않기 위해 사용한다.
-- FOREIGN KEY제약조건에 의해서 테이블간의 관계(RELATIONSHIP)가 형성된다.
-- 제공되는 값 외에는 NULL을 사용할 수 있다.

DROP TABLE IF EXISTS  user_grade; -- 테이블 생성

CREATE TABLE IF NOT EXISTS user_grade(
 grade_code INT PRIMARY KEY ,
 grade_name VARCHAR(255) NOT NULL
) ENGINE = INNODB;

DROP TABLE IF EXISTS user_foreignkey;
CREATE TABLE IF NOT EXISTS user_foreignkey(
      user_no INT PRIMARY KEY , -- 컬럼 레벨에 추가
      user_id VARCHAR(255) NOT NULL ,
      user_pwd VARCHAR(255) NOT NULL,
      user_name VARCHAR(255) NOT NULL,
      gender VARCHAR(3),
      phone VARCHAR(255) NOT NULL,
      email VARCHAR(255),
      grade_code INT , -- null 기입 불가
       # grade_code INT NOT NULL, -- null 기입 불가
      FOREIGN KEY (grade_code) -- 외례 키를 입력하는 경우 테이블에 입력해준다.
      REFERENCES user_grade(grade_code)
) ENGINE=INNODB;

INSERT INTO user_foreignkey
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
    (1, 'user01', 'pass01', '홍길동', '남',
     '010-1234-5678', 'hong123@gmail.com', 10),
    (2, 'user02', 'pass02', '유관순', '여',
     '010-7777-7777', 'yu77@gmail.com', 20);

SELECT * FROM user_foreignkey;

INSERT INTO user_foreignkey
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
    (3, 'user03', 'pass03', '이순신', '남',
     '010-1234-5612', 'lee123@gmail.com', null)

DELETE FROM user_grade WHERE grade_code = 10; -- 유저코드 10의 내용을 삭제할 것이다. 유저등급의
-- 삭제에 대한 규칙은 참조된 자식 테이블을 다 지우고 부모테이블을 그 뒤 지워야 하는 것이 디폴트 값이다.
DROP TABLE IF EXISTS user_foreignkey;
CREATE TABLE IF NOT EXISTS user_foreignkey(
    user_no INT PRIMARY KEY , -- 컬럼 레벨에 추가
    user_id VARCHAR(255) NOT NULL ,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    grade_code INT , -- null 기입 불가
# grade_code INT NOT NULL, -- null 기입 불가
  FOREIGN KEY (grade_code) -- 외례 키를 입력하는 경우 테이블에 입력해준다.
  REFERENCES user_grade(grade_code)
  #ON UPDATE SET NULL
  ON DELETE SET NULL
) ENGINE=INNODB;

INSERT INTO user_grade
values (10, '일반회원');

select * from user_grade;
select * from user_foreignkey;

-- 1. 부모 테이블의 grade_code를 수정
UPDATE  user_grade
    SET grade_code = 300
WHERE
    grade_code = 10;

-- 2.부모 테이블의 행 삭제
DELETE  FROM  user_grade
    WHERE  grade_code = 20;

DROP TABLE user_foreignkey;
CREATE TABLE IF NOT EXISTS user_foreignkey(
              user_no INT PRIMARY KEY ,
              user_id VARCHAR(255) NOT NULL ,
              user_pwd VARCHAR(255) NOT NULL,
              user_name VARCHAR(255) NOT NULL,
              gender VARCHAR(3),
              phone VARCHAR(255) NOT NULL,
              email VARCHAR(255),
              grade_code INT,
  FOREIGN KEY (grade_code)
  REFERENCES user_grade(grade_code)
  ON UPDATE CASCADE -- CASCADE
  ON DELETE CASCADE
) ENGINE=INNODB;

INSERT INTO user_grade VALUES (20, '우수회원');

INSERT INTO user_foreignkey
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
    (1, 'user01', 'pass01', '홍길동', '남',
     '010-1234-5678', 'hong123@gmail.com', 10),
    (2, 'user02', 'pass02', '유관순', '여',
     '010-7777-7777', 'yu77@gmail.com', 20);

SELECT * FROM user_grade;
SELECT * FROM user_foreignkey;

UPDATE  user_grade
    SET grade_code = 300
WHERE grade_code = 10;

DELETE  FROM user_grade -- user_grade만 지워지는 것이 아닌 딸린 모든 것들이 사라진다.
WHERE grade_code = 300;

-- ==================================================
-- CHECK
-- ==================================================
-- CHECK 제약 조건 위반시 허용하지 않는다.

DROP TABLE IF EXISTS user_check;

CREATE TABLE IF NOT EXISTS user_check (
  user_no INT AUTO_INCREMENT PRIMARY KEY,
  user_name VARCHAR(255) NOT NULL,
  gender VARCHAR(5) CHECK(gender IN ('남', '여')),
  age INT CHECK(age >= 19)
) ENGINE=INNODB; -- check를 사용하면 제약 조건이 생겨서 해당 조건을 충족하지 않으면 데이터가 생성되지 않는다.
SHOW CREATE TABLE user_check;

SELECT * FROM information_schema.TABLE_CONSTRAINTS; -- 테이블에 제약조건을 확인하는 방법이다.

INSERT INTO user_check VALUES (null,'홍길동','남',25);
INSERT INTO user_check VALUES (null,'유관순','여',20);
INSERT INTO user_check VALUES (null,'안중근','남성',40);
INSERT INTO user_check VALUES (null,'유승제','남',18);
-- 안중근열사의 경우 남성이라는 체크 조건에 걸려 생성이 되지 않는다.
-- 유승제의 경우 나이라는 체크 조건에 걸려 생성이 되지 않는다.

SELECT * FROM user_check;
