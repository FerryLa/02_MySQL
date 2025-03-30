-- 1. 부서별 직원 급여의 총합 중 가장 큰 액수를 출력하세요.
SELECT MAX(t.급여총합) AS 총합 FROM (
  SELECT SUM(SALARY) AS 급여총합 FROM employee
  GROUP BY DEPT_CODE
) t;


    /*
        ----------- 출력 예시 ----------------
        총합
        ---------------------------------------
        17700000
    */


-- 2. 서브쿼리를 이용하여 영업부인 직원들의 사원번호, 사원명, 부서코드, 급여를 출력하세요.
--    참고. 영업부인 직원은 부서명에 ‘영업’이 포함된 직원임

SELECT * FROM (
  SELECT
      e.EMP_ID,
      e.EMP_NAME,
      e.DEPT_CODE,
      e.SALARY
  FROM employee e
  JOIN department d ON e.DEPT_CODE = d.DEPT_ID
  WHERE d.DEPT_TITLE LIKE '%영업%'
) t;



    /*
        ----------------- 출력 예시 --------------------
        사원번호     사원명     부서코드        급여
        ------------------------------------------------
        206          박나라      D5             1800000
        207          하이유      D5             2200000
        208          김해술      D5             2500000
        209          심봉선      D5             3500000
        210          윤은해      D5             2000000
        215          대북혼      D5             3760000
        203          송은희      D6             2800000
        204          유재식      D6             3400000
        205          정중하      D6             3900000
    */
 
-- 3. 서브쿼리와 JOIN을 이용하여 영업부인 직원들의 사원번호, 직원명, 부서명, 급여를 출력하세요.
SELECT
    e.EMP_ID,
    e.EMP_NAME,
    d.DEPT_TITLE,
    e.SALARY
FROM (SELECT * FROM employee) e
JOIN department d ON e.DEPT_CODE = d.DEPT_ID
WHERE d.DEPT_TITLE LIKE '%영업%'
;

    /*
        ----------------- 출력 예시 --------------------
        사원번호    직원명        부서명     급여
        ------------------------------------------------
        206         박나라        해외영업1부  1800000
        207         하이유        해외영업1부  2200000
        208         김해술        해외영업1부  2500000
        209         심봉선        해외영업1부  3500000
        210         윤은해        해외영업1부  2000000
        215         대북혼        해외영업1부  3760000
        203         송은희        해외영업2부  2800000
        204         유재식        해외영업2부  3400000
        205         정중하        해외영업2부  3900000

    */

-- 4. 1. JOIN을 이용하여 부서의 부서코드, 부서명, 해당 부서가 위치한 지역명, 국가명을 추출하는 쿼리를 작성하세요.
--    2. 위 1에서 작성한 쿼리를 서브쿼리로 활용하여 모든 직원의 사원번호, 사원명, 급여, 부서명, (부서의) 국가명을 출력하세요.
--       단, 국가명 내림차순으로 출력되도록 하세요.


SELECT
    e.EMP_ID,
    e.EMP_NAME,
    e.SALARY,
    t.DEPT_TITLE,
    t.NATIONAL_NAME
FROM employee e
JOIN (
    SELECT
        d.DEPT_ID,
        d.DEPT_TITLE,
        l.LOCAL_NAME,
        n.NATIONAL_NAME
    FROM department d
             LEFT JOIN location l ON l.LOCAL_CODE = d.LOCATION_ID
             LEFT JOIN nation n ON n.NATIONAL_CODE = l.NATIONAL_CODE
) t ON e.DEPT_CODE = t.DEPT_ID
ORDER BY t.NATIONAL_NAME DESC;

    /*
    ------------------------- 출력 예시 --------------------------
    사원번호        사원명     급여      부서명     (부서의) 국가명
    ---------------------------------------------------------------
    214             방명수     1380000   인사관리부        한국
    216             차태연     2780000   인사관리부        한국
    217             전지연     3660000   인사관리부        한국
    219             임시환     1550000   회계관리부        한국
    220             이중석     2490000   회계관리부        한국
    221             유하진     2480000   회계관리부        한국
    223             고두밋     4480000   회계관리부        한국
    200             선동일     8000000   총무부            한국
    201             송종기     6000000   총무부            한국
    ...
    총 row수 22개

    */













