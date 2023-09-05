<%@page import="membership.MemberShipDTO"%>
<%@page import="membership.MemberShipDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//아이디비번폼에서 전송한 폼값을 받는다. 
String userId = request.getParameter("user_id");
String userName = request.getParameter("user_name");
String userEmail = request.getParameter("user_email");

//출력결과가 Console에 나온다.
System.out.println(userName+"="+userEmail+"="+userId);
//출력결과가 웹브라우저에 나온다.(out내장객체를 사용)
out.println(userName+"="+userEmail+"="+userId);


String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

MemberShipDAO dao = new MemberShipDAO(oracleDriver, oracleURL, oracleId, oraclePwd);

//id가 null이 아니면 
if(userId != null){
	MemberShipDTO memberPwDTO = dao.getMemberPw(userId, userName, userEmail);
	dao.close();
	
	if(memberPwDTO.getId() != null){
		//session영역에 회원아이디와 이름을 저장한다.
		session.setAttribute("UserName", memberPwDTO.getName());
		/* session.setAttribute("UserEmail", memberPwDTO.getEmail());
		session.setAttribute("UserId", memberPwDTO.getId()); */
		session.setAttribute("UserPass", memberPwDTO.getPass());

		response.sendRedirect("id_pw.jsp");
	}
	else {
		//로그인에 실패한 경우
		request.setAttribute("PwErrMsg", "없는정보입니다.");
		request.getRequestDispatcher("id_pw.jsp").forward(request, response);
	}
	
}
else{
	MemberShipDTO memberDTO = dao.getMemberId(userName, userEmail);
	dao.close();
	
	if(memberDTO.getName() != null && memberDTO.getEmail() != null){
		//session영역에 회원아이디와 이름을 저장한다.
		session.setAttribute("UserName", memberDTO.getName());
		/* session.setAttribute("UserEmail", memberDTO.getEmail()); */
		session.setAttribute("UserId", memberDTO.getId());

		response.sendRedirect("id_pw.jsp");
	}
	else {
		//아이디찾기에 실패한 경우
		request.setAttribute("IdErrMsg", "없는정보입니다.");
		request.getRequestDispatcher("id_pw.jsp").forward(request, response);
	}
	
}




%>