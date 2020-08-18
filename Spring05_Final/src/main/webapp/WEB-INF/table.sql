CREATE TABLE board_cafe(
	num NUMBER PRIMARY KEY,
	writer VARCHAR2(100) NOT NULL,
	title VARCHAR2(100) NOT NULL,
	content CLOB, -- smartEditor 문자열
	viewCount NUMBER, --조회수  
	regdate DATE
);


SELECT result1.*
FROM
	(SELECT NUM, WRITER, TITLE,
	LEAD(num, 1, 0) OVER (ORDER BY num DESC) AS prevNum,
	Lag(num, 1, 0) OVER (ORDER BY num DESC) AS nextNum
	FROM BOARD_CAFE) RESULT1
WHERE num=54;


	SELECT NUM, WRITER, TITLE,
	LEAD(num, 1, 0) OVER (ORDER BY num DESC) AS nextNum,--번호에 대해서 내림차순 정렬 했을 때 하나 앞선다. 다음글
	Lag(num, 1, 0) OVER (ORDER BY num DESC) AS prevNum,--번호에 대해서 내림차순 정렬 했을 때 하나 뒤에꺼. 이전글
	FROM BOARD_CAFE 
	ORDER BY NUM DESC;




CREATE SEQUENCE board_cafe_seq;

-- 시퀀스를 활용해서 글 번호를 미리 가져와서 INSERT 할 때 집어넣는다.
--댓글
-- ref_group 글 번호와 COMMENT GROUP 번호가 다르면 들여쓰기 한다.
CREATE TABLE board_cafe_comment(
	num NUMBER PRIMARY KEY, -- 댓글의 글번호
	writer VARCHAR2(100), -- 댓글 작성자의 아이디
	content VARCHAR2(500), --댓글 내용
	target_id VARCHAR2(100), -- 댓글의 대상자의 아이디
	ref_group NUMBER, --원글의 몇번의 글번호인지 comment_group, REF-GROUP으로 댓글을 구현한다.
	comment_group NUMBER, --댓글 안 에서의 그룹, 대댓글까지의 댓글이 하나의 그룹이다. //12번이라면 대댓글 까지 다 12번 최초 존재했었던 댓글의 번호를 따라 간다.
	deleted CHAR(3) DEFAULT 'no', -- 삭제 됐는지의 여부, ROW를 삭제하는게 아닌 삭제됐으면 DEFAULT값에 YES를 집어넣는다.
	regdate DATE
);

create sequence board_cafe_comment_seq;
SELECT *
FROM(SELECT RESULT1.*, ROWNUM AS RNUM
	 FROM(SELECT * FROM board_file
	 	  ORDER BY num DESC) RESULT1);
	 	  -- 
WHERE RNUM BETWEEN 1 AND 5;
-- 6 AND 10 (2PAGE), 11 AND 15(3PAGE)  


CREATE TABLE board_gallery(
	num NUMBER PRIMARY KEY,
	writer VARCHAR2(100),
	caption VARCHAR2(100),
	imagePath VARCHAR2(100),
	regdate DATE 
);

CREATE SEQUENCE board_gallery_seq;

--upload된 파일의 정보를 저장 할 테이블
CREATE TABLE board_file(
	num NUMBER PRIMARY KEY,
	writer VARCHAR2(100) NOT NULL,
	title VARCHAR2(100) NOT NULL,
	orgFileName VARCHAR2(100) NOT NULL, -- 원본 파일 명
	saveFileName VARCHAR2(100) NOT NULL, --서버에 실제로 저장된 파일 명
	
	--왜 두개로 관리하냐 클라이언트가 업로드 하는 파일을 하나의 폴더에다 저장하면 똑같은 파일명이 나올 수 있게 때문에
	--파일명이 겹치지 않도록 파일명을 바꿔서 저장 할 것
	fileSize NUMBER NOT NULL,
	regdate DATE
);

CREATE SEQUENCE board_file_seq;

--null 이면 기본 이미지 아니면 이미지 경로 저장

-- 사용자(회원) 정보를 저장할 테이블
CREATE TABLE users(
	id VARCHAR2(100) PRIMARY KEY,
	pwd VARCHAR2(100) NOT NULL,
	email VARCHAR2(100), 
	profile VARCHAR2(100), -- 프로필 이미지 경로를 저장할 칼럼
	regdate DATE
);
