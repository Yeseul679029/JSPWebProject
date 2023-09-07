<%@page import="model1.board.BoardDTO"%>
<%@page import="model1.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
/* 목록에서 제목을 클릭하면 게시물의 일련번호를 ?num=99와 
같이 받아온다. 게시물 인출을 위해 파라미터를 받아온다. */
String tname = request.getParameter("tname");
String num = request.getParameter("num");
//DAO객체 생성을 통해 오라클에 연결한다. 
BoardDAO dao = new BoardDAO(application);
//게시물의 조회수 증가
dao.updateVisitCount(tname, num);
//게시물의 내용을 인출하여 DTO에 저장한다. 
BoardDTO dto = dao.selectView(tname, num);

dao.close();
%>  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    