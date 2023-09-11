<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.File"%>
<%@page import="model1.board.BoardDAO"%>
<%@page import="model1.board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 수정 처리 전 로그인 되었는지 확인한다.  -->    
<%@ include file="./IsLoggedIn.jsp"%>
<%
//수정폼에서 입력한 내용을 파라미터로 받는다. 
String num = request.getParameter("num"); 
String title = request.getParameter("title");
String content = request.getParameter("content");
String tname = request.getParameter("tname");

//파일업로드 외 처리
String prevOfile = request.getParameter("prevOfile");
String prevSfile = request.getParameter("prevSfile");

//출력결과가 Console에 나온다.
//System.out.println(num+"+"+title+"+"+content);

//파일업로드
//업로드 디렉토리의 물리적 경로 확인
String sDirectory = application.getRealPath("/Uploads");
/* 파일 첨부를 위한 <input> 태그의 name속성값을 이용해서 Part객체를
생성한다. 해당 객체를 통해 파일을 서버에 저장할 수 있다. */
Part part = request.getPart("ofile");


//DTO 객체에 수정할 내용을 저장한다. 
BoardDTO dto = new BoardDTO();

String partHeader = "";
String[] phArr;
String originalFileName="";
//part가 null이 아닐경우 (첨부파일게시판일경우)
if(part != null ){

	/* Part객체에서 아래 헤더값을 읽어오면 전송된 파일의 원본명을
	 알수있다.(콘솔에서 확인할것) */
	 partHeader = part.getHeader("content-disposition");
	 System.out.println("partHeader="+ partHeader);
	 
	 /* "filename=" 를 구분자로 헤더값을 split()하면 String타입의 배열로
	반환된다. */
	phArr = partHeader.split("filename=");
	originalFileName = phArr[1].trim().replace("\"", "");
	if (!originalFileName.isEmpty()) {				
		part.write(sDirectory+ File.separator +originalFileName);
		//System.out.println("sDirectory="+sDirectory+", originalFileName="+originalFileName);
		//System.out.println(sDirectory+ File.separator +originalFileName);
	}
	
}

//폼값을 DTO객체에 저장한다. 
dto.setNum(num);
dto.setTitle(title);
dto.setContent(content); 



if(originalFileName != ""){
	
	String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
	
	String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
	
	String newFileName = now + ext;
	
	//원본파일명과 새로운파일명을 통해 File객체를 생성한다. 
	File oldFile = new File(sDirectory + File.separator + originalFileName);
	File newFile = new File(sDirectory + File.separator + newFileName);
	//파일명을 변경한다.
	oldFile.renameTo(newFile);
	
	
	//파일명을 "날짜_시간.확장자"형식으로 변경한다.
	String savedFileName = newFileName;

	dto.setOfile(originalFileName); //원래 파일 이름
	dto.setSfile(savedFileName); //서버에 저장된 파일 이름
	
	
	File file = new File(sDirectory + File.separator + prevSfile);
	//해당 경로에 파일이 있으면 삭제한다.
	if (file.exists()){
		file.delete();
	}
	
}
else {
	//첨부파일이 없으면 기존 이름 유지
	dto.setOfile(prevOfile);
	dto.setSfile(prevSfile);
}


//DAO객체 생성을 통해 오라클에 연결한다.
BoardDAO dao = new BoardDAO(application);




//update 쿼리문을 실행하여 게시물을 수정한다. 
int affected = 0;

if(tname.equals("referenceboard")||tname.equals("imagesboard")){
	affected = dao.updateFileEdit(dto, tname);
}
else{
	affected = dao.updateEdit(dto,tname);
}

System.out.println("tname="+tname+"dto="+dto.getTname());


//자원을 해제한다. 
dao.close();


if (affected == 1) {
	/* 수정이 완료되면 수정된 내용을 확인하기 위해 주로 내용보기
	페이지로 이동한다. */
    //response.sendRedirect("sub01View.jsp?tname="+dto.getTname()+"num=" + dto.getNum()); 
    response.sendRedirect("sub01View.jsp?tname="+tname+"&num=" + dto.getNum()); 
} 
else {
	//수정에 실패하면 경고창을 띄우고 뒤로 이동한다. 
    JSFunction.alertBack("수정하기에 실패하였습니다.", out);
}
%>



