use empdb;

-- 1. EMPLOYEE 테이블에서 여자사원의 급여 총 합을 계산

SELECT
    SUM(SALARY)
FROM
    employee
WHERE
    SUBSTR(EMP_NO, 8, 1) IN (2, 4);


-- 2. 부서코드가 D5인 사원들의 급여총합, 보너스 총합 조회

SELECT
    DEPT_CODE, FORMAT(SUM(SALARY), 0), FORMAT(SUM(SALARY * BONUS), 0)
FROM
    employee
WHERE
    DEPT_CODE = 'D5';

-- 3. 부서코드가 D5인 직원의 보너스 포함 연봉의 총합 을 계산

# SELECT
#     FORMAT(SUM(SALARY) * 12 + SUM(SALARY * BONUS), 0)
# FROM
#     employee
# WHERE
#     DEPT_CODE = 'D5'; -- PASS

# ------- 출력 예시 ----------
# 연봉
# ----------------------------
# 198,060,000

-- 4. 남/여 사원 급여합계를 동시에 표현(가공된 컬럼의 합계)

-- PASS

# ---------------- 출력 예시 -------------------
# '남사원 급여 합계`         `여사원 급여 합계`
# ---------------------------------------------
# 49,760,000                24,816,240

-- 5.  [EMPLOYEE] 테이블에서 사원들이 속해있는 부서의 수를 조회
-- (NULL은 제외하고, 중복된 부서는 하나로 카운팅)

SELECT
    count(DISTINCT DEPT_CODE)
FROM
    employee
WHERE
    DEPT_CODE IS NOT NULL;

# ------ 출력 예시 -------
# `부서 수`
# ------------------------
# 6
-- (NULL은 제외하고, 중복된 부서는 하나로 카운팅)

SELECT
    *
FROM
    employee;
