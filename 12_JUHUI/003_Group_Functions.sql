use empdb;

-- 1. EMPLOYEE 테이블에서 여자사원의 급여 총 합을 계산

    /*
        ---------- 출력 예시 ------------
        `급여 총 합`
        ---------------------------------
        24816240
    */
-- 여자사원을 알려면 주민등록번호 뒤에 2,4면 됨.그래도 내 힘으로 풀었음.

SELECT
    SUM(salary) AS '급여 총 합'
    FROM employee
    WHERE
        SUBSTR(emp_no,8,1) IN (2,4);

-- 2. 부서코드가 D5인 사원들의 급여총합, 보너스 총합 조회

    /*
        ------- 출력 예시 ------------
        급여총합        `보너스 총합`
        ------------------------------
        15,760,000      745,000
    */
-- 답안
SELECT
    FORMAT(sum(salary), 0) 급여총합,
    FORMAT(sum(salary * IFNULL(bonus, 0)), 0) "보너스 총합"-- 가상컬럼
FROM
    employee
WHERE
    dept_code = 'D5';

-- 내가 푸는 거
SELECT
    FORMAT(SUM(salary),0) AS '급여총합'
    , FORMAT(sum(salary * IFNULL(bonus,0)),0) AS '보너스 총합'
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
    FORMAT(SUM((salary + (salary * IFNULL(bonus,0))) * 12),0) 연봉
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
    FORMAT(SUM(CASE WHEN SUBSTR(emp_no,8,1) IN (1, 3) THEN salary ELSE 0 END),0 )AS '남사원 급여 합계'
    , FORMAT(SUM(CASE WHEN SUBSTR(emp_no,8,1) IN (2, 4) THEN salary ELSE 0 END),0 )AS '여사원 급여 합계'
    FROM employee;


-- 5.  [EMPLOYEE] 테이블에서 사원들이 속해있는 부서의 수를 조회
-- (NULL은 제외하고, 중복된 부서는 하나로 카운팅)

    /*
        ------ 출력 예시 -------
        `부서 수`
        ------------------------
        6
    */

-- (NULL은 제외하고, 중복된 부서는 하나로 카운팅)

-- 중복 제거는 DISTINCT, NULL은 제외되어 카운팅되지 않음.
SELECT
    COUNT(DISTINCT dept_code ) '부서 수'
    FROM employee;