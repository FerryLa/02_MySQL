USE empdb;

-- 1. EMPLOYEE 테이블에서 여자사원의 급여 총 합을 계산

/*
    ---------- 출력 예시 ------------
    `급여 총 합`
    ---------------------------------
    24816240
*/
SELECT
    SUM(salary) AS '급여 총 합'
  FROM
      employee
 WHERE
     SUBSTRING(emp_no, 8, 1) IN ('2', '4', '6', '8');


-- 2. 부서코드가 D5인 사원들의 급여총합, 보너스 총합 조회

/*
    ------- 출력 예시 ------------
    급여총합        `보너스 총합`
    ------------------------------
    15,760,000      745,000
*/
SELECT
    -- IFNULL로 NULL인 값을 0으로 대체해줘야 정확한 값이 나옴
    FORMAT(SUM(salary), 0)                    AS 급여총합
  , FORMAT(SUM(salary * IFNULL(bonus, 0)), 0) AS 보너스총합
  FROM
      employee
 WHERE
     dept_code = 'D5';

-- 3. 부서코드가 D5인 직원의 보너스 포함 연봉의 총합 을 계산

/*
    ------- 출력 예시 ----------
    연봉
    ----------------------------
    198,060,000
*/
SELECT
    FORMAT(SUM((salary + (salary * IFNULL(bonus, 0))) * 12), 0) AS 연봉
  FROM
      employee
 WHERE
     dept_code = 'D5';

-- 4. 남/여 사원 급여합계를 동시에 표현(가공된 컬럼의 합계)

/*
    ---------------- 출력 예시 -------------------
    `남사원 급여 합계`         `여사원 급여 합계`
    ----------------------------------------------
     49,760,000                24,816,240
*/
SELECT
    -- case when then else end
    FORMAT(SUM(CASE WHEN SUBSTR(emp_no, 8, 1) IN ('1', '3', '5', '7') THEN salary ELSE 0 END), 0)
  , FORMAT(SUM(CASE WHEN SUBSTR(emp_no, 8, 1) IN ('2', '4', '6', '8') THEN salary ELSE 0 END), 0)
  FROM
      employee;


-- 5.  [EMPLOYEE] 테이블에서 사원들이 속해있는 부서의 수를 조회
-- (NULL은 제외하고, 중복된 부서는 하나로 카운팅)

/*
    ------ 출력 예시 -------
    `부서 수`
    ------------------------
    6
*/

-- (NULL은 제외하고, 중복된 부서는 하나로 카운팅)
SELECT
    -- DISTINCT 컬럼에 포함된 중복값을 한번씩만 표시
    -- dept_code에 있는 중복값(중복 부서)을 하나로 카운팅
    COUNT(DISTINCT dept_code) AS 부서수
  FROM
      employee;

