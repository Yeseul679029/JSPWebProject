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


MemberShipDAO dao = new MemberShipDAO();
MemberShipDTO memberPwDTO = dao.getMemberPw(userId, userName, userEmail);
dao.close();

if(memberPwDTO.getName() != null){
	//session영역에 회원비밀번호와 이름을 저장한다.
	request.setAttribute("UserName", memberPwDTO.getName());
	/* session.setAttribute("UserEmail", memberPwDTO.getEmail());*/
	request.setAttribute("UserId", memberPwDTO.getId()); 
	request.setAttribute("UserPass", memberPwDTO.getPass());

	System.out.println(memberPwDTO.getId()+"="+memberPwDTO.getName()+"="+memberPwDTO.getPass());
	
	request.getRequestDispatcher("id_pw.jsp").forward(request, response);
}
else {
	//로그인에 실패한 경우
	request.setAttribute("PwErrMsg", "없는정보입니다.");
	request.getRequestDispatcher("id_pw.jsp").forward(request, response);
}
	




%>