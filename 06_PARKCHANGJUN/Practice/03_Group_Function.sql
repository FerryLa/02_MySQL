use empdb;

-- 1. EMPLOYEE 테이블에서 여자사원의 급여 총 합을 계산
SELECT
        *
  FROM
        EMPLOYEE;

SELECT
        SUM(SALARY) '급여 총 합'
  FROM
        EMPLOYEE
 WHERE
        # 주민번호가 2, 4인 사람을 뽑아내야 여자만 추출 가능
        # EMP_NO의 8번째에서 한글자를 추출하고 그 숫자를 2 또는 4만 추출
        SUBSTR(EMP_NO, 8, 1) IN (2, 4)

/*
        ---------- 출력 예시 ------------
        `급여 총 합`
        ---------------------------------
        24816240
    */

-- 2. 부서코드가 D5인 사원들의 급여총합, 보너스 총합 조회
SELECT
        *
  FROM
        EMPLOYEE;

SELECT
        # 급여의 총합을 구하고 소수점은 0자리 이므로 천단위마다 , 가 생김
        FORMAT(SUM(SALARY), 0) 급여총합,
        # 급여 * BONUS. 즉, 급여 * 보너스의 합. IFNULL이기 때문에 NULL값인 부분은 0으로 치환
        FORMAT(SUM(SALARY * IFNULL(BONUS, 0)), 0) "보너스 총합"
  FROM
        EMPLOYEE
 WHERE
        DEPT_CODE = 'D5';

    /*
        ------- 출력 예시 ------------
        급여총합        `보너스 총합`
        ------------------------------
        15,760,000      745,000
    */


-- 3. 부서코드가 D5인 직원의 보너스 포함 연봉의 총합 을 계산
SELECT
        *
  FROM
        EMPLOYEE;

SELECT
        # 급여 + 급여의 보너스를 곱한 값. 즉, 급여 + 보너스를 합친 값. 연봉이니 * 12
        FORMAT(SUM(SALARY + SALARY * IFNULL(BONUS, 0)) * 12, 0) 연봉
  FROM
        EMPLOYEE
 WHERE
        DEPT_CODE = 'D5';

    /*ㅣ
        ------- 출력 예시 ----------
        연봉
        ----------------------------
        198,060,000
    */

-- 4. 남/여 사원 급여합계를 동시에 표현(가공된 컬럼의 합계)
SELECT
        *
  FROM
        EMPLOYEE;

SELECT
        # 주민번호가 1, 3인 경우에는 급여를 더한다. 그렇지 않으면 0을 더한다. 그리고 소수점 자리는 0. 따라서 천단위로 구분
        FORMAT(SUM(
                    CASE WHEN SUBSTR(EMP_NO, 8, 1) IN (1, 3)
                    THEN SALARY ELSE 0 END), 0) '남사원 급여 합계',
        # 주민번호가 2, 4인 경우에는 급여를 더한다. 그렇지 않으면 0을 더한다. 그리고 소수점 자리는 0. 따라서 천단위로 구분
        FORMAT(SUM(
                    CASE WHEN SUBSTR(EMP_NO, 8, 1) IN (2, 4)
                    THEN SALARY ELSE 0 END), 0) '여사원 급여 합계'
  FROM
        EMPLOYEE;

/*
        ---------------- 출력 예시 -------------------
        `남사원 급여 합계`         `여사원 급여 합계`
        ----------------------------------------------
         49,760,000                24,816,240
    */

-- 5.  [EMPLOYEE] 테이블에서 사원들이 속해있는 부서의 수를 조회
-- (NULL은 제외하고, 중복된 부서는 하나로 카운팅)
SELECT
        # COUNT 함수는 NULL을 자동으로 제외, DISTINCT도 마찬가지로 중복 비교 대상이 아님
        COUNT(DISTINCT DEPT_CODE) '부서 수'
  FROM
        EMPLOYEE;

SELECT
        COUNT(DISTINCT DEPT_CODE) '부서 수'
  FROM
        EMPLOYEE
 WHERE
        DEPT_CODE IS NOT NULL;
# 둘 다 같은 결과

    /*
        ------ 출력 예시 -------
        `부서 수`
        ------------------------
        6
    */

-- (NULL은 제외하고, 중복된 부서는 하나로 카운팅)