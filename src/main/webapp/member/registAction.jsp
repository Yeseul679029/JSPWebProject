<%@page import="membership.MemberShipDAO"%>
<%@page import="membership.MemberShipDTO"%>
<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
//폼값받기
String id = request.getParameter("id");
String pass = request.getParameter("pass1");
String name = request.getParameter("name");
String tel = request.getParameter("tel1")
				+ "-" + request.getParameter("tel2")
				+ "-" + request.getParameter("tel3");

String mobile = request.getParameter("mobile1")
				+ "-" + request.getParameter("mobile2")
				+ "-" + request.getParameter("mobile3");
String email = request.getParameter("email1") + "@" + request.getParameter("email2");
String openEmail = request.getParameter("open_email");
String zipcode = request.getParameter("zipcode");
String addr1 = request.getParameter("addr1");
String addr2 = request.getParameter("addr2");

//DTO객체에 저장하기
MemberShipDTO dto = new MemberShipDTO();

dto.setId(id);
dto.setPass(pass);
dto.setName(name);
dto.setTel(tel);
dto.setMobile(mobile);
dto.setEmail(email);
dto.setOpen_email(openEmail);
dto.setZipcode(zipcode);
dto.setAddr1(addr1);
dto.setAddr2(addr2);

//DAO객체생성 및 insert처리
MemberShipDAO dao = new MemberShipDAO(application);
int result = dao.memberInsert(dto);

if(result == 1){
	out.print("입력성공");
}
else{
	out.print("입력실패");
}

%>




