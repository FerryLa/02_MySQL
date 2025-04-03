use empdb;

-- 1. EMPLOYEE 테이블에서 직급이 J1을 제외하고, 직급별 사원수 및 평균급여를 출력하세요.
SELECT
        *
  FROM
        EMPLOYEE;

SELECT
        JOB_CODE 직급코드,
        COUNT(JOB_CODE) '직급별 사원수',
        TRUNCATE(AVG(SALARY), 0) 평균급여
  FROM
        EMPLOYEE
 WHERE
        # J1을 뺀 나머지 (!=, <> 가능)
        JOB_CODE <> 'J1'
        # JOB_CODE != 'J1'
 GROUP BY
        JOB_CODE
 ORDER BY
        JOB_CODE ASC;

    /*
        --------------- 출력 예시 -------------
        직급코드  `직급별 사원수`      평균급여
        ----------------------------------------
            J2           3              4726666
            J3           3              3600000
            J4           4              2330000
            J5           3              2820000
            J6           6              2624373
            J7           4              2017500

    */

-- 2. EMPLOYEE테이블에서 직급이 J1을 제외하고, 입사년도별 인원수를 조회해서, 입사년 기준으로 오름차순 정렬하세요.
-- (select에는 groupby절에 명시한 컬럼만 작성가능)
SELECT
        *
  FROM
        EMPLOYEE;

SELECT
        # HIRE_DATE에서 연도만 추출
        EXTRACT(YEAR FROM HIRE_DATE) 입사년,
        COUNT(HIRE_DATE) 인원수
  FROM
        EMPLOYEE
 WHERE
        JOB_CODE <> 'J1'
 GROUP BY
        EXTRACT(YEAR FROM HIRE_DATE)
 ORDER BY
        EXTRACT(YEAR FROM HIRE_DATE) ASC;

    /*
        ---- 출력 예시 -------
        입사년          인원수
        ----------------------
        1994             3
        1996             1
        1997             1
        1999             3
        2000             1
        2001             3
        ...
        총 출력row는 17

    */

-- 3. 성별 급여의 평균(정수처리), 급여의 합계, 인원수를 조회한 뒤 인원수로 내림차순을 정렬 하시오.
SELECT
        *
  FROM
        EMPLOYEE;

SELECT
        # 주민번호 8번째 숫자 하나를 추출. 그리고 그 숫자가 1 또는 3이면 '남'으로 추출.
        CASE SUBSTR(EMP_NO, 8, 1)
        WHEN 1 THEN '남'
        WHEN 3 THEN '남'
        ELSE '여'
        END 성별,

        # 급여의 평균을 구하고 쉼표 추가, 소수점도 제거. 쉼표는 천단위로 추가
        FORMAT((AVG(SALARY)), 0) 평균,
        FORMAT(SUM(SALARY), 0) 합계,
        COUNT(*) 인원수
  FROM
        EMPLOYEE
 GROUP BY
        CASE SUBSTR(EMP_NO, 8, 1)
        WHEN 1 THEN '남'
        WHEN 3 THEN '남'
        ELSE '여'
        END
 ORDER BY
        성별 ASC;

    /*
        ------------------- 출력 예시 -------------------
        셩별          평균          합계          인원수
        -------------------------------------------------
        남       "3,317,333"     "49,760,000"       15
        여       "2,757,360"     "24,816,240"       9
    */


-- 4. 직급별 인원수가 3명이상이 직급과 총원을 조회
SELECT
        *
  FROM
        EMPLOYEE;

# 집계합수는 where절에서 불가, 반드시 Having에서 사용
SELECT
        JOB_CODE 직급,
        COUNT(JOB_CODE) 인원수
  FROM
        EMPLOYEE
 WHERE
        JOB_CODE != 'J1'
 GROUP BY
        JOB_CODE
HAVING
        COUNT(JOB_CODE) >= 3;

    /*
        ------------ 출력 예시 ---------------
        직급          인원수
        -------------------------------------
        J2              3
        J3              3
        J4              4
        J5              3
        J6              6
        J7              4
    */
