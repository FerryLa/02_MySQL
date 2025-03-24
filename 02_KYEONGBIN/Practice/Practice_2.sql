use empdb;

-- 1. employee 테이블에서 남자만 사원번호, 사원명, 주민번호, 연봉을 나타내세요.
-- 단, 주민번호의 뒷6자리는 *처리하세요.

# SELECT
#     EMP_ID, EMP_NAME, EMP_NO, SALARY
# FROM
#     employee;
# WHERE
#     -- PASS



-- 2. EMPLOYEE 테이블에서 사원명, 아이디(이메일 @ 앞부분)을 조회하세요.

# SELECT
#     EMP_NAME, EMAIL
# FROM
#     employee
# WHERE
#     -- PASS


-- 3. 파일경로를 제외하고 파일명만 아래와 같이 출력하세요.
CREATE TABLE tbl_files (
                           file_no BIGINT,
                           file_path VARCHAR(500)
);
-- drop table tbl_files
INSERT INTO tbl_files VALUES(1, 'c:\\abc\\deft\\salesinfo.xls');
INSERT INTO tbl_files VALUES(2, 'c:\\music.mp3');
INSERT INTO tbl_files VALUES(3, 'c:\\documents\\resume.hwp');
COMMIT;
SELECT * FROM tbl_files;

# 출력결과 :
# --------------------------
# 파일번호          파일명
# ---------------------------
# 1             salesinfo.xls
# 2             music.mp3
# 3             resume.hwp
# ---------------------------

# SELECT
#     *
# FROM
#     tbl_files
# WHERE
#     -- PASS

