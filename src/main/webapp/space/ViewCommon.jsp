<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="model1.board.BoardDTO"%>
<%@page import="model1.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
/* 목록에서 제목을 클릭하면 게시물의 일련번호를 ?num=99와 
같이 받아온다. 게시물 인출을 위해 파라미터를 받아온다. */
String tname = request.getParameter("tname");
String num = request.getParameter("num");
System.out.println(tname);

//DAO객체 생성을 통해 오라클에 연결한다. 
BoardDAO dao = new BoardDAO(application);
//게시물의 조회수 증가
dao.updateVisitCount(tname, num);
//게시물의 내용을 인출하여 DTO에 저장한다. 
BoardDTO dto = dao.selectView(tname, num);

dao.close();



//첨부파일 확장자 추출 및 이미지 타입 확인
String ext = null, fileName = dto.getSfile();
//파일의 확장자를 추출한다
if(fileName!=null) {
	ext = fileName.substring(fileName.lastIndexOf(".")+1);
}
//구분하고싶은 확장자를 배열에 담아 컬렉션으로 생성
String[] mimeStr = {"png","jpg","gif"};
List<String> mimeList = Arrays.asList(mimeStr);

boolean isImage = false;
//컬렉션에 같은확장자가 있는지 확인해 true를 반환
if(mimeList.contains(ext)) {
	isImage = true;
}
%>  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    