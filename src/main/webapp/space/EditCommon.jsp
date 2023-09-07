<%@page import="utils.JSFunction"%>
<%@page import="model1.board.BoardDTO"%>
<%@page import="model1.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
//수정할 게시물의 일련번호를 파라미터로 받아온다. 
String tname = request.getParameter("tname");
String num = request.getParameter("num");
//DAO객체 생성 및 DB연결
BoardDAO dao = new BoardDAO(application);
//기존 게시물의 내용을 읽어온다. 
BoardDTO dto = dao.selectView(tname,num);
//세션영역에 저장된 회원 아이디를 가져와서 문자열로 변환한다. 
String sessionId = session.getAttribute("UserId").toString();
//로그인한 회원이 해당 게시물의 작성자인지 확인한다. 
if (!sessionId.equals(dto.getId())) {  
	//작성자가 아니라면 진입할 수 없도록 하고 뒤로 이동한다. 
    JSFunction.alertBack("작성자 본인만 수정할 수 있습니다.", out);
    return;
}
//출력결과가 Console에 나온다.
//System.out.println(num+"+"+sessionId);
/*
URL의 패턴을 파악하면 내가 작성한 게시물이 아니어도 얼마든지
수정페이지로 진입할 수 있다. 따라서 수정페이지 자체에서도 작성자
본인이 맞는지 확인하는 절차가 필요하다. 
*/
dao.close();
%>





























