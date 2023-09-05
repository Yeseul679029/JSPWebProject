<%@page import="membership.MemberShipDTO"%>
<%@page import="membership.MemberShipDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//로그인 폼에서 전송한 폼값을 받는다. 
String userId = request.getParameter("userId");
String userPwd = request.getParameter("userPw");

//출력결과가 Console에 나온다.
System.out.println(userId+"="+userPwd);
//출력결과가 웹브라우저에 나온다.(out내장객체를 사용)
out.println(userId+"="+userPwd);


String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

MemberShipDAO dao = new MemberShipDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
MemberShipDTO memberDTO = dao.getMemberDTO(userId, userPwd);
dao.close();

if(memberDTO.getId() != null){
	//session영역에 회원아이디와 이름을 저장한다.
	session.setAttribute("UserId", memberDTO.getId());
	session.setAttribute("UserName", memberDTO.getName());
	//그리고 로그인 페이지로 '이동' 한다.
	response.sendRedirect("main.jsp");
}
else {
	//로그인에 실패한 경우
	request.setAttribute("LoginErrMsg", "로그인 오류입니다.");
	request.getRequestDispatcher("main.jsp").forward(request, response);
}
%>