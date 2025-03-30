use empdb;

-- 1. employee 테이블에서 이름 끝이 연으로 끝나는 사원의 이름을 출력하시오
SELECT
        *
  FROM
        EMPLOYEE;

SELECT
        EMP_NAME
  FROM
        EMPLOYEE
 WHERE
        EMP_NAME LIKE '%연';

/*
    출력

    차태연
    전지연

*/

-- 2. employee 테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호를 출력하시오
SELECT
        *
  FROM
        EMPLOYEE;

SELECT
        EMP_NAME,
        PHONE
  FROM
        EMPLOYEE
 WHERE
        PHONE NOT LIKE '%010%';

/*
    출력
    심봉선 0113654485
    윤은해 0179964233
    하동운 01158456632
*/

-- 3. employee 테이블에서 메일주소 '_'의 앞이 4자이면서,
-- DEPT_CODE가 D9 또는 D5이고
-- 고용일이 90/01/01 ~ 01/12/31이면서,
-- 월급이 270만원 이상인 사원의 전체 정보를 출력하시오
SELECT
        *
  FROM
        EMPLOYEE;

SELECT
        *
  FROM
        EMPLOYEE
 WHERE
        EMAIL LIKE '____\_%' # escape문자 : \% - %를 문자로만 인지
    AND
        DEPT_CODE IN ('D9', 'D5')
    AND
        HIRE_DATE BETWEEN '90/01/01' AND '01/12/31'
    AND
        SALARY >= 2700000;
# AND가 OR 보다 우선순위가 높기 때문에 IN 대신 OR를 쓸 경우에는 괄호를 해줘야 명확한 결과를 가져올 수 있음.

/*
    출력
    201 송종기 631126-1548654 song_jk@ohgiraffers.com 01045686656 D9 J2 S1 6000000  200 2001-09-01 00:00:00 N
*/

-- 4. employee테이블에서 현재 근무중인 사원을 이름 오름차순으로 정렬해서 출력.
SELECT
        *
  FROM
        EMPLOYEE;

SELECT
        EMP_ID,
        EMP_NAME
  FROM
        EMPLOYEE
 WHERE
        QUIT_YN = 'N' # 근무중인 사원이기 때문에 N을 사용 : 현재 근무중
 ORDER BY
        EMP_NAME ASC; # ASC 오름차순이 Default

/*
    출력 (23 row)
    223,고두밋
    208,김해술
    ...
*/

-- 5. 사원별 입사일, 퇴사일, 근무기간(일)을 조회하세요. 퇴사자 역시 조회되어야 합니다.
SELECT
        *
  FROM
        EMPLOYEE;

SELECT
        EMP_NAME,
        HIRE_DATE 입사일,
        QUIT_DATE 퇴사일,
        DATEDIFF(IFNULL(QUIT_DATE, now()), HIRE_DATE) '근무기간(일)',
        QUIT_YN
  FROM
        EMPLOYEE;


/* 출력 (24 row)
    선동일 1990-02-06 00:00:00  12488 N
    송종기 2001-09-01 00:00:00  8263  N
    노옹철 2001-01-01 00:00:00  8506  N
    송은희 1996-05-03 00:00:00  10210 N
    ...

*/

-- 6. 재직 중이고 휴대폰 마지막 자리가 2인 직원 중 입사일이 가장 최근인 직원 3명의 사원번호,
-- 직원명, 전화번호, 입사일, 퇴직여부를 출력하세요.
-- 참고. 퇴사한 직원은 퇴직여부 컬럼값이 ‘Y’이고, 재직 중인 직원의 퇴직여부 컬럼값은 'N'
SELECT
        *
  FROM
        EMPLOYEE;

SELECT
        EMP_ID 사원번호,
        EMP_NAME 직원명,
        HIRE_DATE 입사일,
        QUIT_YN 퇴직여부
  FROM
        EMPLOYEE
 WHERE
        PHONE LIKE '%2'
   AND
        QUIT_YN <> 'Y'
 ORDER BY
        HIRE_DATE DESC
        LIMIT 3;

/*
    출력결과
    216	차태연	01064643212	2013-03-01 00:00:00	N
    211	전형돈	01044432222	2012-12-12 00:00:00	N
    206	박나라	01096935222	2008-04-02 00:00:00	N
*/

-- 7. <1단계> 전체 직원 중 연결된 관리자가 있는 직원의 인원을 출력하세요.
-- 참고. 연결된 관리자가 있다는 것은 관리자사번이 NULL이 아님을 의미함
SELECT
        *
  FROM
        EMPLOYEE;

SELECT
        COUNT(*)
  FROM
        EMPLOYEE
 WHERE
        MANAGER_ID IS NOT NULL
 ORDER BY
        EMP_NAME DESC;

/*
    출력
    16
*/


