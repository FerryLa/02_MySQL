-- ==============
-- INDEX
-- ==============
-- 인덱스(Index)는 데이터 검색 속도를 향상시키는 데이터 구조로 데이터를 빠르게 조회할 수 있는 포인터를 제공한다.
-- 데이터베이스에서 데이터를 찾을 때 전체 테이블을 검색하는 대신 인덱스를 통해 검색을 하므로 속도가 더 빨라지게 된다.
-- 인덱스는 주로 WHERE절의 조건이나 JOIN 연산에 사용되는 컬럼에 생성한다.
-- 다만 인덱스도 데이터 저장 공간을 차지하고 데이터가 변경될 때마다 인덱스 역시 갱신해야 하기 때문에 어떤 컬럼에 인덱스를 생성할지는 신중히 결정해야 한다.

CREATE TABLE phone
(
    phone_code  INT PRIMARY KEY,
    phone_name  VARCHAR(100),
    phone_price DECIMAL(10, 2)
);

INSERT INTO
    phone (phone_code, phone_name, phone_price)
VALUES
    (1, 'galaxyS23', 1200000)
  , (2, 'iPhone14pro', 1433000)
  , (3, 'galaxyZfold3', 1730000);

SELECT *
  FROM
      phone;

SELECT *
  FROM
      phone
 WHERE
     phone_name = 'galaxyS23';

EXPLAIN
SELECT *
  FROM
      phone
 WHERE
     phone_name = 'galaxyS23';

-- phone_name에 index 추가하기
CREATE INDEX idx_name ON phone (phone_name);

SELECT *
  FROM
      phone
 WHERE
     phone_name = 'galaxyS23';

EXPLAIN
SELECT *
  FROM
      phone
 WHERE
     phone_name = 'galaxyS23';

-- index 삭제
DROP INDEX idx_name ON phone;