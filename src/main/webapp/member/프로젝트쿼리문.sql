/********************************
3차 프로젝트 - 웹사이트 만들기
******************************/
--system계정으로 접속한 후 새로운 계정을 등록한다.
alter session set "_ORACLE_SCRIPT"=true;
create user sua_project identified by 1234;
grant connect, resource, unlimited tablespace TO sua_project;

--접속창 -> +버튼을 눌러 등록
--등록이후 sua_project계정으로 연결한 후 작업 시작

--회원관리 테이블 생성

create table membership (
--id같은경우 primary key는 자동 not null이기에 not null을 기재하지않아도된다.
    id varchar2(30) primary key,
	pass varchar2(30) not null,
	name varchar2(30) not null,
    tel varchar2(15) not null,
    mobile varchar2(15) not null,
	email varchar2(100) not null,
	open_email varchar2(1),
	zipcode varchar2(5) not null,
	addr1 varchar2(100) not null,
	addr2 varchar2(200) not null

);

select * from membership;

--회원 레코드 입력하기
insert into membership values(
    'test','1234','테스트','02-1234-5678','010-1234-5678',
    'tj@naver','Y','12345','서울시 종로구','대왕빌딩9층'
);

commit;


SELECT COUNT(*) FROM membership WHERE id= 'test';
SELECT * FROM membership WHERE name= '홍길동' and email='hkd@naver.com';


--공지사항 보드 생성
--모델1 방식의 게시판 테이블 생성
create table noticeboard (
    num number primary key, --일련번호
    title varchar2(200) not null, --제목
    content varchar2(2000) not null, --내용
    id varchar2(50) not null, --작성자아이디
    postdate date default sysdate not null, --작성일
    ofile varchar2(200), /* 원본 파일명 */
    sfile varchar2(30), /* 서버에 저장된 파일명 */
    visitcount number default 0 not null --조회수
);

drop table noticeboard;

/* 외래키 설정
자식인 게시판 테이블의 id컬럼이 부모인 회원 테이블의 id컬럼을 참조하는
외래키를 생성한다. */
alter table noticeboard
    add constraint notice_mem_fk foreign key (id)
    references membership (id);


--게시판 테이블에서 사용할 시퀀스 생성
create sequence seq_noticeboard_num
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
     
 varchar2(200), /* 원본 파일명 */
    
insert into noticeboard (num, title, content, id, ofile, sfile)
    values (seq_noticeboard_num.nextval, '제목1입니다','내용1입니다', 'test', null, null);
insert into noticeboard (num, title, content, id, ofile, sfile)
    values (seq_noticeboard_num.nextval, '제목2입니다','내용2입니다', 'test', null, null);
insert into noticeboard (num, title, content, id, ofile, sfile)
    values (seq_noticeboard_num.nextval, '제목3입니다','내용3입니다', 'test',null, null);
insert into noticeboard (num, title, content, id, ofile, sfile)
    values (seq_noticeboard_num.nextval, '제목4입니다','내용4입니다', 'test',null, null);

   
--실제 테이블에 적용하기 위해 커밋은 필수 
commit;
    
select * from membership;
select * from noticeboard;
delete from noticeboard where title like '%asdfasdfaf%';



