-- BIT_LENGTH: 비트 크기
-- CHAR_LENGTH: 문자열의 길이
-- LENGTH: 바이트 크기
SELECT menu_name, BIT_LENGTH(menu_name), CHAR_LENGTH(menu_name), LENGTH(menu_name)
FROM tbl_menu;

-- CONCAT: 문자열을 이어붙임
-- CONCAT_WS: 구분자와 함께 문자열을 이어붙임
SELECT CONCAT('호랑이', '기린', '원숭이');
SELECT CONCAT_WS(',', '호랑이', '기린', '원숭이');
SELECT CONCAT_WS('-', '2025', '03', '21');

-- ELT(위치, 문자열1, 문자열2, ...), FIELD(찾을 문자열, 문자열1, 문자열2, ...)
-- FIELD: 찾을 문자열 위치 반환
-- ELT: 해당 위치의 문자열 반환
SELECT ELT(2, '사과', '딸기', '바나나'),
       FIELD('딸기', '사과', '딸기', '바나나');

-- FIND_IN_SET(찾을 문자열, 문자열 리스트)
-- FIND_IN_SET: 찾을 문자열의 위치 반환, 문자열 리스트의 구분자는 반드시 ,여야 한다.
SELECT FIND_IN_SET('바나나', '사과,딸기,바나나');

-- ORDER BY에서 특정 레코드를 끌어올리기 위한 용도로도 사용 가능
SELECT *
FROM tbl_menu
ORDER BY FIND_IN_SET(menu_code, 12) DESC,
         FIND_IN_SET(menu_code, 16) DESC;

-- INSTR(string, substring)                 string에서 substring이 처음 나타나는 위치를 반환
-- LOCATE(substring, string [, position])	string에서 substring이 처음 나타나는 위치를 반환, position을 지정하면 해당 위치 이후부터 검색
SELECT INSTR('사과딸기바나나딸기', '딸기'),
       LOCATE('딸기', '사과딸기바나나딸기', 5);
-- 출력: 3, 8

-- FORMAT(숫자, 소수점 자릿수)
-- FORMAT: 1000단위마다 콤마(,) 표시를 해 주며 소수점 아래 자릿수(반올림)까지 표현한다.
-- FORMAT(number, decimal_places)
SELECT FORMAT(123412341321321.5164465, 3);
SELECT menu_code, FORMAT(menu_price, 0) 단위
FROM tbl_menu;

-- INSERT(기준 문자열, 위치, 길이, 삽입할 문자열)
-- INSERT: 기준 문자열의 위치부터 길이만큼을 지우고 삽입할 문자열을 끼워 넣는다.
SELECT INSERT('내 이름은 아무개 입니다.', 7, 3, '이석진');

SELECT INSERT(menu_name, INSTR(menu_name, '쥬스'), 2, 'JUICE')
FROM tbl_menu
WHERE menu_name LIKE '%쥬스%';

-- UPPER(문자열), LOWER(문자열)
-- UPPER: 소문자를 대문자로 변경
-- LOWER: 대문자를 소문자로 변경
SELECT LOWER('Hello World'), UPPER('Hello World');

-- LPAD(문자열, 길이, 채울 문자열), RPAD(문자열, 길이, 채울 문자열)
-- LPAD: 문자열을 길이만큼 왼쪽으로 늘린 후에 빈 곳을 문자열로 채운다.
-- RPAD: 문자열을 길이만큼 오른쪽으로 늘린 후에 빈 곳을 문자열로 채운다.
SELECT LPAD('왼쪽', 6, '@'), RPAD('오른쪽', '6', '@'), RPAD('881122-1', 14, '*');

-- LTRIM(문자열), RTRIM(문자열)
-- LTRIM: 왼쪽 공백 제거
-- RTRIM: 오른쪽 공백 제거
SELECT LTRIM('      왼쪽'), RTRIM('오른쪽      ');

-- TRIM(문자열), TRIM(방향 자를_문자열 FROM 문자열)
-- TRIM은 기본적으로 앞뒤 공백을 제거하지만
-- 방향(LEADING(앞), BOTH(양쪽), TRAILING(뒤))이 있으면
-- 해당 방향에 지정한 문자열을 제거할 수 있다.
SELECT TRIM('     MySQL    '), TRIM(BOTH '@' FROM '@@@@MySQL@@@@@');

-- REPEAT(문자열, 횟수)
-- REPEAT: 문자열을 횟수만큼 반복
SELECT REPEAT('집가고십다', 100);