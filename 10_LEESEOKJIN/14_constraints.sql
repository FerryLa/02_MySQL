-- ================================
-- FOREIGN KEY
-- ================================
-- 참조(REFERENCES)된 다른 테이블에서 제공하는 값만 사용할 수 있다.
-- 참조무결성을 위배하지 않기 위해 사용한다.
-- FOREIGN KEY제약조건에 의해서 테이블간의 관계(RELATIONSHIP)가 형성된다.
-- 제공되는 값 외에는 NULL을 사용할 수 있다.
DROP TABLE IF EXISTS user_grade;
CREATE TABLE user_grade
(
    grade_code INT PRIMARY KEY,
    grade_name VARCHAR(255) NOT NULL
) ENGINE = INNODB;

INSERT INTO user_grade
VALUES (10, '일반회원'),
       (20, '우수회원'),
       (30, '특별회원');

SELECT *
FROM user_grade;

DROP TABLE IF EXISTS user_foreignkey;
CREATE TABLE user_foreignkey
(
    user_no    INT PRIMARY KEY,
    user_id    VARCHAR(255) NOT NULL,
    user_pwd   VARCHAR(255) NOT NULL,
    user_name  VARCHAR(255) NOT NULL,
    gender     VARCHAR(3),
    phone      VARCHAR(255) NOT NULL,
    email      VARCHAR(255),
    grade_code INT,
    FOREIGN KEY (grade_code)
        REFERENCES user_grade (grade_code)
        ON UPDATE SET NULL
        ON DELETE SET NULL
) ENGINE = INNODB;

INSERT INTO user_foreignkey
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
       (2, 'user02', 'pass02', '유관순', '여', '010-7777-7777', 'yu77@gmail.com', 20);

SELECT *
FROM user_foreignkey;

-- 1. 부모 테이블의 grade_code 수정
UPDATE user_grade
SET grade_code = 300
WHERE grade_code = 10;

-- 2. 부모 테이블의 행 삭제
DELETE
FROM user_grade
WHERE grade_code = 20;


CREATE TABLE user_check
(
    user_no   INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(255) NOT NULL,
    gender    VARCHAR(5) CHECK ( gender IN ('남', '여') ),
    age       INT CHECK (age >= 19)
);

INSERT INTO user_check VALUE (null, '홍길동', '남', 25);
INSERT INTO user_check VALUE (null, '유관순', '여', 20);

-- [HY000][3819] Check constraint 'user_check_chk_1' is violated.
INSERT INTO user_check VALUE (null, '안중근', '남성', 40);

-- [HY000][3819] Check constraint 'user_check_chk_2' is violated.
INSERT INTO user_check VALUE (null, '안중근', '남', 10);

SELECT *
FROM user_check;

SELECT * FROM tbl_menu;
