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