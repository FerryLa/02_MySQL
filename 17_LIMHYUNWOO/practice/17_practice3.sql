use empdb;

-- 1. EMPLOYEE 테이블에서 여자사원의 급여 총 합을 계산
SELECT
       SUM(A.SALARY) "급여 총 합"
  FROM EMPLOYEE A
 WHERE
     A.EMP_NO LIKE '_______2%';
    /*
        ---------- 출력 예시 ------------
        `급여 총 합`
        ---------------------------------
        24816240
    */


-- 2. 부서코드가 D5인 사원들의 급여총합, 보너스 총합 조회
SELECT
       FORMAT(SUM(A.SALARY),0) "급여총합"
     , FORMAT(SUM(A.SALARY*A.BONUS),0) "보너스 총합"
  FROM EMPLOYEE A
  JOIN DEPARTMENT B ON A.DEPT_CODE = B.DEPT_ID
 WHERE
    B.DEPT_ID = 'D5';
    /*
        ------- 출력 예시 ------------
        급여총합        `보너스 총합`
        ------------------------------
        15,760,000      745,000
    */


-- 3. 부서코드가 D5인 직원의 보너스 포함 연봉의 총합 을 계산
SELECT
       FORMAT(SUM(A.SALARY*12+(A.SALARY*12*IFNULL(A.BONUS,0))),0)
  FROM EMPLOYEE A
  JOIN DEPARTMENT B ON A.DEPT_CODE = B.DEPT_ID
 WHERE
    B.DEPT_ID = 'D5';
    /*
        ------- 출력 예시 ----------
        연봉
        ----------------------------
        198,060,000
    */




-- 4. 남/여 사원 급여합계를 동시에 표현(가공된 컬럼의 합계)
SELECT
       SUM()
  FROM EMPLOYEE A
 WHERE
     EMP_NO LIKE '_______1%'
    OR
     EMP_NO LIKE '_______3%'


    /*
        ---------------- 출력 예시 -------------------
        `남사원 급여 합계`         `여사원 급여 합계`
        ----------------------------------------------
         49,760,000                24,816,240
    */



-- 5.  [EMPLOYEE] 테이블에서 사원들이 속해있는 부서의 수를 조회
-- (NULL은 제외하고, 중복된 부서는 하나로 카운팅)

    /*
        ------ 출력 예시 -------
        `부서 수`
        ------------------------
        6
    */

-- (NULL은 제외하고, 중복된 부서는 하나로 카운팅)
