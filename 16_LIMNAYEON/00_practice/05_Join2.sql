-- 1. 가장 나이가 적은 직원의 사번, 사원명, 나이, 부서명, 직급명을 조회하시오.

/*
    --------------------- 출력예시 ---------------------------------------
    사번          사원명         나이      부서명         직급명
    ----------------------------------------------------------------------
    203           송은희         16        해외영업2부    차장

*/
SELECT
        E.EMP_ID 사번
      , E.EMP_NAME 사원명
      , TRUNCATE(
        DATEDIFF(NOW()
                ,CONCAT
                (IF(SUBSTR(emp_no, 8, 1) IN ('1', '2'), 19, 20), LEFT(emp_no, 6))
                ) / 365, 0) 나이
      , D.DEPT_TITLE 부서명
      , J.JOB_NAME 직급명
  FROM
        employee E

        INNER JOIN department D ON E.DEPT_CODE = D.DEPT_ID
        INNER JOIN job J ON E.JOB_CODE = J.JOB_CODE
ORDER BY 나이
LIMIT 1;


-- 2. 해외영업부에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.
/*
    --------------------- 출력예시 ---------------------------------------
    사원명         직급명         부서코드            부서명
    ----------------------------------------------------------------------
    박나라         사원              D5              해외영업1부
    하이유         과장              D5              해외영업1부
    김해술         과장              D5              해외영업1부
    심봉선         부장              D5              해외영업1부
    윤은해         사원              D5              해외영업1부
    대북혼         과장              D5              해외영업1부
    송은희         차장              D6              해외영업2부
    유재식         부장              D6              해외영업2부
    정중하         부장              D6              해외영업2부
*/
SELECT
        E.EMP_NAME 사원명
      , J.JOB_NAME 직급명
      , E.DEPT_CODE 부서코드
      , D.DEPT_TITLE
FROM
        employee E
            INNER JOIN department D ON E.DEPT_CODE = D.DEPT_ID
            INNER JOIN job J USING(JOB_CODE)

WHERE
        E.DEPT_CODE IN ('D5', 'D6');

-- 3. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.

/*
    --------------------- 출력예시 ---------------------------------------
    사원명         보너스포인트          부서명         근무지역명
    ----------------------------------------------------------------------
    선동일         0.3                   총무부         ASIA1
    유재식         0.2                   해외영업2부    ASIA3
    하이유         0.1                   해외영업1부    ASIA2
    심봉선         0.15                  해외영업1부    ASIA2
    장쯔위         0.25                  기술지원부     EU
    하동운         0.1                     <null>       <null>
    차태연         0.2                   인사관리부     ASIA1
    전지연         0.3                   인사관리부     ASIA1
    이태림         0.35                  기술지원부     EU

*/
SELECT
        E.EMP_NAME 사원명
      , E.BONUS 보너스포인트
      , D.DEPT_TITLE 부서명
      , L.LOCAL_NAME 근무지역명
  FROM
        employee E
        LEFT JOIN department D ON E.DEPT_CODE = D.DEPT_ID
        LEFT JOIN location L ON D.LOCATION_ID = L.LOCAL_CODE
WHERE
        BONUS IS NOT NULL;
   


-- 4.  급여등급테이블 sal_grade의 등급별 최대급여(MAX_SAL)보다 많이 받는 직원들의 사원명, 직급명, 급여, 연봉을 조회하시오.
--  (사원테이블과 급여등급테이블을 SAL_LEVEL컬럼기준으로 동등 조인할 것)
/*
    --------------------- 출력예시 ---------------------------------------
    사원명     직급명     급여        연봉            최대급여
    ----------------------------------------------------------------------
    고두밋      부사장     4480000    53760000        2999999
*/

SELECT
        E.EMP_NAME 사원명
      , J.JOB_NAME 직급명
      , E.SALARY 급여
      , E.SALARY + (E.SALARY * IFNULL(E.BONUS, 0)) * 12 연봉
      , S.MAX_SAL 최대급여
  FROM
        employee E
        INNER JOIN job J ON E.JOB_CODE = J.JOB_CODE
        INNER JOIN sal_grade S USING(SAL_LEVEL)
WHERE
        E.SALARY > S.MAX_SAL;

-- 5. 한국(KO)과 일본(JP)에 근무하는 직원들의 사원명, 부서명, 지역명, 국가명을 조회하시오.
/*
    --------------------- 출력예시 ---------------------------------------
    사원명         부서명         지역명         국가명
    ----------------------------------------------------------------------
    방명수         인사관리부     ASIA1          한국
    차태연         인사관리부     ASIA1          한국
    전지연         인사관리부     ASIA1          한국
    임시환         회계관리부     ASIA1          한국
    이중석         회계관리부     ASIA1          한국
    유하진         회계관리부     ASIA1          한국
    고두밋         회계관리부     ASIA1          한국
    박나라         해외영업1부    ASIA2          일본
    하이유         해외영업1부    ASIA2          일본
    김해술         해외영업1부    ASIA2          일본
    심봉선         해외영업1부    ASIA2          일본
    윤은해         해외영업1부    ASIA2          일본
    대북혼         해외영업1부    ASIA2          일본
    선동일         총무부,ASIA1                  한국
    송종기         총무부,ASIA1                  한국
    노옹철         총무부,ASIA1                  한국

*/
SELECT
        E.EMP_NAME 사원명
      , D.DEPT_TITLE 부서명
      , L.LOCAL_NAME 지역명
      , CASE WHEN L.NATIONAL_CODE = 'KO' THEN '한국'
             WHEN L.NATIONAL_CODE = 'JP' THEN '일본'
             ELSE L.NATIONAL_CODE
             END AS 국가명
  FROM
        employee E
        INNER JOIN department D ON E.DEPT_CODE = D.DEPT_ID
        LEFT JOIN location L ON D.LOCATION_ID = L.LOCAL_CODE
 WHERE
        L.NATIONAL_CODE IN ('KO', 'JP');

    

-- 6. 같은 부서에 근무하는 직원들의 사원명, 부서명, 동료이름을 조회하시오. (self join 사용)
--     사원명으로 오름차순정렬
/*
    --------------------- 출력예시 ---------------------------------------
    사원명         부서명         동료사원명
    ----------------------------------------------------------------------
    고두밋         회계관리부     임시환
    고두밋         회계관리부     이중석
    고두밋         회계관리부     유하진
    김해술         해외영업1부    박나라
    김해술         해외영업1부    하이유
    김해술         해외영업1부    심봉선
    김해술         해외영업1부    윤은해
    김해술         해외영업1부    대북혼
    ...
    총 row 66
*/

SELECT
        E.EMP_NAME 사원명
      , D.DEPT_TITLE 부서명
      , E2.EMP_NAME 동료사원명
  FROM
        employee E
        INNER JOIN employee E2 ON E.DEPT_CODE = E2.DEPT_CODE
        INNER JOIN department D ON E.DEPT_CODE = D.DEPT_ID
WHERE
        E.EMP_NAME != E2.EMP_NAME
ORDER BY
        E.EMP_NAME ASC;


   
-- 7. 보너스포인트가 없는 직원들 중에서 직급이 차장과 사원인 직원들의 사원명, 직급명, 급여를 조회하시오.
--     단, join과 in 연산자 사용할 것
/*
    --------------------- 출력예시 -------------
    사원명         직급명         급여
    ---------------------------------------------
    송은희         차장           2,800,000
    임시환         차장           1,550,000
    이중석         차장           2,490,000
    유하진         차장           2,480,000
    박나라         사원           1,800,000
    윤은해         사원           2,000,000
    ...
    총 row수는 8
*/
SELECT
        E.EMP_NAME 사원명
      , J.JOB_NAME 직급명
      , FORMAT(E.SALARY, 0) 급여

  FROM employee E
        INNER JOIN job J USING(JOB_CODE)
WHERE
        BONUS IS NULL AND J.JOB_NAME IN ('차장', '사원');


-- 8. 재직중인 직원과 퇴사한 직원의 수를 조회하시오.

/*
  --------------------- 출력예시 -------------
  재직여부          인원수
  --------------------------------------------
  재직              23
  퇴사              1
*/

SELECT
        CASE WHEN QUIT_YN = 'Y' THEN '퇴사'
             WHEN QUIT_YN = 'N' THEN '재직'
             END AS 재직여부
      , COUNT(*) 인원수
  FROM
        employee E
GROUP BY
        E.QUIT_YN;