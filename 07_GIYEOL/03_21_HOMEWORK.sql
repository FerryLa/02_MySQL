-- 1 0


-- 2. 0
select
    emp_name,
    phone
from
   employee
where
    phone
not like '010%' ;
-- 3
select *
  /*  employee_mailadd     -- select * from tbl_empdb
,   DEPT_CODE */
from
    employee
where
    (email
    like '____')   -- where (empdb_mail like '____\_%)
  and
    (DEPT_CODE = '9일차') or (DEPT_CODE= '5일차')
  between
    (hire_date between '90/01/01' and '01/12/31') -- and
  and
    salary >= 270; -- empdb_money >= 270000;
-- 4
select
   *   -- select * from tbl_empdb
from
    employee
where
    QUIT_Yn = 'N'  -- quit_yn ='N' 퇴사일이 N으로 표현된 것
order by  emp_name;
-- 5
select
    emp_name          -- hire_date 입사일,
    hire_date입사일,  -- quit_date 퇴사일
    quit_date 퇴사일,         -- dateddiff(ifnull(quit_data,now()),
    datediff(ifnull(quit_date,now()),employee.HIRE_DATE)       -- hire_date) '근무기간 (일)',
     '근무기간(일)'                      -- quit_yn
from                       -- where tbl_empdb;
    employee;

-- 6
select
    EMP_ID,
    EMP_NAME,
    PHONE,
    HIRE_DATE,
    QUIT_YN
from
    employee
where
    PHONE LIKE '%2'
and
    QUIT_YN <> 'y'
ORDER BY
    HIRE_DATE -- ??(설명)
LIMIT  3;
-- 7
select
count(*)   --  employee_name,  -- COUNT(*) from tbl_empdb
   -- employee_grde   -- where MANFER_ID IS NOT NULL
from                -- ORDER BY EMP_NAME;
   employee
where
    MANAGER_ID is not null
order by
    EMP_NAME;
-- 02.1
select
    emp_id 사원번호,
    emp_name 성명,
    concat(substr(emp_no,1,8),'******')주민번호,   -- concat(substr(emp_no,1,8),'****')주민번호
    rpad(substr(emp_no,1,8),14,) 주민번호'*',
    format(급여(급여 ifnull(보너스,+*0)))*12,0) 연봉
                    -- rpad(substr(emp_no,1,8),14,) 주민번호'*'
from                -- format(급여(급여 ifnull(보너스,+*0)))*12,0) 연봉
    employee
where                              -- where
    substr(emp_no,8,1)안으로 ('1','3'); -- substr(emp_no,8,1)안으로 ('1','3');
-- 2
select
    emp_name,
    substring_index(email,, '@'1) email_id
  /*  emp_name,
    emp_id  */-- substring_index(이메일,,'@'1) email_id
from
   employee;

-- 3
CREATE TABLE tbl_files (
                           file_no BIGINT,
                           file_path VARCHAR(500)
);
-- drop table tbl_files
INSERT INTO tbl_files VALUES(1, 'c:\\abc\\deft\\salesinfo.xls');
INSERT INTO tbl_files VALUES(2, 'c:\\music.mp3');
INSERT INTO tbl_files VALUES(3, 'c:\\documents\\resume.hwp');
COMMIT;
SELECT * FROM tbl_files;

-- 4
select
    file_no 파일번호,
    substring_index(file_path, , '\\'-1) as "파일명"
from tbl_files;


-- 03.1
select
    sum(salary)'급여 총 합'         -- sum(급여) '급여 총 합'
from
    employee
where
    substr(emp_no,8,1) in('2','4');  -- substr(emp_no,8,1) 아느로 ('2','4');
-- 2
select
  format(sum(salary),0) 급여총합,
  format(sum(salary*ifnull(bonus,0)),0)보너스총합
   -- empdb_money, -- sum(급여),0) 급여총합,
   -- empdb_specail -- sum(급여 ifnull(보너스,*0)),0)"보너스 총합"
from employee
where
    DEPT_CODE ='D5';
   /* empdb_money      -- dept_code ='5일차';
group by
    sum(empdb_code = 5); */
-- 3
select
    format(sum(salary + (salary * ifnull(bonus,0))*12),0)as 연봉
   -- empdb_code -- sum((급여(급여 ifnull(보너스,+*0)))*12),0) as 연봉
from
    employee
where
    DEPT_CODE ='D5';
 -- group by
    -- empdb_code = 5;  -- ='5일차';
-- 4
select
    format(sum(case when substr(emp_no,8,1)in (1,3)then employee.SALARY else 0 end),0)"남사원급여",
    format(sum(case when substr(emp_no,8,1)in (2,4)then employee.SALARY else 0 end),0)"여사원급여"
from employee;
   /* empdb_money,                  -- (sum(substr(emp_no,8,1)in(1,3) next money else 0 end),0) "남자급여",
    sum(man) as '남사원 급여 합계', -- (sum(substr(emp_no,8,1)in(2,4) next money else 0 end),0) "여자급여"
    sum(woman) as '여사원 급여 합계'
from
        tbl_empdb   -- ;
group by
    empdb_money = man; */

-- 5
select
    count(distinct  DEPT_CODE) "부서 수"
    -- empdb_part,      -- count(dept_code)"부서 수" //null은 자동 제외
    -- count(empdb_part)
from
   employee;
   -- group by
   --  empdb_part is not null;
-- 04.01
select
    JOB_CODE 직급코드,
    count(JOB_CODE)'직급별 사원수',
    truncate(avg(SALARY),0)평균급여
from
    employee
where
    JOB_CODE <> 'j1'
group by
    JOB_CODE
order by
    JOB_CODE;
/* select
    empdb_code,   -- job_code 직급코드,
    empdb_part,   -- count(job_code)'직급별 사원수',
    empdb_money = avg(*) as '평균급여' -- cut(avg(급여),0) 평균급여
from
        employee     -- where job_code is not 'j1'
group by              -- group by job_code
    empdb_code is not like '%j1'; -- order by job_code; */
-- 2
/* select
    empdb_year,  -- (year from hire_date) 입사년,
    empdb_people  -- count(*) 인원수 // null 포함
from
    employee  -- where job_code is not 'j1'
group by       -- group by 추출물(year from hire_date)
    empdb_year asc; -- order by hire_code; */
-- 3
/* select
    empdb_maile,        -- case_substr(emp_no,8,1)
    sum(empdb_money), -- when 1 and '남' when 3 and '남' another '여'
    sum(empdb_people) -- end as 성별, (truncate(avg(급여),0),0) as 평균,
                      -- (sum(급여),0) as 합계, count(*) as 인원수
from
    employee
group by      -- case substr(emp_no,8,1)
    empdb_,maile -- when 1 and '남' when 3 and '남' another '여'end
having avg(empdb_maile='man',empdb_maile ='woman'); -- order by emp_people ; */
-- 4
/*select
    empdb_part,        -- ifnull(job_code,'총원') 직급,
    count(*) as '인원수'
from
    tbl_empdb
group by
    empdb_part ;  -- jpb_code
                  -- where
                  -- count(*) >=3
                  -- order by job_code; */



-- 조인 문제 1
/* select
    EMP_ID,
    EMP_NAME,
    PHONE,
    HIRE_DATE,
    QUIT_DATE
    from
        employee
where
    PHONE like '%2' between HIRE_DATE= 'Y' and
    quit_date = 'Y' or hire_date ='N';

-- 2
select
    EMP_NAME,
    SAL_LEVEL,
    SALARY,
    EMP_ID,
    EMAIL,
    HIRE_DATE
from
    employee
where
    (HIRE_DATE = 'Y') and (SAL_LEVEL ='대리')
order by
    SAL_LEVEL desc; */

-- 1
select
    EMP_ID 사원번호,
    EMP_NAME 사원명,
    PHONE 전화번호,
    HIRE_DATE 입사일,
    QUIT_yn 퇴직여부
from
    employee
where
    QUIT_YN = 'N' and
    PHONE like '%2'
order by
    hire_date desc
limit 3;

-- 2.
select
    a.EMP_NAME 사원명,
    b.job_name 직급명,
    a.SALARY 급여,
    a.EMP_no 주민번호,
    a.EMAIL 이메일,
    a.PHONE 전화번호,
    a.HIRE_DATE 입사일
from
    employee a
join job b on a.job_code =b.JOB_CODE
where
    a.QUIT_YN = 'N'
and
    b.JOB_name = '대리'
order by
    a.SALARY desc;
-- 3
select
    a.DEPT_CODE 부서명,
    a.EMP_ID 인원,
    a.SALARY 급여합계,
    a.SALARY 급여평균
    from
        employee a
join empdb.department d on a.DEPT_CODE = d.DEPT_ID
where
    SALARY = sum(*) '급여합계'
group by
    salary = avg(*) '급여평균';
-- 4
select
    a.EMP_NAME 사원명,
    a.EMP_NO 주민번호,
    a.PHONE 전화번호,
    d.dept_title 부서명,
    j.JOB_NAME 직급명
    from
        employee a
    join empdb.department d on a.DEPT_CODE = d.DEPT_ID
    join empdb.job j on a.JOB_CODE = j.JOB_CODE

order by
    HIRE_DATE;
-- 5
select
    date_add()
    from
        employee
-- 6
select
    a.EMP_NAME 사원명,
    a.EMP_NO 주민번호,
    d.dept_title 부서명,
    j.JOB_CODE 직급명
from
    employee a
   join empdb.department d on a.DEPT_CODE = d.DEPT_ID
    join empdb.job j on a.JOB_CODE = j.JOB_CODE
where
    a.EMP_NO like '70____%' and a.EMP_NAME like '%전';
-- 7??
select * from employee
where to_days();

-- 8 내가 한거
select
    a.EMP_NAME 사원명,
    j.JOB_name 직급명,
    a.DEPT_CODE 부서코드,
    k.LOCAL_CODE 부서명
from employee a
         join empdb.department d on a.DEPT_CODE = d.DEPT_ID
         join empdb.job j on a.JOB_CODE = j.JOB_CODE
     left join empdb.location k on a.JOB_CODE = k.LOCAL_CODE
where
    a.DEPT_CODE = 'D5' or
    a.DEPT_CODE ='D6';
/* SELECT 답?
    emp_name 사원명,
    job_name 직급명,
    dept_code 부서코드,
    dept_title 부서명
FROM
    employee
        JOIN department ON dept_code = dept_id
        JOIN job USING(job_code)
WHERE
    dept_title LIKE '해외영업%';
*/
-- 조인 2
-- 1

select
    EMP_ID 사번,
    EMP_NAME 사원명,
truncate(
    datediff(now(),
    concat(
    if(substr(EMP_NO,8,1)in (1,2),19,20),
    left(EMP_NO,6)
    )) /365,0) 나이,
    dept_title 부서명,
    job_name 직급명
    from
        employee
left join department on DEPT_CODE = DEPT_ID
left join job using (job_code)
order by
    나이
limit 1;

-- 2 이전 8번과 동일


SELECT
    emp_name 사원명,
    job_name 직급명,
    dept_code 부서코드,
    dept_title 부서명
FROM
    employee
        JOIN department
            ON dept_code = dept_id
        JOIN job USING(job_code)
WHERE
    dept_title LIKE '해외영업%'
-- 3
select
    EMP_NAME 사원명,
    BONUS 보너스포인트,
    dept_title 부서명,
    k.local_name 근무지역명
from
    employee
    join department on DEPT_CODE =DEPT_ID
    join job using (job_code)
    left join empdb.location k on JOB_CODE = k.LOCAL_CODE;
-- left join empdb.location k on JOB_CODE = k.LOCAL_CODE;를
-- left join location | on location_id = local_code 로 변경
-- where bouns is not null을 넣어야 null값이 나오지 않고 모두 출력

-- 4
select
    EMP_NAME 사원명,
    job_name 직급명,
    SALARY 급여,
    SAL_LEVEL 연봉,
    MAX_SAL 최대급여
from
employee
    left join department on DEPT_CODE = DEPT_ID
    left join job using (job_code)
    left join  sal_grade on employee.SAL_LEVEL = MAX_SAL
where
    max_sal = 29999999;
-- 5

