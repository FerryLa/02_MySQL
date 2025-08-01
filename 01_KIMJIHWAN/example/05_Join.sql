-- 1. 재직 중(QUIT_YN)이고 휴대폰 마지막 자리가 2인 직원 중 입사일이 가장 최근인 직원 3명의 사원번호,
-- 사원명, 전화번호, 입사일, 퇴직여부를 출력하세요.
-- 참고. 퇴사한 직원은 퇴직여부 컬럼값이 ‘Y’이고, 재직 중인 직원의 퇴직여부 컬럼값은 ‘N’ (JOIN은 아님)
SELECT EMP_ID 사원번호, EMP_NAME 사원명, PHONE 전화번호, HIRE_DATE 입사일,  QUIT_YN 퇴직여부
  FROM employee
 WHERE QUIT_YN = 'N'
   AND PHONE LIKE '%2'
ORDER BY HIRE_DATE DESC
LIMIT 3;
    /*
        -------------------- 출력 예시 ----------------------------
        사원번호    사원명     전화번호        입사일     퇴직여부
        -----------------------------------------------------------
        216         차태연     01064643212     2013-03-01 00:00:00,N
        211         전형돈     01044432222     2012-12-12 00:00:00,N
        206         박나라     01096935222     2008-04-02 00:00:00,N
    */


-- 2. 재직 중인 ‘대리’들의 직원명, 직급명, 급여, 사원번호, 주민번호, 이메일, 전화번호, 입사일을 출력하세요.
-- 단, 급여를 기준으로 내림차순 출력하세요.
SELECT a.EMP_NAME 사원명, b.JOB_NAME 직급명, a.SALARY 급여
     , a.EMP_NO 주민번호, a.EMAIL 이메일, a.PHONE 전화번호, a.HIRE_DATE 입사일
FROM employee a
         JOIN JOB b ON a.JOB_CODE = b.JOB_CODE
WHERE a.QUIT_YN = 'N'
  AND b.JOB_NAME = '대리'
ORDER BY a.SALARY DESC;
    /*
        ---------------------------------- 출력 예시 ------------------------------------------------
        사원명     직급명     급여       주민번호        이메일                    입사일
        ----------------------------------------------------------------------------------------------
        전지연     대리      3660000     770808-2665412  jun_jy@ohgiraffers.com    2007-03-20 00:00:00
        차태연     대리      2780000     000704-3364897  cha_ty@ohgiraffers.com    2013-03-01 00:00:00
        장쯔위     대리      2550000     780923-2234542  jang_zw@ohgiraffers.com   2015-06-17 00:00:00
        하동운     대리      2320000     621111-1785463  ha_dh@ohgiraffers.com     1999-12-31 00:00:00
        전형돈     대리      2000000     830807-1121321  jun_hd@ohgiraffers.com    2012-12-12 00:00:00
    */


-- 3. 재직 중인 직원들을 대상으로 부서별 인원, 급여 합계, 급여 평균을 출력하고,
--    마지막에는 전체 인원과 전체 직원의 급여 합계 및 평균이 출력되도록 하세요.
--    단, 출력되는 데이터의 헤더는 컬럼명이 아닌 ‘부서명’, ‘인원’, ‘급여합계’, ‘급여평균’으로 출력되도록 하세요. (ROLLUP사용)
SELECT * FROM department;
SELECT * FROM employee;
SELECT b.DEPT_TITLE FROM employee a JOIN department b ON a.DEPT_CODE = b.DEPT_ID;
use empdb;

SELECT
      b.DEPT_TITLE 부서명,
      COUNT(b.DEPT_TITLE) 인원,
      SUM(a.SALARY) 급여합계,
      AVG(a.SALARY) 급여평균
  FROM
      employee a
  JOIN
      department b ON a.DEPT_CODE = b.DEPT_ID
 WHERE
      a.QUIT_YN = 'N'
GROUP BY
      b.DEPT_TITLE
WITH ROLLUP;

    /*
        -------------------------- 출력 예시 -----------------------------
        부서명         인원      급여합계            급여평균
        ---------------------------------------------------------------
        기술지원부       2       4550000             2275000
        인사관리부       3       7820000             2606666.6666666665
        총무부           3       17700000            5900000
        해외영업1부      6       15760000            2626666.6666666665
        해외영업2부      3       10100000            3366666.6666666665
        회계관리부       4       11000000            2750000
        <null>          21       66930000            3187142.8571428573

    */


-- 4. 전체 직원의 사원명, 주민등록번호, 전화번호, 부서명, 직급명을 출력하세요.
--    단, 입사일을 기준으로 오름차순 정렬되도록 출력하세요.
SELECT * FROM employee;
SELECT * FROM department;

SELECT a.EMP_NAME, a.EMP_NO, IFNULL(a.PHONE, ''), b.DEPT_TITLE, c.JOB_NAME
  FROM employee a
  JOIN department b ON a.DEPT_CODE = b.DEPT_ID
  JOIN JOB c ON a.JOB_CODE = c.JOB_CODE
ORDER BY HIRE_DATE;

    /*
        ------------------- 출력 예시 ---------------------------------
        사원명     주민등록번호          전화번호        부서명     직급명
        선동일     621225-1985634        01099546325     총무부      대표
        고두밋     470808-2123341                        회계관리부  부사장
        유하진     800808-1123341                        회계관리부  차장
        하이유     690402-2040612        01036654488     해외영업1부 과장
        송은희     070910-4653546        01077607879     해외영업2부 차장
        이태림     760918-2854697        01033000002     기술지원부  대리
        정중하     770102-1357951        01036654875     해외영업2부 부장
        임시환     660712-1212123                        회계관리부  차장
        ...
        총 row 수는 24
    */

-- 5. 2020년 12월 25일이 무슨 요일인지 조회하시오.(Join아님)
# SELECT CASE
#     WHEN DAYOFWEEK(20201225) = 1 THEN '일'
#     WHEN DAYOFWEEK(20201225) = 2 THEN '월'
#     WHEN DAYOFWEEK(20201225) = 3 THEN '화'
#     WHEN DAYOFWEEK(20201225) = 4 THEN '수'
#     WHEN DAYOFWEEK(20201225) = 5 THEN '목'
#     WHEN DAYOFWEEK(20201225) = 6 THEN '금'
#     WHEN DAYOFWEEK(20201225) = 7 THEN '토'
#     END 요일

SELECT CASE WHEN DAYOFWEEK(20201225) = 6 THEN 'Friday' END 요일

    /*


        -------- 출력예시 ---------
        요일
        ---------------------------
        Friday
    */

-- 6. 주민번호가 70년대 생이면서 성별이 여자이고,
--    성이 전씨인 직원들의 사원명, 주민번호, 부서명, 직급명을 조회하시오.
SELECT
    a.EMP_NAME, a.EMP_NO, b.DEPT_TITLE, c.JOB_NAME
  FROM employee a
  JOIN department b ON a.DEPT_CODE = b.DEPT_ID
  JOIN JOB c ON a.JOB_CODE = c.JOB_CODE
 WHERE EMP_NAME LIKE '전%'
   AND SUBSTR(EMP_NO, 8,1) IN (2,4);

    /*
        -------------------- 출력 예시 -------------------------
        사원명         주민번호            부서명         직급명
        ---------------------------------------------------------
        전지연         770808-2665412       인사관리부    대리
    */


-- 7. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 직급명을 조회하시오.
SELECT
      a.EMP_ID, a.EMP_NAME, b.JOB_NAME
  FROM
      employee a
  JOIN
      JOB b ON a.JOB_CODE = b.JOB_CODE
 WHERE
      EMP_NAME LIKE '%형%';
    /*
        ------------------- 출력 예시 -----------------------
        사번      사원명    직급명
        -----------------------------------------------------
        211        전형돈    대리
    */

-- 8. 해외영업팀에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.
SELECT
      a.EMP_NAME, c.JOB_NAME, b.DEPT_ID, b.DEPT_TITLE
  FROM employee a
  JOIN department b ON a.DEPT_CODE = b.DEPT_ID
  JOIN JOB c ON a.JOB_CODE = c.JOB_CODE
 WHERE DEPT_TITLE LIKE '해외영업%';
    /*
        ------------------- 출력 예시 ---------------------------
        사원명     직급명     부서코드        부서명
        ----------------------------------------------------------
        박나라     사원        D5             해외영업1부
        하이유     과장        D5             해외영업1부
        김해술     과장        D5             해외영업1부
        심봉선     부장        D5             해외영업1부
        윤은해     사원        D5             해외영업1부
        대북혼     과장        D5             해외영업1부
        송은희     차장        D6             해외영업2부
        유재식     부장        D6             해외영업2부
        정중하     부장        D6             해외영업2부

    */














