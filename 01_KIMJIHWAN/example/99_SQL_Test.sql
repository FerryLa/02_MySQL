use empdb;

SELECT * FROM employee;

-- 날짜별
SELECT HIRE_DATE, COUNT(*)
  FROM employee
GROUP BY HIRE_DATE
ORDER BY HIRE_DATE;


SELECT HIRE_DATE, COUNT(*)
FROM employee
GROUP BY HIRE_DATE WITH ROLLUP
ORDER BY HIRE_DATE;

GRANT SELECT, INSERT ON employee TO user1;

CREATE TABLE PRODUCT
( PROD_ID VARCHAR2(10) NOT NULL
    ,PROD_NM VARCHAR2(100) NOT NULL
    ,REG_DT DATE NOT NULL
    ,REGR_NO NUMBER(10)
    ,CONSTRAINT PRODUCT_PK PRIMARY KEY (PROD_ID) );