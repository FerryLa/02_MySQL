use empdb;

-- 1. employee 테이블에서 남자만 사원번호, 사원명, 주민번호, 연봉을 나타내세요.
-- 단, 주민번호의 뒷6자리는 *처리하세요.
SELECT
        *
  FROM
        EMPLOYEE;

SELECT
        EMP_ID 사원번호,
        EMP_NAME 성명,
        RPAD(SUBSTR(EMP_NO, 1, 8), 14, "*") 주민번호,
        # 주민번호 첫번째에서 여덟번째까지 읽어들이고 9번째에서 14번째를 오른쪽으로 별로 채운다.
        FORMAT((SALARY + (SALARY * IFNULL(bonus, 0))) * 12, 0) 연봉
        # 연봉 + 보너스를 곱한 월급
        # 만약 BOUNS가 NULL이면 0으로 치환
        # FORMAT(..., 0) : 연봉 + 보너스를 곱한 월급을 불러오고 소수점은 없음
  FROM
        EMPLOYEE
 WHERE
        # 주민번호의 8번째 자리에서 한글자를 추출하고 그 숫자는 1 또는 3 추출.
        SUBSTR(EMP_NO, 8, 1) IN ('1', '3'); # 남자만 추출

    /*
        --------------- 출력 예시 ------------------------
        사원번호    성명      주민번호           연봉
        --------------------------------------------------
        200        선동일     621225-1******   124,800,000
        201        송종기     631126-1******   72,000,000
        202        노옹철     861015-1******   44,400,000
        204        유재식     660508-1******   48,960,000
        205        정중하     770102-1******   46,800,000
        208        김해술     870927-1******   30,000,000
        209        심봉선     750206-1******   48,300,000
        ...
        총 row수는 15
    */

-- 2. EMPLOYEE 테이블에서 사원명, 아이디(이메일 @ 앞부분)을 조회하세요.
SELECT
        *
  FROM
        EMPLOYEE;

SELECT
        EMP_NAME,
        # INSTR(email, '@') -> @의 위치 찾기
        SUBSTR(EMAIL, 1, INSTR(email, '@') -1) EMAIL_ID
  FROM
        EMPLOYEE;

SELECT
        EMP_NAME,
        # SUBSTRING(str, delim, count)
        # str : 대상 문자열, delim : 기준이 될 구분자, count : 양수 = 왼쪽부터, 음수 = 오른쪽부터
        SUBSTRING_INDEX(email, "@", 1) EMAIL_ID
  FROM
        EMPLOYEE;

    /*
        --------- 출력 예시 -----------
        emp_name        email_id
        -------------------------------
        선동일          sun_di
        송종기          song_jk
        노옹철          no_hc
        송은희          song_eh
        유재식          yoo_js
        정중하          jung_jh
        박나라          pack_nr
        하이유          ha_iy
        김해술          kim_hs
        ...
        총 row수는 24
    */

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

SELECT
        FILE_NO 파일번호,
        # 파일 경로는 \\ 별로 구분되어지는데 -1 오른쪽에서 첫번째라는 뜻이기 때문에 파일명만 불러올 수 있음
        SUBSTRING_INDEX(FILE_PATH, '\\', -1) 파일명
  FROM
        TBL_FILES;

/*
출력결과 :
--------------------------
파일번호          파일명
---------------------------
1             salesinfo.xls
2             music.mp3
3             resume.hwp
---------------------------
*/