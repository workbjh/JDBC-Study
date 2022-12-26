CREATE TABLE `MEMBER` (
	`USER_ID`	VARCHAR(36 )	NOT NULL primary key COMMENT '회원 아이디',
	`PASSWORD`	VARCHAR(70)	NOT NULL	COMMENT '회원 비밀번호',
	`EMAIL`	VARCHAR(50 )	NOT NULL	COMMENT '회원 이메일',
	`GRADE`	CHAR(50 )	NULL	DEFAULT 'ROLE_USER'	COMMENT '회원 등급',
	`TELL`	VARCHAR(15 )	NULL	COMMENT '회원 전화번호',
	`IS_LEAVE`	bool	NOT NULL	DEFAULT false	COMMENT '탈퇴여부',
	`REG_DATE`	TIMESTAMP	NULL	DEFAULT now(),
	`RENTABLE_DATE`	timestamp	NULL	DEFAULT now()
);

CREATE TABLE `BOOK` (
	`BK_IDX`	int	NOT NULL auto_increment primary key COMMENT '도서번호',
	`ISBN`	VARCHAR(36 )	NULL	COMMENT 'ISBN코드',
	`CATEGORY`	CHAR(4 )	NULL	COMMENT '도서카테고리',
	`TITLE`	VARCHAR(100 )	NOT NULL	COMMENT '도서명',
	`AUTHOR`	VARCHAR(36 )	NOT NULL	COMMENT '저자',
	`INFO`	VARCHAR(36 )	NULL	COMMENT '도서설명',
	`BOOK_AMT`	int	NULL	DEFAULT 0	COMMENT '도서재고',
	`REG_DATE`	timestamp	NULL	DEFAULT now()	COMMENT '도서등록일자',
	`RENT_CNT`	int	NULL	DEFAULT 0	COMMENT '대출횟수'
);

CREATE TABLE `RENT_BOOK` (
	`RB_IDX`	int	NOT NULL auto_increment primary key	COMMENT '대출도서번호',
	`RM_IDX`	int	NOT NULL	COMMENT '대출번호',
	`BK_IDX`	int	NOT NULL	COMMENT '도서번호',
	`REG_DATE`	timestamp	NULL	DEFAULT now()	COMMENT '대출일자',
	`STATE`	VARCHAR(36)	NULL	DEFAULT 'RE00'	COMMENT '대출도서상태',
	`RETURN_DATE`	timestamp	NULL	COMMENT '반납(예정)일자',
	`EXTENSION_CNT`	int	NULL	DEFAULT 0	COMMENT '연장횟수'
);

CREATE TABLE `FILE_INFO` (
	`FL_IDX`	int	NOT NULL auto_increment primary key	COMMENT '파일번호',
	`ORIGIN_FILE_NAME`	VARCHAR(36)	NOT NULL	COMMENT '원본파일명',
	`RENAME_FILE_NAME`	VARCHAR(36 )	NOT NULL	COMMENT '저장파일명',
	`SAVE_PATH`	VARCHAR(255 )	NOT NULL	COMMENT '저장경로',
	`REG_DATE`	timestamp	NULL	DEFAULT now()	COMMENT '파일등록일자',
	`IS_DEL`	bool	NULL	DEFAULT 0	COMMENT '삭제여부',
	`BD_IDX`	int	NOT NULL	COMMENT '게시글번호'
);

CREATE TABLE `BOARD` (
	`BD_IDX`	int	NOT NULL auto_increment primary key	COMMENT '게시글번호',
	`USER_ID`	VARCHAR(36 )	NOT NULL	COMMENT '작성자',
	`REG_DATE`	timestamp	NOT NULL	DEFAULT now()	COMMENT '등록일자',
	`TITLE`	VARCHAR(50)	NOT NULL	COMMENT '제목',
	`CONTENT`	VARCHAR(10000 )	NOT NULL	COMMENT '게시글내용',
	`IS_DEL`	bool	NULL	DEFAULT 0	COMMENT '삭제여부'
);

CREATE TABLE `RENT_HISTORY` (
	`RH_IDX`	int	NOT NULL auto_increment primary key	COMMENT '대출이력번호',
	`RM_IDX`	int	NOT NULL	COMMENT '대출번호',
	`RB_IDX`	int	NOT NULL	COMMENT '대출도서번호',
	`BK_IDX`	int	NULL	COMMENT '도서번호',
	`REG_DATE`	timestamp	NULL	DEFAULT now()	COMMENT '이력등록일자',
	`STATE`	CHAR(4 )	NULL	COMMENT '대출상태'
);

CREATE TABLE `RENT_MASTER` (
	`RM_IDX`	int	NOT NULL auto_increment primary key	COMMENT '대출번호',
	`USER_ID`	VARCHAR(36 )	NOT NULL	COMMENT '회원 아이디',
	`REG_DATE`	timestamp	NULL	DEFAULT now()	COMMENT '대출일자',
	`IS_RETURN`	bool	NULL	DEFAULT 0	COMMENT '반납여부',
	`TITLE`	VARCHAR(50)	NOT NULL	COMMENT '대출건제목',
	`RENT_BOOK_CNT`	int	NOT NULL	COMMENT '대출도서권수'
);

CREATE TABLE `CODE` (
	`CODE`	VARCHAR(4 )	NOT NULL	COMMENT '코드',
	`UPPER_CODE`	VARCHAR(4 )	NULL	COMMENT '상위코드',
	`INFO`	VARCHAR(100 )	NULL	COMMENT '설명'
);

CREATE TABLE `MEMBER_INFO` (
	`MI_IDX`	int	NOT NULL auto_increment primary key	COMMENT '회원로그번호',
	`USER_ID`	VARCHAR(36 )	NOT NULL	COMMENT '회원 아이디',
	`REG_DATE`	timestamp	NULL	DEFAULT now()	COMMENT '가입일자',
	`LOGIN_DATE`	timestamp	NOT NULL	COMMENT '마지막로그인일자',
	`MODIFY_DATE`	timestamp	NOT NULL	COMMENT '마지막수정일자',
	`LEAVE_DATE`	timestamp	NULL	COMMENT '탈퇴일자',
	`RENTABLE_DATE`	timestamp	NULL	DEFAULT now()	COMMENT '대출가능일자'
);






ALTER TABLE `RENT_BOOK` ADD CONSTRAINT `FK_RENT_MASTER_TO_RENT_BOOK_1` FOREIGN KEY (
	`RM_IDX`
)
REFERENCES `RENT_MASTER` (
	`RM_IDX`
);

ALTER TABLE `RENT_BOOK` ADD CONSTRAINT `FK_BOOK_TO_RENT_BOOK_1` FOREIGN KEY (
	`BK_IDX`
)
REFERENCES `BOOK` (
	`BK_IDX`
);

ALTER TABLE `FILE_INFO` ADD CONSTRAINT `FK_BOARD_TO_FILE_INFO_1` FOREIGN KEY (
	`BD_IDX`
)
REFERENCES `BOARD` (
	`BD_IDX`
);

ALTER TABLE `BOARD` ADD CONSTRAINT `FK_MEMBER_TO_BOARD_1` FOREIGN KEY (
	`USER_ID`
)
REFERENCES `MEMBER` (
	`USER_ID`
);

ALTER TABLE `RENT_HISTORY` ADD CONSTRAINT `FK_RENT_MASTER_TO_RENT_HISTORY_1` FOREIGN KEY (
	`RM_IDX`
)
REFERENCES `RENT_MASTER` (
	`RM_IDX`
);

ALTER TABLE `RENT_HISTORY` ADD CONSTRAINT `FK_RENT_BOOK_TO_RENT_HISTORY_1` FOREIGN KEY (
	`RB_IDX`
)
REFERENCES `RENT_BOOK` (
	`RB_IDX`
);

ALTER TABLE `RENT_MASTER` ADD CONSTRAINT `FK_MEMBER_TO_RENT_MASTER_1` FOREIGN KEY (
	`USER_ID`
)
REFERENCES `MEMBER` (
	`USER_ID`
);

ALTER TABLE `MEMBER_INFO` ADD CONSTRAINT `FK_MEMBER_TO_MEMBER_INFO_1` FOREIGN KEY (
	`USER_ID`
)
REFERENCES `MEMBER` (
	`USER_ID`
);

