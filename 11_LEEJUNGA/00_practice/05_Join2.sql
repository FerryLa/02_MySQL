-- 1. 가장 나이가 적은 직원의 사번, 사원명, 나이, 부서명, 직급명을 조회하시오.
-- ⭐⭐⭐⭐⭐

SELECT
    e.EMP_ID,
    e.EMP_NAME,
    DATE_FORMAT(NOW(), '%Y') -
    SUBSTRING(CASE
        WHEN SUBSTRING(EMP_NO, 8, 1) IN ('1', '2') THEN CONCAT('19', SUBSTRING(EMP_NO, 1, 6))
        WHEN SUBSTRING(EMP_NO, 8, 1) IN ('3', '4') THEN CONCAT('20', SUBSTRING(EMP_NO, 1, 6))
    END, 1, 4) - 1 AS 나이,
    d.DEPT_TITLE,
    j.JOB_NAME
FROM employee e
JOIN department d ON e.DEPT_CODE = d.DEPT_ID
JOIN job j ON e.JOB_CODE = j.JOB_CODE
ORDER BY
    CASE
         WHEN SUBSTRING(EMP_NO, 8, 1) IN ('1', '2') THEN CONCAT('19', SUBSTRING(EMP_NO, 1, 6))
         WHEN SUBSTRING(EMP_NO, 8, 1) IN ('3', '4') THEN CONCAT('20', SUBSTRING(EMP_NO, 1, 6))
    END DESC
LIMIT 1;
/*
    --------------------- 출력예시 ---------------------------------------
    사번          사원명         나이      부서명         직급명
    ----------------------------------------------------------------------
    203           송은희         16        해외영업2부    차장

*/


-- 2. 해외영업부에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.
SELECT
    e.EMP_NAME, j.JOB_NAME, d.DEPT_ID, d.DEPT_TITLE
FROM employee e
         JOIN department d ON e.DEPT_CODE = d.DEPT_ID
         JOIN job j ON e.JOB_CODE = j.JOB_CODE
WHERE
    d.DEPT_TITLE LIKE '해외영업%';
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
  
-- 3. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.
SELECT
    e.EMP_NAME,
    e.BONUS,
    d.DEPT_TITLE,
    l.LOCAL_NAME
FROM employee e
LEFT JOIN department d ON e.DEPT_CODE = d.DEPT_ID
LEFT JOIN job j ON e.JOB_CODE = j.JOB_CODE
LEFT JOIN location l ON d.LOCATION_ID = l.LOCAL_CODE
WHERE
    e.BONUS IS NOT NULL;

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
   


-- 4.  급여등급테이블 sal_grade의 등급별 최대급여(MAX_SAL)보다 많이 받는 직원들의 사원명, 직급명, 급여, 연봉을 조회하시오.
--  (사원테이블과 급여등급테이블을 SAL_LEVEL컬럼기준으로 동등 조인할 것)
SELECT
    e.EMP_NAME,
    j.JOB_NAME,
    e.SALARY,
    e.SALARY * 12 AS 연봉,
    s.MAX_SAL
FROM employee e
LEFT JOIN sal_grade s ON e.SAL_LEVEL = s.SAL_LEVEL
LEFT JOIN job j ON e.JOB_CODE = j.JOB_CODE
WHERE e.SALARY > s.MAX_SAL;

/*
    --------------------- 출력예시 ---------------------------------------
    사원명     직급명     급여        연봉            최대급여
    ----------------------------------------------------------------------
    고두밋      부사장     4480000    53760000        2999999
*/
   

-- 5. 한국(KO)과 일본(JP)에 근무하는 직원들의 사원명, 부서명, 지역명, 국가명을 조회하시오.
SELECT
    e.EMP_NAME,
    d.DEPT_TITLE,
    l.LOCAL_NAME,
    n.NATIONAL_NAME
FROM employee e
JOIN department d ON d.DEPT_ID = e.DEPT_CODE
JOIN location l ON l.LOCAL_CODE = d.LOCATION_ID
JOIN nation n ON n.NATIONAL_CODE = l.NATIONAL_CODE
WHERE n.NATIONAL_CODE IN ('KO', 'JP');

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
    

-- 6. 같은 부서에 근무하는 직원들의 사원명, 부서명, 동료이름을 조회하시오. (self join 사용)
--     사원명으로 오름차순정렬

SELECT
    e1.EMP_NAME,
    d.DEPT_TITLE,
    e2.EMP_NAME
FROM employee e1
JOIN employee e2 ON e1.DEPT_CODE = e2.DEPT_CODE
JOIN department d ON d.DEPT_ID = e1.DEPT_CODE
    AND e1.EMP_NAME != e2.EMP_NAME
ORDER BY e1.EMP_NAME;

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

   
-- 7. 보너스포인트가 없는 직원들 중에서 직급이 차장과 사원인 직원들의 사원명, 직급명, 급여를 조회하시오.
--     단, join과 in 연산자 사용할 것

SELECT
    e.EMP_NAME,
    j.JOB_NAME,
    FORMAT(e.SALARY, 0)
FROM employee e
JOIN job j ON j.JOB_CODE = e.JOB_CODE
WHERE
    e.BONUS IS NULL AND
    j.JOB_NAME IN ('차장', '사원');


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


-- 8. 재직중인 직원과 퇴사한 직원의 수를 조회하시오.
SELECT
    CASE
        WHEN e.QUIT_YN = 'Y' THEN '퇴사' ELSE '재직'
    END AS 재직여부,
    COUNT(e.QUIT_YN) AS 인원수
FROM employee e
GROUP BY e.QUIT_YN;

/*
  --------------------- 출력예시 -------------
  재직여부          인원수
  --------------------------------------------
  재직              23
  퇴사              1
*/
